#Leverage the power of Linux commands to create a note-making script.

#Get the directory where this script is located.
#This is necessary for sourcing all files as they are relative. 
current=$(dirname $0);
#Get inside it.
pushd $current >> /dev/null;
#Source all the .sh files containing the variables and the functions.
#All global constants.
source notebash/globals.sh;
#All setup functions.
source notebash/setup.sh;
#All main functions.
source notebash/main.sh;
#Leave that directory.
popd >> /dev/null;

#Before anything, initialize notebash.
notebash::setup::initNotebash;
#Begin parsing.
case $1 in
	#Create a new note.
	'--create'|'-c')
		notebash::main::createNote;shift;;
	#Show all notes.
	'--show'|'-s')
		notebash::main::showNotes;shift;;
	#Edit the note.
	'--edit'|'-e')
		notebash::main::editNote $2;shift;shift;;
	#Delete the note.
	'--delete'|'-d')
		notebash::main::deleteNote $2;shift;shift;;
	'--version'|'-v')
		notebash::main::versionInfo;shift;;
	'--help'|'-h'|*)
		notebash::main::usage;shift;;
esac;
#At the end, uninitialize notebash.
notebash::setup::exitNotebash;

#References:
#https://stackoverflow.com/questions/19670061/bash-if-false-returns-true-instead-of-false-why

