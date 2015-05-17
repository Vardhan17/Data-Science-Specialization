# Read thr .rds file from the data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")


# First subset the scc codes from SCC dataframe
coal_df <- scc[grep("[Cc][oO][aA][lL]", scc$Short.Name), ]
scc_codes <- as.character(coal_df[,1])

# Secondly, use the scc codes to match it in NIC dataframe
coal_based_emissions <- nei[(which(nei$SCC %in% scc_code)), ]


# Lastly, subsetting, grouping and calculating sum using dplyr package
library(dplyr)

emission_sum <- (coal_based_emissions %>% 
                   group_by(year) %>% 
                   select(year, Emissions) %>%
                   summarise(sum(Emissions))
                )

names(emission_sum) <- c("Year", "Total_Emisson")

# Initiaing the png device
png("Plot-4.png")

# Plotting using ggplot2 pckg
library(ggplot2)

coal_plot <- (
              ggplot(emission_sum, aes(Year, Total_Emisson))
              + geom_point(aes(color = Year), size = 4)
              + geom_line(aes(color = Year), size = 1)
              + labs(x = "Year", y = "Total Coal Based Emissions", title = "Year v/s Total Emissions by Coal combustion or Coal related sources" )
              )

print(coal_plot)

# Device off
dev.off()
