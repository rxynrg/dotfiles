#!/usr/bin/env bash
set -Eeuo pipefail # https://www.reddit.com/r/commandline/comments/g1vsxk/comment/fniifmk/?utm_source=share&utm_medium=web2x&context=3

# Fail fast with concise message when not using bash
# Single brackets is needed here for POSIX compatibility
# shellcheck disable=SC2292
if [ -z "${BASH_VERSION:-}" ]; then echo "Error: Bash is required to run." >&2; exit 1; fi

set +o posix # as we are using bash now

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] -p param_value arg1 [arg2...]

Script description here.

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-f, --flag      Some flag description
-p, --param     Some param description
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
log_debug() { log "${fg_blue}DEBUG${ta_none}" "$@"; }
log_info() { log "INFO" "$@"; }
log_warning() { log "${fg_yellow}WARNING${ta_none}" "$@"; }
log_error() { log "${fg_red}ERROR${ta_none}" "$@"; }

die() { log_error "${1-}"; exit 1; }

parse_params() {
  # default values of variables set from params
  helm=false
  istio=false
  update_brew=false
  upgrade_brew=false
  while [[ $# -gt 0 ]]; do
    case "${1-}" in
        --no-color) NO_COLOR=true ;;
        -h | --help) usage ;;
        --helm) helm=true ;;
        --istio) istio=true ;;
        --brew)
          update_brew=true
          upgrade_brew=true
          ;;
        -*) die "Unknown option ${ta_uscore}$1${ta_none}" ;;
        *) die "Unknown command ${ta_uscore}$1${ta_none}" ;;
    esac
    shift
  done
  return 0
}

# Script logic
##############
setup_homebrew() {
  if hash brew 2>/dev/null; then
    log_info "Homebrew already installed"
    if [[ $update_brew == true ]]; then
      log_info "Updating Homebrew..."
      # Make sure we are using the latest Homebrew
      brew update >/dev/null && log_info "Brew updated"
    fi
    if [[ $upgrade_brew == true ]]; then
      log_info "Upgrading Homebrew..."
      # Upgrade any already-installed formulae
      brew upgrade >/dev/null && log_info "Brew upgraded"
    fi
  else
    log_info "Installing Homebrew..."
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
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

  printf -v EXTRA_VARS '{"helm": %s, "istio": %s}' $helm $istio
  # TODO: take as args otherwise use defaults
  SKIPPED_TAGS="macos,packer"

  ansible-playbook -i "$HOSTS" "$PLAYBOOK" --extra-vars "$EXTRA_VARS" --skip-tags "$SKIPPED_TAGS"
  #ansible-playbook -i "$HOSTS" "$PLAYBOOK" --extra-vars "$EXTRA_VARS" --skip-tags "$SKIPPED_TAGS" --ask-become-pass
}

setup_colors
parse_params "$@"
setup_homebrew
setup_ansible
run_ansible

######################################################
#################### Credits: ########################
### https://github.com/ralish/bash-script-template ###
######################################################
