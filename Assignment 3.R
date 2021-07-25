library(tidyverse)
library(dplyr)
library(lubridate)
library(janitor)
a <- read.csv("StormEvents_details-ftp_v1.0_d1991_c20170717.csv", header = TRUE, sep = ",")
glimpse(a)

#Limit the dataframe to: the beginning and ending dates and times, the episode ID, the event ID, the state name and FIPS, the "CZ" name, type, and FIPS, the event type, the source, and the beginning latitude and longitude and ending latitude and longitude (10 points)

c<- a %>%
  select("BEGIN_YEARMONTH","END_YEARMONTH","BEGIN_DAY", "BEGIN_TIME","END_DAY","END_TIME","EPISODE_ID","EVENT_ID","STATE","STATE_FIPS","EVENT_TYPE","CZ_TYPE","CZ_FIPS","CZ_NAME","SOURCE","BEGIN_LAT","BEGIN_LON","END_LAT","END_LON")


#Convert the beginning and ending dates to a "date-time" class (there should be one column for the beginning date-time and one for the ending date-time) (5 points)
d<- c %>%
  separate(BEGIN_YEARMONTH, into = c("YEAR", "MONTH"), sep = 4)
  
e <- d %>%
  separate(END_YEARMONTH, into = c("YEAR2", "MONTH2"), sep = 4)
  
f <-  unite(data = e,
        col = "BEGIN_DATE",
        c("YEAR", "MONTH", "BEGIN_DAY"),
        sep = "-") %>%
  mutate(BEGIN_DATE = ymd(BEGIN_DATE))

f <- unite(data = f,
           col = "END_DATE",
           c("YEAR2", "MONTH2", "END_DAY"),
           sep = "-") %>%
  mutate(END_DATE = ymd(END_DATE))



f$BEGIN_TIME_PAD <- as.character(f$BEGIN_TIME)
f$BEGIN_TIME_PAD <- str_pad(f$BEGIN_TIME_PAD, 4, "left", "0")
f<- f %>%
  separate(BEGIN_TIME_PAD, into = c("hh", "mm"), sep = 2)
  
f <-unite(data = f,
        col = "BEGIN_TIME_PAD",
        c("hh", "mm"),
        sep = ":")

f$END_TIME_PAD <- as.character(f$END_TIME)
f$END_TIME_PAD <- str_pad(f$END_TIME_PAD, 4, "left", "0")
f<- f %>%
  separate(END_TIME_PAD, into = c("hh", "mm"), sep = 2)

f <-unite(data = f,
          col = "END_TIME_PAD",
          c("hh", "mm"),
          sep = ":")


f <- unite(data = f,
           col = "BEGIN_DT",
           c("BEGIN_DATE", "BEGIN_TIME_PAD"),
           sep = " ") %>%
  mutate(BEGIN_DT = ymd_hm(BEGIN_DT))
  
f <- unite(data = f,
        col = "END_DT",
        c("END_DATE", "END_TIME_PAD"),
        sep = " ") %>%
  mutate(END_DT = ymd_hm(END_DT))

f<- f %>%
select("BEGIN_DT","END_DT","EPISODE_ID","EVENT_ID","STATE","STATE_FIPS","EVENT_TYPE","CZ_TYPE","CZ_FIPS","CZ_NAME","SOURCE","BEGIN_LAT","BEGIN_LON","END_LAT","END_LON")


#Change state and county names to title case (e.g., "New Jersey" instead of "NEW JERSEY") (5 points)
library("tools")
library("base")
f$STATE <- toTitleCase(tolower(f$STATE))
f$CZ_NAME <- toTitleCase(tolower(f$CZ_NAME))

#Limit to the events listed by county FIPS (CZ_TYPE of "C") and then remove the CZ_TYPE column (5 points)
g <- f %>%
  filter(CZ_TYPE == "C")
  #Every observation in the column CZ_TYPE is C

g <- subset(f, CZ_TYPE == "C", select = -CZ_TYPE)


#Pad the state and county FIPS with a "0" at the beginning (hint: there's a function in stringr to do this) and then unite the two columns to make one fips column with the 5-digit county FIPS code (5 points)
g$CZ_FIPS <- str_pad(as.character(g$CZ_FIPS), 3, "left", "0")
g$STATE_FIPS <- str_pad(as.character(g$STATE_FIPS), 2, "left", "0")
g <-unite(data = g,
          col = "S_CZ_FIPS",
          c("STATE_FIPS", "CZ_FIPS"),
          sep = "")


#Change all the column names to lower case (you may want to try the rename_all function for this) (5 points)
names(g)<-tolower(names(g))

#There is data that comes with R on U.S. states (data("state")). Use that to create a dataframe with the state name, area, and region.
library("datasets")
h <- data.frame(state.name, state.area, state.region)

#Create a dataframe with the number of events per state in the year of your birth. Merge in the state information dataframe you just created. Remove any states that are not in the state information dataframe. (5 points)
i<- g %>%
select("state","event_id")

library("dplyr")
i<- i %>%
rename(state.name = state)%>%
  dplyr::mutate(state.name = forcats::fct_lump(state.name)) %>%
  dplyr::count(state.name)

j <- left_join(h, i)#if "i" is the states information dataframe then this is the correct answer.
j_a <-left_join(i, h)##if "h" is the states information dataframe then this is the correct answer.

#Create the following plot (10 points):
library(ggplot2)
ggplot(j,aes(state.area,n)) + geom_point(aes(color = state.region)) + labs(x = "Land area (square miles)", y = "# of storm events in 1991")


