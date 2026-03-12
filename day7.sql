--   VIEWS AND PROCEDURES   --


-- create view electronics_items as 
-- select product_id , name , price , stock_quantity
-- from products
-- where category = 'Electronics';

-- select * from electronics_items;

-- create view low_stock as 
-- select name , category , stock_quantity
-- from products
-- where stock_quantity < 30;

-- CREATE PROCEDURE add_product(
-- 	p_name varchar,
-- 	p_sku char(8),
-- 	p_price numeric,
-- 	p_qty int,
-- 	p_category text
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- 	INSERT INTO products (name,sku_code,price,stock_quantity,category)
-- 	VALUES (p_name,p_sku,p_price,p_qty,p_category);
-- END;
-- $$;

-- call add_product('Bottle','WB324736',674.04,45,'Bags');


-- select * from products;