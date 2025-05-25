# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -n "$ZSH_VERSION" ]; then
    if [ -f "$ZDOTDIR/.zshrc" ]; then
        . "$ZDOTDIR/.zshrc"
    fi
fi
