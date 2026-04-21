-- =====================================
-- Purpose: Identify distinct category values in the dataset
-- Insight:
-- - There are 4 valid categories and 1 missing (NULL) value
-- - Used to understand categorical structure

SELECT DISTINCT category 
FROM `playground027.my_eda_project.products`
ORDER BY category;

-- =====================================
-- Purpose: Identify distinct sub-category values in the dataset
-- Insight:
-- - There are 56 valid subcategories and 1 missing (NULL) value
-- - Used to understand sub-categorical structure

SELECT DISTINCT subcategory 
FROM `playground027.my_eda_project.products`
ORDER BY subcategory;

-- =======================================

-- Purpose: Identify distinct product_name values in the dataset
-- Insight:
-- - There are 295 unique products , no NULL value found.
-- - Used to understand products structure

SELECT DISTINCT product_name 
FROM `playground027.my_eda_project.products`
ORDER BY product_name;

-- ========================================
-- Purpose: Identify distinct product_line values in the dataset

-- Insight:
-- - There are 4 unique products lines , one NULL value found.
-- - Used to understand product line structure

SELECT DISTINCT product_line
FROM `playground027.my_eda_project.products`
ORDER BY product_line;

-- ========================================
-- Purpose:
-- Explore the relationship between category and subcategory values
-- to understand how categorical data is structured in the dataset.

-- Insight:
-- - Shows all unique category–subcategory combinations,
--   helping to understand grouping structure and detect inconsistencies
--   such as unexpected or missing pairings.
-- ========================================

SELECT DISTINCT category, subcategory
FROM `playground027.my_eda_project.products`;

--  ========================================
-- Purpose:
-- Explore the relationship between category, subcategory and product values
-- to understand how categorical data is structured in the dataset.

-- Insight:
-- - Shows all unique category–subcategory and product combinations,
--   helping to understand grouping structure and detect inconsistencies
--   such as unexpected or missing combinations.
-- ========================================

SELECT DISTINCT category, subcategory,product_name
FROM `playground027.my_eda_project.products`;

-- =========================================
-- Purpose:
-- To check whether the product_id has any duplicacy of values

--  Insight:
--  No duplicates values were found within product_key
--  =========================================

SELECT product_id
FROM `playground027.my_eda_project.products`
GROUP BY product_id
HAVING COUNT(*) > 1

-- ===========================================
-- Purpose:
-- To check whether the category_id mapping with category

--  Insight:
--  For one category_id is asscociated with one category
--  =========================================

SELECT category_id
FROM `playground027.my_eda_project.products`
GROUP BY category_id
HAVING COUNT(DISTINCT category) > 1

-- ==========================================
-- Purpose: Understand overall cost distribution across all products
-- Insight: Provides baseline metrics (avg, min, max) to identify range,
--          minimum cost is 0 , maximum cost is 2171 and 
-- 			average cost is 431.07 (rounded to 2 decimal places)
-- ===========================================

SELECT 
  SUM(cost) as total_cost,
  MIN(cost) as Min_cost,
  MAX(cost) as Max_cost,
  ROUND(AVG(cost),2) as Avg_cost
FROM `playground027.my_eda_project.products`

-- ============================================
-- Purpose: Understand Missing values for all columns wise on percentage basis
-- Observation: - category has 2.37 % missing value, indicating a low data incompleteness
--              - subcategory has 2.37 % missing value, indicating a low data incompleteness
--              - product_name is fully populated, 0 % missing value indcating data completeness.
--              - product_line is fully populated, 0 % missing value indcating data completeness.
--              - maintenance has 2.37 % missing value, indicating a low data incompleteness
--              - cost is fully populated, 0 % missing value indcating data completeness.
--              - start_date is fully populated, 0 % missing value indcating data completeness.
-- 					
-- =====================================
SELECT 
  (COUNT(*) - COUNT(category)) / COUNT(*) * 100.0 AS category_null_pct
FROM `playground027.my_eda_project.products` ;

SELECT 
	  (COUNT(*) - COUNT(subcategory)) / COUNT(*) * 100.0 AS subcategory_null_pct
FROM `playground027.my_eda_project.products` ;
 
SELECT 
		(COUNT(*) - COUNT(product_name)) / COUNT(*) * 100.0 AS product_name_null_pct
FROM `playground027.my_eda_project.products` ;

 SELECT 
		(COUNT(*) - COUNT(maintenance)) / COUNT(*) * 100.0 AS maintenance_null_pct
FROM `playground027.my_eda_project.products` ;

SELECT
   100.0 * COUNTIF(cost IS NULL) / COUNT(*) AS cost_null_pct
FROM `playground027.my_eda_project.products`;

SELECT
   100.0 * COUNTIF(start_date IS NULL) / COUNT(*) AS date_null_pct
FROM `playground027.my_eda_project.products` ;

SELECT
   100.0 * COUNTIF(product_line IS NULL) / COUNT(*) AS product_line_null_pct
FROM `playground027.my_eda_project.products` ;

