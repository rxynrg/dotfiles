## Usage
Now it works only locally but *soon* it will be possible to target a remote host, i.e. it means that repository should be cloned to the target machine to be used.

Install playbook dependencies

```bash
$ ./install.sh
```

Run playbook

```bash
$ ansible-playbook dotfiles.yml [--skip-tags tags,to,skip] [--tags ]
```

List of all the supported tags can be found in the play [definition](./dotfiles.yml)

## Roadmap
- Refactor with devcontainers in mind (as a main target)
- Add the ability to target a remote environment
- [Add tests](https://actuated.dev/blog/kvm-in-github-actions)
- Refactor the *zsh* role for Linux target
	- [Forbid running as root](https://docs.brew.sh/FAQ#why-does-homebrew-say-sudo-is-bad)
	- `adduser <username>` && `usermod -aG sudo <username>` && `deluser -r <username>`
- Support the *bash* role as well as the *zsh* role is supported

## Legal
Works on My Machine<sup>TM</sup>
