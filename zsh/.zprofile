for dir in "$HOME/.local/bin" "$HOME/bin"; do
  if [ -d "$dir" ]; then
    PATH="$dir:$PATH"
  fi
done
export PATH
