# JOIN Practice Question 1

/* Question:
Write a SQL query to retrieve the full name, email, product name, order date, and quantity for all customer orders. */

SELECT 
  c.customer_name,
  c.email,
  p.product_name,
  o.order_date,
  o.quantity
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN products AS p ON o.product_id = p.product_id
ORDER BY o.order_date DESC
LIMIT 10;


# JOIN Practice Question #2

/*
Question:
Write a SQL query to get a list of all customers, including those who have never placed an order.
For each customer, show:
 */

SELECT 
  c.customer_name,
  c.email,
  o.order_id,
  o.order_date
FROM customers AS c
LEFT JOIN orders AS o
  ON c.customer_id = o.customer_id;

/*
Question:
Write a SQL query to find all customers who have never placed an order.
Display only their:*/

SELECT customer_name, email
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM orders WHERE customer_id IS NOT NULL
);

/*
Question:
Write a SQL query to show the total number of orders and total quantity ordered for each product.
Return:

 */
SELECT 
  p.product_name,
  COUNT(o.order_id) AS total_orders,
  SUM(o.quantity) AS total_quantity
FROM products AS p
INNER JOIN orders AS o ON p.product_id = o.product_id
GROUP BY p.product_name;

/*
Question:
Write a SQL query to find all customers who have placed an order in the last 30 days.

*/
SELECT 
  c.customer_name,
  c.email,
  o.order_date,
  p.product_name
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN products AS p ON o.product_id = p.product_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;

/*
Question:
Write a SQL query to find the top 5 customers who have spent the most total money on orders.
*/

SELECT
    c.customer_name,
    c.email,
    SUM(o.quantity * p.price) AS total_spent
    FROM customers AS c
    INNER JOIN
    orders AS o
    ON c.customer_id = o.customer_id
    INNER JOIN
    products as p
    ON o.product_id = p.product_id
    GROUP BY c.customer_name,c.email
    ORDER BY total_spent DESC;

/*
Question:
Write a query to find all customers who have placed more orders than the average number of orders placed by all customers.
*/

SELECT 
    c.customer_name,
    c.email,
    COUNT(o.order_id) AS number_of_orders
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.email
HAVING COUNT(o.order_id) > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_id
    ) AS customer_orders
);

/*
Question: Find the top 3 products with the highest total revenue.
*/
SELECT
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders AS o
INNER JOIN products AS p ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 3;

/*
For each order, return the order_id, customer_id, and quantity, along with a new column
named order_size that categorizes the order as 'Small' if the quantity is between 1 and 2, 
'Medium' if the quantity is between 3 and 5, and 'Large' if the quantity is greater than 5. */


SELECT
    o.order_id,
    c.customer_id,
    o.quantity,
    CASE
        WHEN o.quantity <= 2 THEN 'Small'
        WHEN o.quantity <= 5 THEN 'Medium'
        ELSE 'Large'
    END AS order_size
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id;

/*
For each customer, return their `customer_name`, `email`, and `total_spent` calculated
 as the sum of `quantity × price` from their orders, along with a new column named 
 `spending_level` that categorizes them as a `'Low Spender'` if their total spending is 
 less than 5000, a `'Medium Spender'` if their total spending is between 5000 and 10000, 
 and a `'High Spender'` if their total spending exceeds 10000. */


SELECT
    c.customer_id,
    c.email,
    SUM(o.quantity * p.price) AS total_spent,
    CASE
        WHEN SUM(o.quantity * p.price) < 5000 THEN 'Low Spender'
        WHEN SUM(o.quantity * p.price) < 1000 THEN 'Medium Spender'
        ELSE 'High Spender'
    END AS spending_level
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN products AS p ON p.product_id = o.product_id
GROUP BY c.customer_id, c.email;

# Using CTE (Common Table Expression)
/*
For each customer, return their customer ID, name, email, total amount spent, and categorize
them as a Low Spender (≤ 5000), Medium Spender (≤ 10000), or High Spender (> 10000) based on
their total spending. */

WITH spent_table AS (
    SELECT 
        o.customer_id,
        SUM(o.quantity * p.price) AS total_spent,
        CASE
            WHEN SUM(o.quantity * p.price) <= 5000 THEN 'Low Spender'
            WHEN SUM(o.quantity * p.price) <= 10000 THEN 'Medium Spender'
            ELSE 'High Spender'
        END AS spending_level
    FROM 
        orders AS o
    INNER JOIN 
        products AS p 
        ON o.product_id = p.product_id
    GROUP BY 
        o.customer_id
)

SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    s.total_spent,
    s.spending_level
FROM 
    customers AS c
INNER JOIN 
    spent_table AS s 
    ON c.customer_id = s.customer_id;


