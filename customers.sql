-- Purpose: To understand gender identity
-- Observation: Customers have identified themselves as male , female, and n/a as among those
--              niether identify them male or female or dont want there gender identity disclose
SELECT distinct gender FROM `playground027.my_eda_project.customer`;

-- Purpose: To understand customers numbers genderwise
-- Observation: There 9341 males, 9128 females and 15 have undisclosed or prefered not share about there gender identity
SELECT distinct gender, Count(*) populations FROM `playground027.my_eda_project.customer` GROUP BY gender;

-- Purpose: To know marital_status of customers
-- Observation: There are two status either Married or Single
SELECT DISTINCT marital_status FROM `playground027.my_eda_project.customer` ;

-- Purpose to know numberwise marital_ststus of customer
-- Observation : There are 10011 customer have stated themselves as married, while 8473 says they are single
SELECT DISTINCT marital_status ,  COUNT(customer_id) FROM `playground027.my_eda_project.customer` 
GROUP BY marital_status;

-- Purpose: To Know customer's nationality.
-- Observation: Our customers belong to Canada, USA, France, Australia, Germany, UK and UK
SELECT DISTINCT country FROM `playground027.my_eda_project.customer`;

-- Purpose: To Know numberwise, natioanlity from which customer belongs.
-- Observation: With Highest being United Status and Second to it stands Australia
SELECT DISTINCT country ,  
COUNT(customer_id) FROM `playground027.my_eda_project.customer` 
GROUP BY country;

-- Purpose: To Know unique first_named customer numberwise
-- Observation: There are 93 such customers that dont share a common first_name
SELECT DISTINCT first_name ,  COUNT(customer_id) FROM `playground027.my_eda_project.customer` 
GROUP BY first_name
HAVING COUNT(customer_id) <= 1;

-- Purpose: To know most common first name amongs customers
-- Observation: 
-- There are 97 customers that share first name as Marcus or Kartherine.
-- Richard being in second
SELECT DISTINCT first_name ,  
COUNT(customer_id) numbers FROM `playground027.my_eda_project.customer` 
GROUP BY first_name
HAVING numbers > 1
ORDER BY numbers DESC;

-- Purpose: To know last name of customer that are unique or less common among customers
-- Observation: There are 126 such customers that have less common lastname.
SELECT DISTINCT last_name ,  
COUNT(customer_id) FROM `playground027.my_eda_project.customer` 
GROUP BY last_name
HAVING COUNT(customer_id) <= 1; 

-- Purpose: To know most common last name amongs customers
-- Observation: There are total such 249 last name amongs these at top most common last name is diaz
SELECT DISTINCT last_name ,  
COUNT(customer_id) FROM `playground027.my_eda_project.customer` 
GROUP BY last_name
HAVING COUNT(customer_id) > 1
ORDER BY 2 DESC;

-- Purpose: To Know the youngest customer from date of birth
-- Observation: The Youngest customer born on`1986-06-25`
SELECT MAX(birthdate) 
FROM `playground027.my_eda_project.customer`;

-- Purpose: To Know the oldest customer from date of birth
-- Observation: The oldest customer born on `1916-02-25`
SELECT MIN(birthdate) 
FROM `playground027.my_eda_project.customer` ;

-- Purpose: To know Top 5 Countries Female customer wise 
-- Observation: The US with 3724 female has most female customer 
--              than rest of the countries following it Australia with 1777
--              then UK 932, France with 891 & finally Germany with 873
SELECT country, gender, COUNT(customer_id) numbers
FROM `playground027.my_eda_project.customer` 
WHERE gender = 'Female'
GROUP BY country, gender
ORDER BY 3 DESC
LIMIT 5 ;

-- Purpose: To identify gender imbalance in customers across countries.
-- Observation : -- Gender distribution is nearly balanced across all countries with differences under 3%.
				 -- United States has the largest customer base and shows almost equal male and female counts (~0.44% male skew).
				 -- United Kingdom and Canada have slightly higher male skew (~2.36%).
				 -- Germany and Australia show mild male dominance (~1–1.7%).
				 -- No country exhibits significant gender imbalance.
				 -- 'n/a' category indicates missing country data that should be cleaned.
