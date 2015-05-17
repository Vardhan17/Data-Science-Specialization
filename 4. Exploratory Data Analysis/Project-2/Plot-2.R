# Read thr .rds file from the data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Subsetting, grouping and calculating sum using dplyr package

library(dplyr)
x <- nei %>% filter(fips == "24510") %>% select(year, Emissions) %>% group_by(year) %>% summarise(sum(Emissions))

# Initiaing the png device
png("Plot-2.png")

# Changing plot parameter to default 
plot.new()
par( mfrow = c(1,1), mar = c(5,4,4,1))

# Plotting the data and showing linear relationship
plot(x, col = "red", pch =16, xaxt = "n",type = "b", xlab = "Year", ylab = "Total Emission", main = "Total Emissions Yearwise for Baltimore City")
axis(side = 1, at = c(1999, 2002, 2005, 2008))


# Device off
dev.off()
