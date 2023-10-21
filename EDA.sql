-- inital exploratory data analysis on quantity and price 

SELECT 
    COUNT(quantity),
    AVG(quantity) AS avg_quantity,
    MAX(quantity) AS max_quantity,
    MIN(quantity) AS min_quantity
FROM ecom_rfm_data erd ;

SELECT 
	COUNT(total_price),
    AVG(total_price) AS avg_total_price,
    MAX(total_price) AS max_total_price,
    MIN(total_price) AS min_total_price
FROM ecom_rfm_data; 

-- # of unique products
SELECT COUNT(DISTINCT stock_code) AS unqiue_products
FROM ecom_rfm_data;

-- Bestselling products
SELECT count(stock_code) AS quantity_sold, stock_code, description
FROM ecom_rfm_data
GROUP BY Stock_Code, Description
ORDER BY quantity_sold DESC;

-- Unique customer count
SELECT COUNT(DISTINCT Customer_ID) AS unique_customers
FROM ecom_rfm_data;

-- How many purchases has one customer made?
SELECT customer_id, COUNT(DISTINCT invoice) AS order_count 
FROM ecom_rfm_data 
GROUP BY customer_id
ORDER BY order_count DESC;

-- Caluclating AOV
SELECT 
    customer_id,
    AVG(total_price) AS avg_order_value
FROM 
    (SELECT 
         customer_id,
         total_price
     FROM 
         ecom_rfm_data erd 
     GROUP BY 
         customer_id, invoice)
GROUP BY customer_id;

