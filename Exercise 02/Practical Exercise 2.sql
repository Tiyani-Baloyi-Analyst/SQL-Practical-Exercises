-- Checking for completely duplicate rows in the 3 tables

SELECT*,COUNT(*)
FROM orders
GROUP BY ALL
HAVING COUNT(*) > 1;

SELECT*,COUNT(*)
FROM customers
GROUP BY ALL
HAVING COUNT(*) > 1;

SELECT*,COUNT(*)
FROM products
GROUP BY ALL
HAVING COUNT(*) > 1;


-- Checking for missing values in the 3 tables

SELECT* 
FROM orders
WHERE orderid IS NULL OR customerid IS NULL OR productid IS NULL OR quantity IS NULL OR orderdate IS NULL;

SELECT* 
FROM customers
WHERE customerid IS NULL OR customername IS NULL OR country IS NULL;

SELECT* 
FROM products
WHERE productid  IS NULL OR productname IS NULL OR price IS NULL;



--1. INNER JOIN: Orders with Customer and Product Names

SELECT
    o.orderid,
    o.orderdate,
    c.customername,
    p.productname,
    o.quantity
FROM orders AS o
INNER JOIN customers AS c ON c.customerid = o.customerid
INNER JOIN products AS p ON p.productid = o.productid;


--2. INNER JOIN: Customers Who Placed Orders

SELECT
    c.customerid,
    c.customername,
    c.country,
    o.orderid,
    o.orderdate
FROM customers AS c
INNER JOIN orders AS o ON c.customerid = o.customerid
WHERE quantity >=1;


--3. LEFT JOIN: All Customers and Their Orders

SELECT
    c.customerid,
    c.customername,
    c.country,
    o.orderid,
    o.orderdate,
    p.productid,
    o.quantity
FROM customers AS c
LEFT JOIN orders AS o ON c.customerid = o.customerid
LEFT JOIN products AS p ON o.productid = p.productid;


--4. LEFT JOIN: Product Order Count

SELECT
    p.productid,
    p.productname,
    COUNT(o.productid) AS totalorders
FROM products AS p
LEFT JOIN orders as o ON p.productid = o.productid
GROUP BY ALL;


-- 5. RIGHT JOIN: Orders with Product Info (Include Products Not Ordered)
-- Question: Find all orders along with product details, including any products that might not have been ordered.

SELECT 
    o.orderid,
    o.orderdate,
    p.productid,
    p.productname,
    p.price,
    o.quantity
FROM products AS p
RIGHT JOIN orders AS o ON p.productid = o.productid;



-- 6. RIGHT JOIN: Customer Info with Orders (Include All Customers)
-- Question: Which customers have made orders, and include customers even if they have never placed an order.

SELECT
    c.customerid,
    c.customername,
    c.country,
    o.orderid,
    o.orderdate,
    o.productid,
    o.quantity
FROM customers AS c
RIGHT JOIN orders AS o ON c.customerid = o.customerid;



-- 7. FULL OUTER JOIN: All Customers and All Orders
-- Question: List all customers and orders, showing NULLs where customers have not ordered or where orders have no customer info.

SELECT
    c.customerid,
    c.customername,
    c.country,
    o.orderid,
    o.orderdate,
    o.productid,
    o.quantity
FROM customers AS c
FULL OUTER JOIN orders AS o ON c.customerid = o.customerid;



-- 8. FULL OUTER JOIN: All Products and Orders
-- Question: List all products and orders, showing NULLs where products were never ordered or orders are missing product info.

SELECT 
    p.productid,
    p.productname,
    p.price,
    o.orderid,
    o.orderdate,
    o.customerid,
    o.quantity
FROM products AS p
FULL OUTER JOIN orders AS o ON p.productid = o.productid;