With a as (SELECT country, gender, COUNT(customer_id) female_count
FROM `playground027.my_eda_project.customer` 
WHERE gender = 'Female'
GROUP BY country, gender
ORDER BY 3 DESC
),

b as (
SELECT country, gender, COUNT(customer_id) male_count
FROM `playground027.my_eda_project.customer` 
WHERE gender = 'Male'
GROUP BY country, gender
ORDER BY 3 DESC
)

SELECT 
  a.country,
  a.female_count,
  b.male_count,
  ROUND((100 * (b.male_count - a.female_count) /  (b.male_count + a.female_count)),2)  
FROM a 
JOIN b
  ON a.country = b.country;

-- Purpose: To understand the distribution of single customers across countries.
-- Observations:	-- United States has the highest number of single customers (3213), driven by its overall larger customer base.
					-- Australia follows with a relatively high count (1678), indicating a strong presence of single customers.
					-- European countries (France, Germany, United Kingdom) show moderate and comparable levels of single customers.
					-- Canada has the lowest count among listed countries, suggesting a smaller segment size.
					-- The 'n/a' category indicates missing country information, which may affect the completeness of the analysis.
SELECT 
	country, 
	COUNT(customer_id) AS singles
FROM `playground027.my_eda_project.customer`
WHERE marital_status = 'Single'
GROUP BY country
ORDER BY 2 DESC;

-- Purpose:
-- To understand the distribution of single customers by country and gender.

-- Observations: -- United States has the highest number of single customers, with females (1716) slightly higher than males (1497).
-- Australia also shows a similar pattern, with more single females (876) than males (802).
-- France is nearly balanced between male (502) and female (501) single customers.
-- Germany and United Kingdom show a slight male dominance among single customers.
-- Canada has more single females (356) than males (314).
-- 'n/a' gender and country values indicate missing data that should be cleaned for accurate analysis.
-- Overall, gender distribution among single customers is fairly balanced with minor variations across countries.

SELECT country, gender, COUNT(customer_id) AS singles
FROM `playground027.my_eda_project.customer`
WHERE marital_status = 'Single'
GROUP BY country, gender
ORDER BY 3 DESC;

-- Purpose:
-- To understand the distribution of married customers by country and gender

-- Observations:
-- United States has the highest number of married customers, with males (2260) exceeding females (2008).
-- Australia shows a similar pattern, with more married males (1012) than females (901).
-- United Kingdom is relatively balanced, though males (522) slightly outnumber females (510).
-- Canada shows a noticeable male skew (490 vs 411).
-- Germany and France also exhibit mild male dominance among married customers.
-- Across all countries, married male customers consistently outnumber married females.
-- 'n/a' values in country and gender indicate missing data that should be addressed for accuracy.

SELECT country, gender, COUNT(customer_id) AS singles
FROM `playground027.my_eda_project.customer`
WHERE marital_status = 'Married'
GROUP BY country, gender
ORDER BY 3 DESC;


-- Purpose:
-- To identify the number and percentage of missing (NULL) values in the birthdate column.
-- Observations:
-- There are 17 such records or 0.09%  missing birthdate values.
-- The number of missing entries is relatively small compared to the overall dataset.
-- These null values may have minimal impact but should still be handled before age-based analysis.

SELECT COUNT(*) - COUNT(birthdate) AS Null_Found
FROM `playground027.my_eda_project.customer`;

SELECT 
  (COUNT(*) - COUNT(birthdate)) * 100.0 / COUNT(*) AS Birthdate_null_percentage
FROM `playground027.my_eda_project.customer`;

SELECT
 *,
  COALESCE(
    CAST(DATE_DIFF(CURRENT_DATE(), birthdate, YEAR) AS STRING),
    'Missing_value'
  ) AS Age_as_on_today
