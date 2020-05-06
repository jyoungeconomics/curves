# For math and details, visit: https://divisbyzero.com/2008/12/22/how-to-curve-an-exam-and-assign-grades/

######geometric series (concave curve)
power.curve <- function(grade,alpha=0.75){
  if(alpha<=0 | alpha>=1) stop("Formula requires the condition `0<alpha<1`")
  first <- 100^(1-alpha)
  second <- as.vector(unlist(lapply(grade,function(x){x^alpha})))
  foo <- first*second
  foo <- as.vector(unlist(lapply(foo,function(x){ifelse(x>100,100,x)})))
  return(round(foo,2))
}
#example: 3 students make a 55%, a 78%, and a 90%. Use power curve with alpha=75%.
power.curve(c(55,78,90),3/4)

#######how far from 100% was each grade and how far should they recover?
proportional.curve <- function(grade,alpha=0.25){
  first <- as.vector(unlist(lapply(grade,function(x){((100-x)*alpha)+x})))
  first <- as.vector(unlist(lapply(first,function(x){ifelse(x>100,100,x)})))
  return(round(first,2))
}
#example: 3 students make a 55%, a 78%, and a 90%. Use proportion-of-the-gap curve with alpha=25%.
proportional.curve(c(55,78,90),1/4)

###########how many points to get the top score to 100%?
flat.curve <- function(grade){
  first <- as.vector(unlist(lapply(grade,function(x){(100-max(grade))+x})))
  first <- as.vector(unlist(lapply(first,function(x){ifelse(x>100,100,x)})))
  return(round(first,2))
}
#example: 3 students make a 55%, a 78%, and a 90%. Use flat curve to get the top-scoring
#student to 100%.
flat.curve(c(55,78,90))

###########how many points to get the average to some number%?
avg.curve <- function(grade,desired.avg=85){
  first <- as.vector(unlist(lapply(grade,function(x){(desired.avg-mean(grade))+x})))
  first <- as.vector(unlist(lapply(first,function(x){ifelse(x>100,100,x)})))
  return(round(first,2))
}
#example: 3 students make a 55%, a 78%, and a 90%. Use a mean shifter to get a
#class average of 85%.
avg.curve(grade = c(55,78,90),desired.avg = 85)

###########given a desired avg and min, what line gets me there?
linear.curve <- function(grade,desired.min=60,desired.avg=85){
  intercept <- desired.avg
  slope <- (desired.min-desired.avg)/(min(grade)-mean(grade))
  third <- as.vector(unlist(lapply(grade,function(x){x-mean(grade)})))
  foo <- intercept+slope*third
  foo <- as.vector(unlist(lapply(foo,function(x){ifelse(x>100,100,x)})))
  return(round(foo,2))
}
#example: 3 students make a 55%, a 78%, and a 90%. Use an affine curve to get the class
#average to an 80%, minimum to a 64%.
linear.curve(grade = c(55,78,90),desired.min = 64,desired.avg = 80)

###################
# point to the location of the CSV or .xlsx file containing the grades to be curved
setwd("C:/Users/myusername/folderwithgrades")
# in this example, the column I am curving is called "final score"
groo <- as.numeric(as.matrix(readxl::read_excel("student grades.xlsx")[,"Final Score"]))
# remove students who haven't 
groo <- groo[!is.na(groo)]

#stack the curved grades side-by-side (student names or numbers should appear as row names)
cbind(linear.curve(grade = groo,desired.min = 60,desired.avg = 80),avg.curve(grade = groo,desired.avg = 80),
      flat.curve(groo),power.curve(groo,3/4),proportional.curve(groo,1/4))

#splitting the difference between the 5 methods
rowMeans(cbind(linear.curve(grade = groo,desired.min = 60,desired.avg = 80),avg.curve(grade = groo,desired.avg = 80),
               flat.curve(groo),power.curve(groo,3/4),proportional.curve(groo,1/4)))


