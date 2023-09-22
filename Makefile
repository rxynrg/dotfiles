install:
	pip3 install -r requirements.txt

init:
	pip install ansible

deps:
	ansible-galaxy install -r requirements.yml

help:
	@./bootstrap.py play --help
