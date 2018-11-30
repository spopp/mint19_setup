 
 path_to_executable=$(which ansible)
 if [ -x "$path_to_executable" ] ; then
    echo "Ansible path: $path_to_executable"
 else
 	# Setup ansible if needed
    sudo apt install software-properties-common python-apt python-git apt-transport-https ca-certificates curl

    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update
    sudo apt install ansible
 fi
