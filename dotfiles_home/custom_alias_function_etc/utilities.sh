mkcd() {
    mkdir -p "$1"
    cd "$1" || return
}

if command -v eza > /dev/null; then
    alias ls="eza --icons"
    alias ll="eza --long"
    alias la="eza --long --all"
    alias lt="eza --icons --tree"
fi

alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
alias whereami="curl https://ifconfig.co/json"
alias java_print_all="java -XX:+UnlockDiagnosticVMOptions -XX:+UnlockExperimentalVMOptions -XX:+PrintFlagsFinal -XX:+JVMCIPrintProperties --version"
