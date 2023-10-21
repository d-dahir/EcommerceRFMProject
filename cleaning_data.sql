-- removing empty strings in customer_id & refunds

SELECT *
FROM ecom_rfm_data
WHERE quantity >= 0
AND customer_id <> '';

-- A. Delete refunds
DELETE FROM ecom_rfm_data
WHERE quantity < 0;

-- B. Delete rows with empty strings in customer_id
DELETE FROM ecom_rfm_data
WHERE customer_id = '';
