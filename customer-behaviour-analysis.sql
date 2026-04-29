create database Customer_behaviour_analysis;
use  Customer_behaviour_analysis;
select * from customers limit 10;
# 1 which category generates highest_value
select category,sum(purchase_amount) as highest_value from customers group by category order by highest_value desc;
-- BUSINESS PROBLEM:-Which product category contributes the most to overall revenue?
-- IMPACT Helps decide where to invest more inventory
-- Focus marketing budget on high-performing categories
-- Identify low-performing categories to improve or remove

#2 are discounting actually incresing the purchase values
select discount_applied,sum(purchase_amount) as total_revenue from customers group by discount_applied order by total_revenue desc;

-- BUSINESS PROBLEM:-Do discounts actually drive higher revenue or reduce profit margins
-- IMPACT Decide whether to:
-- Continue discounts 
-- Reduce discounts 
-- Understand if discounts attract:
-- High-value customers
-- Or just low-spending buyers

#3 what is the total revenue generate by male and female category
select gender,sum(purchase_amount) as total_revenue from customers group by gender order by total_revenue desc;
-- BUSINESS PROBLEM:- Which gender contributes more to total revenue
-- IMPACT arget marketing campaigns (ads, offers)
-- Personalize product recommendations
-- Optimize customer segmentation strategy

#4 which customer used a discount but still spent more than the average purchase amount
select  customer_id,purchase_amount,discount_applied from customers
where discount_applied='yes' and purchase_amount>(select avg(purchase_amount) from customers) 
order by purchase_amount desc
limit 10;
 ;
 -- business Problem:- business cannot identify high spending cuatomers who are also discount users
 -- IMPACT :- Udentifies premium discount customers 
 -- enables targeted discount campaigns
 -- Improves customer retention and revenue
 
 #5 which are the top bottom 5 products with the highest average review rating
 select item_purchased,round(avg(review_rating),2) as average from customers 
 group by item_purchased
 order by average DESC
 LIMIT 5;

select item_purchased,round(avg(review_rating),2) as average from customers 
 group by item_purchased
 order by average ASC
 LIMIT 5
 ; 
-- BUSINESS PROBLEM :- NO VISIBILTY INTO BUSINESS PROBLEM BASED ON CUSTOMER SATISFACTION
-- IMPACT:- PROMOTES HIGH PERFORMING PRODUCTS
-- IMPROVE LOW_RATES PRODUCTS 
-- ENHANCES CUSTOMER EXPERIRNCE

#6 AVERAGE PURCHASE STANDARD VS EXPRESS SHIPPING
SELECT * FROM CUSTOMERS;
SELECT  SHIPPING_TYPE,
COUNT(DISTINCT CUSTOMER_ID) AS ORDER_PLACED, AVG(PURCHASE_AMOUNT) AS AVERAGE_PURCHASE
,SUM(PURCHASE_AMOUNT) AS REVENUE
FROM CUSTOMERS 
GROUP BY SHIPPING_TYPE ORDER BY REVENUE DESC  ; 

-- BUSINESS PROBLE,:- IF FASTER SHIPPING IMAPCTS TO HIGHER SPENDING 

-- IMPACT HELP OPTIMIZE SHIPPING PRICING STRATEGY
-- ENCOURAGE PREMIUM SHIPPING ADOPTION
-- INCREASE AVERAGE ORDER values


#7 DO SUBSCRIBE CUSTOMER SPENT MORE COMPARE TO AVERAGE AND TOTAL REVENUE BETWEEN SUBSCRIBER AND NON SUBSCRIBER?
SELECT * FROM CUSTOMERS;

SELECT COUNT(CUSTOMER_ID) AS USERS
,SUBSCRIPTION_STATUS,
AVG(PURCHASE_AMOUNT) AS AVERAGE,
SUM(PURCHASE_AMOUNT) AS TOTAL_REVENUE
 FROM CUSTOMERS
 GROUP BY SUBSCRIPTION_STATUS;
-- BUSINESS PROBLEM THE EFFECTIVENESS OF THE SUBSCRIPTION IS UNKNOWN
-- IMPACT VALIDATES CUSTOMER MODEL PERFORMANCE
-- INCREASE CUSTOMER LIFE TIME VALUE(CLV)

