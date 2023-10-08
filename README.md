## Usage
For now it only works locally, but soon it will be possible to target a remote host, i.e. it means that repository should be cloned to target machine to be used.

```bash
$ ./install.sh
```

## Roadmap
- Add the ability to target a remote environment
- [Add tests](https://actuated.dev/blog/kvm-in-github-actions)
- Refactor *zsh* role for Linux target
	- [Forbid running as root](https://docs.brew.sh/FAQ#why-does-homebrew-say-sudo-is-bad)
	- `adduser <username>` && `usermod -aG sudo <username>` && `deluser -r <username>`
- [Measure the performance of the execution](https://www.redhat.com/sysadmin/faster-ansible-playbook-execution)

## Legal
Works on My Machine<sup>TM</sup>
