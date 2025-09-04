#---
#title: Wrangling with Tidyverse
#author: Helen Holt
#date: 09/04/2025
#output:html_document: default, pdf_document: default
#---

#load libraries
library(tidyverse)
library(readxl)

#All the following question use the sttst_all_sites.xlsx file in the /data directory.

#1. Import sttstj_all_sites and inspect the data set.  What is the data structure and the data type of each field?

site <- read_xlsx("data/sttstj_all_sites.xlsx", sheet = "locations")

#Data Structure: 

glimpse(site)
#Rows: 2,505
#Columns: 5
#$ yr_site <chr> "2001_241", "2001_243", "200…
#$ year    <dbl> 2001, 2001, 2001, 2001, 2001…
#$ lat     <dbl> 18.31079, 18.34443, 18.34059…
#$ lon     <dbl> -64.77668, -64.68200, -64.68…
#$ hab     <chr> "PVMT", "AGRF", "AGRF", "AGR…

#data frame

#Data Type: yr-site - character, year - numeric, lat - numeric, lon - numeric, hab - charactrer
  
#2. How many samples are in the data set? 

nrow(site)
#2505 
  
#3. How many unique habitat types are there?  What are the names of each habitat?

unique(site$hab) #base R
#"PVMT" "AGRF" "SCR"  "PTRF" "BDRK" "HARD"
#OR
#site %>% distinct(hab), tidyverse

#4. How many sites are there in the "PVMT" habitat type?
PVMT_sites <- filter(site, hab == "PVMT")
nrow (PVMT_sites)
#571
#creates data frame and then prints in the console the number of rows 

#OR
#PVMT_sites <- filter(site, hab == "PVMT") %>% nrow ()
#saves as a value

#OR 
#PVMT_sites <- site %>% 
#  count(hab)
#  print(PVMT_sites)
#this gives the number of sites of each type of habitat, not just PVMT
  
#5. How many sites are there in the "PVMT" or "AGRF" habitat types?
P_A_sites <- filter(site, hab %in% c("PVMT","AGRF"))

  
#6. How many sites are there in all the habitat types EXCEPT "PVMT"?
Not_PVMT <- filter(site, hab != "PVMT")
  
#7. Show the first 6 records (rows) of...
head(site)

#- all sites sampled in "AGRF" or "SCR"
filter(site, hab %in% c("AGRF", "SCR"))%>% head()
  
#- only show the "yr_site" and "hab" columns
filter(site, hab %in% c("AGRF", "SCR"))%>% select(yr_site, hab) %>% 
  head()

#8. What is the northern most site sampled in the "BDRK" habitat?
North_site <- filter(site, hab == "BDRK") %>%
  arrange(desc(lat))
  
#9. What is the western most site sampled in either "AGRF" or "PTRF" habitat?
West_site <- filter(site, hab %in% c("AGRF", "PTRF")) %>%
  arrange(lon)
  
#10. How many years were surveyed in the data set?
num_year <- unique(site$year) 
  
#11. What is the eastern most site sample in the "AGRF" habitat in 2004?
East_site_spec <- filter(site, hab == "AGRF" & year == "2004") %>%
  arrange(desc(lon))
