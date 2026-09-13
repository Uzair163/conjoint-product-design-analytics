library(readxl)
library(xlsx)
library(conjoint)
library(dplyr)
# Read the Excel file and store it in a Laptop_DP
product_profiles <- read.csv(file.choose())
product_profiles <- product_profiles[,-1]

#pref_data <- read_excel("C:/Users/Uzair Khan/Downloads/Conjoint Prefernces.xlsx")
pref_data <- read_excel("C:/Users/Uzair Khan/Downloads/Conjoint Prefernces.xlsx")

#set.seed(40385187)

pref_data <- pref_data[,-1]
## Set up attributes and levels as a list
attrib.level <- list(Environmental.friendliness = c("0% CO2 reduction", "30% CO2 reduction", "50% CO2 reduction"), 
                     Delivery.time  = c("14 days", "21 days", "30 days"),
                     Service.Level = c("5-year warranty", 
                                       "5-year warranty & free maintenance",
                                       "5-year warranty, free maintenance and installation, & upgradeability"), 
                     Price = c("1000 GBP", "1200 GBP", "1500 GBP"),
                     Quality.of.material = c ("Market average", 
                                              "A bit higher than market average"),
                     Marketing.Proficiency = c("Not very proficient and poor communication", 
                                               "Very proficient and have good communication skills"))
## Check for correlation in fractional factorial product_profiles
print(cor(caEncodedDesign(product_profiles)))
summary(product_profiles)
## Run the conjoint analysis study

## Set up attributes and levels as a vector and Estimate the part-worths for each respondent
attrib.vector <- data.frame(unlist(attrib.level,use.names=FALSE))
colnames(attrib.vector) <- c("levels")
part.worths <- NULL
for (i in 1:ncol(pref_data)){
  temp <- caPartUtilities(pref_data[,i], product_profiles, attrib.vector)
  ## Pick the baseline case
  ## Adjust coding as needed based on number of attributes and levels
  ## Base Case: Environmental.friendliness 0% CO2 reduction, Delivery.time 14 days, 
  ## Service.Level 5-year warranty, Price 1000 GBP, 
  ## Quality.of.material Market average, Marketing.Proficiency Not very proficient and poor communication"
  Base_Environmental.friendliness <- temp[,"0% CO2 reduction"]; Base_Delivery.time <- temp[,"14 days"]; Base_Service.Level <- temp[,"5-year warranty"]
  Base_Price <- temp[,"1000 GBP"]; Base_Quality.of.material <- temp[,"Market average"]; Base_Marketing.Proficiency <- temp[, "Not very proficient and poor communication"]
  ## Adjust Intercept
  temp[,"intercept"] <- temp[,"intercept"] - Base_Environmental.friendliness - Base_Delivery.time - Base_Service.Level - 
    Base_Price - Base_Quality.of.material - Base_Marketing.Proficiency
  ## Adjust Coefficients
  ## Environmental.friendliness
  L1 <- length(attrib.level$Environmental.friendliness) + 1 ## Add 1 for the intercept
  for (j in 2:L1){temp[,j] <- temp[,j] - Base_Environmental.friendliness}
  ## Delivery.time
  L2 <- length(attrib.level$Delivery.time) + L1
  for (k in (L1+1):L2){temp[,k] <- temp[,k] - Base_Delivery.time}
  ## Service.Level
  L3 <- length(attrib.level$Service.Level) + L2
  for (l in (L2+1):L3){temp[,l] <- temp[,l] - Base_Service.Level}
  ## Price
  L4 <- length(attrib.level$Price) + L3
  for (m in (L3+1):L4){temp[,m] <- temp[,m] - Base_Price}
  ## Quality.of.material
  L5 <- length(attrib.level$Quality.of.material) + L4
  for (n in (L4+1):L5){temp[,n] <- temp[,n] - Base_Quality.of.material}
  ## Marketing.Proficiency
  L6 <- length(attrib.level$Marketing.Proficiency) + L5
  for (o in (L5+1):L6){temp[,o] <- temp[,o] - Base_Marketing.Proficiency}
  part.worths <- rbind(part.worths, temp)
}
rownames(part.worths) <- colnames(pref_data)
print(part.worths)
## Export part-worths from analysis
write.csv(part.worths, file.choose(new=TRUE), row.names = FALSE) ## Name the file conjoint_partworth
