#!/usr/bin/bash

# DO NOT UPDATE
server_loc="http://icarus.cs.weber.edu/~dweidman/CS3030/"   # DO NOT CHANGE
custFolder="presidentData"  # DO NOT CHANGE

unset DFILE     # Data file
unset SFILE     # Sed File 
unset AFILE     # AWK File

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
  # Check if presedent file exits
  #   Create a new predent file if it doesn't extis
  # Check if correct month file exits
  #   Create a new MM file if it doesn't exist
  # Download file from icarus server to correct location
  # 
  PRESIDENT="presidentData/$(date +%m)"
  if [[ ! -d "$PRESIDENT" ]]
  then
    echo "Customer folder [$PRESIDENT] is missing"
    
    mkdir -p "$PRESIDENT"
  fi

  echo "Getting $DFILE from icarus server "
  wget -P "$PRESIDENT" "https://icarus.cs.weber.edu/~dweidman/CS3030/$1"
  if [ $? -eq 0 ]
  then 
    echo "Got it"
  else
    echo "Could not find $DFILE on server"
    exit 1
  fi

}

################################################################################
# Update Date Format Using Sed
################################################################################
UpdateFile()
{
  printf "Task 3: Updating date format\n"
  sed -i.bak -f $SFILE presidentData/$(date +%m)/$DFILE
}

################################################################################
# Create Files based on century
################################################################################
count_lines()
{
    file=$1
    num_lines=$(cat $file | wc -l)
    echo "There are $num_lines records from $file file"
}
SplitFile()
{
  PRESIDENT="presidentData/$(date +%m)"
  printf "Task 4: Spliting file based on century\n"  
  awk -f $AFILE $PRESIDENT/$DFILE

  count_lines $PRESIDENT/Presidents1700.txt
  count_lines $PRESIDENT/Presidents1800.txt
  count_lines $PRESIDENT/Presidents1900.txt
  count_lines $PRESIDENT/Presidents2000.txt
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


# Task 1
while getopts ":s:a:f:h" opt; do 
   case $opt in
      s) 
      SFILE=$OPTARG
      UpdateFile $SFILE
      ;;

      a)
      AFILE=$OPTARG
      SplitFile $AFILE
      ;;
      f)
      DFILE=$OPTARG
      GetFile $DFILE
      ;;
      h)
      Usage
      exit 0
      ;;

      \?) # invalid entry
      echo "Invalid option: -$OPTARG"
      Usage
      ;;
      :) # require argument is missing
      echo "Option -$OPTARG requires an argument"
      Usage
      ;;
   esac
done

echo "Bye"
exit 0
