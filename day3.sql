-- create table products(
-- product_id serial primary key,
-- name varchar(100) not null,
-- sku_code char(8) unique not null,
-- price numeric(10,2) check (price >=0),
-- stock_quantity int default 0 check (stock_quantity>=0),
-- is_available boolean default TRUE,
-- category text not null,
-- added_on date default current_date,
-- last_update Timestamp default now()

-- );


-- insert into products (name,sku_code,price,stock_quantity,is_available,category)
-- values
-- ('Wireless Mouse',        'WM001234', 29.99,  150, TRUE,  'Electronics'),
-- ('Mechanical Keyboard',   'KB002345', 89.99,  75,  TRUE,  'Electronics'),
-- ('USB-C Hub 7-Port',      'UH003456', 45.50,  200, TRUE,  'Electronics'),
-- ('Noise Cancelling Headphones', 'HP004567', 129.99, 60, TRUE, 'Electronics'),
-- ('Webcam 1080p',          'WC005678', 59.99,  90,  TRUE,  'Electronics'),
-- ('Standing Desk Mat',     'DM006789', 39.99,  120, TRUE,  'Office Supplies'),
-- ('Ergonomic Chair',       'EC007890', 349.00, 25,  TRUE,  'Furniture'),
-- ('Monitor Stand',         'MS008901', 24.99,  180, TRUE,  'Office Supplies'),
-- ('LED Desk Lamp',         'LD009012', 34.99,  95,  TRUE,  'Lighting'),
-- ('Laptop Backpack',       'LB010123', 79.99,  55,  FALSE, 'Bags'),
-- ('Screen Cleaner Kit',    'SC011234', 9.99,   300, TRUE,  'Accessories'),
-- ('Cable Management Box',  'CM012345', 19.99,  0,   FALSE, 'Accessories');


-- select * from products;

-- Q1> show the name of price of all products 

-- select name, price from products;

-- Q2> show all products where the category is 'Electronics'

-- select * from products where category = 'Electronics';

-- Q3> group products by category , show each category once

-- select category from products Group by category;

-- Q4> show categories that have more than 1 product.(use after group by)

-- select category, count(*) from products Group by category Having count(*)>1;

-- Q5> show all products sorted by price in ascending order

-- select * from products order by price ASC;
-- select * from products order by price DESC;

-- Q6> show only the first 3 products from the table

-- select * from products limit 3;

-- Q7> show products name as item_name and price as item_price 

-- select name as item_name , price as item_price from products;

-- Q8 show all the unique categories from the products

-- select Distinct category from products;

--             clauses with operations


-- select * from products where category != 'Electronics';


-- select * from products where price > 50;

-- select * from products where price < 50 and category = 'Electronics';

-- select * from products where price Between 40 and 50;

-- select * from products where category = 'Electronics' or category = 'Lighting';

-- select * from products where category in ('Electronics','Lighting','Bags');

-- select * from products where sku_code like 'W%';

-- select * from products where sku_code like '%123%';

-- select * from products where sku_code like '_B%';

-- select * from products where not category = 'Bags';


-- Aggregation functions 

-- select count(product_id) from products;

-- select sum(price) from products;

-- select sum(price) from products where category = 'Electronics' or category='Bags';


-- select round(avg(price),2) from products;

-- select min(price) from products;

-- select max(price) from products;


-- Q1> display the name and price of the cheapest product in the entire table 

-- SELECT name, price
-- FROM products
-- ORDER BY price ASC
-- LIMIT 1;


-- SELECT name, price
-- FROM products
-- WHERE price = (SELECT MIN(price) FROM products);


-- Q2> find the avg. price of products that belong to the electronics or Accessories category

-- select round(avg(price),2) from products
-- where category = 'Electronics' or category= 'Accessories';


-- select round(avg(price),2) from products
-- where category in('Electronics','Accessories');

-- Q3> show the names and stock quality where the product is available, stock is more the 50 , and price is not equal to 299

-- SELECT name, stock_quantity
-- FROM products
-- WHERE stock_quantity > 50
-- AND price <> 299
-- AND is_available = true;

-- Q4> find the most expensive product in each category (name and price)

-- select category , max(price) as max_price from products
-- group by category;

--Q5> show all unique category in uppercase , sorted in desending order,


-- select distinct upper(category) as category_upper 
-- from products 
-- order by category_upper desc;


-- STRING FUNCTIONS 

-- select upper(name) from products;
-- select lower(name) from products;

-- select length(sku_code) from products;

-- select substring('brother in arms',1,7);

-- select name , substring(sku_code,1,2) from products;

-- select name, left(sku_code,2) from products;

-- select concat(name,' ',category)
-- as product_with_category from products; 

-- select concat_ws (' ',name,category,sku_code)
-- as new_column from products;


-- select trim ('   brother   '); -- trim spaces

-- select name , replace(sku_code,left(sku_code,2),'GG')
-- from products;