#8 TOP 5 PRODUCTS WITH HIGHTEST DISCOUNT USAGE 
SELECT * FROM CUSTOMERS;
SELECT ITEM_PURCHASED, 
COUNT(ITEM_PURCHASED) AS TOTAL_NO_OF_TIMES_SOLD,
COUNT(CASE WHEN DISCOUNT_APPLIED ='YES' THEN 1  END) AS NO_OF_TIMES_DISCOUNT_APPLIED,
ROUND(COUNT(CASE WHEN DISCOUNT_APPLIED ='YES' THEN 1  END)*100.0/COUNT(*),2) AS PERCENTAGE
FROM CUSTOMERS GROUP BY ITEM_PURCHASED
ORDER BY PERCENTAGE DESC
LIMIT 5;

--  BUSINESS PROBLEM :- SOME PRODUCTS MAYBE OVERLY DEPENDENT ON DISCOUNT
-- IMPACT :- IDENTIFIES DISCOUNT DRIVEN PRODUCTS 
-- HELP OPTIMIZE PRICING STRATEGY
-- REDUCE PROFIT MARGIN LOSS

#9 Segment customer into new, returning and loyal based on their total number of previous purchase,
--  show the count of each segment
SELECT 
CASE WHEN PREVIOUS_PURCHASES=0 THEN 'NEW CUSTOMERS'
WHEN PREVIOUS_PURCHASES BETWEEN 1 AND 15 THEN 'RETURNING CUSTOMER'
ELSE
'LOYAL CUSTOMERS'
END AS CUSTOMERS,
COUNT(*) AS CUSTOMERS
 FROM CUSTOMERS
 GROUP BY CASE WHEN PREVIOUS_PURCHASES=0 THEN 'NEW CUSTOMERS'
WHEN PREVIOUS_PURCHASES BETWEEN 1 AND 15 THEN 'RETURNING CUSTOMER'
ELSE
'LOYAL CUSTOMERS'
END;

-- BUSINESS PROBLEM :- LACK OF CUSTOMER SEGMENTATION LEADS TO GENRIC STRATEGIES
-- IMPACT:- ENABLE PERSONALIZED MARKETING 
-- IMPROVES RETENTION STRATEGIES
-- INCREASE CONVERSION RATES

#10 WHAT ARE THE TOP 3 MOST PURCHASED PRODUCT WITHIN EACH CATEGORY
SELECT * FROM CUSTOMERS;

SELECT CATEGORY,SUM(PURCHASE_AMOUNT) AS PRODUCTS_COST FROM CUSTOMERS GROUP BY CATEGORY ORDER BY PRODUCTS_COST DESC LIMIT 3;

WITH CTES AS(
SELECT CATEGORY,ITEM_PURCHASED,COUNT(ITEM_PURCHASED) AS MOST_PURCHASED,
RANK() OVER(PARTITION BY CATEGORY ORDER BY COUNT(ITEM_PURCHASED) DESC) AS RNK
 FROM CUSTOMERS
 GROUP BY CATEGORY,ITEM_PURCHASED)
SELECT * FROM CTES WHERE RNK<=3;

-- BUSINESS PROBLEM:- COMPANY DOESNT KNOW THE TOP PERFORMING PRODUCTS WITHIN CATEGORIES 
-- IMPACT :-IMPROVE PRODOUCT PLACEMENT AND RECOMMENDATION
-- HELPS INVENTORY OPTIMIZATION
-- INCREASES SALES THROUGH BEST SELLERS

 #11 Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe ?
SELECT 
CASE WHEN PREVIOUS_PURCHASES>5 THEN 'REPEAT BUYERS'
ELSE 'NORMAL BUYERS'
END AS CUSTOMER_TYPE,
SUBSCRIPTION_STATUS,
COUNT(*) AS NO_OF_CUSTOMERS
 FROM CUSTOMERS
 GROUP BY 
 CASE WHEN PREVIOUS_PURCHASES>5 THEN 'REPEAT BUYERS'
ELSE 'NORMAL BUYERS'
END
,SUBSCRIPTION_STATUS
ORDER BY NO_OF_CUSTOMERS DESC
 ;
-- business problem unclear relationship between loyalty and subscription
-- impact improves subscriotion strategy
--  improves conversion to paid programs
-- improve customer retention strategy
 
#12 what is the revenue contribution of age group
SELECT * FROM CUSTOMERS;
SELECT 
case when age between 18 and 25 then '18-25'
 when age between 26 and 35 then '26-35'
when age between 36 and 50 then '36-50'
else '51+'
end age_group,
round(sum(purchase_amount),2) as Total_Revenue
FROM CUSTOMERS
group by case when age between 18 and 25 then '18-25'
 when age between 26 and 35 then '26-35'
when age between 36 and 50 then '36-50'
else '51+'
end 
order by Total_Revenue  desc
;

-- business problem:- no visibility into which age group contributes most to the revenue
-- impact:- enable age group targetting
-- enhance marketting efficiency

























