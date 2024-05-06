#Tutorial for PCA

# remember to install the related packages before calling them via library command!
library(tidyverse)   # data manipulation and visualization  (first load tidyverse and then rlang!)
library(gridExtra)  # plot arrangement
library(ggplot2)     # for ggplot and qplot
library(rlang)         # is needed in tidyverse package

data("USArrests")
head(USArrests, 10)  # show the first 10 lines of the dataset

#Preparing the Data

# compute variance of each variable
apply(USArrests, 2, var)

# create new data frame with centered variables
scaled_df <- apply(USArrests, 2, scale)
head(scaled_df)

#Obviously, we could also apply directly the scale function, with the same results. See below
scaled_df1 <- scale(USArrests)
head(scaled_df1)

#Principal Components

# Calculate eigenvalues & eigenvectors
arrests.cov <- cov(scaled_df)
arrests.eigen <- eigen(arrests.cov)
str(arrests.eigen)                     

# Extract the loadings
(phi <- arrests.eigen$vectors[,1:2])    # see the “,” inside the brackets. All rows.

phi <- -phi     # see the – sign
row.names(phi) <- c("Murder", "Assault", "UrbanPop", "Rape")
colnames(phi) <- c("PC1", "PC2")
phi

# Calculate Principal Components scores
PC1 <- as.matrix(scaled_df) %*% phi[,1]       # %*% in R does matrix multiplication
PC2 <- as.matrix(scaled_df) %*% phi[,2]

# Create data frame with Principal Components scores
PC <- data.frame(State = row.names(USArrests), PC1, PC2)
head(PC)


# Plot Principal Components for each State
ggplot(PC, aes(PC1, PC2)) + 
  modelr::geom_ref_line(h = 0) +
  modelr::geom_ref_line(v = 0) +
  geom_text(aes(label = State), size = 3) +
  xlab("First Principal Component") + 
  ylab("Second Principal Component") + 
  ggtitle("First Two Principal Components of USArrests Data")

#The Proportion of Variance Explained
PVE <- arrests.eigen$values / sum(arrests.eigen$values)
round(PVE, 2)

# PVE (aka scree) plot
PVEplot <- qplot(c(1:4), PVE) + 
  geom_line() + 
  xlab("Principal Component") + 
  ylab("PVE") +
  ggtitle("Scree Plot") +
  ylim(0, 1)

# Cumulative PVE plot
cumPVE <- qplot(c(1:4), cumsum(PVE)) + 
  geom_line() + 
  xlab("Principal Component") + 
  ylab(NULL) + 
  ggtitle("Cumulative Scree Plot") +
  ylim(0,1)

grid.arrange(PVEplot, cumPVE, ncol = 2)

#Built-in PCA Functions

data("USArrests")
head(USArrests, 10)
apply(USArrests, 2, var)
##     Murder    Assault   UrbanPop       Rape 
##   18.97047 6945.16571  209.51878   87.72916

pca_result <- prcomp(USArrests, scale = TRUE)
names(pca_result)
## [1] "sdev"     "rotation" "center"   "scale"    "x"

summary(pca_result)

# means
pca_result$center
##   Murder  Assault UrbanPop  Rape 
##    7.788  170.760   65.540   21.232

# standard deviations
pca_result$scale
##    Murder   Assault  UrbanPop      Rape 
##  4.355510 83.337661 14.474763  9.366385
#The rotation matrix provides the principal component loadings; each column of pca_result$rotation contains the corresponding principal component loading vector.

pca_result$rotation

pca_result$rotation <- -pca_result$rotation
pca_result$rotation

pca_result$x <- - pca_result$x
head(pca_result$x)

biplot(pca_result, scale = 0)

#The prcomp function also outputs the standard deviation of each principal component.
pca_result$sdev

#The variance explained by each principal component is obtained by squaring these values:
  
(VE <- pca_result$sdev^2)

PVE <- VE / sum(VE)
round(PVE, 2)

varPercent <- PVE*100
barplot(varPercent, xlab='PC', ylab='Percent Variance', names.arg=1:length(varPercent), las=1, ylim=c(0, max(varPercent)), col='gray')
abline(h=1/ncol(USArrests)*100, col='red')

pca_result$rotation

sqrt(1/ncol(USArrests))

library(factoextra)
fviz_contrib(pca_result, choice = "var", axes = 1)

#For prcomp: The calculation is done by singular value decomposition (SVD) of the (centered and possibly scaled) data matrix, not by using eigen on the covariance matrix. This is generally the preferred method for numerical accuracy.

#Try this:
  new_pca =princomp(~Murder + Assault + UrbanPop + Rape, data= USArrests, cor=TRUE) 
summary(new_pca, loadings=TRUE)
predict(new_pca)
screeplot(new_pca,type="lines")
biplot(new_pca)








