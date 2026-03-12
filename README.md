# 🗄️ SQL Learning Journey — PostgreSQL from Scratch

A day-by-day log of everything I've learned in PostgreSQL — from basic table creation to joins, views, stored procedures, and a mini project.

---

## 📅 Learning Timeline

| Day | Topic |
|-----|-------|
| Day 1 | SQL Basics — CREATE, INSERT, SELECT, WHERE, UPDATE |
| Day 2 | Data Types — Numbers, Strings, Constraints |
| Day 3 | Clauses & Aggregates — GROUP BY, HAVING, ORDER BY, String Functions |
| Day 4 | CASE Statements — Conditional logic & column updates |
| Day 5 | Relationships & Joins — FK, INNER / LEFT / RIGHT / FULL JOIN |
| Day 6 | Many-to-Many — Junction tables, multi-table JOINs |
| Day 7 | Views & Stored Procedures — CREATE VIEW, plpgsql |
| Project | Mini Project — Products + Orders real-world system |

---

## Day 1 — SQL Basics

```sql
-- Create a table
CREATE TABLE student (
  student_name CHAR(50),
  age          INT,
  agrade       CHAR(1)
);

-- Insert rows
INSERT INTO student (student_name, age, agrade)
VALUES ('Johaib Akhtar', 22, 'A'),
       ('Sahid Ansari',  21, 'A');

-- Read data
SELECT * FROM student;
SELECT student_name FROM student WHERE age = 22;

-- Update data
UPDATE student SET age = 20 WHERE student_name = 'Sahid Ansari';
```

---

## Day 2 — Data Types & Constraints

### Numeric Types
- `SMALLINT` — small whole numbers
- `INT` / `SERIAL` — integers, SERIAL auto-increments
- `NUMERIC(p, s)` — exact decimals (great for prices)
- `REAL` — approximate floating-point

### String Types
- `CHAR(n)` — fixed length, padded with spaces
- `VARCHAR(n)` — variable length up to n characters
- `TEXT` — unlimited length

### Constraints
```sql
CREATE TABLE random (
  id         SERIAL PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  email      TEXT UNIQUE NOT NULL,
  created_at DATE DEFAULT now(),
  age        INT  CHECK (age >= 18)
);
```

| Constraint | Purpose |
|------------|---------|
| `PRIMARY KEY` | Uniquely identifies each row |
| `NOT NULL` | Column must have a value |
| `UNIQUE` | No duplicate values allowed |
| `DEFAULT` | Auto-fills if not provided |
| `CHECK` | Enforces a custom condition |

---

## Day 3 — Clauses & Aggregate Functions

```sql
-- Filtering & sorting
SELECT * FROM products WHERE category = 'Electronics';
SELECT * FROM products ORDER BY price ASC;
SELECT * FROM products LIMIT 3;
SELECT DISTINCT category FROM products;
SELECT name AS item_name, price AS item_price FROM products;

-- Grouping
SELECT category, COUNT(*) FROM products GROUP BY category;
SELECT category, COUNT(*) FROM products
  GROUP BY category HAVING COUNT(*) > 1;

-- Aggregate functions
SELECT COUNT(product_id)    FROM products;
SELECT SUM(price)           FROM products;
SELECT ROUND(AVG(price), 2) FROM products;
SELECT MIN(price), MAX(price) FROM products;
```

### Operators
```sql
WHERE price BETWEEN 40 AND 50
WHERE category IN ('Electronics', 'Bags')
WHERE sku_code LIKE 'W%'       -- starts with W
WHERE sku_code LIKE '%123%'    -- contains 123
WHERE sku_code LIKE '_B%'      -- second char is B
```

### String Functions
```sql
SELECT UPPER(name), LOWER(name) FROM products;
SELECT LENGTH(sku_code) FROM products;
SELECT SUBSTRING(sku_code, 1, 2) FROM products;
SELECT LEFT(sku_code, 2) FROM products;
SELECT CONCAT(name, ' ', category) AS product_with_category FROM products;
SELECT TRIM('   hello   ');
SELECT REPLACE(sku_code, LEFT(sku_code, 2), 'GG') FROM products;
```

---

## Day 4 — CASE Statements

```sql
-- CASE in SELECT (display only)
SELECT name, price,
  CASE
    WHEN price > 100              THEN 'Expensive'
    WHEN price BETWEEN 50 AND 100 THEN 'Moderate'
    ELSE 'Cheap'
  END AS price_tag
FROM products;

-- CASE in UPDATE (permanently stores the result)
ALTER TABLE products ADD COLUMN price_tag CHAR(100);

UPDATE products
SET price_tag =
  CASE
    WHEN price > 100              THEN 'Expensive'
    WHEN price BETWEEN 50 AND 100 THEN 'Moderate'
    ELSE 'Cheap'
  END;

-- CASE with subquery
SELECT name, price,
  CASE
    WHEN price > (SELECT AVG(price) FROM products) THEN 'Above Average'
    WHEN price < (SELECT AVG(price) FROM products) THEN 'Below Average'
    ELSE 'Exactly Average'
  END AS price_vs_avg
FROM products;

-- CASE with GROUP BY
SELECT category,
  CASE
    WHEN AVG(price) < 30              THEN 'Cheap Category'
    WHEN AVG(price) BETWEEN 30 AND 80 THEN 'Moderate Category'
    ELSE 'Expensive Category'
  END AS category_class
FROM products
GROUP BY category;
```

