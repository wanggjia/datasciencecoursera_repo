library(dplyr)

# Find the hosptial name with lowest fatality rate with outcome in given state. 
best <- function(state, outcome) {
    
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
    # Return the hospital name with lowest fatality rate
    # else stop withe error message "invalid state"
    
    allStates <- levels(factor(careMeasure[, 7]))
    
    if (state %in% allStates) {
        subCareMeasure <- select(careMeasure, Hospital.Name,  State, measure = colName)
        subCareMeasure <- filter(subCareMeasure, State == state & measure != "Not Available")
        arrange(subCareMeasure, as.numeric(measure), Hospital.Name)[1, 1]
    }
    else {
        stop("invalid state")
    }
} 