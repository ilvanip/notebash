#
#The actual workflows that will be performed.
#

#Source all core functions.
source notebash/core.sh;
#Source all helper functions.
source notebash/helpers.sh;
#Source all logging functions.
source logging.sh;

#Create a new note.
notebash::main::createNote()
{
	#To keep names unique, the names are actually the date and timestamps.
	#The date and time info is encoded as numbers.
	#It is only to ensure uniqueness and may not represent the actual date and time.
	local notefile=$(date "+%d%m%Y%H%M%S")
	#Create the note.
	notebash::core::__editNote $notefile;
	#By default, nano will not create any file if the contents are empty.
	#So check for existence first.
	#If the note doesn't exist, return.
	if [[ ! -f $notefile ]];then
		__failure 'Your note was not created as it was empty.';
		__failure 'Please retry.';
		return;
	fi;
	#The note has been created, and it has text! So make an entry in the registry.
	#Generate a hash using uuidgen to identfy the note made.
	local note_id=$(uuidgen);
	#Get the date and time of when the note was made.
	#We are specifying all the parameters for the entry in the date format only.
	#This is the entry which we will enter into the registry.
	local entry=$(date "+%d/%m/%Y,%H/%M,${note_id},${notefile}");
	#Add the entry to the registry.
	notebash::helpers::__addEntry $entry;
	#Notify user.
	__success 'Your note has been successfully created.';
}


#Show all notes in the registry.
notebash::main::showNotes()
{
	#Return the last and second last columns of the registry.
	#They contain the note id and the note name respectively.
	local noteinfo=$(notebash::helpers::__getNoteInfo);
	#Populate the display file.
	notebash::helpers::__populateDisplay $noteinfo;
	#Show the display file via the less command.
	#Use the -c flag to ensure that output starts from the top of the screen.
	#Use the -R flag to ensure that colors are displayed as they are.
	less -c -R $displayer;
}

#Edit a note when its id is given.
notebash::main::editNote()
{
	#If no note id was given, exit with an error.
	if [[ -z $1 ]];then
		__failure 'No note id was given.';
		__info "Type 'notebash --help' for further information";
		return;
	fi;
	#Get the note file given the note id.
	notefile=$(notebash::helpers::__getNoteName $1);
	#Error if the note file name is blank.
	if [[ -z $notefile ]];then
		__failure 'Failed to open note.'
		__failure 'Exiting.';
		__info "There is no note created for the id [$1]."
		return;
	fi;
	shift;
	#Edit the note.
	notebash::core::__editNote $notefile;
	__success 'Note edited successfully.';
	#If the note was emptied, remove it.
#TODO
#Make this regex better.
#	local nlines=$(grep -c "^.*$" $notefile);
#	if [[  $nlines -eq 0 ]];then
#		__deleteNote $notefile;
#		__warn 'The note was cleared of all contents and has been removed.';
#	fi;

}

#Delete a note when its id is given.
notebash::main::deleteNote()
{
	#If no note id was given, exit with an error.
	if [[ -z $1 ]];then
		__failure 'No note id was given.';
		__info "Type 'notebash --help' for further information";
		return;
	fi;
	#Get the note file given the note id.
	notefile=$(notebash::helpers::__getNoteName $1);
	#Error if the note file name is blank.
	if [[ -z $notefile ]];then
		__failure 'Failed to open note.'
		__failure 'Exiting.';
		__info "There is no note created for the id [$1]."
		return;
	fi;
	shift;
	notebash::core::__deleteNote $notefile;
	__success 'Note deleted successfully.';
}


#General usage of the script.
notebash::main::usage()
{
	__info "The following usages are defined:";
	__info "'notebash [--create|-c]' to create a new note.";
	__info "'notebash [--show-all|-s]' to display all notes.";
	__info "'notebash [--edit|-e] <note_id>' to edit a note given its note id.";
	__info "'notebash [--delete|-d] <note_id>' to delete a note given its note id.";
}

#Display version information about the script.
notebash::main::versionInfo()
{
	__info "NOTEBASH.";
	__info "Version 1";
}

