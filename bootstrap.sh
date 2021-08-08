#!/usr/bin/env bash
set -e

if test ! "$(which brew)"; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed"
  echo "Updating Homebrew..."
  # Make sure we are using the latest Homebrew
  brew update
  # Upgrade any already-installed formulae
  brew upgrade
fi

# Dotfiles' project root directory
ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Host file location
HOSTS="$ROOTDIR/hosts"
# Main playbook
PLAYBOOK="$ROOTDIR/dotfiles.yml"

if test ! "$(which ansible)"; then
  echo "Installing Ansible..."
  brew install ansible
else
  echo "Ansible already installed"
fi

# TODO: take as args otherwise use defaults
SKIPPED_TAGS="macos,slack,zoom"

ansible-playbook -i "$HOSTS" "$PLAYBOOK" --skip-tags "$SKIPPED_TAGS" --ask-become-pass
