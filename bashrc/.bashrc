#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# My exports
export PATH="$HOME/.local/bin:$PATH"

# My aliases
alias la='ls -a'
alias mount_hd='sudo mount -t ntfs-3g -o uid=$(id -u),gid=$(id -g),rw /dev/sda1 /mnt/HDD_2tb'
alias bashrc='nvim ~/.bashrc && source ~/.bashrc'

# Sdumont - Yorke tunnel
alias open_tunnel='ssh -R 2223:login.sdumont.lncc.br:22 -N -f jfernandes@yorke.if.usp.br'
alias check_tunnel="ps -ef | grep '[s]sh'"

# Starship
eval "$(starship init bash)"

# Zoxide
eval "$(zoxide init bash)"

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