FROM `playground027.my_eda_project.customer`;

-- Purpose: -- To count customer records with valid age (0–100) and complete demographic data (country and gender).
-- Observations:
-- A total of 18,097 records meet all validation criteria.
-- These records exclude NULL birthdates, unrealistic ages, and 'n/a' values in country and gender.
-- Compared to the earlier valid age count (18,448), 351 additional records were removed due to missing country or gender.
-- This refined dataset is suitable for demographic analysis involving age, country, and gender.


SELECT COUNT(customer_id) valid_Records
FROM `playground027.my_eda_project.customer`
WHERE birthdate IS NOT NULL
  AND DATE_DIFF(CURRENT_DATE(), birthdate, YEAR) BETWEEN 0 AND 100
  AND COUNTRY <> 'n/a' AND gender <> 'n/a' ;


-- Purpose: -- To assess data quality by identifying missing and invalid values across key fields.
-- Observations:
-- There are 17 records with missing birthdate and 19 records with age above 100, indicating minor age-related data issues.
-- A larger number of records have missing country information (337), making it the most significant data quality concern.
-- Only 15 records have missing gender values, indicating relatively complete gender data.
-- These counts may overlap (i.e., the same record can have multiple issues), so they should not be summed directly.
-- Overall, country field requires the most attention for data cleaning.

SELECT
  COUNTIF(birthdate IS NULL) AS null_birthdate,
  COUNTIF(DATE_DIFF(CURRENT_DATE(), birthdate, YEAR) > 100) AS age_above_100,
  COUNTIF(country = 'n/a') AS missing_country_name,
  COUNTIF(gender = 'n/a') AS missing_gender_value
FROM `playground027.my_eda_project.customer`;

-- Purpose:  -- To create a cleaned subset of customer data with valid age and complete demographic fields.
-- Observations:
-- The CTE filters out records with missing birthdate, unrealistic ages (outside 0–100), and 'n/a' values in country and gender.
-- The resulting dataset represents a refined and reliable population for demographic and age-based analysis.
-- This approach centralizes data cleaning logic, making downstream queries more consistent and reusable.

WITH clean_records_of_customers AS (
SELECT 
    customer_key,
    customer_id,
    customer_number,
    first_name,
    last_name,
    country,
    marital_status,
    gender,
    birthdate,
    DATE_DIFF(CURRENT_DATE(), birthdate, YEAR) as age,
    create_date
FROM `playground027.my_eda_project.customer`
WHERE birthdate IS NOT NULL
    AND DATE_DIFF(CURRENT_DATE(), birthdate, YEAR) BETWEEN 0 AND 100
    AND country <> 'n/a'
    AND gender <> 'n/a'
)
SELECT * FROM clean_records_of_customers;

-- Purpose:
-- To segment customers into age groups and understand the distribution across different life stages.
-- Observations:
-- The majority of customers fall in the Middle-aged group (40–59) with 11,377 customers, indicating a strong concentration in this segment.
-- Senior customers (60–80) form the second largest group with 6,052 customers, showing a significant older customer base.
-- Customers aged 80+ are relatively few (668), indicating a very small elderly segment.
-- Overall, the customer base is skewed toward middle-aged individuals, with decreasing representation in higher age groups.

SELECT 
CASE 
  WHEN age < 40 THEN 'Young (<40)'
  WHEN age BETWEEN 40 AND 59 THEN 'Middle-aged (40–59)'
  WHEN age BETWEEN 60 AND 80 THEN 'Senior (60–80)'
  ELSE '80+'
END AS age_group,
COUNT(customer_id) AS Number_of_customers
FROM clean_records_of_customers
GROUP BY Age_Group 
ORDER BY 2 DESC;

