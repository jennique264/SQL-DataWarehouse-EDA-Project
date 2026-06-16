
-------------------------------------------------
--6. Ranking Analysis
-------------------------------------------------
/* Order the values of dimensions by measure */

-- Which 5 products generates the highest revenue?
SELECT TOP 5
	product_name,
	SUM(sales_amount) as total_revenue
FROM gold.dim_products as p
RIGHT JOIN gold.fact_sales as f
ON p.product_key = f.product_key
GROUP BY product_name
ORDER BY total_revenue DESC



-- What are the 5 worst-performing products in terms of sales? 
SELECT TOP 5
	product_name,
	SUM(sales_amount) as total_revenue
FROM gold.dim_products as p
RIGHT JOIN gold.fact_sales as f
ON p.product_key = f.product_key
GROUP BY product_name
ORDER BY total_revenue ASC


-- Find the top 10 customers who have generated the highest revenue 
SELECT * 
FROM
(
	SELECT
		customer_id,
		SUM(sales_amount) as total_revenue,
		RANK() OVER(ORDER BY SUM(sales_amount) DESC) as rank_customers
	FROM gold.fact_sales as f
	LEFT JOIN gold.dim_customers as c
	ON c.customer_key = f.customer_key
	GROUP BY customer_id
)t 
WHERE rank_customers <= 10


-- Find the 3 customers with fewest placed orders
SELECT TOP 3
	c.customer_id,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT f.order_number) as total_orders
FROM gold.fact_sales as f
LEFT JOIN gold.dim_customers as c
ON c.customer_key = f.customer_key
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders ASC
