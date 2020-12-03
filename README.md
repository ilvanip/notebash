NOTEBASH....

A note-making application written in pure bash. 

The Linux ecosystem has a large number of general purpose utilities that can be used for various tasks.
We have utilities for:
1)Processing regular expressions(grep)
2)Editing text files as text streams(sed)
3)Processing columnar data(awk)
4)Builtin text editors(nano)
5)Text readers(less)
and many more.

Notebash is an attempt to use them together and create something useful.

This application has three components:
1)The application driver(notebash.sh)
2)Logging functions(logging.sh)
3)The internal notebash libraries(notebash)

To run this application, do the following:
1)Place the above three components in the same directory.
2)Make sure that the directory is set in the $PATH environment variable.
3)Open a terminal window.
4)Type 'notebash.sh'.

Notebash will create a directory called .NOTEBASH in your home directory(as defined by $HOME).
All the notes and associated files will be stored there.

Features provided:

Currently Notebash provides the following features:
1)Create new notes.
2)View all created notes.
3)Edit an existing note.
4)Remove an existing note.

All notes are indexed by a unique id.
To edit or delete a note, its id must be provided.
The id will be displayed when the notes are viewed.

