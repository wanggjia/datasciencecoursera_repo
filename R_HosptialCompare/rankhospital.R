library(dplyr)

# Ranking the hospitals by outcome in a state
rankhospital <- function(state, outcome, num) {
    
    # read the csv file to a data frame careMeasure
    careMeasure <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # check if outcome is valid
    # else stop with error message "invalid outcome"
    if (outcome == "heart attack"){
        colName <- 11
    } else if (outcome == "heart failure") {
        colName <- 17    
    }else if (outcome == "pneumonia" ){
        colName <- 23   
    }else {
        stop("invalid outcome")
    }
    
    
    # if value state is one of the States in data, subset the data frame contents only
    # required state and outcome columns. Arrange the result accordign to fatality rate. 
    # and add the rank column to data frame
    # else stop withe error message "invalid state"
    
    allStates <- levels(factor(careMeasure[, 7]))
    
    if (state %in% allStates) {
        subCareMeasure <- select(careMeasure, Hospital.Name,  State, measure = colName)
        subCareMeasure <- filter(subCareMeasure, State == state & measure != "Not Available")
        hospitalRank <- arrange(subCareMeasure, as.numeric(measure), Hospital.Name)
        hospitalRank[, "rank"] <- (1:nrow(hospitalRank))
    }
    else {
        stop("invalid state")
    }
    
    # return the row corresponding to num.
    if (num == "best") {
        hospitalRank[1, 1]
    } else if(num == "worst"){
         hospitalRank[nrow(hospitalRank), 1 ]
    } else if (is.numeric(num)){
        if (as.numeric(num) > nrow(hospitalRank)){
             NA
        }else{
            hospitalRank[num, 1]
        }
    }
} 