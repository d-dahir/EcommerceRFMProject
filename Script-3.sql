-- rfm calculations

SELECT 
    customer_id,
    julianday('2012-01-01') - julianday(MAX(formatted_date)) AS recency,
    COUNT(DISTINCT invoice) AS frequency,
    SUM(total_price) AS monetary
FROM 
    ecom_rfm_data
WHERE 
    formatted_date <= '2012-01-01'
GROUP BY 
    customer_id;
    
-- rfm scoring
   
WITH
  RFM AS (
    SELECT 
        customer_id,
        julianday('2012-01-01') - julianday(MAX(formatted_date)) AS recency,
        COUNT(DISTINCT invoice) AS frequency,
        SUM(total_price) AS monetary
    FROM 
        ecom_rfm_data
    WHERE 
        formatted_date <= '2012-01-01'
    GROUP BY 
        customer_id
  ),
  Percentiles AS (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY recency DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS monetary_score
    FROM
        RFM
  )
SELECT
  RFM.customer_id,
  recency_score,
  frequency_score,
  monetary_score,
  CAST(recency_score AS TEXT) || CAST(frequency_score AS TEXT) || CAST(monetary_score AS TEXT) AS rfm_segment
FROM
  RFM
JOIN
  Percentiles
ON
  RFM.customer_id = Percentiles.customer_id;
  
 
-- strict scoring defintions
WITH
  RFM AS (
    SELECT 
        customer_id,
        julianday('2012-01-01') - julianday(MAX(formatted_date)) AS recency,
        COUNT(DISTINCT invoice) AS frequency,
        SUM(total_price) AS monetary
    FROM 
        ecom_rfm_data
    WHERE 
        formatted_date <= '2012-01-01'
    GROUP BY 
        customer_id
  ),
  Percentiles AS (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY recency DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS monetary_score
    FROM
        RFM
  ),
  RFM_Segments AS (
    SELECT
      RFM.customer_id,
      recency_score,
      frequency_score,
      monetary_score,
      CAST(recency_score AS TEXT) || CAST(frequency_score AS TEXT) || CAST(monetary_score AS TEXT) AS rfm_segment
    FROM
      RFM
    JOIN
      Percentiles
    ON
      RFM.customer_id = Percentiles.customer_id
  )
SELECT
  customer_id,
  recency_score,
  frequency_score,
  monetary_score,
  rfm_segment,
  CASE 
    WHEN rfm_segment = '555' THEN 'High-Value Customers'
    WHEN rfm_segment LIKE '5_1' THEN 'New Customers'
    WHEN rfm_segment = '251' THEN 'At-Risk Customers'
    WHEN rfm_segment = '355' THEN 'Loyal Customers'
    WHEN rfm_segment = '111' THEN 'Disengaged or Low-Value Customers'
    WHEN rfm_segment LIKE '2_1' THEN 'Occasional Buyers'
    WHEN rfm_segment LIKE '51_' THEN 'High Potential / Recent Customers'
    WHEN recency_score <= 2 AND frequency_score >= 4 AND monetary_score <= 2 THEN 'Bargain Hunters'
    WHEN recency_score = '4' AND frequency_score = '5' THEN 'Growing Customers'
    WHEN recency_score = '5' AND frequency_score = '1' THEN 'One-Time High Spenders'
    WHEN recency_score <= 2 AND frequency_score >= 4 AND monetary_score <= 2 THEN 'Frequent Small-Spenders'
    ELSE 'Other'
  END AS segment_name
FROM
  RFM_Segments;
  
--broader scoring definitions
 WITH
  RFM AS (
    SELECT 
        customer_id,
        julianday('2012-01-01') - julianday(MAX(formatted_date)) AS recency,
        COUNT(DISTINCT invoice) AS frequency,
        SUM(total_price) AS monetary
    FROM 
        ecom_rfm_data
    WHERE 
        formatted_date <= '2012-01-01'
    GROUP BY 
        customer_id
  ),
  Percentiles AS (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY recency DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS monetary_score
    FROM
        RFM
  ),
  RFM_Segments AS (
    SELECT
      RFM.customer_id,
      recency_score,
      frequency_score,
      monetary_score,
      CAST(recency_score AS TEXT) || CAST(frequency_score AS TEXT) || CAST(monetary_score AS TEXT) AS rfm_segment
    FROM
      RFM
    JOIN
      Percentiles
    ON
      RFM.customer_id = Percentiles.customer_id
  )
SELECT
  customer_id,
  recency_score,
  frequency_score,
  monetary_score,
  rfm_segment,
  CASE 
    WHEN recency_score = 5 THEN 'High-Value/Recent Customers'
    WHEN frequency_score = 5 THEN 'High Frequency Customers'
    WHEN monetary_score = 5 THEN 'High Monetary Value Customers'
    WHEN recency_score = 1 THEN 'At-Risk/Churned Customers'
    WHEN frequency_score = 1 AND monetary_score >= 3 THEN 'One-Time High Spenders'
    WHEN frequency_score >= 3 AND monetary_score = 1 THEN 'Frequent Small-Spenders'
    ELSE 'Average Customers'
  END AS segment_name
FROM
  RFM_Segments;