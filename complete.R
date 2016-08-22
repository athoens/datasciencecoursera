
complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV file
    
    ## 'id' is an integer vector indicating the monitor ID numders
    ## to be used.
    
    ## Returns a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of comlete cases
    

    nl   <- length(id)  # define the number of the monitors to be read
    nobs <- numeric(nl) # create empty vectors to fill
    
    for(i in 1:nl ) {
        # define the path and read files with id[i]
        file_id <- id[i]
        if(file_id<10) {
            filename <- paste("00",toString(file_id), sep = "")
        } else {
            if(file_id<100) {
                filename <- paste("0",toString(file_id), sep = "")
            } else {
                filename <- toString(file_id)
            }
        }
        path <- paste(directory, "/", filename, ".csv", sep ="")
        filedata <- read.csv(path)
        nobs[i] <- sum(!is.na(filedata[,2] + filedata[,3] ))
    }
    id_nobs.data <- data.frame("id" =  id, "nobs" =  nobs)
    # print(id_nobs.data)
}
