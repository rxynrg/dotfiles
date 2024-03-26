info:
	ansible-playbook dotfiles.yml --tags all --list-tasks

run:
	ansible-playbook dotfiles.yml --tags bash,docker,git,home,toolbox,zsh
