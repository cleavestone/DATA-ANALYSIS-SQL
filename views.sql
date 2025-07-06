/*
Create a view named `customer_summary` that joins the `customers`, `orders`, and `products` 
tables to return each customer's `customer_id`, `customer_name`, `email`, and the 
total amount spent calculated as the sum of `quantity × price`. Then, query the `customer_summary` 
view to return only those customers whose total amount spent is greater than 1000. 
*/

CREATE VIEW customer_summary AS
SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    SUM(o.quantity * p.price) AS total_amount_spent
FROM customers AS c
JOIN orders AS o USING(customer_id)
JOIN products AS p USING(product_id)
GROUP BY c.customer_id, c.customer_name, c.email;

SELECT * FROM customer_summary2 WHERE total_amount_spent>10000;

/*
Create a stored procedure called get_customer_summary that takes one input parameter: 
a numeric amount. The procedure should return a list of customers (customer_id, customer_name, 
and email) along with their total_spent (calculated as the sum of quantity × price across all orders). 
Only include customers whose total spending is less than the given amount.
*/

DELIMITER //

CREATE PROCEDURE get_customer_summary(IN amount DECIMAL)
BEGIN
     SELECT 
         c.customer_id,
         c.customer_name,
         c.email,
         SUM(o.quantity * p.price) AS total_spent
     FROM customers AS c 
     JOIN orders AS o USING(customer_id)
     JOIN products AS p USING(product_id)
     GROUP BY c.customer_id, c.customer_name, c.email
     HAVING SUM(o.quantity * p.price) < amount;
END //

DELIMITER ;

