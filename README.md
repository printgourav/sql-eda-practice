# Products EDA using BigQuery

##  Project Summary
This is an **exploratory data analysis (EDA) learning project** using **Google BigQuery** to analyze a product dataset. 
I've created a SQL-based analysis of 295 products across 11 dimensions to understand data structure, quality, and patterns.

### Goal 
Understand structure, data quality, and cost distribution of products across categories

## Dataset Information
**Database:** `playground027.my_eda_project.products`
| Attribute | Details |
|-----------|----------|
| **Total Records** | 295 products |
| **Total Columns** | 11 columns |
| **Data Types** | Integer, String, Date |
| **Storage** | Google BigQuery |

### Column Overview
| Column | Type | Purpose |
|--------|------|----------|
| `product_key` | Integer | Unique identifier for products |
| `product_id` | Integer | Alternate product identifier |
| `product_number` | String | Product number format |
| `product_name` | String | Human-readable product name |
| `category_id` | String | Category identifier |
| `category` | String | Product category (Bikes, Accessories, Components, Clothing) |
| `subcategory` | String | Product subcategory (37 unique values) |
| `maintenance` | String | Maintenance requirement indicator |
| `cost` | Integer | Product cost (Range: $0 - $2171) |
| `product_line` | String | Product line classification (4 unique values) |
| `start_date` | String | Product launch/start date |

 Overall Findings
 - High data quality (97.63% complete)  
 - Clear cost differentiation by category  
 - Product concentration in 2 subcategories (Road Bikes, Road Frames)  
 - Data ready for deeper analysis  

## Detailed Findings

**1. Data Structure**
- 4 categories, 37 subcategories, 295 products, 4 product lines
- Explored hierarchical relationships (category → subcategory → product)
- Validated category-ID mappings

**2. Data Quality**
- No duplicate product IDs 
- 97.63% data completeness
- Identified 2.37% NULL values in category/subcategory/product_line/maintenance
- Zero-cost products detected: 2 RoadFrame items

**3. Cost Analysis**
- Range: $0 - $2,171 | Average: $431.07
- **By Category:**
  - Bikes: $969.44 (highest)
  - Components: $264.72
  - Clothing: $24.80
  - Accessories: $13.17 (lowest)

**4. Subcategory Distribution**
- Road Bikes: 43 products (largest)
- Road Frames: 33 products (2nd)
- 20 subcategories with only 1-3 products
- Most expensive: Road Bikes ($2,171), Mountain Bikes ($1,912)
