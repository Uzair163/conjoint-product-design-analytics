#Installing and loading pacakge
install.packages("data.table")
library(data.table)
set.seed(40385187)

#Reading the perception data
perception.data <- read.csv(file.choose())
summary(perception.data)

#Removing first column since all columns needs to be numeric
new_data <- perception.data[,2:length(perception.data)]

#Getting the Principal Component Scores on Perceptions
pca_score <- prcomp(new_data, retx = T, scale = T)

## Perceptual Map Data - Attribute Factors and CSV File
attribute <- as.data.table(colnames(new_data)); setnames(attribute, 1, "Attribute")
factor1 <- pca_score$rotation[,1]*pca_score$sdev[1]; factor2 <- pca_score$rotation[,2]*pca_score$sdev[2]; path <- rep(1,nrow(attribute))
pca_score_factors <- subset(cbind(attribute, factor1, factor2, path), select = c(Attribute, factor1, factor2, path))
pca_score_origin <- cbind(attribute, factor1 = rep(0,nrow(attribute)), factor2 = rep(0,nrow(attribute)), path = rep(0,nrow(attribute)))
pca_score_attributes <- rbind(pca_score_factors, pca_score_origin)

write.csv(pca_score_attributes, file = file.choose(new=TRUE), row.names = FALSE) ## Name file perceptions_attributes.csv

#computations specifically asked within question
# Compute singular values
singular_values <- pca_score$sdev
singular_values
pca_score_singular_values <- cbind(attribute, `Singular Values` = singular_values)

# Compute loadings
loadings <- pca_score$rotation
loadings
pca_score_loadings <- cbind(attribute, `Loadings` = loadings)

# Compute Proportion of Variance Explained
pve <- (singular_values^2) / sum(singular_values^2)
pve
pca_score_pve <- cbind(attribute, `Proportion of Variance Explained` = pve)

## Perceptual Map Data - Model Factors and CSV File
score1 <- (pca_score$x[,1]/apply(abs(pca_score$x),2,max)[1])
score1
score2 <- (pca_score$x[,2]/apply(abs(pca_score$x),2,max)[2])
score2
pca_score_scores <- subset(cbind(perception.data, score1, score2), select = c(Model, score1, score2))
write.csv(pca_score_scores, file = file.choose(new=TRUE), row.names = FALSE) ## Name file perceptions_scores.csv

