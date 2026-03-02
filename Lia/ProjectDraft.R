#Lia Romanotto
#RNR 597
#Mosquito Data Project

library(tidyverse)
library(ggplot2)

mosquito_data <- read_csv("mosquito_data.csv")

#data visualization
head(mosquito_data)
str(mosquito_data)
glimpse(mosquito_data)
is.na(mosquito_data)

#First, tidy up the data
#Removing nones and NAs
mosquito_data_clean <- na.omit(mosquito_data)
mosquito_data2 <- mosquito_data_clean[mosquito_data_clean$Species %in% c("Culex quinquefasciatus",
                                                                         "Culex tarsalis",
                                                                         "Aedes aegypti"), ]

#add week column & sort by week
mosquito_data2$Date <- as.Date(mosquito_data2$Date)
mosquito_data2$Week <- format(mosquito_data2$Date, "%U")

#make a map with spatial limits
mosquito_data3 <- filter(mosquito_data2, Longitude > -112.573997704, 
                         Longitude < -111.5837, 
                         Latitude > 33.2043, 
                         Latitude < 33.7987)
ggplot(mosquito_data3, aes(x = Longitude, y = Latitude)) + 
  geom_point(aes(color = Species, alpha = 0.5))

#Pseudocode for HSM