SELECT * FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS;


--1. Find all records where Size is missing and the purchase_amount is greater than 50. Expected Columns: Customer ID, Size, purchase_amount, Item Purchased
SELECT customer_id,
    size,
    purchase_amount,
    item_purchased
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE size IS NULL AND purchase_amount > 50;


-- 2. List the total number of purchases grouped by Season, treating NULL values as 'Unknown Season'. Expected Columns: Season, Total Purchases
SELECT IFNULL(season,'Unknown Season') season,
    SUM(previous_purchases) AS Total_Purchases
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
GROUP BY ALL;


--3. Count how many customers used each Payment Method, treating NULLs as 'Not Provided'. Expected Columns: Payment Method, Customer Count
SELECT IFNULL(payment_method,'Not Provided') payment_method,
    COUNT(customer_id) AS customer_count
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
GROUP BY ALL;


-- 4. Show customers where Promo Code Used is NULL and Review Rating is below 3.0.
SELECT customer_id,
    Promo_code_used,
    REVIEW_RATING,
    ITEM_PURCHASED
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE promo_code_used IS NULL AND REVIEW_RATING < 3;


-- 5. Group customers by Shipping Type, and return the average purchase_amount, treating missing values as 0. Expected Columns: Shipping Type, Average purchase_amount
SELECT IFNULL(shipping_type,'Unknown') Shopping_Type,
    AVG(IFNULL(purchase_amount,0)) Average_purchase_amount
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
GROUP BY ALL;


--6. Display the number of purchases per Location only for those with more than 5 purchases and no NULL Payment Method. Expected Columns: Location, Total Purchases
SELECT IFNULL(location,'Unknown') location,
    SUM(previous_purchases) AS Total_Purchases
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE payment_method IS NOT NULL AND previous_purchases > 5
GROUP BY ALL;


-- 7. Create a column Spender Category that classifies customers using CASE: 'High' if amount > 80, 'Medium' if BETWEEN 50 AND 80, 'Low' otherwise. Replace NULLs in purchase_amount with 0. Expected Columns: Customer ID, purchase_amount, Spender Category
SELECT customer_id,
    IFNULL(purchase_amount,0) purchase_amount,
    CASE
        WHEN IFNULL(purchase_amount,0) > 80 THEN 'High'
        WHEN IFNULL(purchase_amount,0) BETWEEN 50 AND 80 THEN 'Medium'
        ELSE 'Low'
    END AS Spend_Category
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS;

--OR

SELECT 
    COUNT(IFNULL(purchase_amount,0)) purchase_count,
    CASE
        WHEN IFNULL(purchase_amount,0) > 80 THEN 'High'
        WHEN IFNULL(purchase_amount,0) BETWEEN 50 AND 80 THEN 'Medium'
        ELSE 'Low'
    END AS Spend_Category
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
GROUP BY ALL;


--8. Find customers who have no Previous Purchases value but whose Color is not NULL. Expected Columns: Customer ID, Color, Previous Purchases
SELECT customer_id,
    color,
    previous_purchases
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE previous_purchases IS NULL AND color IS NOT NULL;


-- 9. Group records by Frequency of Purchases and show the total amount spent per group, treating NULL frequencies as 'Unknown'. Expected Columns: Frequency of Purchases, Total purchase_amount
SELECT IFNULL(frequency_of_purchases,'Unkown') AS Frequency_of_purchase,
    SUM(purchase_amount) AS Total_purchase_amount
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
GROUP BY 1;


-- 10. Display a list of all Category values with the number of times each was purchased, excluding rows where Categoryis NULL. Expected Columns: Category, Total Purchases
SELECT category,
    COUNT(purchase_amount) AS total_purchase
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE category IS NOT NULL
GROUP BY 1;


--11 Return the top 5 Locations with the highest total purchase_amount, replacing NULLs in amount with 0.
SELECT IFNULL(location,'Unknown') location,
    SUM(IFNULL(PURCHASE_AMOUNT,0)) AS Total_Purchase_amount
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
GROUP BY 1
ORDER BY location DESC
LIMIT 5;


-- 12. Group customers by Gender and Size, and count how many entries have a NULL Color. Expected Columns: Gender, Size, Null Color Count
SELECT Gender,
    size,
    COUNT(customer_id) AS Null_Color_Count
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE color IS NULL
GROUP BY ALL;


-- 13. Identify all Item Purchased where more than 3 purchases had NULL Shipping Type. Expected Columns: Item Purchased, NULL Shipping Type Count
SELECT item_purchased,
    COUNT(customer_id) AS NULL_Shipping_Type_Count
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE shipping_type IS NULL
GROUP BY 1
HAVING COUNT(customer_id) > 3;


--14. Show a count of how many customers per Payment Method have NULL Review Rating. Expected Columns: Payment Method, Missing Review Rating Count
SELECT payment_method,
    COUNT(customer_id) AS Missing_Review_Rating_Count
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE review_rating IS NULL
GROUP BY ALL;


--15. Group by Category and return the average Review Rating, replacing NULLs with 0, and filter only where average is greater than 3.5. Expected Columns: Category, Average Review Rating
SELECT category,
    AVG(IFNULL(review_rating,0)) AS Average_Review_Rating
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
GROUP BY ALL
HAVING Average_Review_Rating > 3.5;


--16. List all Colors that are missing (NULL) in at least 2 rows and the average Age of customers for those rows. Expected Columns: Color, Average Age
SELECT color,
    AVG(age) AS Average_Age
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE color IS NULL
GROUP BY 1
HAVING COUNT(customer_id) > 1;


-- 17. Use CASE to create a column Delivery Speed: 'Fast' if Shipping Type is 'Express' or 'Next Day Air', 'Slow' if 'Standard', 'Other' for all else including NULL. Then count how many customers fall into each category. Expected Columns: Delivery Speed, Customer Count
SELECT 
    COUNT(IFNULL(customer_id,0)) Customer_Count,
    CASE
        WHEN shipping_type = 'Express' THEN 'Fast'
        WHEN shipping_type = 'Air' THEN 'Next Day'
        WHEN shipping_type = 'Standard' THEN 'Slow'
        ELSE 'Other'
    END AS Delivery_Speed
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
GROUP BY ALL;


--18. Find customers whose purchase_amount is NULL and whose Promo Code Used is 'Yes'. Expected Columns: Customer ID, purchase_amount, Promo Code Used
SELECT customer_id,
    purchase_amount,
    promo_code_used
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE purchase_amount IS NULL AND promo_code_used = 'Yes';


-- 19. Group by Location and show the maximum Previous Purchases, replacing NULLs with 0, only where the average rating is above 4.0. Expected Columns: Location, Max Previous Purchases, Average Review Rating
SELECT location,
    MAX(IFNULL(previous_purchases,0)) AS Max_Previous_Purchase,
    AVG(IFNULL(review_rating,0)) AS Average_Review_Rating
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
GROUP BY ALL
HAVING 3 > 4;


--20 Show customers who have a NULL Shipping Type but made a purchase in the range of 30 to 70 USD. Expected Columns: Customer ID, Shipping Type, purchase_amount, Item Purchased
SELECT customer_id,
    shipping_type,
    purchase_amount,
    item_purchased
FROM BRIGHTLIGHT.PUBLIC.SHOPPINGTRENDS
WHERE shipping_type IS NULL AND purchase_amount BETWEEN 30 AND 70;






