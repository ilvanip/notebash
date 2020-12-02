#
#Contains functions for initializing and deinitializing notebash.
#

#Create a new registry if one has not already been created.
notebash::setup::initNotebash()
{
	#Push the home directory onto the directory stack.
	#Get rid of all output.
	pushd $HOME >> /dev/null;
	#If the notebash directory doesn't exist, create it.
	if [[ ! -d $notebash_dir ]];then
		mkdir $notebash_dir;
	fi;
	#The notebash directory has been created.
	#Pop off the home directory and push the notebash directory.
	#Get rid of all output.
	popd >> /dev/null;
	pushd $HOME"/"$notebash_dir >> /dev/null;
	#If the registry doesn't exist, create it.
	if [[ ! -f $registry ]];then
		touch $registry;
	fi;
	#If the display file doesn't exist, create it.
	if [[ ! -f $displayer ]];then
		touch $displayer;
	fi;
}

#Perform cleanup actions.
notebash::setup::exitNotebash()
{
	#Restore directory stack.
	popd >> /dev/null;
}

