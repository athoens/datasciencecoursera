## The two functions provide a special form of a matrix 
## which allows to save an inverse of it in cache and 
## retrieve it when called again. 
## The matrix is expected to be invertable.

## 'makeCacheMatrix' function creates a special "matrix" object 
## that can cache its inverse. It returns a list:
## list(set, get, setinv, getinv)

makeCacheMatrix <- function(x = matrix()) {
    In <- NULL
    set <- function(y) {
        x <<- y
        In <<- NULL
    }
    get <- function() x
    setinv <- function(inverse) In <<- inverse
    getinv <- function() In
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}

## 'cacheSolve' computes the inverse of the special "matrix" 
## returned by 'makeCacheMatrix'. If the inverse has already 
## been calculated and the matrix has not changed, 
## then 'cacheSolve' should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    In <- x$getinv()
    if(!is.null(In)) {
        message("getting cached data")
        return(In)
    }
    data <- x$get()
    In <- solve(data, ...)
    x$setinv(In)
    In
}

