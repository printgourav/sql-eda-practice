-- Purpose:
-- To view the structure of the 'sales' table.
-- Observations:
-- The table contains order, product, and customer identifiers.
-- It includes date fields for order, shipping, and due dates.
-- Sales-related fields include sales_amount, quantity, and price.
-- Data types are mostly numeric (INT64) and date-based, suitable for analysis.

SELECT column_name, ordinal_position, data_type FROM `playground027.my_eda_project.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'sales';

-- Purpose:
-- To get the total distinct count of orders, products, and customers in the sales table.
-- Observations:
-- Provides a high-level view of dataset size across key business entities.

SELECT 
  COUNT(DISTINCT order_number) AS total_orders,
  COUNT(DISTINCT product_key) AS total_products,
  COUNT(DISTINCT customer_key) AS total_customers
FROM `playground027.my_eda_project.sales`;

-- Purpose: To Know number of rows exist in total
-- Observation:

SELECT COUNT(*) AS total_rows
FROM `playground027.my_eda_project.sales`;

-- Purpose:
-- To quantify the percentage of missing (NULL) values across key columns in the sales dataset.

-- Observations:
-- order_date has a very low null percentage (~0.03%), indicating minimal missing data.
-- All other columns (shipping_date, due_date, quantity, price) have 0% null values.
-- Overall, the dataset is highly complete with negligible data quality concerns.

SELECT
  COUNT(*) AS total_rows,

  COUNT(CASE WHEN order_number IS NULL THEN 1 END) AS null_orders,
  ROUND(COUNT(CASE WHEN order_number IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_null_orders,

  COUNT(CASE WHEN product_key IS NULL THEN 1 END) AS null_products,
  ROUND(COUNT(CASE WHEN product_key IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_null_products,

  COUNT(CASE WHEN customer_key IS NULL THEN 1 END) AS null_customers,
  ROUND(COUNT(CASE WHEN customer_key IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_null_customers,

  COUNT(CASE WHEN sales_amount IS NULL THEN 1 END) AS null_sales,
  ROUND(COUNT(CASE WHEN sales_amount IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_null_sales,

  COUNT(CASE WHEN order_date IS NULL THEN 1 END) AS null_order_date,
  ROUND(COUNT(CASE WHEN order_date IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_null_order_date,

  COUNT(CASE WHEN shipping_date IS NULL THEN 1 END) AS null_shipping_date,
  ROUND(COUNT(CASE WHEN shipping_date IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_null_shipping_date,

  COUNT(CASE WHEN due_date IS NULL THEN 1 END) AS null_due_date,
  ROUND(COUNT(CASE WHEN due_date IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_null_due_date,

  COUNT(CASE WHEN quantity IS NULL THEN 1 END) AS null_quantity,
  ROUND(COUNT(CASE WHEN quantity IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_null_quantity,

  COUNT(CASE WHEN price IS NULL THEN 1 END) AS null_price,
  ROUND(COUNT(CASE WHEN price IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_null_price

FROM `playground027.my_eda_project.sales`;


-- Purpose:
-- To determine the time span of sales data and recency of transactions.
-- Observations:
-- The dataset ranges from 29-Dec-2010 to 28-Jan-2014, covering a span of ~4 years.
-- The most recent transaction is from 2014, indicating no recent or current data activity.
-- The first order occurred 16 years ago and the last order 12 years ago (relative to current date).

SELECT 
  MIN(order_date) as first_order_date,
  MAX(order_date) as last_order_date,
  DATE_DIFF(MAX(order_date), MIN(order_date), Year) year_span,
  DATE_DIFF(CURRENT_DATE(),MIN(order_date), Year)  first_order_ago,
  DATE_DIFF(CURRENT_DATE(),MAX(order_date), Year) last_order_ago
FROM `playground027.my_eda_project.sales` ;

-- Purpose:
-- To determine the time range and recency of shipping activity in the dataset.
-- Observations:
-- Shipping data ranges from 05-Jan-2011 to 04-Feb-2014, covering a span of ~3 years.
-- The last shipping activity occurred around 12 years ago, indicating no recent fulfillment data.
-- The first shipping record dates back ~15 years from today.
-- Similar to order data, this confirms the dataset is historical and not current.

SELECT 
  MIN(shipping_date) as first_shipping_date,
  MAX(shipping_date) as last_shipping_date,
  DATE_DIFF(MAX(shipping_date), MIN(shipping_date), Year) shipping_year_span,
  DATE_DIFF(CURRENT_DATE(),MIN(shipping_date), Year)  first_shipping_ago,
  DATE_DIFF(CURRENT_DATE(),MAX(shipping_date), Year) last_shipping_ago
FROM `playground027.my_eda_project.sales`;

-- Purpose:
-- To identify the range of due dates in the sales data.
-- Observations:
-- Due dates range from 10-Jan-2011 to 09-Feb-2014.

SELECT 
    MIN(due_date),
    MAX(due_date)
    FROM `playground027.my_eda_project.sales`;
    
-- Purpose:
-- To summarize the pricing distribution by calculating minimum, maximum, average price,
-- and the spread (standard deviation) of prices.
-- Observations:
-- Prices range from 2 to 3578, confirming a wide pricing spectrum.
-- The average price (~486) is significantly lower than the maximum, indicating right-skewness.
-- The high standard deviation (~928) shows substantial variability in prices.
-- This suggests the dataset contains a mix of low-cost items and a few high-value products (possible outliers).

SELECT 
MIN(price) low_price , 
MAX(price) high_price ,
ROUND(AVG(price), 2) average_price,
STDDEV(price) spread
FROM `playground027.my_eda_project.sales` ;

-- Purpose:
-- To evaluate how quantities vary across sales transactions.
-- Observations:
-- Quantity ranges from 1 to 10, but the average is exactly 1.0.
-- The extremely low standard deviation (~0.04) indicates almost all transactions are single-unit purchases.
-- Multi-unit purchases (up to 10) exist but are very rare and have negligible impact on overall distribution.

SELECT 
MIN(quantity) AS min_quantity,
MAX(quantity) AS max_quantity,
SUM(quantity) As total_quantity,
ROUND(AVG(quantity), 2) avg_quantity,
STDDEV(quantity) spread
FROM `playground027.my_eda_project.sales`;

-- Purpose:
-- To analyze purchasing behavior by identifying products that are bought in multiple quantities.
-- Observations:
-- All products have a minimum purchase quantity of 1, indicating single-unit purchases are standard.
-- A small set of products shows higher maximum quantities (e.g., up to 10), suggesting occasional bulk buying.
-- Most products are purchased in low multiples (typically 2–3 units), indicating limited bulk purchase behavior.
-- Products with higher quantity ranges may represent frequently used or high-demand items.

SELECT 
product_key,
MIN(quantity) AS min_quantity,
MAX(quantity) AS max_quantity
FROM `playground027.my_eda_project.sales`
GROUP BY product_key
HAVING MAX(quantity) > 1;


-- Purpose:
-- To examine products purchased in multiple quantities along with their price points.
-- Observations:
-- Only a limited set of products are bought in quantities greater than one, indicating bulk purchases are not widespread.
-- Product 104 shows the highest quantity (10 units) at a relatively low price (10), suggesting price may influence bulk buying.
-- Other products have low maximum quantities (2–5), indicating moderate multi-unit purchases.
-- Bulk purchases occur across a range of prices (from 5 to 64), though higher quantities are generally seen at lower price points.
-- The same product appears with a single price here, but grouping by price ensures capturing any price variation across transactions.

SELECT 
product_key,
price,
MAX(quantity) AS max_quantity
FROM `playground027.my_eda_project.sales`
GROUP BY product_key, price
HAVING MAX(quantity) >  1
ORDER BY 1 ASC;


-- Purpose:
-- To identify products that are only purchased in single units.
-- Observations:
-- All returned products have both minimum and maximum quantity equal to 1.
-- This indicates these products are never purchased in bulk.
-- Suggests a strong single-unit buying pattern, possibly due to product type or usage.
-- These items may represent low-consumption or non-bulk purchase categories.

SELECT 
product_key,
MIN(quantity) AS min_quantity,
MAX(quantity) AS max_quantity
FROM `playground027.my_eda_project.sales`
GROUP BY product_key
HAVING MAX(quantity) = 1;

-- Purpose:
-- To analyze the distribution of sales_amount by identifying its range,
-- central tendency (average), and variability (standard deviation).
-- Observations:
-- Sales amount ranges from 2 to 3578, showing a wide transaction value range.
-- The average (~486) is much lower than the maximum, indicating a right-skewed distribution.
-- High standard deviation (~928) reflects significant variability in transaction values.
-- Most transactions are likely low to mid-value, with a few high-value transactions driving the spread.

SELECT 
MIN(sales_amount) low_sales_amount , 
MAX(sales_amount) high_sales_amount ,
SUM(sales_amount) total_sales,
ROUND(AVG(sales_amount), 2) average_price,
STDDEV(sales_amount) spread
FROM `playground027.my_eda_project.sales` ;

-- Purpose:
-- To verify whether sales_amount equals price * quantity across all transactions.
-- Observation:
-- No mismatch found between sales_amount and price * quantity.
-- sales_amount is fully derived from price * quantity with zero exceptions.
-- This confirms that sales_amount is a redundant column — it adds no new information
-- beyond what price and quantity already provide.
-- Going forward, either column can be used for revenue analysis, but using
-- price * quantity explicitly is more transparent.

SELECT 
  COUNT(*) AS total_rows,
  COUNT(CASE WHEN sales_amount = price * quantity THEN 1 END) AS exact_matches,
  COUNT(CASE WHEN sales_amount != price * quantity THEN 1 END) AS mismatches,
  COUNT(CASE WHEN sales_amount IS NULL THEN 1 END) AS null_sales_amount
FROM `playground027.my_eda_project.sales`;

-- Purpose:
-- To analyze yearly order volume by counting distinct orders per year.
-- Observations:
-- A small number of orders (15) have NULL order_date, indicating missing date records.
-- Order volume starts very low in 2010 (14 orders), suggesting partial or initial data capture.
-- Significant growth is observed from 2011 (2216) to a peak in 2013 (21287).
-- A sharp drop in 2014 (871) likely indicates incomplete data for that year rather than actual decline.
SELECT 
  EXTRACT(YEAR FROM order_date) AS YEAR,
  COUNT(DISTINCT order_number) Total_Orders
FROM `playground027.my_eda_project.sales`
GROUP BY 1
ORDER BY 1 ASC ;

-- Purpose:
-- To evaluate yearly revenue trends by aggregating total sales_amount per year.
-- Observations:
-- Revenue is grouped by order year, including a NULL group due to missing order_date values.
-- Helps identify growth patterns and peak revenue years.
-- Any sharp drop (especially in the latest year) may indicate incomplete data rather than true decline.
-- Formatting with '$' improves readability but converts numeric output to string (limits further calculations).
SELECT 
  EXTRACT(YEAR FROM order_date) AS YEAR,
  CONCAT('$',SUM(Sales_amount)) Sales_worth_of
FROM `playground027.my_eda_project.sales`
GROUP BY 1
ORDER BY 1 ASC;

-- Purpose:
-- To analyze the trend of average sales amount per order across years.
-- Observations:
-- A small portion of records fall under NULL year, due to missing order_date.
-- Average sales value is high in early years (2010–2011 ~ $3100+), then declines over time.
-- A noticeable drop begins in 2012 and becomes significant in 2013 (~$309).
-- 2014 shows an extremely low average (~$23), likely due to incomplete or partial data.
-- Overall pattern suggests either a shift toward lower-value transactions or data inconsistency in later years.
SELECT 
  EXTRACT(YEAR FROM order_date) AS YEAR,
  CONCAT('$',ROUND(AVG(Sales_amount),2)) Sales_worth_of
FROM `playground027.my_eda_project.sales`
GROUP BY 1
ORDER BY 1 ASC;

-- Purpose:
-- To identify the highest transaction value (max sales_amount) for each year.
-- Observations:
-- Peak transaction value reaches $3578 in 2010 and 2011, indicating high-value orders in early years.
-- From 2012–2013, the maximum drops to $2443, suggesting a decline in top-end transactions.
-- 2014 shows a sharp fall to $159, likely due to incomplete data rather than actual business decline.
-- NULL year group ($2320) indicates some high-value transactions exist without a valid order_date.
-- Overall trend suggests decreasing maximum order values over time or data coverage issues in later years.
SELECT 
  EXTRACT(YEAR FROM order_date) AS YEAR,
  CONCAT('$',ROUND(MAX(Sales_amount),2)) Max_Sales_worth_of
FROM `playground027.my_eda_project.sales`
GROUP BY 1
ORDER BY 1;

-- Purpose:
-- To analyze product-wise sales volume by year using total quantity sold.
-- Observations:
-- Provides yearly demand distribution for each product_key.
-- Some products show activity across multiple years, indicating sustained demand.
-- Low quantities in 2010 suggest partial data or initial sales phase.
-- Higher volumes in 2011 reflect increased sales activity or better data coverage.
-- Useful for identifying top-performing products and demand trends over time.
SELECT 
  product_key,
  EXTRACT(YEAR FROM order_date) AS YEAR,
  SUM(quantity)
FROM `playground027.my_eda_project.sales`
GROUP BY 1 , 2 
ORDER BY 1;

-- Purpose:
-- To analyze customer-wise yearly spending by aggregating total sales_amount.
-- Observations:
-- Shows how each customer's contribution varies across years.
-- Helps identify high-value customers and their spending patterns over time.
-- Customers appearing across multiple years indicate repeat engagement.
-- Lower or missing values in certain years may reflect inactivity or incomplete data.
SELECT 
  customer_key,
  EXTRACT(YEAR FROM order_date) AS year,
  SUM(sales_amount) sales_worth_of
FROM `playground027.my_eda_project.sales`
GROUP BY 1, 2 
ORDER BY 1, 2 ASC;

-- Purpose:
-- To analyze yearly Average Order Value (AOV), total orders, and total revenue
-- to understand how order-level spending has trended over time.
-- Observations:
-- AOV peaked in 2011 at $3,192, indicating high-value transactions dominated early years.
-- A sharp and consistent decline in AOV is observed from 2012 ($1,787) through 2013 ($767) and 2014 ($52),
--    suggesting a significant shift toward lower-value transactions over time.
-- Despite falling AOV, total revenue grew substantially — from $7M in 2011 to $16.3M in 2013 —
--    driven by a 551% surge in order volume (2,216 to 21,287 orders), indicating volume compensated for value decline.
-- 2014 shows only 871 orders and $52 AOV, confirming it represents incomplete/partial year data
--    and should be excluded from trend conclusions.
-- 15 orders with NULL order_date contribute $4,992 in revenue at $332 AOV,
--    indicating missing date records that require investigation and cleaning.
-- Overall, the business appears to have shifted from a low-volume, high-value model
--    to a high-volume, low-value model — likely driven by a product mix change
--    toward accessories and lower-cost items in later years.
SELECT
  EXTRACT(YEAR FROM order_date) AS year,
  COUNT(DISTINCT order_number) AS total_orders,
  SUM(sales_amount) AS total_revenue,
  ROUND(SUM(sales_amount) / COUNT(DISTINCT order_number), 2) AS Year_AOV
FROM `playground027.my_eda_project.sales`
GROUP BY year
ORDER BY year ASC;

-- Purpose:
-- Analyze quarterly sales performance by evaluating total orders,
-- total revenue, and average order value (AOV) to understand
-- growth trends and purchasing behavior over time.
-- Observations:
--  Strong growth from 2011 to 2013, with increasing orders and revenue,
--  peaking in 2013 Q4.
--  Average order value (AOV) declines over time (~$3.2K in 2011
--  to <$1K in 2013), indicating a shift toward lower-value transactions.
--  2014 shows a sharp decline in performance, likely due to incomplete data
--  or business slowdown.
--  2010 contains only partial data (Q4), making it non-comparable with full years.
--  Presence of NULL order dates (15 records) introduces minor data quality issues
--  and should be handled before final reporting.

SELECT
  EXTRACT(YEAR FROM order_date) AS Year,
  EXTRACT(QUARTER FROM order_date) AS Quarter,
  COUNT(DISTINCT order_number) AS total_orders,
  SUM(sales_amount) AS total_revenue,
  ROUND(SUM(sales_amount) / COUNT(DISTINCT order_number), 2) AS Avg_order_value
FROM `playground027.my_eda_project.sales`
GROUP BY 1,2
ORDER BY year ASC , Quarter ASC;

-- Purpose:
-- To analyze quarterly sales performance across countries by evaluating
-- order volume, total revenue, and average order value (AOV).
-- Observations:
-- The United States and Australia consistently contribute the highest order volumes and revenue across most quarters.
-- 2011 represents a peak period with high AOV (~$3K+) across all countries, indicating strong high-value transactions.
-- A noticeable decline in AOV begins in 2012 across all regions, dropping to ~$1.6K–$2K, suggesting a shift in purchasing behavior or product mix.
-- Canada shows relatively lower order volumes but maintains comparable AOV to other countries, indicating fewer but high-value transactions.
-- European countries (France, Germany, UK) show moderate and stable contributions without extreme fluctuations.
-- Presence of NULL year/quarter and 'n/a' country indicates minor data quality issues that should be addressed.
-- Early data (2010) is limited to Q4 and should not be directly compared with full-year trends.
SELECT
  EXTRACT(YEAR FROM order_date) AS Year,
  EXTRACT(QUARTER FROM order_date) AS Quarter,
  COUNT(DISTINCT order_number) AS total_orders,
  cus.country,
  SUM(sales_amount) AS total_revenue,
  ROUND(SUM(sales_amount) / COUNT(DISTINCT order_number), 2) AS Avg_order_value
FROM `playground027.my_eda_project.sales` JOIN `playground027.my_eda_project.customer` AS cus
USING(customer_key)
GROUP BY 1,2,4 
ORDER BY year ASC , Quarter ASC, 4 ASC ;

-- Purpose:
-- To analyze customer lifecycle by measuring time between signup and first purchase,
-- along with customer tenure and recency.
-- Observations:
-- days_to_first_order shows how quickly customers convert after joining.
-- days_since_first_order indicates overall customer tenure.
-- days_since_last_order reflects recent activity and helps identify inactive customers.
SELECT 
  customer_key,
  DATE_DIFF(MIN(order_date), MIN(cust.create_date), DAY) AS days_to_first_order,
  DATE_DIFF(CURRENT_DATE(), MIN(order_date), DAY) AS days_since_first_order,
  DATE_DIFF(CURRENT_DATE(), MAX(order_date), DAY) AS days_since_last_order
FROM `playground027.my_eda_project.sales` sale
JOIN `playground027.my_eda_project.customer` cust
USING(customer_key)
GROUP BY customer_key
ORDER BY customer_key;

-- Purpose:
-- To compute core RFM (Recency, Frequency, Monetary) metrics for each customer.
-- Observations:
-- Recency measures how recently a customer made a purchase (lower = more recent, more engaged).
-- Frequency captures how often a customer transacts via distinct order counts.
-- Monetary reflects total revenue contribution per customer.
SELECT
  customer_key,
  DATE_DIFF(CURRENT_DATE(), MAX(order_date), DAY) AS Recency,
  COUNT(DISTINCT order_number) AS frequency,
  SUM(sales_amount) AS monetary
FROM `playground027.my_eda_project.sales`
GROUP BY customer_key;

-- Purpose:
-- To identify the top 10 customers based on total spending.
-- Observations:
-- The top customers have very similar spending levels (~$12.9K–$13.3K), indicating a tightly clustered high-value segment.
-- No single customer significantly outspends others, suggesting relatively uniform high-value behavior.
-- Customer 1302 and 1133 are tied for the highest spend (~$13.3K).
-- The small variation across top customers indicates limited skew at the top end.
-- This group represents the most valuable customers for retention and targeted strategies.
SELECT 
  customer_key,
  CONCAT('$', SUM(sales_amount)) total_spend
  FROM `playground027.my_eda_project.sales`
  GROUP BY customer_key
  ORDER BY SUM(sales_amount) DESC
  LIMIT 10;
  
-- Purpose:
-- To evaluate revenue contribution across product categories.
-- Observations:
-- Bikes dominate revenue (~28.3M), contributing the vast majority of total sales.
-- Accessories generate moderate revenue (~700K), significantly lower than Bikes.
-- Clothing contributes the least (~340K), indicating minimal impact on overall revenue.
-- Business appears heavily dependent on Bike sales, with other categories playing a supporting role.
SELECT 
  category,
  SUM(sales_amount) as revenue
  FROM `playground027.my_eda_project.products` JOIN `playground027.my_eda_project.sales`
  USING(product_key)
  GROUP BY category
  ORDER BY 2 ASC;

-- Purpose:
-- To compare average order value (AOV) across product categories.
-- Observations:
-- Bikes have a significantly higher AOV (~1862), indicating high-ticket purchases.
-- Accessories (~38) and Clothing (~45) have very low AOV, suggesting they are low-cost or add-on items.
-- There is a massive gap between Bikes and other categories, confirming revenue is driven by high-value products.
-- Accessories and Clothing likely contribute through volume rather than value per order.
-- The business model appears to rely on Bikes as primary revenue drivers, with other categories as supplementary sales.
SELECT 
  category,
  ROUND(SUM(sales_amount) / COUNT(DISTINCT order_number), 2) AS Avg_order_value
  FROM `playground027.my_eda_project.products` JOIN `playground027.my_eda_project.sales` 
  USING(product_key)
  GROUP BY category
  ORDER BY 2 ASC;
  
  -- Purpose:
-- To analyze revenue contribution at the subcategory level.
-- Observations:
-- Revenue is heavily concentrated in bike subcategories, with Road Bikes (~14.5M), Mountain Bikes (~9.9M), and Touring Bikes (~3.8M) dominating.
-- Road Bikes generate the highest revenue, making them the primary revenue driver.
-- Accessories and apparel subcategories contribute relatively small amounts, mostly below ~250K.
-- Tires and Tubes (~244K), Helmets (~225K), and Jerseys (~173K) are the top contributors among non-bike items.
-- Low-value items like Socks, Cleaners, and Caps contribute minimal revenue despite likely higher sales volume.
-- Overall revenue distribution is highly skewed toward high-ticket bike products, with other subcategories playing a supporting role.
SELECT 
  subcategory,
  SUM(sales_amount) AS Revenue
  FROM `playground027.my_eda_project.products` JOIN `playground027.my_eda_project.sales`
  USING(product_key)
  GROUP BY 1
  ORDER BY 2 ASC;  

-- Purpose:
-- To evaluate average order value (AOV) across product subcategories.
-- Observations:
-- Clear price segmentation exists: low-value accessories (<$100) vs high-value bikes (>$1700).
-- Subcategories like Cleaners, Caps, and Socks have very low AOV (<$10), indicating small add-on purchases.
-- Mid-range items (e.g., Helmets, Jerseys, Shorts) fall between ~$35–$70, representing moderate-value purchases.
-- Equipment-related items (Bike Racks, Bike Stands) show higher AOV (~$120–$159), indicating functional add-ons.
-- Bike subcategories (Touring, Road, Mountain) dominate with very high AOV (~$1700–$2000).
-- Mountain Bikes have the highest AOV (~$2002), followed by Road and Touring Bikes.
-- Overall, revenue is driven by high-value bike purchases, while accessories contribute through volume.
SELECT 
  category,
  ROUND(SUM(sales_amount) / COUNT(DISTINCT order_number), 2) AS Avg_order_value
  FROM `playground027.my_eda_project.products` JOIN `playground027.my_eda_project.sales` 
  USING(product_key)
  GROUP BY category
  ORDER BY 2 ASC;
    
-- Purpose:
-- To analyze revenue distribution by customer gender.
-- Observations:
-- Female customers contribute slightly higher revenue (~14.8M) compared to male customers (~14.5M).
-- Revenue contribution between male and female segments is nearly balanced.
-- 'n/a' gender contributes a negligible portion (~29K), indicating minimal impact from missing data.
SELECT 
  gender,
  SUM(sales_amount) AS Revenue
  FROM `playground027.my_eda_project.customer` JOIN `playground027.my_eda_project.sales`
  USING(customer_key)
  GROUP BY 1
  ORDER BY 2 ASC;  

-- Purpose:
-- To analyze revenue contribution by marital status.
-- Observations:
-- Married customers generate higher revenue (~15.2M) compared to single customers (~14.2M).
-- The difference is noticeable but not extreme, indicating both segments are important contributors.
-- Revenue distribution is relatively balanced, with a slight skew toward married customers.
-- Suggests married customers may have higher purchasing power or frequency.
  SELECT 
  marital_status,
  SUM(sales_amount) AS Revenue
  FROM `playground027.my_eda_project.customer` JOIN `playground027.my_eda_project.sales`
  USING(customer_key)
  GROUP BY 1
  ORDER BY 2 ASC;  

-- Purpose:
-- To analyze revenue contribution by marital status.
-- Observations:
-- Married customers generate higher revenue (~15.2M) compared to single customers (~14.2M).
-- The difference is noticeable but not extreme, indicating both segments are important contributors.
-- Revenue distribution is relatively balanced, with a slight skew toward married customers.
-- Suggests married customers may have higher purchasing power or frequency.
  SELECT 
  marital_status,
  SUM(sales_amount) AS Revenue
  FROM `playground027.my_eda_project.customer` JOIN `playground027.my_eda_project.sales`
  USING(customer_key)
  GROUP BY 1
  ORDER BY 2 ASC;  
  
  WITH shipping_overview AS (
  SELECT
    country,
    order_number,
    order_date,
    shipping_date,
    due_date,
    EXTRACT(YEAR FROM order_date) AS Year,
    DATE_DIFF(shipping_date, order_date, DAY) AS fulfillment_lag,
    DATE_DIFF(due_date, order_date, DAY) AS delivery_window,
    DATE_DIFF(due_date, shipping_date, DAY) AS buffer_days
  FROM `playground027.my_eda_project.sales`
  JOIN `playground027.my_eda_project.customer`
  USING(customer_key)
  WHERE order_date IS NOT NULL
    AND shipping_date IS NOT NULL
    AND due_date IS NOT NULL
),

shipping_summary AS (
  SELECT 
    country,
    Year,
    AVG(fulfillment_lag) AS avg_fulfillment_day,
    AVG(delivery_window) AS avg_delivery_window,
    AVG(buffer_days) AS avg_buffer_days
  FROM shipping_overview
  GROUP BY country, Year
)

-- Purpose:
-- To measure year-over-year changes in shipping efficiency metrics by country.
-- Observations:
-- Shipping performance metrics remain identical across all years and countries,
-- resulting in 0% YoY variation.
SELECT 
  country,
  Year,
  ROUND(
    100 * (avg_fulfillment_day - LAG(avg_fulfillment_day) OVER(PARTITION BY country ORDER BY Year))
    / NULLIF(LAG(avg_fulfillment_day) OVER(PARTITION BY country ORDER BY Year), 0), 2
  ) AS YoY_avg_fulfillment_pct,
  ROUND(
    100 * (avg_delivery_window - LAG(avg_delivery_window) OVER(PARTITION BY country ORDER BY Year))
    / NULLIF(LAG(avg_delivery_window) OVER(PARTITION BY country ORDER BY Year), 0), 2
  ) AS YoY_avg_delivery_window_pct,
  ROUND(
    100 * (avg_buffer_days - LAG(avg_buffer_days) OVER(PARTITION BY country ORDER BY Year))
    / NULLIF(LAG(avg_buffer_days) OVER(PARTITION BY country ORDER BY Year), 0), 2
  ) AS YoY_avg_buffer_days_pct
FROM shipping_summary
ORDER BY country, Year;

-- Purpose:
-- To calculate cumulative sales growth over time.
-- Observations:
-- Shows how total revenue accumulates across order dates.
-- Helps identify growth trajectory and periods of accelerated sales.
-- Useful for trend analysis and business performance monitoring.
SELECT
  order_date,
  SUM(SUM(sales_amount)) OVER(ORDER BY order_date) AS Running_Total
FROM `playground027.my_eda_project.sales`
WHERE order_date IS NOT NULL
GROUP BY order_date
ORDER BY order_date;






