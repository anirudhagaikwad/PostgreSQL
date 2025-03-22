-- Database Design for Online Bookshop
-- For a basic online bookshop, we’ll need the following tables:

-- Users: Stores customer information (e.g., for login and orders).
-- Books: Stores book details (title, author, price, etc.).
-- Authors: Stores author information (to normalize the data and avoid redundancy).
-- Orders: Tracks customer orders.
-- Order_Items: Links orders to specific books (since an order can contain multiple books).
-- Categories: Stores book categories (e.g., Fiction, Non-Fiction).

-- Relationships:
-- Users to Orders: One-to-Many (One user can place many orders).
-- Books to Authors: Many-to-One (A book has one author, but an author can write many books). (Note: For simplicity, I’ll assume one author per book; in a real system, you might need a many-to-many relationship with a junction table.)
-- Books to Categories: Many-to-One (A book belongs to one category, but a category can have many books).
-- Orders to Order_Items: One-to-Many (One order can have multiple items).
-- Books to Order_Items: Many-to-One (A book can appear in many order items).

-- Create Categories table
CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Create Authors table
CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    bio TEXT
);

-- Create Books table
CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author_id INT NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    isbn VARCHAR(13) UNIQUE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE RESTRICT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE RESTRICT
);

-- Create Users table
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Orders table
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Create Order_Items table (junction table for Orders and Books)
CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE RESTRICT
);

-- Add indexes for better performance
CREATE INDEX idx_books_author_id ON Books(author_id);
CREATE INDEX idx_books_category_id ON Books(category_id);
CREATE INDEX idx_orders_user_id ON Orders(user_id);
CREATE INDEX idx_order_items_order_id ON Order_Items(order_id);
CREATE INDEX idx_order_items_book_id ON Order_Items(book_id);


-- Insert into Categories
INSERT INTO Categories (name, description) VALUES
    ('Fiction', 'Fictional stories and novels'),
    ('Non-Fiction', 'Factual and informative books'),
    ('Science Fiction', 'Speculative fiction with futuristic themes'),
    ('Mystery', 'Books centered around suspense and crime'),
    ('Biography', 'Life stories of notable individuals');

-- Insert into Authors
INSERT INTO Authors (first_name, last_name, bio) VALUES
    ('Jane', 'Austen', 'English novelist known for her romance novels'),
    ('Isaac', 'Asimov', 'Science fiction writer and biochemist'),
    ('Agatha', 'Christie', 'Renowned mystery writer'),
    ('Michelle', 'Obama', 'Former First Lady and author'),
    ('George', 'Orwell', 'Author of dystopian classics');

-- Insert into Books
INSERT INTO Books (title, author_id, category_id, price, stock, isbn) VALUES
    ('Pride and Prejudice', 1, 1, 12.99, 50, '9780141439518'),
    ('Foundation', 2, 3, 15.99, 30, '9780553293357'),
    ('Murder on the Orient Express', 3, 4, 9.99, 40, '9780062693662'),
    ('Becoming', 4, 5, 18.49, 25, '9781524763138'),
    ('1984', 5, 3, 14.99, 60, '9780451524935');

-- Insert into Users
INSERT INTO Users (username, email, password_hash) VALUES
    ('john_doe', 'john.doe@email.com', 'hashed_password_123'),
    ('jane_smith', 'jane.smith@email.com', 'hashed_password_456'),
    ('booklover', 'booklover@email.com', 'hashed_password_789'),
    ('reader123', 'reader123@email.com', 'hashed_password_101'),
    ('bibliophile', 'bibliophile@email.com', 'hashed_password_202');

-- Insert into Orders
INSERT INTO Orders (user_id, total_amount, status) VALUES
    (1, 28.98, 'Shipped'),    -- John Doe orders 2 books
    (2, 15.99, 'Pending'),    -- Jane Smith orders 1 book
    (3, 24.98, 'Delivered'),  -- Booklover orders 2 books
    (4, 18.49, 'Processing'), -- Reader123 orders 1 book
    (5, 14.99, 'Shipped');    -- Bibliophile orders 1 book

-- Insert into Order_Items
INSERT INTO Order_Items (order_id, book_id, quantity, unit_price) VALUES
    (1, 1, 1, 12.99),  -- John Doe: Pride and Prejudice
    (1, 2, 1, 15.99),  -- John Doe: Foundation
    (2, 2, 1, 15.99),  -- Jane Smith: Foundation
    (3, 3, 1, 9.99),   -- Booklover: Murder on the Orient Express
    (3, 5, 1, 14.99),  -- Booklover: 1984
    (4, 4, 1, 18.49),  -- Reader123: Becoming
    (5, 5, 1, 14.99);  -- Bibliophile: 1984