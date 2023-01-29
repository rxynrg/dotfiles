#!/usr/bin/env bash

# https://www.reddit.com/r/commandline/comments/g1vsxk/comment/fniifmk/?utm_source=share&utm_medium=web2x&context=3
set -Eeuo pipefail

# Fail fast with concise message when not using bash
# Single brackets is needed here for POSIX compatibility
# shellcheck disable=SC2292
if [ -z "${BASH_VERSION:-}" ]; then
  echo "Error: Bash is required to run." >&2
  exit 1
elif [ "${BASH_VERSION::1}" -lt 4 ]; then
  # https://stackoverflow.com/questions/1494178/how-to-define-hash-tables-in-bash
  echo "Error: Please update Bash to version 4 or higher, then try again." >&2
  exit 1
fi

# As we are using bash now
set +o posix

DEBUG_ENABLED=false

usage() {
  cat <<EOF
usage: ./$(basename "${BASH_SOURCE[0]}") [-h | --help] [-macos[=defaults]]
                      [-git] [-docker] [-k8s[=helm,istio]] [-macos] [-packer]
                      [-terraform] [-tmux] [-vim] [-zsh] [--debug]

This script will install or update brew, install ansible if not installed,
and then run the playbook, which will set up the system so it is ready to go.

Available options:

--debug         Enable debug output
-h, --help      Print this help and exit
-defaults       Configure MacOS system defaults
-macos          Configure MacOS
-docker         Install docker
-packer         Install packer
EOF
  exit
}

# DESC: Initialise colour variables
# ARGS: None
# OUTS: Read-only variables with ANSI control codes
# NOTE: If --no-color was set the variables will be empty.
# shellcheck disable=SC2034,SC2155
function setup_colors() {
  if [[ -t 2 ]] && [[ -z ${NO_COLOR-} ]]; then
    readonly ta_none="$(tput sgr0 2> /dev/null || true)"
    # Text attributes
    readonly ta_bold="$(tput bold 2> /dev/null || true)"
    readonly ta_uscore="$(tput smul 2> /dev/null || true)"
    readonly ta_blink="$(tput blink 2> /dev/null || true)"
    readonly ta_reverse="$(tput rev 2> /dev/null || true)"
    readonly ta_conceal="$(tput invis 2> /dev/null || true)"
    # Foreground codes
    readonly fg_black="$(tput setaf 0 2> /dev/null || true)"
    readonly fg_blue="$(tput setaf 4 2> /dev/null || true)"
    readonly fg_cyan="$(tput setaf 6 2> /dev/null || true)"
    readonly fg_green="$(tput setaf 2 2> /dev/null || true)"
    readonly fg_magenta="$(tput setaf 5 2> /dev/null || true)"
    readonly fg_red="$(tput setaf 1 2> /dev/null || true)"
    readonly fg_white="$(tput setaf 7 2> /dev/null || true)"
    readonly fg_yellow="$(tput setaf 3 2> /dev/null || true)"
    # Background codes
    readonly bg_black="$(tput setab 0 2> /dev/null || true)"
    readonly bg_blue="$(tput setab 4 2> /dev/null || true)"
    readonly bg_cyan="$(tput setab 6 2> /dev/null || true)"
    readonly bg_green="$(tput setab 2 2> /dev/null || true)"
    readonly bg_magenta="$(tput setab 5 2> /dev/null || true)"
    readonly bg_red="$(tput setab 1 2> /dev/null || true)"
    readonly bg_white="$(tput setab 7 2> /dev/null || true)"
    readonly bg_yellow="$(tput setab 3 2> /dev/null || true)"
  else
    # Text attributes
    readonly ta_bold=''
    readonly ta_uscore=''
    readonly ta_blink=''
    readonly ta_reverse=''
    readonly ta_conceal=''
    # Foreground codes
    readonly fg_black=''
    readonly fg_blue=''
    readonly fg_cyan=''
    readonly fg_green=''
    readonly fg_magenta=''
    readonly fg_red=''
    readonly fg_white=''
    readonly fg_yellow=''
    # Background codes
    readonly bg_black=''
    readonly bg_blue=''
    readonly bg_cyan=''
    readonly bg_green=''
    readonly bg_magenta=''
    readonly bg_red=''
    readonly bg_white=''
    readonly bg_yellow=''
  fi
}

