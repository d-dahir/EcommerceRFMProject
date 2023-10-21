# Customer Segmentation through RFM Analysis for Optimised Email Marketing
SQL + PowerBI - Data Analytics Project

**Introduction:**  
An e-commerce company is looking to optimise its email marketing strategy by segmenting its customer base to target them with personalised marketing messages. The goal is to increase engagement rates and ultimately, revenue. The company has historical sales data but hasn’t leveraged it for marketing purposes yet.  

**Objective:**   
To carry out RFM (Recency, Frequency, Monetary) analysis on e-commerce transaction data, segment customers, and propose personalised email marketing strategies for each segment.  

**Data Overview:**  
Source: The dataset is obtained from [Kaggle](https://www.kaggle.com/datasets/carrie1/ecommerce-data), originally from the UCI Machine Learning Repository, covering transactions from 01/12/2010 to 09/12/2011. This specific analysis covers 01/12/2010 - 31/10/2011.
Dataset Description: The dataset encapsulates transactions of non-store online retail based in the UK, primarily selling unique all-occasion gifts. Key attributes include invoice number, customer ID, unit price, etc.    

**Data Preparation:**  
Key steps involved:
* Removing rows with empty customer_id and refunds.  (See cleaning_data.sql)
* Creating a total_price column by multiplying the quantity and unit price.  (See total_price.sql)
* Splitting the invoice_date column into separate date and time columns.  (See splicing_date_time.sql)
* Formatting the date for uniformity.  (See date_rearrange.sql)

**Exploratory Data Analysis (EDA):**  
(SEE eda.sql)
* Identified 3665 unique products with the most popular being 'WHITE HANGING HEART T-LIGHT HOLDER' (2028 sold).
* Customer 12748 has made the highest number of orders (210).
* The average quantity purchased is 13, indicating that this is bulk purchasers/wholesalers (backed up by notes in the data source)
* Average purchase price = 22.3

**RFM Analysis:**  
See script3.sql
Employed RFM methodology to segment customers based on their purchasing behaviour. Encountered challenges with SQLite's Julian function and had to ensure a fine balance in segment definition to maintain meaningful segmentation.

**Insights and Recommendations:**  

Post-segmentation, the plan is to initiate email marketing initiatives tailored to each segment. Some strategies include:  

**High-Value/Recent Customers (Recency Score: 5):**  
Exclusive Offers: Utilise automated flows to provide early access to new product launches, appreciating their recent engagement and incentivizing further purchases. A sequence of 3 emails over a week leading up to the product launch can create anticipation.
Referral Program: Leverage a referral campaign to encourage them to refer new customers, offering referral discounts as a reward.  

**High Frequency Customers (Frequency Score: 5):**  
Loyalty Program: Implement an educational flow surrounding the loyalty program, rewarding them with points or discounts on future purchases to acknowledge their frequent shopping behaviour. A 4-email series explaining the benefits and how-to of the loyalty program can be effective.  

**High Monetary Value Customers (Monetary Score: 5):**  
VIP Program: Establish a VIP club offering exclusive benefits like free shipping, early access to sales, and personalised service, communicated through a dedicated VIP flow.
Upsell & Cross-Sell Campaigns: Utilise campaigns to recommend higher-value products or complementary items to increase the transaction value.  

**At-Risk/Churned Customers (Recency Score: 1):**  
Win-Back Campaign: Deploy a win-back campaign offering special discounts or incentives to encourage re-engagement and purchases.
Feedback Request: Initiate a feedback request sequence to understand the reasons behind their inactivity and to gather insights for improvement.   

**One-Time High Spenders (Frequency Score: 1 and Monetary Score: ≥3):**  
Re-Purchase Reminder: Send a re-purchase reminder highlighting the value they found in their previous high-value purchase.
Exclusive Offers: Provide exclusive deals or early access to new products to entice another significant purchase.  

**Frequent Small-Spenders (Frequency Score: ≥3 and Monetary Score: 1):**  
Volume Discounts: Offer volume discounts on bulk purchases through targeted campaigns to encourage larger transactions.
Bundle Deals: Promote bundle deals to increase the average order value.  

**Average Customers (Any other combination):**  
Engagement Campaigns: Engage regularly through promotional campaigns, newsletters, and product updates to keep the brand top of mind.
Survey and Feedback: Conduct survey and feedback campaigns to better understand their preferences and to refine offerings based on their feedback.  

**Power BI Dashboard:**
An interactive dashboard was created in Power BI to visualise the customer segments, RFM score distribution, and monetary value by segment. The dashboard allows for a deeper exploration of the data and understanding of customer segmentation.  

**Dashboard Link:**

**Dashboard Screenshots**:

**Evaluation:**  
The project unearthed challenges in setting up DBeaver, ODBC connector, and crafting extensive SQL queries for RFM analysis. Despite these, the segmentation provides a solid foundation for personalised marketing campaigns. Future steps involve creating the automated flows and campaigns recommended via these segments, starting off with the larger segments. Then conducting tracking and optimisations to further increase revenue. 



