## for loop for odd numbers
for (i in 0:9) {
  print(2*i+1)
}
## another way for odd numbers using logic statements
for (i in 1:20) {
  if (i%%2 == 1){
    print(i)
  } else {
    print(i+1)
  }
}


## for loop for fib sequence
x <- 1
y <- 1
print(x)
print(y)
for (i in 1:10) {
  sum <- x+y
  print(sum)
  x <- y
  y <- sum
}

## another way to make a fib seq using list
fib_list <- list()
fib_list[[2]] <- 1
fib_list[[3]] <- 1
for (i in 4:100) {
  fib_list[[i]] = fib_list[[i-1]] + fib_list[[i-2]]
}

fib_list

###
## exercise
x <- 3 ## i want 3 m tall lego block
## how to calculate number of block to go up to x meter
x/9.6*1000

lego <- function(height){
  return(height*1000/9.6)
}

lego(1)

### now with lego width being 31.8 mm what volume would you need for a square
## also change to feet 1 meter = 3.28 ft
y <- 2
x/9.6*1000/3.28 ## height in ft
x/9.6*1000/3.28*(y/31.8*1000/3.28)

lego_square <- function(height, width){
  return(height/9.6*1000/3.28*(width/31.8*1000/3.28))
}

lego_square(10,10)
