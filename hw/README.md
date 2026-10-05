# CS 3030 Bash Programming Assignment 3

## Purpose and Skills

In this assignment, we will add more features to our data processing cycle. First, we will be retrieving a data file from a customer server on the web. Also, we will process the file and retrieve some valuable information. To achieve this, you will create three scripts. One `shell` script (`hw3.sh`) to take the user input and retrieve a data file. Then, you will create a `sed` script (`hw3.sed`) that will update some information from the data file. Finally, you will write an `awk` script (`hw3.awk`) to parse the data file.

This lab will help you practice the following skills use in communicating and transferring of files between Linux servers.

- The wget command: to transfer files
- The date command: Date manipulation string
- Check for folder/files properties.
- How to move or rename files.
- The sed and awk programming languages.
- Extract relevant data from csv files.

This lab will also help you to become familiar with the following important content knowledge in CS:
-  Working in multiple Linux servers.
-  Exchange of files manually and automatically.
-  Process customer data.
-  Use Source Version Control (Git)
-  Working with files
- Manipulation of data
## Task 1

Your first task is to get all the user options configure. 

First, add the standard `--help` option

```bash
 ./hw3.sh --help
Usage: ./hw3.sh [-s sedsrc] [-a awksrc] [-f inputFile]
```
As you can see from the help message above, you script should take three input parameters. To make your script more flexible, you are requried to use `getopts` for the input paramters. This way, you will allow the user to enter the input parameters in any order. 

Your `getopts` should take the following options

- A `-f` option for the data file
- A `-s` option for your `sed` script
- A `-a` option for your `awk` script

All three input parameters are required.

After you validated all the input parameters, print a `Bye` message at the end of the script.

### Sample Output Task 1
```bash
# No input params
./hw3.sh  
Missing required parameters
Usage: ./hw3.sh [-s sedsrc] [-a awksrc] [-f inputFile]

# Invalid option
./hw3.sh -z
Invalid Option: -z
Usage: ./hw3.sh [-s sedsrc] [-a awksrc] [-f inputFile]

# One valid option but no argument
 ./hw3.sh -f  
Error: -f requires an argument.
Usage: ./hw3.sh [-s sedsrc] [-a awksrc] [-f inputFile]

# One valid option
 ./hw3.sh -f president.csv 
Missing required parameters
Usage: ./hw3.sh [-s sedsrc] [-a awksrc] [-f inputFile]

# Two valid option
./hw3.sh -f president.csv -a hw3.awk 
Missing required parameters
Usage: ./hw3.sh [-s sedsrc] [-a awksrc] [-f inputFile]

# Three Valid option
./hw3.sh -f presidents.csv -s hw3.sed -a hw3.awk
Bye

```
## Task 2

Your next task is to create a function called `GetFile()` that will retrive the `presidents.csv` file from the following web location: 
`https://icarus.cs.weber.edu/~dweidman/CS3030/`

To retrieve this file, use the `wget` command. 

Make sure you have the correct folder structure to store your data file. The folder hierarchy should be as follows:

- The data should be stored in your present working directory under the `presidentData/MM` folder. MM represents the current month.

- The `presidentData` folder should be divided by months (01, 02, .., 12)
  - If the folder is not available, then your script should be able to create it.
  - Otherwise it should save the file in current structure. Hint: use the date command to retrieve the current month or any other date information.

The first time your run your script, the folders for your data should not exist. 

To list your project structure we will use the `tree` command. Type `tree` at the command prompt to see if it is installed. 
If your system does not have the this program, install it using this command:

```bash
sudo apt install tree
```
The `tree` command helps us visualize the folder content in a more graphical way
```bash
tree 
.
├── README.md
├── hw3.awk
├── hw3.sed
└── hw3.sh

1 directories, 4 files
```

### Sample Output Task 2  (Assuming that the current month is October)

```bash
./hw3.sh -f presidents.csv -s hw3.sed -a hw3.awk
Task 2: Checking for data structure
	Customer folder [presidentData/10] is missing 
	Creating folder
	Retreving presidents.csv from icarus Web server
	Got it
Bye
```

Now, check your folder structure
```bash
# Check working folder 
# The script during the October month (10), so the data file 
# should be in that folder
tree 
.
├── README.md
├── hw3.awk
├── hw3.sed
├── hw3.sh
├── log
└── presidentData
    └── 10
        └── presidents.csv

2 directories, 6 files
```
Note: the `log` file catches all the output from your `wget` command. 
## Task 3

Your next task is create a function called `UpdateFile()`. This function should call your `hw3.sed` script. Your script 
should change the date format in the `presidents.csv` file from `dd/mm/yyyy` to `dd.mm.yyyy`. 

Note: be aware that the day and month numbers could be one or two digits.

You could test your sed code directly 
```bash
sed -f hw3.sed presidents.csv
```

Make sure you are updating the date fields correctly. Once you are happy with the result, add the same command to your `UpdateFile()` function.

In order to avoid the overwriting the original script, make sure your create a backup copy of the file using the the `-i.bak` sed option. 

### Sample Output Task 3 (Assuming that the current month is October)

```bash
./hw3.sh -s hw3.sed -f presidents.csv -a hw3.awk
Task 2: Checking for data structure
	Customer folder [presidentData/10] exists
	Retreving presidents.csv from icarus Web server
	Got it
Task 3: Updating date format
Bye
```
And your project should look like: 

```bash
tree
.
|-- hw3.awk
|-- hw3.sed
|-- hw3.sh
|-- log
|-- presidentData
|   `-- 10
|       |-- presidents.csv
|       `-- presidents.csv.bak
`-- README.md

2 directories, 7 files
```

## Task 4
Your last task is to create an `awk` script to parse the `presidents.csv` file by century. Your script should be called in a function called `SplitFile()`. Your script should parse the records based on the beginning year the presidents took office. You should group all presidents from the `1700` century in one file. All the presidents from the `1800` in another, etc.

When writting your script, take into account the field separator `FS = ","` for the file records. Also you can use the `substr` function within `awk` to extract substring of a given field, in this case the year.

You can test your script as follows:
```bash
awk -f hw3.awk /presidentData/10/presidents.csv
```
Finally,  display the number of records in each file.
### Sample Output Task 4 (Assuming that the current month is October)

```bash
Task 2: Checking for data structure
	Customer folder [presidentData/10] exists
	Retreving presidents.csv from icarus Web server
	Got it
Task 3: Updating date format
Task 4: Spliting file based on century
	There are 2 records from President1700.txt file
	There are 23 records from President1800.txt file
	There are 17 records from President1900.txt file
	There are 6 records from President2000.txt file
Bye
```

And your final project should look like: 

```bash
tree
.
|-- hw3.awk
|-- hw3.sed
|-- hw3.sh
|-- log
|-- presidentData
|   `-- 10
|       |-- Presidents1700.txt
|       |-- Presidents1800.txt
|       |-- Presidents1900.txt
|       |-- Presidents2000.txt
|       |-- presidents.csv
|       `-- presidents.csv.bak
`-- README.md

2 directories, 11 files
```
