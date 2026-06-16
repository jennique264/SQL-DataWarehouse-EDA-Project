-------------------------------------------------
--3. Date Exploration
-------------------------------------------------

-- Find the date of first and last order
-- How many years of sales are available
SELECT
	MAX(order_date) as last_order_date,
	MIN(order_date) as first_order_date,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) as order_range_month
FROM gold.fact_sales


-- Find the youngest and oldest customer
SELECT 
	MIN(birthdate) as youngest_birthdate,
	DATEDIFF(YEAR,MIN(birthdate),GETDATE()) as youngest_age,
	MAX(birthdate) as oldest_birthdate,
	DATEDIFF(YEAR, MAX(birthdate), GETDATE()) as oldest_age
FROM gold.dim_customers