-- Purpose:
-- To compare customer age group distribution across countries and identify demographic patterns.
-- Observations:
-- Middle-aged customers (40–59) dominate across all countries, forming the largest segment consistently.
-- The United States leads in customer count across all age groups, reflecting its larger customer base.
-- Senior customers (60–80) represent a substantial portion in every country, indicating a mature customer demographic.
-- The 80+ segment remains minimal across all regions, showing limited presence of very elderly customers.
-- Age distribution patterns are uniform across countries, suggesting similar demographic structures globally.
-- Variations between countries are driven more by total volume than by differences in age composition.

SELECT 
Country,
CASE 
  WHEN age < 40 THEN 'Young (<40)'
  WHEN age BETWEEN 40 AND 59 THEN 'Middle-aged (40–59)'
  WHEN age BETWEEN 60 AND 80 THEN 'Senior (60–80)'
  ELSE '80+'
END AS age_group,
COUNT(customer_id) AS Number_of_customers
FROM clean_records_of_customers
GROUP BY Age_Group, Country
ORDER BY country, Number_of_customers DESC;

-- Purpose:
-- To understand how married customers are distributed across age groups within each country.
-- Observations:
-- Married customers are primarily concentrated in the Middle-aged (40–59) group across all countries.
-- Senior (60–80) married customers form the second largest segment, indicating a significant older married population.
-- The Young (<40) married segment is relatively small across all regions, suggesting lower early-marriage representation.
-- The 80+ group is minimal in every country.
-- The United States has the highest number of married customers in all age groups, followed by other countries with similar proportional patterns.
-- Overall, the age distribution of married customers is consistent across countries, with differences mainly driven by total volume rather than structure.

SELECT 
Country,
CASE 
  WHEN age < 40 THEN 'Young (<40)'
  WHEN age BETWEEN 40 AND 59 THEN 'Middle-aged (40–59)'
  WHEN age BETWEEN 60 AND 80 THEN 'Senior (60–80)'
  ELSE '80+'
END AS Agegroup,
COUNT(customer_id) AS Number_of_customers
FROM clean_records_of_customers
WHERE marital_status = 'Married'
GROUP BY Agegroup, Country
ORDER BY country, Number_of_customers DESC;

-- Purpose:
-- To analyze marital status distribution (married vs single) across age groups and countries, and quantify their proportions.
-- Observations:
-- Middle-aged customers (40–59) show near-balanced or single-dominant patterns in some countries (e.g., Australia ~50/50, France skewed toward singles).
-- Senior (60–80) and 80+ groups consistently show higher married percentages across most countries, indicating stronger marital stability with increasing age.
-- Canada and Australia exhibit a clear shift toward married customers as age increases, with married_pct rising significantly in older groups.
-- France is an outlier in the middle-aged group, where single customers dominate (63.66%), unlike other countries.
-- The 80+ segment, while small in volume, has the highest married proportions in most countries, reinforcing the age–marriage correlation.
-- Overall, there is a clear trend: likelihood of being married increases with age across countries, with some regional variation in younger segments.

SELECT 
  country,
  CASE 
    WHEN age < 40 THEN 'Young (<40)'
    WHEN age BETWEEN 40 AND 59 THEN 'Middle-aged (40–59)'
    WHEN age BETWEEN 60 AND 80 THEN 'Senior (60–80)'
    ELSE '80+'
  END AS age_group,
  COUNT(customer_id) AS overall_customers,
  COUNTIF(marital_status = 'Married') AS married_customers,
  COUNTIF(marital_status = 'Single') AS single_customers,
  ROUND(COUNTIF(marital_status = 'Married') * 100.0 / COUNT(customer_id), 2) AS married_pct,
  ROUND(COUNTIF(marital_status = 'Single') * 100.0 / COUNT(customer_id),  2) AS single_pct
FROM clean_records_of_customers
GROUP BY age_group, country
ORDER BY country ASC, married_customers DESC;


-- Purpose:
-- To analyze monthly customer acquisition trends over time.
-- Observations:
-- Customer acquisition is highly uneven across months, with significant spikes in October 2025 (4,178) and January 2026 (13,763).
-- November (30) and December (126) show extremely low counts, suggesting incomplete data capture or partial months rather than true business trends.
-- January 2026 represents the peak, accounting for the majority of new customers in the observed period.
-- Overall, the data does not reflect a smooth monthly trend and should be interpreted with caution.

