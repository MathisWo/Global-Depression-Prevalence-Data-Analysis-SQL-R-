-- Countries with the top 10 highest average prevalances
SELECT cd.country, ROUND(AVG(df.prevalence)*100,2) as avg_prevalence_percent
FROM depression_fact df
JOIN country_dim cd
	ON cd.country_id = df.country_id
GROUP BY cd.country
ORDER BY avg_prevalence_percent DESC
LIMIT 10;


-- Years with the top 10 highest average prevalances
SELECT yd.year, ROUND(AVG(df.prevalence)*100,2) as avg_prevalence_percent
FROM depression_fact df
JOIN year_dim yd
	ON yd.year_id = df.year_id
GROUP BY yd.year
ORDER BY avg_prevalence_percent DESC
LIMIT 10;


-- Average prevalence in Germany ("Deutschland")
SELECT ROUND(AVG(df.prevalence)*100,2) as avg_prevalence_percent
FROM depression_fact df
JOIN country_dim cd
	ON cd.country_id = df.country_id
WHERE cd.country = 'Deutschland';



-- Overall rank of Germany ("Deutschland")
WITH countries_ranked AS(
SELECT 
	cd.country,
	RANK() OVER(ORDER BY AVG(df.prevalence) DESC) AS rank
FROM depression_fact df
JOIN country_dim cd
	ON cd.country_id = df.country_id
GROUP BY cd.country
)

SELECT country, rank
FROM countries_ranked
WHERE country = 'Deutschland';


-- Germany's rank over time
WITH countries_ranked AS(
SELECT 
	yd.year, 
	cd.country,
	ROUND(AVG(df.prevalence)*100,2) as avg_prevalence_percent,
	RANK() OVER(PARTITION BY yd.year ORDER BY AVG(df.prevalence) DESC) AS rank
FROM depression_fact df
JOIN country_dim cd
	ON cd.country_id = df.country_id
JOIN year_dim yd
	ON yd.year_id = df.year_id
GROUP BY yd.year, cd.country
)

SELECT year, country, avg_prevalence_percent, rank
FROM countries_ranked
WHERE country = 'Deutschland';


-- Prevalence in 2021 in Germany
SELECT cd.country, yd.year, ROUND(df.prevalence*100, 2) AS prevalence_percent
FROM depression_fact df
JOIN country_dim cd
	ON cd.country_id = df.country_id
JOIN year_dim yd
	ON yd.year_id = df.year_id
WHERE cd.country = 'Deutschland' AND yd.year = 2021;


-- Is the yearly prevalence in Germany higher than the average?
WITH yearly_average AS (
SELECT yd.year, ROUND(AVG(df.prevalence)*100,2) as avg_prevalence_percent
FROM depression_fact df
JOIN year_dim yd
	ON yd.year_id = df.year_id
GROUP BY yd.year
)

SELECT 
	cd.country, 
	yd.year, 
	ROUND(df.prevalence*100, 2) AS prevalence_percent,
	CASE WHEN (ROUND(df.prevalence*100, 2) > ya.avg_prevalence_percent) 
		THEN 'Yes' 
		ELSE 'NO'
	END AS higher_than_avg
FROM depression_fact df
JOIN country_dim cd
	ON cd.country_id = df.country_id
JOIN year_dim yd
	ON yd.year_id = df.year_id
JOIN yearly_average ya 
	ON ya.year = yd.year
WHERE cd.country = 'Deutschland'
ORDER BY yd.year DESC;


-- Rank 1 country of every year
WITH yearly_ranks AS(
SELECT 
	yd.year,
	df.country_id,
	ROUND(df.prevalence*100, 2) AS prevalence_percent,
	ROW_NUMBER() OVER(PARTITION BY yd.year ORDER BY df.prevalence DESC) AS rank
FROM depression_fact df
JOIN year_dim yd
	ON yd.year_id = df.year_id
)

SELECT yr.year, cd.country, yr.prevalence_percent
FROM yearly_ranks yr
JOIN country_dim cd
ON cd.country_id = yr.country_id
WHERE rank = 1;
