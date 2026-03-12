--      CASE    --


-- if the price is above 100 you will say it is expensive.
-- if the price is between 50 and 100 you qill say it is moderate.
-- and if the price is below 50 it is cheap .

-- select name , price,
-- case when (price > 100) then 'Expensive'
-- 	when price  between 50 and 100 then 'Moderate'
-- 	else 'cheap'
-- end as price_tag from products;

-- this is only a extraction of data 

-- now we will use this case as a new column 

-- alter table products
-- add column price_tag char(100);

-- update products
-- set price_tag=
-- 	case
-- 	when (price > 100) then 'Expensive'
-- 	when price  between 50 and 100 then 'Moderate'
-- 	else 'cheap'
-- end;

-- Q> if the product is available then return in stock and if not then out of stock

-- select name,
-- case
-- 	when is_available then 'in stock'
-- 	else 'out of stock'
-- 	end as availability_status
-- from products;

-- Q> show product name , stock quantity , and label:
-- 'high stock' if quantity > 100
-- 'medium stock' if between 30 and 50
-- 'low stock' otherwise 


-- select name,
-- case
-- 	when stock_quantity > 75 then 'high stock'
-- 	when stock_quantity between 20 and 40 then 'medium stock'
-- 	else 'low stock'
-- 	end as stocks 
-- from products;

-- Q>. Show name, price, and a column discount_price 
-- apply a 10% discount if category is 'Electronics', 5% if 'Furniture', 
-- and no discount otherwise. Round to 2 decimal places.

-- select name, 
-- case
-- 	when category = 'Electronics' then '10% discount'
-- 	when category = 'Furniture' then '5% discount'
-- 	else 'no discount'
-- 	end as discount_price
-- from products;

-- attempt 2

-- SELECT name, price,
--   ROUND(
--     CASE
--       WHEN category = 'Electronics' THEN price * 0.90
--       WHEN category = 'Furniture'   THEN price * 0.95
--       ELSE price
--     END
--   , 2) AS discount_price
-- FROM products;

-- Q>. Show category, and classify each category's
-- average price as:

-- 'Cheap Category' → avg price < 30
-- 'Moderate Category' → avg price between 30 and 80
-- 'Expensive Category' → avg price > 80

-- SELECT category,
--   CASE
--     WHEN AVG(price) < 30 THEN 'Cheap Category'
--     WHEN AVG(price) BETWEEN 30 AND 80 THEN 'Moderate Category'
--     WHEN AVG(price) > 80 THEN 'Expensive Category'
--   END AS category_class
-- FROM products
-- GROUP BY category;

-- Q>. Show name, price, and a column price_vs_avg:

-- 'Above Average' → price is higher than the average price of ALL products
-- 'Below Average' → price is lower
-- 'Exactly Average' → price equals average


-- SELECT name, price,
--   CASE
--     WHEN price > (SELECT AVG(price) FROM products) THEN 'Above Average'
--     WHEN price < (SELECT AVG(price) FROM products) THEN 'Below Average'
--     WHEN price = (SELECT AVG(price) FROM products) THEN 'Exactly Average'
--   END AS price_vs_avg
-- FROM products;


-- Q>. Show category, and for each category show the most expensive product's name and its price bracket:

-- 'Premium' → max price > 100
-- 'Mid' → max price between 30 and 100
-- 'Budget' → max price < 30


-- select category,
-- case
-- 	when max(price) > 100 then 'Premium'
-- 	when max(price) between 30 and 100 then 'Mid'
-- 	when max(price) < 30 then 'Budget'
-- 	end as price_class
-- from products
-- group by category;


-- Q>. Show each product's name, price, and a column tax_amount — apply tax based on category:

-- 'Electronics' → 18% tax
-- 'Furniture' → 12% tax
-- 'Bags' → 5% tax
-- Everything else → 0% tax

-- Also show a final_price column (price + tax_amount). Round both to 2 decimal places.


-- SELECT name, price,
--   ROUND(
--     CASE
--       WHEN category = 'Electronics' THEN price * 0.18
--       WHEN category = 'Furniture'   THEN price * 0.12
--       WHEN category = 'Bags'        THEN price * 0.05
--       ELSE 0
--     END
--   , 2) AS tax_amount,

--   ROUND(
--     price +
--     CASE
--       WHEN category = 'Electronics' THEN price * 0.18
--       WHEN category = 'Furniture'   THEN price * 0.12
--       WHEN category = 'Bags'        THEN price * 0.05
--       ELSE 0
--     END
--   , 2) AS final_price

-- FROM products;


-- finaly add this to my table 

-- ALTER TABLE products
-- ADD COLUMN tax_amount numeric(10,2);

-- ALTER TABLE products
-- ADD COLUMN final_price numeric(10,2);


-- UPDATE products
-- SET 
--   tax_amount = ROUND(
--     CASE
--       WHEN category = 'Electronics' THEN price * 0.18
--       WHEN category = 'Furniture'   THEN price * 0.12
--       WHEN category = 'Bags'        THEN price * 0.05
--       ELSE 0
--     END
--   , 2),

--   final_price = ROUND(
--     price +
--     CASE
--       WHEN category = 'Electronics' THEN price * 0.18
--       WHEN category = 'Furniture'   THEN price * 0.12
--       WHEN category = 'Bags'        THEN price * 0.05
--       ELSE 0
--     END
--   , 2);



-- select * from products;








