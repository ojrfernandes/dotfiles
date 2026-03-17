#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias confhl='nano /home/jfernandes/.config/hypr/hyprland.conf'
alias la='ls -a'
alias mount_hd='sudo mount -t ntfs-3g -o uid=$(id -u),gid=$(id -g),rw /dev/sda1 /mnt/HDD_2tb'

# Starship
eval "$(starship init bash)"

# Zoxide
eval "$(zoxide init bash)"
