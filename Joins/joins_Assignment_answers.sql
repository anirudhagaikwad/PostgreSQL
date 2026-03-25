-- =============================================
-- PRACTICAL QUESTIONS ON ALL TYPES OF SQL JOINS
-- PostgreSQL
-- =============================================

-- First, create and populate sample tables (Run this once)
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    amount DECIMAL(10,2),
    order_date DATE
);

CREATE TABLE IF NOT EXISTS employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT REFERENCES employees(id)
);

-- Insert sample data
INSERT INTO users (name, city) VALUES
('Alice', 'Delhi'), ('Bob', 'Mumbai'), ('Charlie', 'Delhi'),
('David', 'Bangalore'), ('Eve', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO orders (user_id, amount, order_date) VALUES
(1, 1500.00, '2025-01-10'),
(1, 800.00,  '2025-02-15'),
(2, 2000.00, '2025-01-20'),
(3, 500.00,  '2025-03-05'),
(6, 1200.00, '2025-02-01')  -- orphan order (user_id 6 doesn't exist)
ON CONFLICT DO NOTHING;

INSERT INTO employees (name, manager_id) VALUES
('Alice', NULL),
('Bob', 1),
('Charlie', 1),
('David', 2),
('Eve', 2)
ON CONFLICT DO NOTHING;


-- =============================================
-- 1. CROSS JOIN Questions
-- =============================================

-- Question 1: Generate all possible combinations of users and order statuses
-- for a marketing campaign (statuses: Pending, Completed, Cancelled)
SELECT
    u.name AS user_name,
    s.status
FROM users u
CROSS JOIN (
    VALUES ('Pending'), ('Completed'), ('Cancelled')
) AS s(status)
ORDER BY u.name, s.status;


-- Question 2: Simulate all possible product-warehouse combinations
-- (Assume small products and warehouses tables)
-- For demonstration, we'll use VALUES
SELECT
    p.product_name,
    w.warehouse_name,
    p.price * 0.05 AS estimated_monthly_storage_cost
FROM (VALUES
    ('Laptop', 45000),
    ('Mouse', 800),
    ('Keyboard', 1500),
    ('Monitor', 12000),
    ('Headphones', 2500)
) AS p(product_name, price)
CROSS JOIN (VALUES
    ('Delhi Warehouse'),
    ('Mumbai Warehouse'),
    ('Bangalore Warehouse'),
    ('Hyderabad Warehouse')
) AS w(warehouse_name)
ORDER BY p.product_name, w.warehouse_name;


-- =============================================
-- 2. INNER JOIN Questions
-- =============================================

-- Question 1: Find users who have placed at least one order
-- along with their total spending
SELECT
    u.name,
    SUM(o.amount) AS total_spent,
    COUNT(o.order_id) AS number_of_orders
FROM users u
INNER JOIN orders o ON u.id = o.user_id
GROUP BY u.name
ORDER BY total_spent DESC;


-- Question 2: Show orders with user details for high-value orders in 2025
SELECT
    u.name,
    u.city,
    o.order_id,
    o.amount,
    o.order_date
FROM users u
INNER JOIN orders o ON u.id = o.user_id
WHERE o.order_date >= '2025-01-01'
  AND o.amount > 1000
ORDER BY o.amount DESC;


-- =============================================
-- 3. LEFT JOIN Questions
-- =============================================

-- Question 1: Show ALL users and their order details (even if they have no orders)
SELECT
    u.name,
    u.city,
    o.order_id,
    o.amount,
    o.order_date
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
ORDER BY u.name;


-- Question 2: Show all users with the count of orders they placed
-- (users with zero orders should show 0)
SELECT
    u.name,
    u.city,
    COUNT(o.order_id) AS order_count,
    COALESCE(SUM(o.amount), 0) AS total_spent
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.name, u.city
ORDER BY order_count DESC, u.name;


-- =============================================
-- 4. RIGHT JOIN Questions
-- =============================================

-- Question 1: Show ALL orders including orphan orders (user may not exist)
SELECT
    o.order_id,
    o.amount,
    o.order_date,
    u.name AS user_name,
    u.city
FROM users u
RIGHT JOIN orders o ON u.id = o.user_id
ORDER BY o.order_id;


-- Question 2: List every order with user city (NULL if user deleted)
SELECT
    o.order_id,
    o.amount,
    COALESCE(u.city, 'Unknown / User Deleted') AS user_city
FROM users u
RIGHT JOIN orders o ON u.id = o.user_id
ORDER BY o.order_id;


-- =============================================
-- 5. FULL OUTER JOIN Questions
-- =============================================

-- Question 1: Complete reconciliation - ALL users and ALL orders
SELECT
    u.name AS user_name,
    u.city,
    o.order_id,
    o.amount,
    o.order_date
FROM users u
FULL OUTER JOIN orders o ON u.id = o.user_id
ORDER BY u.name, o.order_id;


-- Question 2: Find unmatched records - users without orders AND orders without users
SELECT
    u.name AS user_name,
    u.city,
    o.order_id,
    o.amount,
    CASE
        WHEN u.id IS NULL THEN 'Orphan Order'
        WHEN o.order_id IS NULL THEN 'User with No Orders'
    END AS issue_type
FROM users u
FULL OUTER JOIN orders o ON u.id = o.user_id
WHERE u.id IS NULL OR o.order_id IS NULL
ORDER BY issue_type, u.name, o.order_id;


-- =============================================
-- 6. SELF JOIN Questions
-- =============================================

-- Question 1: Show every employee with their direct manager's name
SELECT
    e.name AS employee_name,
    m.name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
ORDER BY e.name;


-- Question 2: Find pairs of users who live in the same city
-- (friend suggestions) - exclude self-pairing and duplicates
SELECT
    u1.name AS user1,
    u2.name AS user2,
    u1.city
FROM users u1
JOIN users u2 ON u1.city = u2.city AND u1.id < u2.id
WHERE u1.city IS NOT NULL
ORDER BY u1.city, u1.name;
