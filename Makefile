install:
	pip3 install -r requirements.txt

init:
	pip install ansible

deps:
	ansible-galaxy install -r requirements.yml

info:
	ansible-playbook dotfiles.yml --tags all --list-tasks

help:
	@./bootstrap.py play --help
