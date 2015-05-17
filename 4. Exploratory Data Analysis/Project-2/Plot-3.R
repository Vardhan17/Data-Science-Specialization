# Read thr .rds file from the data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Subsetting, grouping and calculating sum using dplyr package
library(dplyr)

x <- nei %>% filter(fips == "24510") %>% select(year, Emissions, type) 
x <- transform(x, type = factor(type))
x <- x %>% group_by(type, year) %>% summarise(sum(Emissions))

# Changing column names of the subsetted dataset
names(x) <- c("Type", "Year", "Emission")

# Initiaing the png device
png("Plot-3.png")

# Plotting using ggplot2 pckg
library(ggplot2)

x_plot <- (
            ggplot(x, aes(Year, Emission), col = Type)
           + geom_line(aes(color = Type), size = 1)
           + geom_point(aes(color = Type), size = 4)
           + labs(x = "Year", y = "Total Emissions", title = "Year v/s Emissions at different Source Types for Baltimore City" )
           )


print(x_plot)

# Device off
dev.off()

