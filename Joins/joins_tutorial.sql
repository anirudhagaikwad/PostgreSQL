-- =============================================
-- Practical SQL JOINs Tutorial for PostgreSQL
-- Tables: users and orders
-- At least 5+ rows in each table
-- Demonstrates: CROSS, INNER, LEFT, RIGHT, FULL, SELF JOIN
-- =============================================

-- Drop tables if they already exist (for re-running the script)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;

-- =============================================
-- 1. Create Tables
-- =============================================

CREATE TABLE users (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(100),
    city        VARCHAR(50)
);

CREATE TABLE orders (
    id          SERIAL PRIMARY KEY,
    user_id     INTEGER REFERENCES users(id),   -- Foreign Key kept
    amount      NUMERIC(10,2),
    order_date  DATE,
    status      VARCHAR(20)
);

-- =============================================
-- 2. Insert Sample Data (at least 5+ rows each)
-- =============================================

-- Users (7 users)
INSERT INTO users (name, email, city) VALUES
('Aarav Sharma',      'aarav.sharma@example.com',     'Mumbai'),
('Priya Patel',       'priya.patel@example.com',      'Ahmedabad'),
('Rahul Verma',       'rahul.verma@example.com',      'Delhi'),
('Ananya Singh',      'ananya.singh@example.com',     'Bangalore'),
('Vikram Malhotra',   'vikram.malhotra@example.com',  'Hyderabad'),
('Sneha Gupta',       'sneha.gupta@example.com',      'Chennai'),
('Arjun Reddy',       'arjun.reddy@example.com',      'Pune');

-- Orders (8 orders)
-- Some users have multiple orders, some have none, some orders have no matching user (for RIGHT/FULL JOIN demo)
INSERT INTO orders (user_id, amount, order_date, status) VALUES
(1,  299.99, '2025-01-15', 'Completed'),   -- Aarav Sharma
(1,  149.50, '2025-02-20', 'Completed'),   -- Aarav Sharma
(2,  499.00, '2025-01-10', 'Pending'),     -- Priya Patel
(3,   89.99, '2025-03-05', 'Completed'),   -- Rahul Verma
(5,  199.99, '2025-02-28', 'Completed'),   -- Vikram Malhotra
(5,   75.00, '2025-03-10', 'Cancelled');  -- Vikram Malhotra


--  Insert "Orphan" Orders (user_id = NULL) for RIGHT/FULL JOIN demo
-- =============================================
INSERT INTO orders (user_id, amount, order_date, status) VALUES
(NULL,  599.00, '2025-03-15', 'Completed'),   -- Order with no user
(NULL,  249.50, '2025-03-20', 'Pending');     -- Another order with no user


-- =============================================
-- 3. Verify Data
-- =============================================
SELECT 'Users Table' AS table_name;
SELECT * FROM users ORDER BY id;

SELECT 'Orders Table' AS table_name;
SELECT * FROM orders ORDER BY id;

-- =============================================
-- 4. JOIN Examples
-- =============================================

-- 1. CROSS JOIN (Cartesian Product)
SELECT
    u.name AS user_name,
    o.amount,
    o.order_date
FROM users u
CROSS JOIN orders o
LIMIT 20;                     -- Limit to avoid too many rows in demo

-- 2. INNER JOIN (Only matching records)
SELECT
    u.name,
    u.city,
    o.amount,
    o.order_date,
    o.status
FROM users u
INNER JOIN orders o ON u.id = o.user_id
ORDER BY u.name, o.order_date;

-- 3. LEFT JOIN (All users + matching orders, NULL if no order)
SELECT
    u.name,
    u.city,
    o.amount,
    o.order_date,
    o.status
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
ORDER BY u.name, o.order_date;

-- 4. RIGHT JOIN (All orders + matching users, NULL if no user)
SELECT
    u.name,
    u.city,
    o.amount,
    o.order_date,
    o.status
FROM users u
RIGHT JOIN orders o ON u.id = o.user_id
ORDER BY o.order_date;

-- 5. FULL OUTER JOIN (All users and all orders)
SELECT
    u.name,
    u.city,
    o.amount,
    o.order_date,
    o.status
FROM users u
FULL JOIN orders o ON u.id = o.user_id
ORDER BY u.name, o.order_date;

-- 6. SELF JOIN (Example: Find users who live in the same city)
SELECT
    u1.name AS user1,
    u2.name AS user2,
    u1.city
FROM users u1
JOIN users u2 ON u1.city = u2.city AND u1.id < u2.id   -- Avoid duplicate pairs
ORDER BY u1.city, u1.name;

-- Bonus: Count orders per user (using LEFT JOIN + GROUP BY)
SELECT
    u.name,
    COUNT(o.id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_spent
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name
ORDER BY total_spent DESC;
