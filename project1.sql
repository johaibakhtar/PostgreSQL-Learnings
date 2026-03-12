CREATE TABLE products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100),
	category TEXT,
	price NUMERIC(10,2),
	stock_quantity INT,
	is_available BOOLEAN,
	added_on DATE 
);

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	product_id INT,
	quantity INT,
	order_date DATE,
	customer_name VARCHAR(50),
	payment_method VARCHAR(50),
	CONSTRAINT fk_product
		FOREIGN KEY (product_id)
		REFERENCES products(product_id)
		ON DELETE CASCADE
	
);

select * from orders;
select * from products;

-- Q1> Show each order along with the product name and price 

select o.order_id , o.customer_name , p.product_name , p.price 
from orders o inner join products p 
on o.product_id = p.product_id;

-- Q2> show all products even if they were never orderd

select p.product_name , o.order_id
from products p left join orders o
on o.product_id = p.product_id;

-- Q3> show orders sorted by product price (high to low)

select o.order_id , p.product_name , p.price 
from orders o join products p 
on o.product_id = p.product_id
order by p.price desc;

-- Q4> show orders for only electronics category

select o.order_id , p.product_name , p.category
from orders o
join products p
on o.product_id = p.product_id
where p.category = 'Electronics';

-- Q5> show number of orders placed for each product

select count(o.order_id) , p.product_name as total_orders  
from orders o
left join products p 
on o.product_id = p.product_id
group by p.product_name;

-- Q6> show total revenue earned per product 

select p.product_name, sum(o.quantity * p.price) as total_revenue  
from orders o
left join products p 
on o.product_id = p.product_id
group by p.product_name
order by total_revenue desc;


-- Q7> show products where total order revenue > 2000

select p.product_name, sum(o.quantity * p.price) as total_revenue  
from orders o
left join products p 
on o.product_id = p.product_id
group by p.product_name
having sum(o.quantity * p.price) > 2000;


-- Q8> show unique customers who ordered fitness products

select distinct o.customer_name 
from orders o
join products p 
on o.product_id = p.product_id
where p.category = 'Fitness';