SELECT 
  FORMAT_DATE('%Y-%m', create_date) AS YYYY_MM,
  COUNT(customer_id) AS new_customers
FROM clean_records_of_customers
GROUP BY YYYY_MM
ORDER BY YYYY_MM ASC;

-- Purpose:
-- To analyze monthly customer acquisition segmented by age group and marital status.
-- Observations:
-- October 2025 shows strong customer acquisition across all age groups, with Middle-aged (40–59) contributing the largest share.
-- In October, Middle-aged customers are more single-heavy, while Senior (60–80) and 80+ groups are predominantly married.
-- November and December 2025 have very low counts across all segments, indicating incomplete or partial data rather than actual decline.
-- January 2026 shows a sharp spike in new customers, especially in the Middle-aged group, with a near-balanced split between married and single customers.
-- Across months, younger segments tend to have higher single proportions, while older segments (60+) consistently show higher married counts.
-- Overall, acquisition trends are irregular, suggesting batch data loads or reporting cutoffs rather than steady growth patterns.

SELECT 
  CASE 
    WHEN age < 40 THEN 'Young (<40)'
    WHEN age BETWEEN 40 AND 59 THEN 'Middle-aged (40–59)'
    WHEN age BETWEEN 60 AND 80 THEN 'Senior (60–80)'
    ELSE '80+'
  END AS age_group,
  FORMAT_DATE('%Y-%m', create_date) AS YYYY_MM,
  COUNT(customer_id) AS new_customers,
  COUNTIF(marital_status = 'Married')AS new_married_customers,
  COUNTIF(marital_status = 'Single')AS new_single_customers
FROM clean_records_of_customers
GROUP BY YYYY_MM, age_group
ORDER BY YYYY_MM  ASC ;

-- Purpose:
-- To analyze customer acquisition trends by country, age group, and month.
-- Observations:
-- October 2025 shows strong acquisition across all countries, with the United States contributing the highest volumes, especially in the Middle-aged (40–59) segment.
-- Across all countries, Middle-aged customers consistently form the largest share of new customers, followed by Seniors (60–80), with 80+ being minimal.
-- November and December 2025 show extremely low acquisition across all countries and age groups, indicating likely partial or incomplete data.
-- January 2026 exhibits a sharp surge in new customers across every country, with particularly high growth in the United States and Australia.
-- The spike in January is most pronounced in the Middle-aged segment, reinforcing it as the primary driver of customer growth.
-- Senior customer acquisition is also substantial in January across all regions, indicating strong engagement from older demographics.
-- The 80+ segment remains consistently small across all months and countries.
-- Overall, acquisition patterns are inconsistent over time, suggesting batch data loads or reporting cutoffs rather than steady month-on-month growth.
SELECT 
  Country,
  CASE 
    WHEN age < 40 THEN 'Young (<40)'
    WHEN age BETWEEN 40 AND 59 THEN 'Middle-aged (40–59)'
    WHEN age BETWEEN 60 AND 80 THEN 'Senior (60–80)'
    ELSE '80+'
  END AS age_group,
  FORMAT_DATE('%Y-%m', create_date) AS YYYY_MM,
  COUNT(customer_id) AS new_customers
FROM clean_records_of_customers
GROUP BY  YYYY_MM, age_group, Country
ORDER BY  country ASC,  age_group ASC, YYYY_MM ASC ;

