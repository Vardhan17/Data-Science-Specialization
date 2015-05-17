### Read thr .rds file from the data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")



# Subset Baltimore City from NEI dataframe (fips == "24510" and type == "ON-ROAD") and calculate total Emission for the given years

library(dplyr)
Baltimore_df <- ( nei %>% 
                    filter(fips == "24510" & type == "ON-ROAD") %>% 
                    select(year, Emissions) %>%
                    group_by(year) %>%
                    summarise(sum(Emissions))
                )

# Changing the column names
names(Baltimore_df) <- c("Year", "Total_Emissions")
                    

# Initiaing the png device
png("Plot-5.png")

# Plotting using ggplot2 pckg
library(ggplot2)

baltimore_plot <- (
                    ggplot(Baltimore_df, aes(Year, Total_Emissions))
                  + geom_point(aes(color = Year), size = 4)
                  + geom_line(aes(color = Year), size = 1)
                  + labs(x = "Year", y = "Total Emissions (Motor Vehicles)", title = "Year v/s Total Emissions(in Tons) by Motor Vehicles - Baltimore City" )
                  )

print(baltimore_plot)

# Device off
dev.off()
