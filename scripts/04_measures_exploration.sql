
-------------------------------------------------
--4. Measures Exploration & generating report
------------------------------------------------- 
/* Calculate and find out key metric of the business
Highest level of aggregtion|Lowest level of details */


-- Find the total sales
SELECT	
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales


-- Find how many items are sold
SELECT
SUM(quantity) AS total_items_sold
FROM gold.fact_sales


-- Find the average selling price
SELECT
AVG(price) AS avg_selling_price
FROM gold.fact_sales


-- Find the total number of orders
SELECT 
COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales


-- Find the total number of products
SELECT
COUNT(product_name) AS total_products
FROM gold.dim_products


-- Find the total number of customers
SELECT 
COUNT(DISTINCT customer_id) as total_customers
FROM gold.dim_customers


-- Find the total number of customers that has placed an order
SELECT
COUNT(DISTINCT customer_key) as customers_placed_o
FROM gold.fact_sales

-------------------------------------------------------------------------------
-- Generate a report that shows all key metrics of the business
-------------------------------------------------------------------------------

SELECT 'Total Sales' AS measure_name, SUM(sales_amount) measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total items' ,SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' ,AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders' ,COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products' ,COUNT(product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers' ,COUNT(DISTINCT customer_id) FROM gold.dim_customers
UNION ALL
SELECT 'Total Customers O' ,COUNT(DISTINCT customer_key) FROM gold.fact_sales