-- Purpose:
-- To perform a detailed month-over-month (MoM) analysis of new customer acquisition by country and age group,
-- including gender composition and growth trends.
-- Observations:
-- Customer acquisition shows extreme volatility, with sharp drops in Nov–Dec 2025 followed by very large spikes in Jan 2026 across all countries and age groups.
-- MoM growth percentages are highly inflated (e.g., >5000% or even >18000%) due to very low or near-zero base values in prior months, limiting their analytical reliability.
-- Middle-aged (40–59) customers consistently drive the highest acquisition volumes and dominate growth across all countries.
-- Gender participation remains stable (~45–55%) in high-volume months (e.g., Jan 2026), indicating a balanced gender distribution in reliable data periods.
-- In low-volume months, gender percentages fluctuate significantly, which is a sample size effect rather than a real behavioral shift.
-- Female and male MoM trends closely mirror overall customer trends, suggesting no strong gender-specific acquisition bias.
-- Countries like the United States, Australia, and Canada exhibit the largest spikes in Jan 2026, indicating bulk data inflow or onboarding events rather than organic growth.
-- Smaller segments (especially 80+) show exaggerated MoM changes due to low counts, making trend interpretation less meaningful for these groups.
-- Overall, trends are inconsistent over time, and MoM metrics should be interpreted with caution, especially when prior month values are very low or zero.

WITH New_customers_data AS (
  SELECT Country,
  CASE 
    WHEN age < 40 THEN 'Young (<40)'
    WHEN age BETWEEN 40 AND 59 THEN 'Middle-aged (40–59)'
    WHEN age BETWEEN 60 AND 80 THEN 'Senior (60–80)'
    ELSE '80+'
  END AS age_group,
  FORMAT_DATE('%Y-%m', create_date) AS YYYY_MM,
  COUNT(customer_id) AS new_customers,
  COUNTIF(gender = "Female") as new_female_customers,
  ROUND(COUNTIF(gender = "Female") * 100 / COUNT(customer_id),2) female_participation,
  COUNTIF(gender = "Male") as new_male_customers,
  ROUND(COUNTIF(gender = "Male") * 100 / COUNT(customer_id),2) male_participation,
  COUNTIF(marital_status = "Single") as single_customers,
  ROUND(COUNTIF(marital_status = "Single") * 100 / COUNT(customer_id),2) single_pct,
  COUNTIF(marital_status="Married") married_customer,
  ROUND(COUNTIF(marital_status = "Married") * 100 / COUNT(customer_id),2) married_pct
FROM clean_records_of_customers
GROUP BY  YYYY_MM, age_group, Country
ORDER BY  country ASC, age_group ASC, YYYY_MM ASC 
)
SELECT Country, age_group, YYYY_MM, new_customers,
COALESCE(LAG(new_customers) OVER(PARTITION BY Country, age_group Order by YYYY_MM),0) AS prev_mth_customer,
ROUND(COALESCE((new_customers - LAG(new_customers) OVER (PARTITION BY Country, age_group ORDER BY YYYY_MM)) / NULLIF(LAG(new_customers) OVER (PARTITION BY Country, age_group ORDER BY YYYY_MM), 0),0) * 100,2)AS `MoM%_New_Customers`,
  new_female_customers,
  female_participation,
COALESCE(LAG(new_female_customers) OVER(PARTITION BY Country, age_group Order by YYYY_MM),0) AS prev_mth_female_customers,
ROUND(COALESCE((new_female_customers - LAG(new_female_customers) OVER(PARTITION BY Country, age_group ORDER BY YYYY_MM))/NULLIF(LAG(new_female_customers) OVER(PARTITION BY Country, age_group ORDER BY YYYY_MM),0), 0)* 100,2) as `MoM%_New_female_Customers`,
  new_male_customers,
  male_participation,
COALESCE(LAG(new_male_customers) OVER(PARTITION BY Country, age_group Order by YYYY_MM),0) AS prev_mth_male_customer,
ROUND(COALESCE((new_male_customers - LAG(new_male_customers) OVER(PARTITION BY Country, age_group ORDER BY YYYY_MM))/NULLIF(LAG(new_male_customers) OVER(PARTITION BY Country, age_group ORDER BY YYYY_MM),0),0)* 100,2) as `MoM%_New_male_customers`
FROM New_customers_data;

