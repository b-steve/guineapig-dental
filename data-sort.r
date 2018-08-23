library(lubridate)
## Loading in data.
guineapig.df <- read.csv("data/guineapig-dental-original.csv", stringsAsFactors = FALSE)
## Fixing the zombie guinea pig.
guineapig.df[416, 164] <- "31/1/15"
## Fixing the mangled date.
guineapig.df[389, 100] <- "01/09/11"
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
