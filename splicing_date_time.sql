--Splicing Date & Time
    SUBSTR(invoice_date, 1, INSTR(invoice_date, ' ') - 1) AS date_purchase,
    SUBSTR(invoice_date, INSTR(invoice_date, ' ') + 1) AS time_purchase
FROM 
    ecom_rfm_data;
    
ALTER TABLE ecom_rfm_data
ADD COLUMN date__purchase TEXT;

ALTER TABLE ecom_rfm_data
ADD COLUMN time_purchase TEXT;

UPDATE ecom_rfm_data
SET 
    date__purchase = SUBSTR(invoice_date, 1, INSTR(invoice_date, ' ') - 1),
    time_purchase = SUBSTR(invoice_date, INSTR(invoice_date, ' ') + 1);

SELECT date__purchase 
FROM ecom_rfm_data;