#Contains all logging functions.

#The colors that are going to be used.

#Red foreground.
readonly fg_red='\033[0;31m';
#Green foreground.
readonly fg_green='\033[0;32m';
#Yellow foreground.
readonly fg_yellow='\033[0;33m';
#Cyan foreground.
readonly fg_cyan='\033[0;36m';
#End of colored foreground.
readonly fg_none='\033[0m';

#Failure.
#TODO
#Redirect this to stderr.
__failure()
{
	echo -e "${fg_red}${1}${fg_none}";
}

#Success
__success()
{
	echo -e "${fg_green}${1}${fg_none}";
}

#Warn the user of any unexpected side effects which the user may not expect.
__warn()
{
	echo -e "${fg_yellow}${1}${fg_none}";
}

#Inform the user about any other info.
__info()
{
	echo -e "${fg_cyan}${1}${fg_none}";
}


