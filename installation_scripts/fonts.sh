#!/usr/bin/env bash

fonts_home=$( [[ "$(uname)" == "Darwin" ]] && echo "$HOME/Library/Fonts" || echo "$HOME/.fonts" )
mkdir -p "$fonts_home"

styles=(
    "Bold"
    "BoldItalic"
    "ExtraBold"
    "ExtraBoldItalic"
    "ExtraLight"
    "ExtraLightItalic"
    "Italic"
    "Light"
    "LightItalic"
    "Medium"
    "MediumItalic"
    "Regular"
    "SemiBold"
    "SemiBoldItalic"
    "Thin"
    "ThinItalic"
)

for style in "${styles[@]}"; do
    file_name="JetBrainsMonoNLNerdFontMono-$style.ttf"
    curl -sSLo "$fonts_home/$file_name" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/$style/$file_name"
    chmod 644 "$fonts_home/$file_name"
done
