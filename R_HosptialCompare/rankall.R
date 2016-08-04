library(dplyr)

# function takes two argument, outcome as the type of treatment and num as the rank inside state 
# returns a 2-column data frame containing the hospital in each state that has the ranking specified in num. 
rankall <- function(outcome, num) {
    
    # read the csv file to a data frame careMeasure
    careMeasure <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # all states name to a list
    allStates <- levels(factor(careMeasure[, 7]))
    
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
    
    
    
    # manupilate careMeasure data frame. The final result is subcareMeasure with column Hospital.Name, State, measure. 
    # It is arranged according to a. State; b. measure; c. Hospital.Name
    result <- data.frame("hospital" = character(), "state" = character())    
    subcareMeasure <- filter(select(careMeasure, Hospital.Name, State, measure = colName), measure != "Not Available")
    #subcareMeasure <- arrange(subcareMeasure, State)
    
    subcareMeasure <- arrange(subcareMeasure, State, as.numeric(measure), Hospital.Name)
    state <- character(length = 2)
    j <- 1
    t <- 1
    m <- FALSE
    
    for (i in 1: nrow(subcareMeasure)){
        stateNow <- subcareMeasure[i, 2]
        if (grepl(stateNow, state)){
            j <- j+1
            m <- FALSE
        }else{
            j <- 1
            t <- j
            m <- TRUE
            state <- stateNow
        }
        if (num == "best" & j == 1){
            result[nrow(result)+1, ] <- c(subcareMeasure[i, 1], stateNow)
        }
        else if ( num == j){
            result[nrow(result)+1, ] <- c(subcareMeasure[i, 1], stateNow)
        }
        #else if ( m == TRUE & num > t){
        #    rbind(result, list[c(subcareMeasure[(i-1), 1], subcareMeasure[(i-1), 2])])
        #}
        else if (num == "worst"){
            result[nrow(result)+1, ] <- c(subcareMeasure[i, 1], stateNow)
            if ( i == nrow(subcareMeasure)) {
                result[nrow(result)+1, ] <- c(subcareMeasure[i, 1], stateNow)
            }
        }
        
    }
            
    
}
    
