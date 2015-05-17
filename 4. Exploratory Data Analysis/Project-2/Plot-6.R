### Read thr .rds file from the data

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

### Subset Baltimore City AND LA from NEI dataframe (fips == "24510" | "06037" and type == "ON-ROAD") and 
# calculate total Emission for the given years

library(dplyr)
LA_Baltimore_df <- ( nei %>% 
                    filter( (fips == "24510" | fips == "06037") & type == "ON-ROAD") %>% 
                    select(year, Emissions, fips) %>%
                    group_by(year, fips) %>%
                    summarise(sum(Emissions))
                    )

# Changing fips to City name
LA_Baltimore_df[(LA_Baltimore_df$fips == "24510"), 2] <- "Baltimore City"
LA_Baltimore_df[(LA_Baltimore_df$fips == "06037"), 2] <- "Los Angeles"


# Changing fips to factors
LA_Baltimore_df <- transform(LA_Baltimore_df, fips = factor(fips))

# Changing the column names
names(LA_Baltimore_df) <- c("Year","City", "Total_Emissions")



### Initiaing the png device
png("Plot-6.png")

# Plotting using ggplot2 pckg
library(ggplot2)

LA_Baltimore_plot <- (  ggplot(LA_Baltimore_df, aes(Year, Total_Emissions))
                      + geom_point(aes(color = City), size = 4)
                      + geom_line(aes(color = City), size = 1)
                      + labs(x = "Year", y = "Total Emissions (Motor Vehicles)", title = "Year v/s Total Emissions(in Tons) by Motor Vehicles" )
                    )

print(LA_Baltimore_plot)

# Device off
dev.off()