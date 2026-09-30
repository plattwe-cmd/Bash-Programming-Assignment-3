#!/usr/bin/bash

# DO NOT UPDATE
server_loc="http://icarus.cs.weber.edu/~dweidman/CS3030/"   # DO NOT CHANGE
custFolder="presidentData"  # DO NOT CHANGE

unset DFILE     # Data file
unset SFILE     # Sed File 
unset AFILE     # AWK Fie

################################################################################
# Help                                                                         #
################################################################################
Usage()
{
    echo "Usage: $0 [-s sedsrc] [-a awksrc] [-f inputFile]"
    exit 1
}

################################################################################
# Get file using WGET from icarus server and timestamp the file
################################################################################
GetFile()
{
  printf "Task 2: Checking for data structure\n"

}

################################################################################
# Update Date Format Using Sed
################################################################################
UpdateFile()
{
  printf "Task 3: Updating date format\n"

}

################################################################################
# Create Files based on century
################################################################################
SplitFile()
{
  printf "Task 4: Spliting file based on century\n"

}


################################################################################
#  Main Script
################################################################################
# Check to see if help was called

#### Task 1: capture user options using getopts

#### Task 2: Function to wget file from icarus WEB server, create folder and rename it

#### Task 3: Update Date format using SED 

#### Task 4: Create files based on Century using SED

#### Task 5: Function to apply awk script 


echo "Bye"
exit 0
