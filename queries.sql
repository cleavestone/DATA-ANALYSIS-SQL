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

customer_name

email

order_id (if any)

order_date (if any) */

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

product_name

total_orders (how many times it appears in the orders table)

total_quantity (sum of quantity ordered)
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

Return the following columns:

customer_name

email

order_date

product_name
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