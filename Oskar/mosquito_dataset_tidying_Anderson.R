# RNR 497 2026 section 002
# Data tidying for mosquito dataset habitat suitability model (HSM)
# Oskar Anderson
# Last edited 2026-03-02

# 1 - setting up 

## read in packages

library(tidyverse)

## read data

setwd("C:/Users/oskar/OneDrive/Documents/University of Arizona
      /University of Arizona Spring 2026/
      RNR 497 - Advanced Topics in Natural Resources Conservation/
      dataset_and_code")
### jeepers that's long. change it to fit your situation and rejoice if you can
### make the directory shorter than this mess.
mosquito_data <- read.csv("mosquito_data.csv",row.names = 1)

## remove rows with NA values for lat/long or number of male/female mosquitos

mosquito_data <- mosquito_data[complete.cases(mosquito_data[ , c(3:4, 7:8)]),]

## I use the complete.cases function because it is more specific than na.omit
## and allows me to keep the instances where mosquitos were not tested for 
## arborviruses and still get count data. 

## If we want to remove all NAs, use code:
##mosquito data <- na.omit(mosquito_data)

# 2 - filter data to species and area of interest

## filter for only the three species of interest

filtered_data <- mosquito_data %>% 
  filter(Species == "Aedes aegypti" | 
           Species == "Culex tarsalis"|
           Species == "Culex quinquefasciatus")

## limit the latitude and longitude to the rectangular portion of Phoenix, AZ
## metro we are considering for this model

## as of last update, these are the bounds for our rectangle:
## West: LON -112.573997704 North: LAT 33.7987N East: LON -111.5837 South: LAT 33.2043

filtered_data <- filtered_data %>% 
  filter(Latitude <= 33.7987 &  Longitude <= -111.5837
         & Latitude >= 33.20434 & Longitude >= -112.573997704)

## add week and year columns to work at the temporal scale of one week

filtered_data <- filtered_data %>%
  mutate(Date = as.Date(Date),
         Week = isoweek(Date),
         Year = isoyear(Date))
