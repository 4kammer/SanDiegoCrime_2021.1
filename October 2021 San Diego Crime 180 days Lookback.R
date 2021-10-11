# Investigation of San Diego Regional Public Crime Data by Kam Zardouzian
# Date: October 7, 2021
# Data Source: San Diego Association of Governments (SANDAG) for most recent 180 days lookback

# DATA SOURCE ########################################################
# Zip File URL: http://www.sandag.org/programs/public_safety/arjis/CrimeData/crimedata.zip

browseURL("https://www.sandag.org/index.asp?classid=14&subclassid=21&projectid=446&fuseaction=projects.detail") # Execute this to go to source location

# INSTALL AND LOAD PACKAGES ################################

# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# Load contributed packages with pacman & psych packages
pacman::p_load(pacman, rio, tidyverse)
# pacman: for loading/unloading packages
# party: for decision trees
# rio: for importing data
# tidyverse: for so many reasons
# 
p_load(psych)           # Load psych package


# LOAD AND PREPARE DATA ####################################
## Load commands
## 
df1 <- read.csv("C:/Users/Kam/Desktop/git/data/ARJISPublicCrime092921.txt")%>%
        as_tibble()%>%
        rename(crimeLegend = CM_LEGEND)%>%
        group_by(community)
view (df1)
str(df1)

# Export to csv file
export(df1,"SDCrime_Sept2021_zip.csv")



# SUMMARIZE DATAFRAME ######################################
summary(df1)  # Gives frequencies for factors only
describe(df1)               # Entire dataframe

# ANALYZE DATA #############################################
# Stacked bars: step 1: create table
df2 <- df1 %>%
        select(ZipCode, community, crimeLegend) %>%
        table() %>%
        print()  # Show table in Console


# Stacked bars: step 1: create graph
df2 %>%
        barplot(legend = rownames(.))  # Draw plot w/legend

# Side-by-side bar
df2 %>%
        barplot(
                legend = rownames(.),  # Dot is placeholder for pipe
                beside = T  # Put bars next to each other
        )
# Export to csv file
export(df2,"SDCrime_Sept2021_zip.csv")
