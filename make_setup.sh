#!/bin/bash

### A script to build a default setup script and add alias

## Inputs Arguments
location=`pwd`
fullName=$1
shortName="s_"$2
## Get path to make setup
make_setup_path=`realpath ${BASH_SOURCE}`
make_setup_dir=`dirname ${make_setup_path}`

## Check details are right
echo
echo "make_setup.sh:  I want to make project '$fullName' in '$location' with a alias name '$shortName'"
while true; do
    read -p "make_setup.sh:  Is this ok? (yes/no/maybe)  " yn
    case $yn in
	[Yy]* ) echo; echo "  **** Ok let's go! ***"; echo; break;;
	[Nn]* ) echo "make_setup.sh: I'll take that as a no"; echo; exit 0;;
	[Mm]* ) echo "make_setup.sh: You can't actually answer 'maybe' to a machine, I can't make decisions for you!"; echo; continue;;
	* ) echo "make_setup.sh: Please answer yes/no/maybe!"; echo; continue;;
    esac
    done
echo

## Name of bash script that will run
setup_name="nsfg_setup_"$2".sh"

## Print out what you are doing
echo "make_setup.sh: Creating alias...." 
echo "alias ${shortName}='source "${location}"/${setup_name}'" >> ${make_setup_dir}/load_setup_aliases.sh
echo 'echo "** '${shortName}' = Go to '$fullName'"' >> ${make_setup_dir}/list_setup_aliases.sh
echo
echo "make_setup.sh: Creating setup script...."

#### Build a set-up script in location
make_setup_text='#!/bin/bash

echo "*****************************************"
echo "**** Welcome to '${fullName}' ('$shortName') ****"
echo "*****************************************"

echo "Where am I?"
local='${location}'
cd $local;
## cur_setup
export CURRENT='$location'; $CURRENT

#### Aliases
echo "Loading aliases..."
echo "## List of aliases for '$shortName' (last setup ran)" > '${make_setup_dir}'/list_setup_local_aliases.txt
alias list_local_alias="cat '${make_setup_dir}'/list_setup_local_aliases.txt"
echo " - list_local_alias (List local aliases)" >> '${make_setup_dir}'/list_setup_local_aliases.txt'
'
## Print out aliases
echo "Here are the aliases..."
cat '${make_setup_dir}'/list_setup_local_aliases.txt

'
echo "${make_setup_text}" > ${location}/${setup_name}

while true; do
    read -p "make_setup.sh:  Do you want jupter notebook? (yes/no)  " yn_jn
    case $yn_jn in
	[Yy]* ) echo; echo "  **** Ok let's go! ***"; do_jn=true; echo; break;;
	[Nn]* ) echo "make_setup.sh: I'll take that as a no"; do_jn=false; echo; break;;
	* ) echo "make_setup.sh: Please answer yes/no!"; echo; continue;;
    esac
done

if ${do_jn}
then
    jn_text='
## Launch JN?
jn_cmd="jupyter notebook &"
while true; do
    read -p "'$shortName':  Do you want to start Jupyter Notebook (y/n): " yn
    case $yn in
        [Yy]* ) echo "'$shortName': Ok, starting Jupyter..."; eval "${jn_cmd}"; echo "'$shortName': Done"; break;;
        [Nn]* ) echo "'$shortName': I will take that as a no"; echo; break;;
        * ) echo "'$shortName': Please answer yes/no!"; echo; continue;;
    esac
done
echo

'
    echo "${jn_text}" >> ${location}/${setup_name}
fi
echo

echo 'Done!'
echo

## Reload the bash script 
echo '££££££££££££ Reload Bash Profile ££££££££££££££'
echo
source ~/.bash_profile
echo
echo
echo '££££££££££££ Loading New Setup Script ££££££££££££££'
echo
source ${location}/${setup_name}
echo "make_setup.sh: Done!!"
echo
