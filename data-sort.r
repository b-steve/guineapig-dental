library(lubridate)
## Loading in data.
guineapig.df <- read.csv("data/guineapig-dental-original.csv", stringsAsFactors = FALSE)
## Fixing the zombie guinea pig.
guineapig.df[416, 164] <- "31/1/15"
## Creating a data frame with only the dates.
dates.df <- guineapig.df[, c(which(names(guineapig.df) %in% "weight_diagnosis_date" |
                                   substr(names(guineapig.df), 1, 4) == "date" |
                                   substr(names(guineapig.df), 1, 4) == "Date"), 164, 2)]
## Checking for guinea pigs who were born after  having procedures.
min.date <- dmy(apply(dates.df, 1, function(x) min(x[x != ""])))
dob <- dmy(dates.df[, 14])
which(dob > min.date)
