--PRACTICAL EXERCISE 1

--Display all columns for all transactions

SELECT*FROM retailsales;


--Display only the Transaction ID, Date, and Customer ID for all records

SELECT 
    transaction_id,
    date,
    CUSTOMER_ID,
FROM retailsales;


--Display all the distinct product categories in the dataset

SELECT 
    DISTINCT(product_category)
FROM retailsales;


--Display all the distinct gender values in the dataset

SELECT 
    DISTINCT(gender)
FROM retailsales;


--Display all transactions where the Age is between 15 & 25, and between 25 & 30 Using UNION
(
SELECT customer_id,
    product_category,
    age
FROM retailsales
WHERE age BETWEEN 15 AND 25
ORDER BY 3 DESC
LIMIT 5
)
UNION
(
SELECT customer_id,
    product_category,
    age
FROM retailsales
WHERE age BETWEEN 25 AND 30
ORDER BY 3 DESC
LIMIT 5
);

--Display all transactions where the Price per Unit is between 100 and 500

SELECT*FROM retailsales
WHERE PRICE_PER_UNIT BETWEEN 100 AND 500;


--Display all transactions where the Product Category is either 'Beauty' or 'Electronics'

SELECT*FROM retailsales
WHERE product_category = 'Beauty' OR product_category = 'Electronics';

--OR

SELECT*FROM retailsales
WHERE product_category IN ('Beauty','Electronics');


--Display all transactions where the Product Category is not 'Clothing'

SELECT*FROM retailsales
WHERE NOT product_category = 'Clothing';

SELECT*FROM retailsales
WHERE product_category <> 'Clothing';

SELECT*FROM retailsales
WHERE product_category != 'Clothing';


--Display all transactions where the Quantity is greater than or equal to 3

SELECT*FROM retailsales
WHERE quantity >= 3;


--Count the total number of transactions

SELECT
    COUNT(*) AS Total_Transaction
FROM retailsales;


--Find the average Age of customers

SELECT
    ROUND(AVG(age),0) AS Average_Age   --ROUNDING TO THE NEAREST WHOLE NUMBER
FROM retailsales;


--Find the total quantity of products sold

SELECT
    SUM(quantity) AS Total_Quantity
FROM retailsales;


--Find the maximum Total Amount spent in a single transaction

SELECT
    MAX(total_amount) AS Max_Total_Amount
FROM retailsales;


--Find the minimum Price per Unit in the dataset

SELECT
    MIN(PRICE_PER_UNIT) AS Min_Price_per_Unit
FROM retailsales;


--Find the number of transactions per Product Category.

SELECT
    product_category,
    COUNT(DISTINCT transaction_id) AS Transaction_Count
FROM retailsales
GROUP BY product_category;


--Find the total revenue (Total Amount) per gender

SELECT
    gender,
    SUM(TOTAL_AMOUNT) AS Total_Revenue
FROM retailsales
GROUP BY gender;


--Find the average Price per Unit per product category

SELECT
    product_category,
    AVG(price_per_unit) AS Average_Price
FROM retailsales
GROUP BY product_category;



--Find the total revenue per product category where total revenue is greater than 10,000

SELECT
    product_category,
    SUM(TOTAL_AMOUNT) AS Total_Revenue
FROM retailsales
GROUP BY product_category
HAVING Total_Revenue > 10000;



--Find the average quantity per product category where the average is more than 2.

SELECT
    product_category,
    ROUND(AVG(quantity),0) AS Average_Quantity
FROM retailsales
GROUP BY product_category
HAVING Average_Quantity > 2;


--Display a column called Spending_Level that shows 'High' if Total Amount > 1000, otherwise 'Low'.

SELECT 
    TRANSACTION_ID,
    TOTAL_AMOUNT,
    CASE
        WHEN total_amount > 1000 THEN 'High'
        ELSE 'Low'
    END AS Spending_Level
FROM retailsales;


SELECT 
    COUNT(DISTINCT customer_id) AS TRANSACTION_ID,
    CASE
        WHEN total_amount > 1000 THEN 'High'
        ELSE 'Low'
    END AS Spending_Level
FROM retailsales
GROUP BY ALL;



--Display a new column called Age_Group that labels customers as:.
-- 'Youth' if Age < 30
-- •
-- 'Adult' if Age is between 30 and 59
-- •
-- 'Senior' if Age >= 60 Expected output: Customer ID, Age, Age_Group

SELECT 
    customer_id,
    age,
    CASE
        WHEN age < 30 THEN 'Youth'
        WHEN age >= 60 THEN 'Senior'
        ELSE 'Adult'
    END AS Age_Group
FROM retailsales
GROUP BY ALL;

SELECT 
    COUNT(customer_id) AS Customer_Count,
    CASE
        WHEN age < 30 THEN 'Youth'
        WHEN age >= 60 THEN 'Senior'
        ELSE 'Adult'
    END AS Age_Group
FROM retailsales
GROUP BY ALL;






























