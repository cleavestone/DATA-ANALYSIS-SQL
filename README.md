# 🧠 SQL Practice Project

Welcome to the **SQL Practice Project**, a hands-on mini project designed to help you master SQL by working with realistic, randomly generated datasets.

---

## 📌 Project Overview

This project includes a collection of practice questions and queries focused on core SQL concepts such as `JOIN`, `GROUP BY`, subqueries, window functions, and more.

You’ll use three main tables:
- `customers`
- `products`
- `orders`

Each table is pre-populated with synthetic data generated using Python and Faker.

---

## 📊 Sample Query & Output

> **🧠 Task:** Find the top 5 customers who have spent the most money on orders.

```sql
SELECT
    c.customer_name,
    c.email,
    SUM(o.quantity * p.price) AS total_spent
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN products AS p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name, c.email
ORDER BY total_spent DESC
LIMIT 5;

+----------------+---------------------------------+--------------------+
| customer_name  | email                           | total_spent        |
+----------------+---------------------------------+--------------------+
| Alex Jenkins   | zjames@martinez.com             |           24745.24 |
| Thomas Barry   | raymondferguson@kirby-price.com | 22559.630000000005 |
| James Allen    | nicholerasmussen@guzman.com     |           19875.42 |
| Megan Delacruz | karen58@hotmail.com             |           19677.49 |
| Judith Allen   | rebekahsparks@moore.com         |           19537.91 |
+----------------+---------------------------------+--------------------+

```


## 📂 Project Structure

- `customers.csv` — Customer data with basic details like name, email, and signup date.
- `products.csv` — Product catalog with product names and prices.
- `orders.csv` — Orders made by customers, including quantity and order dates.
- `create_tables.sql` - Creates Table customers,products and orders
- `insert_data.sql`- Populates our three tables using INSERT statement
- `queriers.sql` - Shows the problem and corresponding queries i have run on my machine

## 🧱 Database Schema

### `customers`
| Column        | Type      | Description           |
|---------------|-----------|-----------------------|
| customer_id   | INT       | Primary key           |
| customer_name | VARCHAR   | Full name             |
| email         | VARCHAR   | Email address         |
| signup_date   | DATE      | Date of registration  |

### `products`
| Column       | Type       | Description      |
|--------------|------------|------------------|
| product_id   | INT        | Primary key      |
| product_name | VARCHAR    | Name of product  |
| price        | DECIMAL    | Price of product |

### `orders`
| Column      | Type   | Description                       |
|-------------|--------|-----------------------------------|
| order_id    | INT    | Primary key                       |
| customer_id | INT    | Foreign key → `customers`         |
| product_id  | INT    | Foreign key → `products`          |
| order_date  | DATE   | When the order was made           |
| quantity    | INT    | Number of units ordered           |

## ✅ SQL Concepts Practiced

This project helps reinforce the following SQL topics:

- 🔗 **JOINs** (`INNER`, `LEFT`)
- 📊 **Aggregations** and `GROUP BY`
- 📆 **Filtering** with `WHERE`, dates, and logical conditions
- 🔍 **Subqueries** (correlated & non-correlated)
- 🧩 **CASE statements** for conditional logic
- 🧵 **String and pattern matching** (`LIKE`, `REGEXP`)
- 📐 **Window functions** (`ROW_NUMBER`, `RANK`, `LEAD`, `LAG`)
- 🧱 **Common Table Expressions (CTEs)** using `WITH`
- ♻️ **Set operations** (`UNION`, `INTERSECT`, `EXCEPT`)
- 👁️ **Views** (virtual tables)
- ⚙️ **Stored procedures** (optional, for advanced users)


## 🚀 Getting Started

1. Create the tables using the provided `CREATE TABLE` statements.
2. Load the data:
   - Option 1: Use `LOAD DATA INFILE` to load from the CSVs.
   - Option 2: Use the `INSERT` scripts (`*.sql`) to populate tables manually.
3. Run practice queries (starting with JOINs).
4. Track your progress by writing and testing your own queries.

## 📌 Notes

- All data is synthetically generated using Python and Faker.
- Suitable for learning SQL on MySQL or PostgreSQL.
- Data distribution may vary — check for date ranges when filtering.

## 👨‍💻 Author

This project was built as a personal hands-on SQL playground.  
Feel free to fork or expand with more tables and use cases!

## 🛠️ Requirements

- **MySQL** (preferred) or **PostgreSQL**
- SQL client (e.g., MySQL Workbench, pgAdmin) **or** terminal/command-line access


