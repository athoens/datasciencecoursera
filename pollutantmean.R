
pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV file
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate"
    
    ## 'id' is an integer vector indicating the monitor ID numders
    ## to be used.
    
    ## Return the mean of pollitant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    ## Note: do not round the result!
    
    nl <- length(id)  # define the number of the monitors to be read
    
    for(i in 1:nl ) {
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
        path<-paste(directory, "/", filename, ".csv", sep ="")
        filedata <- read.csv(path)
        if(pollutant=="sulfate") {
            #print( pollutant)
            all_pollut <- filedata$sulfate
            #print(all_pollut)
          } else {
            if(pollutant=="nitrate") {
                all_pollut <- filedata$nitrate
            } else {
                stop('pollutant has to be either "sulfate" or "nitrate"')
            }
          }
        readdata <- (all_pollut)
        if(i==1) {
            fulldata <- c(readdata)
        } else {
            fulldata <- c(fulldata, readdata)
        }
    }
    mean(fulldata, na.rm=TRUE)
}
