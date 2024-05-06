#assigning variables
x<-4
x

z<-4
y<-2

#addition
x+y
#substraction
x-y
#division
x/y
#multiplication
x*y
#modulus
x%%y
#power
x^y

#logical operators

# equal to?
x == y
# not equal to?
x != y
# greater than?
x > y
# less than?
x < y
# greater than or equal to?
x >= y
# less than or equal to?
x <= y

(x > y) | (y < x)
(x > y) & (y < x)

c(F,F,F,T,F,F) | c(F,F,F,F,F,F)
c(F,F,F,T,F,F) || c(F,F,F,F,F,F)

c(F,F,F,T,F,F) | c(F,F,F,F,NA,F)
c(F,F,F,T,F,F) || c(F,F,F,F,NA,F)

T | NULL
T || NULL

# are any of these true?
any(c(F,F,F,T,F,F))

# are all of these true?
all(c(F,F,F,T,F,F))

z <- "this"
z1 <- "that"
paste(z,z1)

#Other Operators
#is used generate a sequence.
1:10

#%in% is a set operator. "a" %in% c("x","p","a","c") checks if a is a member of the set x,p,a,c.
"a" %in% c("x","p","a","c")

#The reverse would also work, but the number of returned elements are now different.
c("x","p","a","c") %in% "a"

#And here is another operator that are not so commonly used. %*% is used for matrix multiplication.
matrix(c(2,2,3,3),nrow=2) %*% matrix(c(4,2,5,3),nrow=2)
matrix(c(2,2,3,3),nrow=2) %*% c(6,6)

#Can you write the code to find and print even numbers from a vector of numbers, say 1 to 10? The
#output being 2 4 6 8 10.
x <- c(1:10)
y <- x %% 2
z <- y==0
x[z]

#Data Types
u <- 4
v <- 8
u + v
## [1] 12
u - v
## [1] -4
u * v
## [1] 32
u / v
## [1] 0.5
u^v
## [1] 65536

#Vectors store multiple values. Multiple values, variables and vectors are concatenated together using
#the function c(). See these examples.
x <- c(2,3,4,5,6)
y <- c("a","c","d","e")
x
y

c(2,3,5,6)
2:8
seq(2,5,by=0.5)
rep(1:3,times=2)
rep(1:3,each=2)

#R uses 1-based indexing system and a specific value from a specific location in the vector is accessed
#using the [] operator.
x[1]
y[3]
## [1] 2
## [1] "d"
#The c() function can be used to specify multiple positions.
x[c(1,3)]
## [1] 2 4
#The above vector is 1-dimensional and composed of the same data type (homogenous). Such vectors
#are referred to as atomic vectors.
mode(x)
mode(y)
str(x)
str(y)

#Vectors can be added or concatenated directly. This is referred to as a vectorised operation, a crucial
#concept in R.
x <- c(2,3,4,5)
y <- c(9,8,7,6)
x+y
z <- c("a","an","a","a")
k <- c("boy","apple","girl","mess")
paste(z,k)

#A vector of logical type is called a logical vector.
x <- c(T,F,T,T)
is.logical(x)

c(F,T,F,F) | c(F,F,F,F)
c(F,T,F,F) & c(F,F,F,F)

#Vectors can be named if required.
x <- c("a"=2,"b"=3,"c"=8)
x
## a b c
## 2 3 8
#Named vectors can be subsetted using the name.
x["c"]
## c
## 8
#Factors
#Factors are vectors that store categorical data.
x <- factor(c("a","b","b","c","c"))
x
class(x)
str(x)

levels(x)
## [1] "a" "b" "c"
#The levels are ordered automatically in alphabetical order as seen above. The order can be manually set.
factor(c("a","b","b","c","c"),levels=c("b","a","c"))
## [1] a b b c c
## Levels: b a c

#Verify if an R object is a factor.
is.factor(x)
## [1] TRUE

#Matrix
#Vectors can be assembled into a matrix data structure.

x <- matrix(c(2,3,4,5,6,7))
x

dim(x)
# number of rows
nrow(x)
# number of columns
ncol(x)