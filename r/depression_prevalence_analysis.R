library(tidyverse)
library(ggplot2)
library(forcats)
library(lm.beta)

data <- read_csv("depression_prevalence_clean.csv")

# select only relevant data
data_clean <- data %>%
  select(country, year, prevalence)


# yearly global averages
prevalence_per_year <- data_clean %>%
  group_by(year) %>%
  summarize(avg_prevalence_percent = round(mean(prevalence*100), 2))

# country with highest prevalence for every year
data_clean %>%
  group_by(year) %>%
  slice_max(order_by = prevalence, n = 1, with_ties = FALSE)

# country with lowest prevalence for every year
data_clean %>%
  group_by(year) %>%
  slice_max(order_by = -prevalence, n = 1, with_ties = FALSE) 

# average prevalence for brunei
data_clean %>%
  filter(country == "Brunei") %>%
  summarize(avg_prevalence_percent = round(mean(prevalence*100),2))



# base graph for top 10 countries by average prevalence (%)
top10_countries <- data_clean %>%
  group_by(country) %>%
  summarize(avg_prevalence_percent = round(mean(prevalence*100), 2)) %>%
  ungroup() %>%
  
  # top 10
  slice_max(order_by = avg_prevalence_percent, n = 10, with_ties = FALSE) %>%
  
  # plot
  ggplot(aes(avg_prevalence_percent, fct_reorder(country, avg_prevalence_percent))) +
  geom_col(fill = "#2E86AB", color = "black", width = 0.7)

top10_countries


# publication ready visualization for top 10 countries by average prevalence (%)
top10_countries_report <- top10_countries +
  
  # title and axis options
  labs(
    title = "Average Prevalence by Country",
    subtitle = "Top 10 Countries (1990-2021)",
    x = "Prevalence (%)",
    y = "Country"
  ) +
  scale_x_continuous(breaks = 0:9,  limits = c(0, 9)) +
  
  # optional theme choices
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "white", color = NA)
  )

top10_countries_report

ggsave("top10_countries.png", top10_countries_report)




# publication ready visualization for top 10 countries by prevalence (%) in 2021
top10_countries_2021 <- data_clean %>%
  filter(year == 2021) %>%
  mutate(prevalence_percent = round(prevalence*100, 2)) %>%
  
  # top 10
  slice_max(order_by = prevalence_percent, n = 10, with_ties = FALSE) %>%
  
  # plot
  ggplot(aes(prevalence_percent, fct_reorder(country, prevalence_percent))) +
  geom_col(fill = "#2E86AB", color = "black", width = 0.7) +
  
  # title and axis options
  labs(
    title = "Prevalence by Country",
    subtitle = "Top 10 Countries in 2021",
    x = "Prevalence (%)",
    y = "Country"
  ) +
  scale_x_continuous(breaks = 0:9,  limits = c(0, 9)) +
  
  # optional theme choices
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "white", color = NA)
  )

top10_countries_2021

ggsave("top10_countries_2021.png", top10_countries_2021)




# base graph for average prevalence over time
prevalence_over_time <- prevalence_per_year %>%
  ggplot(aes(year, avg_prevalence_percent)) +
  geom_col(fill = "#2E86AB", color = "black", width = 0.7)

prevalence_over_time


# publication ready visualization for average prevalence over time
prevalence_over_time_report <- prevalence_over_time +
  
  # title and axis options
  labs(
    title = "Global Average Prevalence Over Time",
    x = "Year",
    y = "Prevalence (%)"
  ) +
  scale_x_continuous(breaks = seq(1990, 2020, by = 5)) +
  scale_y_continuous(breaks = 0:5, limits = c(0, 5.2))+
  
  # optional theme choices
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "white", color = NA)
  )

prevalence_over_time_report

ggsave("prevalence_over_time.png", prevalence_over_time_report)




# base graph for prevalence in germany over time vs global average
prevalence_germany <- data_clean %>%
  filter(country == "Deutschland") %>%
  mutate(prevalence = round(prevalence*100, 2)) %>%
  
  #joining yearly averages
  inner_join(prevalence_per_year, by = "year") %>%
  
  # plot
  ggplot(aes(year, prevalence)) +
  geom_col(fill = "#2E86AB", color = "black", width = 0.7) + 
  geom_line(aes(y = avg_prevalence_percent), color = "red", size = 1.2)

prevalence_germany


# publication ready visualization for prevalence in germany over time vs. global average
prevalence_germany_vs_avg_report <- prevalence_germany + 
 
   # title and axis option
  labs(
    title = "Prevalence in Germany over Time",
    subtitle = "Global Average in Red",
    x = "Year",
    y = "Prevalence (%)"
  ) +
  scale_x_continuous(breaks = seq(1990, 2020, by = 5)) +
  scale_y_continuous(breaks = 0:5, limits = c(0, 5.2))+
  
  # optional theme choices
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "white", color = NA)
  )

prevalence_germany_vs_avg_report

ggsave("prevalence_germany_vs_avg.png", prevalence_germany_vs_avg_report)

