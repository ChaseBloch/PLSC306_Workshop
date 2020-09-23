*** Which countries have the longest MIDs on Average? ***

***Ensure that working directory is set to current file location using the 'cd' command or going to File --> Change Working Directory... You can see the working directory in the bottom left corner.

cd "\\L2HCS-DEM\UserProfiles$\csb257\Documents\Workshop1_Stata"
log using mylog.log, replace

*import delimited "\\L2HCS-DEM\UserProfiles$\csb257\Documents\Workshop1_Stata\MIDB 4.3.csv"

*View basic statistical summary of variables in data
summarize
summarize styear

*Remove NA values based on variables of interest
drop if styear == -9 | endyear == -9

*View frequency of variables in data
tab stabb

*view cross-tabulation of two variables
tab hostlev fatality if hostlev != -9 & fatality != -9
tab hostlev if hostlev != -9 & fatality != -9, summarize(fatality )

*Creating new variable
gen duration = endyear - styear
summarize duration

*Aggregate duration of MIDs by country
bysort stabb: egen total_duration = sum(duration)

*Count the total number of MIDs per country
bysort stabb: egen midfreq = count(stabb)

*Generate variable for average MID duration
gen avg_duration = total_duration/midfreq

*Now that we have aggregated statistics we can drop country duplicates and the variables that are no longer useful
duplicates drop stabb, force
keep stabb total_duration midfreq avg_duration

*Create the histogram 
hist avg_duration, freq bin(37)

*Save and export the new dataset
export delimited using "Stata_AverageMIDDuration", replace