-- ==========================================
--  Purpose : To know quantity of such product that cost 0 
--  Observation: -- Found such 2 products.
				 -- Products are HL RoadFrame -Black-58 & HL RoadFrame -Red-58.
                 -- Both products come from one category Components.
				 -- Also they share one similar subcategory RoadFrames.
-- ===========================================

SELECT 
   category,
   subcategory, 
   product_name
FROM `playground027.my_eda_project.products`
WHERE cost = 0
GROUP BY category, subcategory, product_name ;

-- ===========================================
-- Purpose : To understand average cost by category
-- Observation: --  Out of 4 categories `Bikes` has 
--              	highest average cost 969.44 .
--              --  Lowest is Accessories with 13.17 .
--              --  Second highest out of 4 is components 
--                  having a average cost 264.72 .
--              --  Second lowest out of 4 is components 
--                  having a average cost of 24.8 .
--              --  For missing or unknown category 
--                  has average cost of 28.57 .
-- ===========================================
SELECT 
   category,
   ROUND(AVG(cost),2) average_cost_category_wise
FROM `playground027.my_eda_project.products`
GROUP BY category;

-- =============================================
-- Purpose: 	    To understand quantity of products that exist
--          	    within each subcategory.
-- Observation:  --  Road Bikes (43) and Road Frames (33) are the two
--    				 largest subcategories .
--               --  20 out of 37 subcategories have only 1-3 products
--    				 (Locks, Fenders, Chains etc.) — accessories are
--   				 present .
--               --  Jerseys, Shorts, Gloves, Helmets combined have very
--    				 few products .
--               --  NULL subcategory contains 7 products
SELECT 
  subcategory,
  COUNT(product_id)
FROM `playground027.my_eda_project.products`
GROUP BY subcategory
ORDER BY 2 DESC, 1 ASC;
-- ===============================================
-- Purpose: To Know expensive product cost within each subcategory
-- Observation:  -- Road Bikes is expensive subcategory with products worth of 2171
--               -- Mountain Bikes is second expensive subcategory with products worth of 1912
SELECT 
  subcategory,
  COUNT(product_id),
  max(cost) 
FROM `playground027.my_eda_project.products`
GROUP BY subcategory
ORDER BY 2 DESC, 1 ASC ;

-- ================================================
-- Purpose: To know which subcategory has expensive products in quantity terms
-- Observation:  -- Road frames, touring bikes exhibit multiple products at the maximum price point .
--               -- In contrast, many subcategories such as caps, chainer, cleaner and etc have a single product defining the maximum cost .
SELECT subcategory, COUNT(product_id) AS max_cost_count
FROM `playground027.my_eda_project.products` p
WHERE cost = (
  SELECT MAX(cost)
  FROM `playground027.my_eda_project.products`
  WHERE subcategory = p.subcategory
)
GROUP BY subcategory
ORDER BY max_cost_count DESC, subcategory ASC;

-- ===================================================
-- Purpose: To know which subcategory has expensive products in quantity terms
-- Observation:  -- Road frames, touring bikes exhibit multiple products at the maximum price point .
--               -- In contrast, many subcategories such as caps, chainer, cleaner and etc have a single product defining the maximum cost .
SELECT subcategory, COUNT(product_id) AS max_cost_count
FROM `playground027.my_eda_project.products` p
WHERE cost = (
  SELECT MAX(cost)
  FROM `playground027.my_eda_project.products`
  WHERE subcategory = p.subcategory
)
GROUP BY subcategory
ORDER BY max_cost_count DESC, subcategory ASC ;

-- ===================================================
-- Purpose: Understand price segmentation of products 
--          within each subcategory to identify budget,
--          standard, and premium product segments.
-- Observation:
-- - Road Bikes: largest subcategory with mixed
--   high-range and budget-range distribution.
-- - Mountain Bikes: second largest with significant
--   premium product concentration.
-- - Accessories (Locks, Chains, Fenders): predominantly
--   budget-range products (avg cost ~$15-25).
-- - Components: balanced distribution between
--   budget and high-range products.
-- - Unknown subcategory: 7 products segmented based
--   on overall product average cost.

WITH product_stats AS (
SELECT 
  COALESCE(subcategory, 'Unknown') as subcategory,
  product_name,
  product_id,
  cost as product_cost,
  MAX(cost) OVER(PARTITION BY COALESCE(subcategory, 'Unknown')) as max_cost_product_wise,
  MIN(cost) OVER(PARTITION BY COALESCE(subcategory, 'Unknown')) as min_cost_product_wise,
  ROUND(AVG(cost) OVER(PARTITION BY COALESCE(subcategory, 'Unknown')),2) as avg_cost_product_wise
FROM `playground027.my_eda_project.products`
)
SELECT 
  subcategory,
  price_segment,
  COUNT(product_id) AS product_count
FROM (
  SELECT *,
    CASE 
      WHEN product_cost > avg_cost_product_wise  THEN 'High-Range'
      WHEN product_cost < avg_cost_product_wise  THEN 'Budget-Range'
      ELSE 'Standard-Range'
    END AS price_segment
  FROM product_stats
)
GROUP BY subcategory, price_segment
ORDER BY subcategory, price_segment;

 
