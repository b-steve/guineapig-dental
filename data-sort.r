library(lubridate)
## Loading in data.
guineapig.df <- read.csv("data/guineapig-dental-original.csv", stringsAsFactors = FALSE)
## Fixing the mangled date.
guineapig.df[389, 100] <- "01/09/11"
## Fixing guinea pig dates of birth (column 2).
guineapig.df[280, 2] <- "27/12/05"
guineapig.df[356, 2] <- "22/08/05"
guineapig.df[375, 2] <- "24/06/09"
guineapig.df[468, 2] <- "03/06/06"
guineapig.df[338, 2] <- "09/10/06"
guineapig.df[358, 2] <- "28/09/14"
guineapig.df[436, 2] <- "29/12/15"
guineapig.df[458, 2] <- "14/02/10"
## Fixing weight at diagnosis.
guineapig.df[195, 17] <- 662
## Fixing date of weight at diagnosis (column 18).
guineapig.df[88, 18] <- "20/10/08"
guineapig.df[165, 18] <- "13/06/14"
guineapig.df[181, 18] <- "22/06/10"
## Fixing guinea pig diagnosis dates (column 51).
guineapig.df[181, 51] <- "22/06/10"
guineapig.df[193, 51] <- "27/08/10"
guineapig.df[195, 51] <- "03/11/14"
guineapig.df[360, 51] <- "18/01/12"
guineapig.df[375, 51] <- "19/01/17"
guineapig.df[384, 51] <- "28/11/12"
## Fixing guinea pig procedure 1 dates (column 52).
guineapig.df[95, 52] <- "11/06/14"
guineapig.df[360, 52] <- "18/01/12"
guineapig.df[375, 52] <- "19/01/17"
guineapig.df[384, 52] <- "29/11/12"
guineapig.df[421, 52] <- "14/01/15"
## Fixing guinea pig procedure 2 dates (column 76).
guineapig.df[412, 76] <- "24/05/11"
## Fixing date of third diagnosis (Date.of.diagnoses.1; column 99).
guineapig.df[450, 99] <- "16/03/2012"
## Fixing date of fourth diagnosis (Date.of.diagnosis.2; column 123).
guineapig.df[356, 123] <- "30/01/12"
## Fixing date of fourth dental procedure (column 124).
guineapig.df[356, 124] <- "31/01/2012"
## Fixing guinea pig death dates (column 162).
guineapig.df[195, 162] <- "03/11/14"
guineapig.df[317, 162] <- "09/08/15"
guineapig.df[358, 162] <- "14/10/16"
guineapig.df[388, 162] <- "01/06/12"
guineapig.df[422, 162] <- "09/11/12"
guineapig.df[430, 162] <- "28/11/11"
## Fixing the zombie guinea pig.
guineapig.df[416, 164] <- "31/1/15"

## STILL TO CHECK:
## Row 309/310 seems to be muddled in email.
## Row 98: Instructed to change weight date from 22/04/15 to 22/03/15. Should I also change diagnosis date from 22/05/15 to 22/03/15?
## Row 182: Confirm this guinea pig weight, diagnosed, died all on 22/06/10.
## Row 194: Confirm this guinea pig weight, diagnosed, died all on 27/08/10.
## Row 422: Should first procedure be 14/05/14 or 14/01/14? Have done the latter.

## Creating a data frame with only the dates.
dates.df <- guineapig.df[, c(which(names(guineapig.df) %in% "weight_diagnosis_date" |
                                   substr(names(guineapig.df), 1, 4) == "date" |
                                   substr(names(guineapig.df), 1, 4) == "Date"), 164, 2)]
## Date of first diagnosis/procedure.
min.date <- ymd(apply(dates.df[, 1:11], 1, function(x) as.character(min(dmy(x), na.rm = TRUE))))
## Date of birth.
dob <- dmy(dates.df[, 14])
## Date of death.
death <- dmy(dates.df[, 12])
## Guinea pigs that were born after any procedures.
which(dob > min.date)
## Guinea pigs that were born after they died.
which(dob > death)

## Date of last diagnosis/procedure.
max.date <- ymd(apply(dates.df[, 1:11], 1, function(x) as.character(max(dmy(x), na.rm = TRUE))))
## Latest alive date from second-to-last column.
latest.alive <- dmy(dates.df[, 13])
## Guinea pigs that need updated.
which(max.date > latest.alive)
## Guinea pigs with a last diagnosis/procedure after death.
which(max.date > death)

## Extracting dates of weight, diagnosis, and first procedure.
weight.date <- dmy(dates.df[, 1])
diagnosis.date <- dmy(dates.df[, 2])
procedure.date <- dmy(dates.df[, 3])
## Differences between these dates.
difftime(diagnosis.date, weight.date, units = "days")
difftime(procedure.date, diagnosis.date, units = "days")
