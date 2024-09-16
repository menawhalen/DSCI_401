vect <- c( 1, 3, 7, 8)
new_vect <- append(vect, c(13, 5))
c(vect, 13, 5)
vect <- c(13, 5, vect)

names(my_list)

names(my_list) <- c("Name", "Age", "Exam_Scores")


ex_list <- list(c(1,4,2,6,3,6), c(325,235,856,230), c(3490,2354))
names(ex_list)
ex_list[[1]]

names(ex_list) <- c("siblings", "weekly", "monthly")

### loop for what is the length of each index value


for (i in 1:length(ex_list)) {
  print(length(ex_list[[i]]))
}


names(ex_list)

for (nam in names(ex_list)) {
  print(length(ex_list[[nam]]))
}


## filter out rows where density if over 100

area_df
area_df$density > 100
area_df[area_df$density > 100, ]
area_df[area_df$density > 100, "state"]

subset(area_df, density > 100)
