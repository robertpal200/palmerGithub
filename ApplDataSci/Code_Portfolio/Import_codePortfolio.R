

#Reading in a tab delimited file from excel ( *.txt file) using read.table
#  The header argument is always set at TRUE, which indicates that the first line of the file 
#  contains the header with the variable names;
#
#  The fill argument is also set as TRUE, which means that if rows 
#  have unequal length, blank fields will be added implicitly.
#
#  the file will become a data.frame object.
#  by default it converts character vectors to factors

df <- read.table("<FileName>.txt", header = TRUE)
read.csv() #-- comma delimited-- 
read.csv2() #--semicolon delimited-- 
#  header and fill arguments set as TRUE by default.



#using the readr library  ___________________


#Unlike readr Base R (read.csv) produces tibbles, doesnt convert character vectors to factors, or use row names

read_csv() #reads comma delimited files, 
read_csv2() #reads semicolon separated files 
read_tsv() #reads tab delimited files, and 
read_delim() #reads in files with any delimiter.
read_fwf() #reads fixed width files. You can specify fields either by their 
#widths with fwf_widths() or their position with fwf_positions(). 
read_table() #fixed width files where columns are 
#separated by white space.
read_log() #reads Apache style log files.


#if the data doesnt have column names, use col_names = FALSE to tell 
#read_csv() not to treat the first row as headings, and instead label them from X1 to Xn:

#Alternatively you can pass col_names a character vector which will be used as the 
#column names:
  
read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))

## Connecting to Databases

# * dplyr can connect to a database as if the data was loaded into a data frame
# * Use the same syntax for local data frames and databases
# * Only generates SELECT statements
# * Currently supports SQLite, PostgreSQL/Redshift, MySQL/MariaDB, BigQuery, MonetDB
# * Example below is based upon an SQLite database containing the hflights data



