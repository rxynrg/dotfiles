## Usage

1. Clone the repository to the machine you want to configure

2. Install dependencies

    ```bash
    $ ./install.sh
    ```

3. Run playbook

    ```bash
    $ ansible-playbook dotfiles.yml [--skip-tags tags,to,exclude] [--tags tags,to,include]
    ```
---
List of all tags can be found in the play [definition](./dotfiles.yml)


## Legal
Works on My Machine<sup>TM</sup>
