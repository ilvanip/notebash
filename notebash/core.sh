#
#Core notebash functions to create, edit, view and delete notes.
#

#Edit a note.
notebash::core::__editNote()
{
	#The first argument is the filename.
	local notefile=$1;
	shift;
	#Open it in nano so that the user can take notes.
	#The --tempfile (or -t) flag is used to save and exit nano without prompting the user.
	#By doing this, the user now has no option of saving his/her file under a different name.
	nano --tempfile $notefile;
}

#Delete a note.
notebash::core::__deleteNote()
{
	#Remove the entry from the registry.
	sed -i "/$1/ d" $registry;
	#Remove the note from the filesystem.
	rm $1;
	shift;
}

