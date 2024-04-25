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





