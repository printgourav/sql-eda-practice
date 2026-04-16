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


 
