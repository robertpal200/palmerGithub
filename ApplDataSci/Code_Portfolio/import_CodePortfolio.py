

import numpy as np    
import pandas as pd

def main():
    # opens a file browse window
    fileName = input("Enter a file name: ")    
    
    #import a csv file
    mydata= pd.read_csv("C:\\Users\\Deepanshu\\Documents\\file1.csv")
    
    #no header (title) in raw data file
    mydata1  = pd.read_csv("C:\\Users\\Deepanshu\\Documents\\file1.csv", header = None)
    
    #include column names using names= option.
    mydata2  = pd.read_csv("C:\\Users\\Deepanshu\\Documents\\file1.csv", header = None, names = ['ID', 'first_name', 'salary'])
    
    #fetch data from URL. applicable only for CSV files stored in URL
    mydata  = pd.read_csv("http://winterolympicsmedals.com/medals.csv")
    
    #read_table() function to pull data from text file. We can also use read_csv() with sep= "\t" to read data from tab-separated file.
    mydata = pd.read_table("C:\\Users\\Deepanshu\\Desktop\\example2.txt")
    mydata  = pd.read_csv("C:\\Users\\Deepanshu\\Desktop\\example2.txt", sep ="\t")
    
    #read_excel() to import excel data into Python.
    mydata = pd.read_excel("https://www.eia.gov/dnav/pet/hist_xls/RBRTEd.xls",sheetname="Data 1", skiprows=2)
    
    # import a file that is separated with white spaces.
    mydata2 = pd.read_table("http://www.ssc.wisc.edu/~bhansen/econometrics/invest.dat", sep="\s+", header = None)
    
    #To include variable names, use the names= option like below -
    mydata3 = pd.read_table("http://www.ssc.wisc.edu/~bhansen/econometrics/invest.dat", sep="\s+", names=['a', 'b', 'c', 'd'])
    
    #By specifying nrows= and usecols=, to fetch specified number of rows and columns.
    mydata7  = pd.read_csv("http://winterolympicsmedals.com/medals.csv", nrows=5, usecols=(1,5,7))
    
    # to skip first 5 rows and wants to read data from 6th row (6th row would be a header row)
    mydata8  = pd.read_csv("http://winterolympicsmedals.com/medals.csv", skiprows=5)
    
    # na_values= option, to specify values as missing values. In this case, we are telling python to consider dot (.) as missing cases.
    mydata9  = pd.read_csv("workingfile.csv", na_values=['.'])    
    
    # Read Data from file Breast-Cancer-Wisconsin.csv :
    df= pd.read_csv("Breast-Cancer-Wisconsin.csv", na_values='?')
    # Replacing '?' with 'NaN'
    df = df.replace("?", np.NAN)
        
    # Filling missing Data with rounded off mean Value:
    df = df.fillna( round(df.mean()  ,0))      
    
  
main()