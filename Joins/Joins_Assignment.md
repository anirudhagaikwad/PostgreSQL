```sql
-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO users (name, city) VALUES
('Alice', 'Delhi'), ('Bob', 'Mumbai'), ('Charlie', 'Delhi'),
('David', 'Bangalore'), ('Eve', NULL);

-- Orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO orders (user_id, amount, order_date) VALUES
(1, 1500.00, '2025-01-10'), (1, 800.00, '2025-02-15'),
(2, 2000.00, '2025-01-20'), (3, 500.00, '2025-03-05'),
(6, 1200.00, '2025-02-01');  -- user_id 6 does not exist in users
```

For **SELF JOIN**, we'll use an extended `users` table with a `referrer_id` column (or a separate `employees` table for hierarchy).

### 1. CROSS JOIN (Cartesian Product)
**Question 1:**  
You want to generate all possible combinations of users and order statuses for a marketing campaign report (e.g., pair every user with every possible status: 'Pending', 'Completed', 'Cancelled'). Write a query using **CROSS JOIN** to create this full list.

**Question 2:**  
A company needs to simulate all possible pairings between 5 products and 4 warehouses to calculate potential storage costs. Use **CROSS JOIN** to list every product-warehouse combination (assume simple `products` and `warehouses` tables).

### 2. INNER JOIN (Most Common)
**Question 1:**  
Find the names of all users who have placed at least one order, along with the total amount they spent. Only include users who actually ordered something. Use **INNER JOIN**.

**Question 2:**  
Retrieve a list of orders with the corresponding user name and city, but only for orders placed in 2025 where the amount is greater than 1000. Use **INNER JOIN** and add a date filter.

### 3. LEFT OUTER JOIN (LEFT JOIN)
**Question 1:**  
Show **all users** (even those who never placed an order) along with their order details if any. For users without orders, show `NULL` for amount and order date. Use **LEFT JOIN**.

**Question 2:**  
Generate a report of all users and the number of orders they placed (use `COUNT`). Users with zero orders should appear with count = 0. Use **LEFT JOIN** with `GROUP BY`.

### 4. RIGHT OUTER JOIN (RIGHT JOIN)
**Question 1:**  
Show **all orders** (even if the user_id doesn't exist in the users table, e.g., deleted users or orphan records), along with the user name if it exists. Use **RIGHT JOIN**.

**Question 2:**  
A cleanup task: List every order and the city of the associated user. Include orders where the user might have been removed from the users table (name and city will be `NULL`). Use **RIGHT JOIN**.

### 5. FULL OUTER JOIN (FULL JOIN)
**Question 1:**  
Create a complete reconciliation report that shows **all users and all orders**, including users without orders and orders without matching users (e.g., for auditing data integrity). Use **FULL OUTER JOIN**.

**Question 2:**  
Find users who have no orders **and** orders that have no matching users in one single query. Display name/amount and use `WHERE` to filter only unmatched rows on either side. Use **FULL OUTER JOIN**.

### 6. SELF JOIN
**Question 3 (Bonus for hierarchy):** First, alter the users table or create an employees table for this:

```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT
);

INSERT INTO employees (name, manager_id) VALUES
('Alice', NULL), ('Bob', 1), ('Charlie', 1),
('David', 2), ('Eve', 2);
```

**Question 1:**  
Find all employees and their direct manager's name (hierarchical reporting). Use **SELF JOIN** (join the table to itself on `manager_id = id`).

**Question 2:**  
In a social app, find pairs of users who are in the same city (potential friend suggestions), excluding pairing a user with themselves. Use **SELF JOIN** with `u1.id < u2.id` to avoid duplicates.
