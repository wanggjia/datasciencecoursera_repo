## Introduction

This is week4 assignment of R-programming from coursera. 

RequirementAssignment3v2.pdf is the requirement of the assignemnt
outcome-of-care-measure.csv is the input data
Hospital-Revised-Faltfiles.pdf states the format of csv file mentioned above. It also includes statement for other csv files. 

best.R
# Find the hosptial name with lowest fatality rate with outcome in given state. 
best <- function(state, outcome)

rankhospital.R
# Ranking the hospitals by outcome in a state
rankhospital <- function(state, outcome, num) 

rankall.R -- this is only a draft. Not working yet. 4.8.2016
# function takes two argument, outcome as the type of treatment and num as the rank inside state 
# returns a 2-column data frame containing the hospital in each state that has the ranking specified in num. 
rankall <- function(outcome, num) 