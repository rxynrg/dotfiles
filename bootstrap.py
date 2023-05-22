#!/usr/bin/env python3

import click as cli
import subprocess
import platform
import pathlib
import getpass
import sys


@cli.group()
def ansible() -> None:
    pass


@ansible.command()
@cli.option("--brew-upgrade", is_flag=True, show_default=True, default=False,
            help="Upgrade homebrew")
@cli.option("--brew-update", is_flag=True, show_default=True, default=False,
            help="Update homebrew")
@cli.option("--dry-run", is_flag=True, show_default=True, default=False,
            help="Whether or not to run playbook in check mode.")
@cli.option("--verbose", is_flag=True, show_default=True, default=False,
            help="Whether to print debugging information.")
@cli.option("--only", help="Add a role to the execution. Ignores invalid role names.")
@cli.option("-s", "--skip", multiple=True,
            help="Remove the role from the execution. "
                 "Ignores invalid role names.")
def play(brew_upgrade: bool,
         brew_update: bool,
         only: str,
         skip: tuple,
         dry_run: bool,
         verbose: bool) -> None:
    install_ansible(brew_upgrade, brew_update)
    run_playbook(only, skip, dry_run, verbose)


def install_ansible(brew_upgrade: bool, brew_update: bool) -> None:
    if is_command_available("ansible"):
        cli.echo("Ansible already installed")
    elif cli.confirm("Failed to detect ansible on the system. Would you like to install?"):
        if is_command_available("brew"):
            if brew_upgrade:
                cli.echo("Upgrading Homebrew")
                if subprocess.run(["brew", "upgrade"]).returncode == 0:
                    cli.echo("Homebrew upgraded")
            if brew_update:
                cli.echo("Updating Homebrew")
                if subprocess.run(["brew", "update"]).returncode == 0:
                    cli.echo("Homebrew updated")
            subprocess.run(["brew", "install", "ansible", ">/dev/null"])
            cli.echo("Ansible installed")
        elif ask_brew_install():
            install_ansible(brew_upgrade, brew_update)
        else:
            sys.exit(1)


def is_command_available(command: str) -> bool:
    return subprocess.run(["hash", command, "2>/dev/null"]).returncode == 0


def ask_brew_install() -> bool:
    if cli.confirm(
        "Failed to detect homebrew on the system. Would you like to install?"):
        cli.echo("Installing Homebrew...")
        try:
            subprocess.run("bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"", shell=True)
            cli.echo("Homebrew installed")
            if platform.system() == "Linux":
                config_file_path = f"/home/{getpass.getuser()}/.bashrc"
                subprocess.run(f"echo '# Set PATH, MANPATH, etc., for Homebrew' >> {config_file_path}", shell=True)
                subprocess.run(f'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" >> {config_file_path}', shell=True)
                subprocess.run("eval \"$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"")
                cli.echo(f"Restart terminal or source {config_file_path} in order to use brew command")
        except KeyboardInterrupt:
            return False
        return True
    else:
        cli.secho(
            "Homebrew is required, confirm installation or install manually.",
            fg="red")
        return False


def run_playbook(only: str, skip: tuple, dry_run: bool, verbose: bool) -> None:
    root_dir = pathlib.Path(__file__).parent.resolve()
    inventory = root_dir / "hosts"
    playbook = root_dir / "dotfiles.yml"
    roles = build_roles_to_execute(only, skip)
    cmd = build_command(playbook, inventory, roles, dry_run, verbose)
    subprocess.run(cmd)


def build_roles_to_execute(only: str | None, skip: tuple) -> list[str]:
    if only is not None and len(skip) > 0:
        cli.secho(
            "Options --only and --skip are not supported together for use.",
            fg="red")
        sys.exit(1)
    roles = [
        "docker",
        "firewall",
        "frontend",
        "git",
        "jvm",
        "k8s",
        "packer",
        "remote_dev_machine",
        "tmux",
        "vim",
        "web_server",
        "zsh",
    ]
    if only is not None and len(skip) == 0:
        return [r for r in roles if r == only]
    if only is None and len(skip) == 0:
        return roles
    if only is None and len(skip) > 0:
        return [r for r in roles if r not in skip]


def build_command(playbook: pathlib.Path,
                  inventory: pathlib.Path,
                  roles: list[str],
                  dry_run: bool,
                  verbose: bool) -> list[str]:
    cmd = [
        "ansible-playbook", playbook,
        "-i", inventory,
        "--tags", ','.join(roles),
    ]
    if dry_run:
        cmd.extend(["--check", "--skip-tags", "sdkman_privilege"])
    if verbose:
        cmd.extend(["--diff", "-vvvv"])
    return cmd


app = cli.CommandCollection(sources=[ansible])

if __name__ == "__main__":
    app()
