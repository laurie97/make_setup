#!/bin/bash

### A script to build a default setup script and add alias

## Inputs Arguments
location=`pwd`
fullName=$1
shortName="s_"$2
make_setup_dir=`dirname ${0}`

## Check details are right
echo
echo "make_setup.sh:  I want to make project '$fullName' in '$location' with a alias name '$shortName'"
while true; do
    read -p "make_setup.sh:  Is this ok? (yes/no/maybe)  " yn
    case $yn in
	[Yy]* ) echo; echo "  **** Ok let's go! ***"; echo; break;;
	[Nn]* ) echo "make_setup.sh: I'll take that as a no"; echo; exit;;
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
echo 'echo "*****************************************"' > ${location}/${setup_name}
echo 'echo "**** Welcome to '${fullName}' ('$shortName') ****"' >> ${location}/${setup_name}
echo 'echo "*****************************************"'>> ${location}/${setup_name}
echo 'echo'>> ${location}/${setup_name}
echo 'echo "Where am I?"'>> ${location}/${setup_name}
echo 'local='${location} >> ${location}/${setup_name}
echo 'cd $local;'>> ${location}/${setup_name}
echo '## cur_setup'>> ${location}/${setup_name}
echo 'export CURRENT='$location'; echo $CURRENT'>> ${location}/${setup_name}
echo 'echo'>> ${location}/${setup_name}
echo 'echo "Loading aliases..."'>> ${location}/${setup_name}
echo '#### Here are the aliases'>> ${location}/${setup_name}
echo ''>> ${location}/${setup_name}
echo 'echo "## List of aliases for '$shortName' (last setup ran)" > '${make_setup_dir}'/list_setup_local_aliases.txt' >> ${location}/${setup_name}
echo 'alias list_local_alias="cat '${make_setup_dir}'/list_setup_local_aliases.txt"' >> ${location}/${setup_name}
echo 'echo " - list_local_alias (List local aliases)" >> '${make_setup_dir}'/list_setup_local_aliases.txt' >> ${location}/${setup_name}
echo ''>> ${location}/${setup_name}
echo '## Print out aliases' >> ${location}/${setup_name}
echo 'echo "Here are the aliases..."' >> ${location}/${setup_name}
echo 'echo' >> ${location}/${setup_name}
echo 'cat '${make_setup_dir}'/list_setup_local_aliases.txt' >> ${location}/${setup_name}
echo 'echo'>> ${location}/${setup_name}
echo ''>> ${location}/${setup_name}

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
    echo '' >> ${location}/${setup_name}
    echo '## Launch JN?' >> ${location}/${setup_name}
    echo 'jn_cmd="jupyter notebook &"' >> ${location}/${setup_name}
    echo 'while true; do' >> ${location}/${setup_name}
    echo '    read -p "'$shortName':  Do you want to start Jupyter Notebook (y/n): " yn' >> ${location}/${setup_name}
    echo '    case $yn in' >> ${location}/${setup_name}
    echo '        [Yy]* ) echo "'$shortName': Ok, starting Jupyter..."; eval "${jn_cmd}"; echo "'$shortName': Done"; break;;' >> ${location}/${setup_name}
    echo '        [Nn]* ) echo "'$shortName': I will take that as a no"; echo; break;;' >> ${location}/${setup_name}
    echo '        * ) echo "'$shortName': Please answer yes/no!"; echo; continue;;' >> ${location}/${setup_name}
    echo '    esac' >> ${location}/${setup_name}
    echo 'done' >> ${location}/${setup_name}
    echo 'echo' >> ${location}/${setup_name}
    echo '' >> ${location}/${setup_name}
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
