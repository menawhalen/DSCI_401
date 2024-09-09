for (j in c("Mena", "Maya", "Micah")) {
  if (j == "Maya") {
    print("I'm a chemist! I'm a twin and the \"middle\" child and my dog is named Ether")
  }
  else if (j == "Micah"){
    print("I'm a bartender! I'm a twin and the youngest and my dog is named Ozzy Pawsborn")
  }
  else {
    print("I'm a statistician! I'm the oldest and my dog's name is Delta and I'm the best!")
  }
}


sum(c(3, 5, 14, 12, NA, 49, 23, 5, 12), na.rm = TRUE)

mean(c(3, 5, 14, 12, NA, 49, 23, 5, 12), na.rm = TRUE)

mean(c("string", "thing"))


x <- 3

ceiling(x*1000/9.6) ## convert to mm and divide by length of brick

legobrick_uppies <- function(x){
  ### x is the length in meters I want tall
  return(ceiling(x*1000/9.6))
}

legobrick_uppies(4)
legobrick_uppies(10)


lego_rec <- function(length, width){
  length_number <- ceiling(length*1000/9.6)
  width_number <- ceiling(width*1000/15.8)
  return(length_number * width_number)
}

lego_rec(3, 3)
