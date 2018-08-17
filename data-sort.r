library(lubridate)

guineapig.df <- read.csv("data/guineapig-dental-original.csv")
dates.df <- guineapig.df[, which(names(guineapig.df) %in% "weight_diagnosis_date" |
                                 substr(names(guineapig.df), 1, 4) == "date" |
                                 substr(names(guineapig.df), 1, 4) == "Date")]
death.date <- dmy(dates.df[, 12])
alive.date <- dmy(guineapig.df[, 164])
da <- cbind(death.date, alive.date)
## We have a zombie!
which(!apply(da, 1, function(x) x[1] >= x[2]))

names(dates.df)

diagnosis.date <- guineapig.df[, 51]
death.date <- as.character(guineapig.df[, 162])
alive.date <- as.character(guineapig.df[, 164])

dates.df[which(is.na(death.date) & is.na(alive.date)), ]
