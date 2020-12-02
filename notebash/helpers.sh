#
#Helper functions for the script.
#

#Add an entry into the registry.
#The entry text is the first parameter.
notebash::helpers::__addEntry()
{
	echo $1|cat >> $registry;
	shift;
}

#Populate the display file.
#Display the note id and the first 5 lines of each note.
notebash::helpers::__populateDisplay()
{
	#Clear the display file.
	echo > $displayer;
	while [[ $# -ne 0 ]];do
		#Input the note id.
		echo -e "${fg_green}Note Id : $1${fg_none}" >> $displayer;
		#And the first 5 lines of the note.
		head --lines=5 $2>> $displayer;
		#And the note separator.
		echo -e "${fg_green}************************${fg_none}\n" >> $displayer;
		shift;shift;
	done;
}

#Get the note file name from the registry when the note id is given.
notebash::helpers::__getNoteName()
{
	#Use grep and find the appropriate entry in the registry.
	#Use awk and find the 4th column entry containing the note file name.
	local notefile=$(grep $1 $registry|awk 'BEGIN{FS=","}{print $4}');
	shift;
	echo $notefile;
}

#Get the note file name and the note ids from the registry.
notebash::helpers::__getNoteInfo()
{
	#Return the last and second last columns of the registry.
	#They contain the note id and the note name respectively.
	local noteinfo=$(awk 'BEGIN{FS=","}{print $3,$4}' $registry);
	echo $noteinfo;
}

