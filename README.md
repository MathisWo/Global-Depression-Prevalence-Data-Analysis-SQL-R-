# 🧠 Global Depression Prevalence Data Analysis (SQL + R)

This project explores global depression prevalence data using **SQL queries for exploratory analysis** and **R for analysis and visualization**. It builds on a previously developed PostgreSQL database that modeled GBD data related to depression.

## 📌 Project Goals

- Write SQL queries for exploratory analysis (Filtering, Joins, Aggregate Functions, Window Functions, CTEs)
- Further data exploration with R
- Create clean visualizations with R

## 🗃️ Data Source

This project uses a PostgreSQL database structure of a [prior project](https://github.com/MathisWo/Data-Modeling-of-Global-Depression-Prevalence-Data), which was based on depression prevalence estimates from an **IHME** / **Global Burden of Disease (GBD)**  dataset.

📎 **Note**: Due to licensing restrictions, data files are not included here. However you can look up the database structure and how to download the data in my [data modeling project](https://github.com/MathisWo/Data-Modeling-of-Global-Depression-Prevalence-Data).

## 📁 File Structure

```
📂 docs/ 
└── 📄 analysis_report.html # rendered report on github pages
📂 r/
├── 📂 visuals/
└── depression_prevalence_analysis.R
📂 sql_queries/
└── depression_prevalence_analysis.sql
📄 README.md
📄 analysis_report.Rmd

```

## 🛠️ Tools & Technologies

- **PostgreSQL**
- **pgAdmin**
- **SQL**
- **R**
- **RMarkdown**

## 📊 Analysis Highlights

The project covers:

- Summary statistics by country and year
- Country comparisons
- Visualizing prevalence trends using `ggplot2`


## ✍️ Author

**MathisWo**  
M.Sc. Psychology | Aspiring Data Analyst  
[LinkedIn](https://www.linkedin.com/in/mathis-wobst-b37125360/?locale=en_US)



Original data is © IHME and subject to [non-commercial usage restrictions](https://www.healthdata.org/Data-tools-practices/data-practices/ihme-free-charge-non-commercial-user-agreement).

Citation: Global Burden of Disease Collaborative Network. Global Burden of Disease Study 2021 (GBD 2021) Results. Seattle, United States: Institute for Health Metrics and Evaluation (IHME), 2022. Available from https://vizhub.healthdata.org/gbd-results/..
