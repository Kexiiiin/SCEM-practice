## 1 Create your first data frame

animals <- c("Snake", "Ostrich", "Cat", "Spider")
animals

num_legs <- c(0, 2, 4, 8)
num_legs

first_data_frame <- data.frame(animals, num_legs)
first_data_frame

## 2 Matrix operations

x_vect <- seq(12, 2, -2)
x_vect

X <- matrix(x_vect, 2, 3) # create a matrix with 2 rows and 3 colounms called X using 
X

#y_vect <- seq(4)
Y <- matrix(seq(4), 2, 2) # create a matrix with 2 rows and 2 colounms called Y
Y

Z <- matrix(seq(4, 10, 2), 2, 2) # create a matrix with 2 rows and 2 colounms called Y
Z

## use the t() function to computute Y^T and Z^T

Y1 <- t(Y)
Y1

Z1 <- t(Z)
Z1

sum_of_YandZ <- Y + Z
sum_of_YandZ

products_of_YZ <- Y %*% Z
products_of_YZ

products_of_ZY <- Z %*% Y
products_of_ZY
## the matrix multiplication is (%*%) is not commutative

products_of_Y_mul_Z <- Y * Z
products_of_Y_mul_Z

products_of_Z_mul_Y <- Z * Y
products_of_Z_mul_Y
## the element-wise multiplication commutative

## use R to compute the matrix product YX
product_of_YX <- Y %*% X
product_of_YX
## what happens if compute the matrix product XY
product_of_XY <- X %*% Y
product_of_XY
## Error in X %*% Y : 非整合参数

# use compute the matrix inverse Y^(-1) via the solve() function
Y1 <- solve(Y)
Y1
# compute Y1Y and YY1 in R
product_of_Y1Y <- Y1 %*% Y
product_of_Y1Y

product_of_YY1 <- Y %*% Y1
product_of_YY1

# compute Y1X
product_of_Y1X <- Y1 %*% X
product_of_Y1X

# compute Y1X without Y1
product_of_YX_temp <- solve(Y) %*% X
product_of_YX_temp

