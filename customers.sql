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

-- 
