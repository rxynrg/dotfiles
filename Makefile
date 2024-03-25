info:
	ansible-playbook dotfiles.yml --tags all --list-tasks

run:
	ansible-playbook dotfiles.yml --skip-tags home,k8s,media,remote_dev_machine,web_server,zig,zsh
