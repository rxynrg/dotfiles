import click as cli
import subprocess
import sys


@cli.command()
@cli.option("--update", is_flag=True, show_default=True, default=False,
            help="Update homebrew")
@cli.option("--upgrade", is_flag=True, show_default=True, default=False,
            help="Upgrade homebrew")
def setup_homebrew(update: bool, upgrade: bool) -> None:
    if subprocess.run(["hash", "brew", "2>/dev/null"]).returncode == 0:
        cli.echo("Homebrew already installed")
        if update:
            cli.echo("Updating Homebrew")
            if subprocess.run(["brew", "update"]).returncode == 0:
                cli.echo("Homebrew updated")
        if upgrade:
            cli.echo("Upgrading Homebrew")
            if subprocess.run(["brew", "upgrade"]).returncode == 0:
                cli.echo("Homebrew upgraded")
    else:
        if cli.confirm(
            "Failed to detect homebrew on the system. Would you like to install?"):
            cli.echo("Installing Homebrew...")
            # bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            cli.echo("Homebrew installed")
            # if [[ $(uname) == "Linux" ]]; then
            #     config_file_path="/home/$(id -u -n)/.bashrc"
            #     echo '# Set PATH, MANPATH, etc., for Homebrew' >> $config_file_path
            #     echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $config_file_path
            #     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            #     log_info "Restart terminal or source $config_file_path in order to use brew command"
            # fi
        else:
            cli.secho(
                "Homebrew is required, confirm installation or install manually.",
                fg="red")


@cli.command()
@cli.option("--dry-run", is_flag=True, show_default=True, default=False,
            help="List roles that will be executed")
@cli.option("--only",
            help="Add a role to the execution. Ignores invalid role names.")
@cli.option("-s", "--skip", multiple=True,
            help="Remove the role from the execution. "
                 "Ignores invalid role names.")
def run_ansible(only: str, skip: tuple, dry_run: bool) -> None:
    roles_to_execute = build_roles_to_execute(only, skip)
    if dry_run:
        cli.echo(f"Roles to be executed: {roles_to_execute}")


def build_roles_to_execute(only: str | None, skip: tuple) -> list[str]:
    if only is not None and len(skip) > 0:
        cli.secho(
            "Options --only and --skip are not supported together for use.",
            fg="red")
        sys.exit(1)
    roles = ["docker", "git", "k8s", "frontend", "packer", "tmux", "vim", "zsh"]
    if only is not None and len(skip) == 0:
        return [r for r in roles if r == only]
    if only is None and len(skip) == 0:
        return roles
    if only is None and len(skip) > 0:
        return [r for r in roles if r not in skip]


if __name__ == "__main__":
    setup_homebrew()
    # run_ansible()