---

## Day 5 — Relationships & Joins

```sql
-- Foreign key
CREATE TABLE grades (
  grade_id   SERIAL PRIMARY KEY,
  student_id INT REFERENCES students(student_id),
  subject    VARCHAR(50),
  marks      INT
);
```

### Join Types

| Join | Returns |
|------|---------|
| `INNER JOIN` | Only matching rows from both tables |
| `LEFT JOIN` | All rows from left, NULL where no right match |
| `RIGHT JOIN` | All rows from right, NULL where no left match |
| `FULL JOIN` | All rows from both tables |

```sql
-- Example
SELECT e.empl_name, h.games, h.score
FROM employees e
JOIN hobbies h ON e.empl_id = h.empl_id
WHERE e.empl_name = 'johaib';
```

---

## Day 6 — Many-to-Many Relationships

When students can take many courses and courses can have many students, use a **junction table**.

```sql
CREATE TABLE student_course (
  student_id INT,
  course_id  INT,
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);

-- Multi-table JOIN
SELECT s.student_name, c.course_name
FROM student_course sc
JOIN students s ON sc.student_id = s.student_id
JOIN courses c  ON sc.course_id  = c.course_id
WHERE s.student_name = 'simran';
```

---

## Day 7 — Views & Stored Procedures

### Views
A VIEW is a saved SELECT query that acts like a virtual table.

```sql
CREATE VIEW electronics_items AS
SELECT product_id, name, price, stock_quantity
FROM products
WHERE category = 'Electronics';

SELECT * FROM electronics_items;  -- use like a regular table
```

### Stored Procedures
```sql
CREATE PROCEDURE add_product(
  p_name     VARCHAR,
  p_sku      CHAR(8),
  p_price    NUMERIC,
  p_qty      INT,
  p_category TEXT
)
LANGUAGE plpgsql AS $$
BEGIN
  INSERT INTO products (name, sku_code, price, stock_quantity, category)
  VALUES (p_name, p_sku, p_price, p_qty, p_category);
END;
$$;

-- Call it
CALL add_product('Bottle', 'WB324736', 674.04, 45, 'Bags');
```

> ⚠️ **Common mistake:** Always pass ALL arguments in the correct order. Missing one causes a *"procedure does not exist"* error because PostgreSQL matches by name AND argument count/type.

---

## 🏗️ Mini Project — Products & Orders System

### Schema

```sql
CREATE TABLE products (
  product_id     INT PRIMARY KEY,
  product_name   VARCHAR(100),
  category       TEXT,
  price          NUMERIC(10,2),
  stock_quantity INT,
  is_available   BOOLEAN,
  added_on       DATE
);

CREATE TABLE orders (
  order_id       INT PRIMARY KEY,
  product_id     INT,
  quantity       INT,
  order_date     DATE,
  customer_name  VARCHAR(50),
  payment_method VARCHAR(50),
  CONSTRAINT fk_product FOREIGN KEY (product_id)
    REFERENCES products(product_id) ON DELETE CASCADE
);
```

### Queries Practiced

```sql
-- Orders with product details
SELECT o.order_id, o.customer_name, p.product_name, p.price
FROM orders o JOIN products p ON o.product_id = p.product_id;

-- All products even if never ordered
SELECT p.product_name, o.order_id
FROM products p LEFT JOIN orders o ON o.product_id = p.product_id;

-- Orders count per product
SELECT p.product_name, COUNT(o.order_id) AS total_orders
FROM orders o LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name;

-- Revenue per product
SELECT p.product_name, SUM(o.quantity * p.price) AS total_revenue
FROM orders o LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Products where revenue > 2000
SELECT p.product_name, SUM(o.quantity * p.price) AS total_revenue
FROM orders o LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(o.quantity * p.price) > 2000;

-- Unique customers who ordered Fitness products
SELECT DISTINCT o.customer_name
FROM orders o JOIN products p ON o.product_id = p.product_id
WHERE p.category = 'Fitness';
```

---

## 📋 Quick Reference

| Keyword | Purpose |
|---------|---------|
| `SELECT` | Read data from a table |
| `INSERT` | Add new rows |
| `UPDATE` | Modify existing rows |
| `DELETE` | Remove rows |
| `WHERE` | Filter rows |
| `GROUP BY` | Group rows for aggregation |
| `HAVING` | Filter after GROUP BY |
| `ORDER BY` | Sort results ASC / DESC |
| `LIMIT` | Return only first n rows |
| `JOIN` | Combine rows from two tables |
| `LEFT JOIN` | All from left, NULL if no right match |
| `CASE` | Conditional logic (like IF/ELSE) |
| `CREATE VIEW` | Save a query as a virtual table |
| `CREATE PROCEDURE` | Save reusable logic block |
| `CALL` | Execute a stored procedure |
| `FOREIGN KEY` | Link a column to another table's PK |

---

> 💡 *Keep practicing. SQL skills compound with every query you write.*
