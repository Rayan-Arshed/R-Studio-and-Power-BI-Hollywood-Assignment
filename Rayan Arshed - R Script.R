# Initializing by importing data set and packages, and analyzing the initial data frame:
df<- read.csv("https://public.tableau.com/app/sample-data/HollywoodsMostProfitableStories.csv")
install.packages("tidyverse")
library(tidyverse)

View(df)
summary(df)
## 74 entries in the data set

str(df)
## 8 Columns in the data set, 3 character strings, integer for scores and years,
## numeric for monetary value like worldwide gross and profitability.


# Checking for missing values:
colSums(is.na(df))
## Seems there are 5 missing values, 1 audience score, 3 profitability values,
## 1 rotten tomatoes score.
## These can be dropped as there is no way for me to retrieve these without
## retrieving new data for the whole set which could make the current data outdated. 

# Dropping missing values:
df <- na.omit(df)
## Double checking nulls have been omitted.
colSums(is.na(df))
## Returns 0 in each column meaning that every null value has been dropped successfully.


# Exploratory Data Analysis:
summary(df)
## Returns mathematical values for each column, specifically interested in the
## Statistical values in the numeric fields.
## Can draw comparisons in that the Rotten Tomatoes scores overall are on average
## Lower than the audience score average.
audience_q1 = quantile(df$Audience..score.., 0.25)
audience_q3 = quantile(df$Audience..score.., 0.75)

tomato_q1 = quantile(df$Rotten.Tomatoes.., 0.25)
tomato_q3 = quantile(df$Rotten.Tomatoes.., 0.75)

audience_IQR = audience_q3 - audience_q1
tomato_IQR = tomato_q3 - tomato_q1
print(paste("Audience IQR = ", audience_IQR, "    Rotten Tomatoes IQR = ", tomato_IQR))
## From the calculations above, it's clear that the Audience is more likely to
## Rate movies around the median due to the lower IQR, meanwhile Rotten Tomatoes
## has a higher IQR, meaning more variance in ratings.


# Drawing graphs:
## Scatter Graph:
ggplot(df, aes(x=Lead.Studio, y=Rotten.Tomatoes..)) + geom_point()+ scale_y_continuous(labels = scales::comma)+coord_cartesian(ylim = c(0, 110))+theme(axis.text.x = element_text(angle = 90))
## Shows the films produced by each studio against the Rotten Tomatoes score for each film,
## allowing for analysis of the performance of each studio's filmography compared to another.
## Companies like Disney seem to be rated fairly high overall, while Warner Bros
## Has some misses with critics despite their number of released films.

## Bar Chart:
ggplot(df, aes(x=Year)) + geom_bar()
## Bar Chart showing the total releases from these studios per year, for example
## 2007 and 2011 saw 11 film releases within those years.
## 2008 Saw the highest amount of film releases, with 2010 following just behind.


# Exporting the Data:
write.csv(df, "clean_df.csv")
## Data has been exported as a new CSV file and the dashboard can now be
## Created in Power Bi.

# Important to note, after cleaning there still was a missing value in the data
# set for the film 'No Reservations' for its lead studio, which having looked up
# was also Warner Bros, so the data has been filled in instead of removed as
# the rest of the entry was valid, while the other missing values were related
# to scores and calculations such as profitability. 

