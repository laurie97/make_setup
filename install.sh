#!/bin/bash


### A script to build to install make_setup

## Get path to make setup
make_setup_path=`realpath  ${BASH_SOURCE}`
make_setup_dir=`dirname ${make_setup_path}`

## Check details are right
echo
echo "install.sh: Install make_setup!, located @ ${make_setup_dir}"
while true; do
    read -p "make_setup.sh:  Do you want to go ahead? Warning, this overwrites existing setups (yes/no)  " yn
    case $yn in
	[Yy]* ) echo; echo " **** Ok let's go! ***"; echo; break;;
	[Nn]* ) echo "make_setup.sh: I'll take that as a no"; echo; exit 0;;
	* ) echo "make_setup.sh: Please answer yes/no!"; echo; continue;;
    esac
    done
echo

echo 'Creating new files...'
echo "## List of aliases for 's_ids' (last setup ran)" > ${make_setup_path}/list_setup_aliases.sh  
echo "## List of setups" > ${make_setup_path}/list_setup_local_aliases.txt  

echo 'Adding text to bash_profile...'

text_for_bash_profile="
######### Setups ##############
## Load Setups
source ${make_setup_dir}/load_setup_aliases.sh
## Make Setup Auto
alias make_setup='source ${make_setup_dir}/make_setup.sh'
## List my Aliases
alias list_setups='source ${make_setup_dir}/list_setup_aliases.sh'
"
echo "${text_for_bash_profile}" >> ~/.bash_profile

echo 'Reloading .bash_profile... '
source ~/.bash_profile

echo ' ** Done ***'