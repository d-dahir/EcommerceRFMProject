-- total price column creation

SELECT quantity * price AS total_price
FROM ecom_rfm_data
WHERE Customer_ID  IS NOT NULL AND Customer_ID  <> '';

ALTER table ecom_rfm_data 
ADD COLUMN total_price DECIMAL(10,2);

UPDATE ecom_rfm_data 
SET total_price = quantity*price;

SELECT *
FROM ecom_rfm_data;