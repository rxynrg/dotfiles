info:
	ansible-playbook dotfiles.yml --tags all --list-tasks

sync:
	ansible-playbook dotfiles.yml --ask-vault-pass -e @secrets.yaml --tags common
