-- Create Table with Primary Key
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Create Table with Foreign Key
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    amount DECIMAL(10,2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Additional Table with Primary Key
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Create Additional Table with Foreign Key
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL
);

-- Insert into users
INSERT INTO users (name, email) VALUES 
('Amit Sharma', 'amit.sharma@example.com'),
('Priya Patel', 'priya.patel@example.com'),
('Rahul Verma', 'rahul.verma@example.com'),
('Neha Kapoor', 'neha.kapoor@example.com'),
('Vikram Singh', 'vikram.singh@example.com');

-- Insert into orders
INSERT INTO orders (user_id, amount, order_date) VALUES 
(1, 1500.75, '2024-03-01 10:15:00'),
(2, 2200.00, '2024-03-02 12:30:00'),
(3, 3200.50, '2024-03-03 15:45:00'),
(4, 800.20, '2024-03-04 18:00:00'),
(5, 5400.00, '2024-03-05 20:15:00');

-- Insert into products
INSERT INTO products (product_name, price) VALUES 
('Laptop', 55000.99),
('Smartphone', 25000.50),
('Headphones', 2000.75),
('Keyboard', 1500.99),
('Mouse', 800.95);

-- Insert into order_items
INSERT INTO order_items (order_id, product_id, quantity) VALUES 
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 3),
(5, 5, 4);
