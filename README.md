# ANA_515_Assignment_3-
Cleaning data.

The Downloaded file and used as data : StormEvents_details-ftp_v1.0_d1991_c20170717

Has the following answers to :

 *Go to https://www1.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/ and download the bulk storm details data for the year you were born, in the file that starts “StormEvents_details” and includes “dXXXX”. For example, it looks like this for 2017:
• Move this into a good local directory for your current working directory and read it in to R using read_csv from the readr package.
• Limit the dataframe to: the beginning and ending dates and times, the episode ID, the event ID, the state name and FIPS, the “CZ” name, type, and FIPS, the event type, the source, and the beginning latitude and longitude and ending latitude and longitude (10 points)
• Convert the beginning and ending dates to a “date-time” class (there should be one column for the beginning date-time and one for the ending date-time) (5 points)
• Change state and county names to title case (e.g., “New Jersey” instead of “NEW JERSEY”) (5 points)
• Limit to the events listed by county FIPS (CZ_TYPE of “C”) and then remove the CZ_TYPE column (5 points)
• Pad the state and county FIPS with a “0” at the beginning (hint: there’s a function in stringr to do this) and then unite the two columns to make one fips column with the 5-digit county FIPS code (5 points)
• Change all the column names to lower case (you may want to try the rename_all function for this) (5 points)
• There is data that comes with R on U.S. states (data("state")). Use that to create a dataframe with the state name, area, and region
• Create a dataframe with the number of events per state in the year of your birth. Merge in the state information dataframe you just created. Remove any states that are not in the state information dataframe. (5 points)
• Create the following plot (10 points):
• Create a new repository in your GitHub (ANA 515 Assignment 3) and upload your code file. Include a Readme file as well. Include a screenshot or output file of the plot. You should have 3 files in the new repository.
• Submit your GitHub link to the assignments page in the Blackboard course site.

Answer in the attached code file.
