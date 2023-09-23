install:
	pip3 install -r requirements.txt

init:
	pip install ansible

info:
	ansible-playbook dotfiles.yml --tags all --list-tasks

deps:
	ansible-galaxy install -r requirements.yml

run: deps
	ansible-playbook dotfiles.yml --skip-tags frontend,media,remote_dev_machine,web_server

help:
	@./bootstrap.py play --help
