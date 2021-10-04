## Now within your script create a short function called “myFirstRFunc” 
## which takes in a single numerical argument n and outputs 
## the sum of all those numbers strictly below n which are divisible 
## by either 2 or 7 or both.

myFisrstRFunc <- function(num){
  result <- 0
  v <- seq(num - 1)
  for(i in v){
    if(i %% 2 == 0 || i %% 7 == 0){
      result <- result + i
    }
  }
  return(result)
}

myFisrstRFunc(1000)  

