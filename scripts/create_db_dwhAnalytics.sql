/*
**********************************************************************************
Script : Create database 'DataWarehouseAnalytics' and schema 'gold'
**********************************************************************************
Script Purpose :
	This script creates a database named 'DataWarehouseAnalytics'.
	If the database exists, it is dropped and recreated. 

Warning : 
	Running this script will drop the entire database 'DataWarehouseAnalytics' 
	and all the data in this database will be permanently deleted.
	Proceed and ensure proper backups before running this script.
**********************************************************************************
*/



USE master
GO 
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseAnalytics')
BEGIN
	ALTER DATABASE DataWarehouseAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouseAnalytics;
END;
GO

-- Create Database 'DataWarehouseAnalytics'
CREATE DATABASE DataWarehouseAnalytics;
GO

USE DataWarehouseAnalytics;
GO

--=========================================================
-- Create Schema -> gold
--=========================================================
CREATE SCHEMA gold;
GO
----------------------------------
-- Creating tables 
----------------------------------
IF OBJECT_ID('gold.dim_customers', 'U') IS NOT NULL
	DROP TABLE gold.dim_customers;
GO
CREATE TABLE gold.dim_customers
(
	customer_key INT,
	customer_id INT,
	customer_number NVARCHAR(50),
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	country NVARCHAR(50),
	marital_status NVARCHAR(50),
	gender NVARCHAR(50),
	birthdate DATE,
	create_date DATE
);
GO

IF OBJECT_ID('gold.dim_products', 'U') IS NOT NULL
	DROP TABLE gold.dim_products;
GO
CREATE TABLE gold.dim_products
(
	product_key INT,
	product_id INT,
	product_number NVARCHAR(50),
	product_name NVARCHAR(50),
	category_id NVARCHAR(50),
	category NVARCHAR(50),
	subcategory NVARCHAR(50),
	maintenance NVARCHAR(50),
	cost INT ,
	product_line NVARCHAR(50),
	start_date DATE
);
GO 

IF OBJECT_ID('gold.fact_sales','U') IS NOT NULL
	DROP TABLE gold.fact_sales;
GO
CREATE TABLE gold.fact_sales
(
	order_number NVARCHAR(50),
	product_key INT,
	customer_key INT,
	order_date DATE,
	shipping_date DATE,
	due_date DATE,
	sales_amount INT,
	quantity INT,
	price INT
);
GO

---------------------------------------------------------
-- >> Inserting csv files data into these tables
---------------------------------------------------------
TRUNCATE TABLE gold.dim_customers;
GO
BULK INSERT gold.dim_customers
FROM 'D:\SQL\sql-data-analytics-project\datasets\flat-files\dim_customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO


TRUNCATE TABLE gold.dim_products;
GO
BULK INSERT gold.dim_products
FROM 'D:\SQL\sql-data-analytics-project\datasets\flat-files\dim_products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO


TRUNCATE TABLE gold.fact_sales;
GO
BULK INSERT gold.fact_sales
FROM 'D:\SQL\sql-data-analytics-project\datasets\flat-files\fact_sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO




