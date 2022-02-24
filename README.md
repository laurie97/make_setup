# Make Setup Tool
Author: Laurie McClymont

Bash tool for creating setup scripts
make_setup creates:
- Creates a setup script in the directory you are in. This script can be added to over time as needed.
- Creates an alias `s_<Project name>` in bash to go to the dir and load the setup script

## How to use

### When starting a new project

1. cd to the directory that your project is in e.g. `~/programming/lauries_awesome_project`
1. Run command:
    ```
    make_setup "<Project Full Name>" "<Project Short Name>"`
    ```
    for example
    ```
    make_setup "Laurie's Awesome Project" "awesome"
    ```
1. Enter *yes* if details are correct.
1. Enter *yes* if this project needs a jupyter notebook (analytical focused)

### When you want to work on that project

1. Go to terminal (or gitbash)
1. (Optional) Run `list_setups` to see what setups you have run
1. Enter the alias created which follows form: `s_<Project Short Name>`
   e.g.
   ```
   s_awesome
   ```
1. You should be there with your shell setup to work!

### Customising Setup Script

- You ***should*** actively add to the setup file created to get the most of this
- Things you can do
    - Load virtual environments
    - Add aliases
    - Commands that are always run for this project (e.g. set-up db)
    - Messages of affirmation (p.s. you're awesome)

## Installation

- Git clone this repo
- Check you have a file in `~/.bash_profile`
    - If not type `echo "# Bash Profile" > ~/.bash_profile`
- Run `sh install.sh`
