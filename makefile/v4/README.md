This Makefile has some problems:

+ if you compiled, then delete all the .d files and modify some .h files, then 
  run 'make' again, something will happen because .d files are not included
  meanwhile .c/.cpp files are not changed

+ if you compiled, then delete some exist .h files, make will output errors
  since the .d files' recipes require these .h files, but they do not exist now
