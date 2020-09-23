#### Which countries have the longest MIDs on Average? ####

###Ensure that working directory is set to current file location by going to Session -> Set Working Directory -> To Source File Location 
df_mid <- read.csv("MIDB 4.3.csv", na.strings="-9")

###View first column of data
df_mid[1]

###View first row of data
df_mid[1,]

###View first cell of data
df_mid[1,1]

###View first 100 rows of data
df_mid[1:100,]

### Subsetting Data
df_sub <- df_mid[c('stabb', 'styear','endyear')]

### Creating New Variable
df_sub['duration'] = df_sub$endyear - df_sub$styear

### Eliminate NA Values
df_sub_clean = na.omit(df_sub)

### Aggregate duration of MIDs by country
df_duration <-aggregate(x = df_sub_clean$duration,
                 by = list(df_sub_clean$stabb),
                 FUN = sum)

### Count the total number of MIDs per country
df_duration['total_mids'] <- table(df_sub_clean$stabb)

###View cross-tabulation of two variables
crosstab <- table(df_mid$hostlev,df_mid$fatality)
crosstab

### Create a new variable that is the average duration of MIDs per country
df_duration['avg_mid_dur'] <- df_duration$x/df_duration$total_mids

### Create a histogram to visualize the average duration of MIDs
hist(df_duration$avg_mid_dur,breaks = 37)

###
write.csv(df_duration, 'R_AverageMIDDuration.csv')