## Write a function that takes a directory of data files and a threshold for 
## complete cases and calculates the correlation between sulfate and nitrate 
## for monitor locations where the number of completely observed cases 
## (on all variables) is greater than the threshold. The function should 
## return a vector of correlations for the monitors that meet the threshold 
## requirement. If no monitors meet the threshold requirement, then the 
## function should return a numeric vector of length 0. 
corr <- function(directory, threshhold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV file
    
    ## 'threshhold' is a numeric vector of length 1 indicating the 
    ## number od completely observed observations (on all 
    ## variables) required to compute the correlation between 
    ## nitrate and sulfate; the default is 0
    
    ## Returns a numeric vector of correlations
    ## Note: do not round the result!
    
    # compute the number of comlete cases for all files
    max_set <- complete(directory) 
    nl <- sum(max_set[,2] > threshhold)
    set_ind <- which(max_set[,2] > threshhold)
    
    for(i in 1:nl) {
        # define the path and read files with id[i]
        file_id <- max_set[set_id[i],1]
        if(file_id<10) {
            filename <- paste("00",toString(file_id), sep = "")
        } else {
            if(file_id<100) {
                filename <- paste("0",toString(file_id), sep = "")
            } else {
                filename <- toString(file_id)
            }
        }
        path <- paste("specdata", "/", filename, ".csv", sep ="")
        filedata <- read.csv(path)
        # correlation for one vectors set
        cor(filedata[,2:3])
        print(cor)
    }
    
    
    
}
    