# DESC: Print the provided string
# ARGS: $1 (required): Level (DEBUG, INFO, WARNING, ERROR, etc.)
#       $2 (required): Message to print
# OUTS: None
log() {
  if [[ $# -lt 2 ]]; then log_error 'Missing required argument to log()!'; return 1; fi
  local level=$1
  shift
  printf "$(date '+%Y/%m/%d %H:%M:%S') ($$) ($level): %s\n" "${1-}" >&2
}
log_debug() { [[ $DEBUG_ENABLED == "true" ]] && log "${fg_blue}DEBUG${ta_none}" "$@" || return 0; }
log_info() { log "INFO" "$@"; }
log_warning() { log "${fg_yellow}WARNING${ta_none}" "$@"; }
log_error() { log "${fg_red}ERROR${ta_none}" "$@"; }

die() { log_error "${1-}"; exit 1; }

parse_params() {
  # https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
  while [[ $# -gt 0 ]]; do
    case "${1-}" in
        --no-color) NO_COLOR=true ;;
        --debug) DEBUG_ENABLED=true ;;
        -h | --help) usage ;;
        -docker | -git | -packer | -terraform | -tmux | -vim | -zsh) roles["${1:1}"]=true ;;
        -macos*)
          rolename=${1:1:5}
          option_length=7
          handle_extras $rolename $option_length $1
          ;;
        -k8s*)
          rolename=${1:1:3}
          option_length=5
          handle_extras $rolename $option_length $1
          ;;
        -*) die "Unknown option ${ta_uscore}$1${ta_none}" ;;
        *) die "Unknown command ${ta_uscore}$1${ta_none}" ;;
    esac
    shift
  done
  return 0
}

# DESC: Enable role and set extra variables
# ARGS: $1 (required): Rolename
#       $2 (required): Option Length
#       $3 (required): Whole option value (--<rolename>*)
# OUTS: None
handle_extras() {
  user_defined_extras=($(echo ${3:$2} | tr ',' ' '))
  for extra in ${user_defined_extras[@]}; do
    if [[ " ${available_extras[$rolename]} " =~ " ${extra} " ]]; then
      REQUIRED_EXTRAS+="\"$extra\":true,"
    elif [[ ! " ${available_extras[$rolename]} " =~ " ${extra} " ]]; then
      die "Unknown extra [$extra] for [$rolename] option. Available list of extras: [${available_extras["k8s"]}]"
    fi
  done
  roles[$rolename]=true
  return 0
}

setup_homebrew() {
  if hash brew 2>/dev/null; then
    log_info "Homebrew already installed"
    # Make sure we are using the latest Homebrew
    log_info "Updating Homebrew..." && brew update >/dev/null && log_info "Brew updated"
    # Upgrade any already-installed formulae
    log_info "Upgrading Homebrew..." && brew upgrade >/dev/null && log_info "Brew upgraded"
  else
    log_info "Installing Homebrew..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    log_info "Homebrew installed"
    if [[ $(uname) == "Linux" ]]; then
      profile_path="/home/$(id -u -n)/.profile"
      echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $profile_path
      echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $profile_path
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
  fi
}

setup_ansible() {
  if command -v ansible >/dev/null; then
    log_info "Ansible already installed"
  else
    log_info "Installing Ansible..."
    brew install ansible >/dev/null && log_info "Ansible installed"
  fi
}

run_ansible() {
  # https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel/246128#246128
  ROOTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
  HOSTS="$ROOTDIR/hosts"
  PLAYBOOK="$ROOTDIR/dotfiles.yml"
  SKIPPED_TAGS=""
  for role in ${!roles[@]}; do
    if [[ "${roles[$role]}" == "false" ]]; then
      SKIPPED_TAGS+="$role,"
    fi
  done
  # Remove the trailing comma
  [[ "${#REQUIRED_EXTRAS}" -eq 0 ]] && REQUIRED_EXTRAS="" || REQUIRED_EXTRAS="${REQUIRED_EXTRAS::-1}"
  SKIPPED_TAGS="${SKIPPED_TAGS::-1}"
  printf -v EXTRA_VARS '{%s}' $REQUIRED_EXTRAS
  log_debug "EXTRA_VARS: $EXTRA_VARS"
  log_debug "SKIPPED_TAGS: $SKIPPED_TAGS"
  ansible-playbook -i "$HOSTS" "$PLAYBOOK" --extra-vars "$EXTRA_VARS" --skip-tags "$SKIPPED_TAGS" #--ask-become-pass
}

# All roles are disabled by default
declare -A roles=(
  ["docker"]=false
  ["git"]=false
  ["k8s"]=false
  ["macos"]=false
  ["packer"]=false
  ["terraform"]=false
  ["tmux"]=false
  ["vim"]=false
  ["zsh"]=false
)
declare -A available_extras=(
  ["k8s"]="istio helm"
  ["macos"]="defaults"
)
REQUIRED_EXTRAS=""
setup_colors
parse_params "$@"
setup_homebrew
setup_ansible
run_ansible

######################################################
#################### Credits: ########################
### https://github.com/ralish/bash-script-template ###
######################################################
