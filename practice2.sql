use practice2;

-- Create Sales table

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10, 2)
);

-- Insert sample data into Sales table
INSERT INTO Sales (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);
INSERT INTO Sales (sale_id, product_id, quantity_sold, sale_date, total_price) 
VALUES (7, 106, 5, '2024-01-06', 3500.00);
-- Create Products table

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);

-- Insert sample data into Products table
INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphones', 'Electronics', 30.00),
(104, 'Keyboard', 'Electronics', 20.00),
(105, 'Mouse', 'Electronics', 15.00);

-- SQL Begginer
-- 1. Retrieve all columns from the Sales table.
select * from sales;

-- 2. Retrieve the product_name and unit_price from the Products table.
select product_name,unit_price
from products;

-- 3. Retrieve the sale_id and sale_date from the Sales table.
select sale_id,sale_date
from sales;

-- 4. Filter the Sales table to show only sales with a total_price greater than $100.
select *
from sales
where total_price>=100;

-- 5. Filter the Products table to show only products in the ‘Electronics’ category.
select * 
from products
where category='Electronics';

-- 6. Retrieve the sale_id and total_price from the Sales table for sales made on January 3, 2024.
select sale_id,total_price
from sales
where sale_date='2024-01-03';

-- 7. Retrieve the product_id and product_name from the Products table for products with a unit_price greater than $100.
select product_id,product_name
from products
where unit_price>100;

-- 8. Calculate the total revenue generated from all sales in the Sales table.
select sum(total_price)
from sales;

-- 9. Calculate the average unit_price of products in the Products table.
select avg(unit_price)
from products;

-- 10. Calculate the total quantity_sold from the Sales table.
select sum(quantity_sold)
from sales;

-- 11. Retrieve the sale_id, product_id, and total_price from the Sales table for sales with a quantity_sold greater than 4.
select sale_id,product_id,total_price
from sales
where quantity_sold>4;

-- 12. Retrieve the product_name and unit_price from the Products table, ordering the results by unit_price in descending order.
select product_name,unit_price
from products
order by unit_price desc;

-- 13. Retrieve the total_price of all sales, rounding the values to two decimal places.
select round(sum(total_price),2) as total_revenue
from sales;

-- 14. Calculate the average total_price of sales in the Sales table.
select avg(total_price)
from sales;

-- 15. Retrieve the sale_id and sale_date from the Sales table, formatting the sale_date as ‘YYYY-MM-DD’.
select sale_id,date_format(sale_date,'%Y-%M-%D') 
from Sales;

-- 16. Calculate the total revenue generated from sales of products in the ‘Electronics’ category.
select sum(sales.total_price)
from products 
join sales
on sales.product_id=products.product_id
where products.category='Electronics';

-- 17. Retrieve the product_name and unit_price from the Products table, filtering the unit_price to show only 
-- values between $20 and $600.
select product_name,unit_price
from products
where unit_price between 20 and 600;

-- 18. Retrieve the product_name and category from the Products table, ordering the results by category in ascending order.
select product_name,category
from products
order by category;

-- 19. Calculate the total quantity_sold of products in the ‘Electronics’ category.
select sum(sales.quantity_sold) as total_quantity_sold
from sales
join products on products.product_id=sales.product_id
where products.category='Electronics';

-- 20. Retrieve the product_name and total_price from the Sales table, calculating the total_price as quantity_sold 
-- multiplied by unit_price.
select products.product_name, (sales.quantity_sold*products.unit_price) as total_price
from sales
 join products on sales.product_id=products.product_id;
 
--  MYSQL intermediate Level
--  1. Calculate the total revenue generated from sales for each product category.
select p.category,sum(s.quantity_sold*p.unit_price) as total_revenue
from sales s 
join products p on s.product_id=p.product_id;

-- 2. Find the product category with the highest average unit price.
select category
from products
group by category
order by avg(unit_price)  desc
limit 1;

-- 3. Identify products with total sales exceeding 30.
select  p.product_name
from  sales s
join products p on s.product_id=p.product_id
group by product_name
having sum(s.total_price)>30;

-- 4. Count the number of sales made in each month.
select date_format(sale_date,'%Y-%M') as month,count(sale_id) as number_of_sales
from sales
group by month(sale_date);

-- 5. Determine the average quantity sold for products with a unit price greater than $100.
select avg(s.quantity_sold)
from sales s
join products p on s.product_id=p.product_id
where unit_price>100;

-- 6. Retrieve the product name and total sales revenue for each product.
select p.product_name,sum(s.total_price) as total_revenue
from products p
join sales s on p.product_id=s.product_id
group by product_name;

-- 7. List all sales along with the corresponding product names.
select p.product_name,s.sale_id as all_sales
from products p
join sales s on p.product_id=s.product_id;

-- 8. Retrieve the product name and total sales revenue for each product.
select p.product_name, s.quantity_sold*p.unit_price as total_sales
from sales s
join products p on s.product_id=p.product_id
group by p.product_name;

-- 9. Rank products based on total sales revenue.
select  p.product_name, 
		s.quantity_sold*p.unit_price as total_sales,
        rank() over (order by s.quantity_sold*p.unit_price desc) as rnk
from sales s
join products p on s.product_id=p.product_id
group by p.product_name;

-- 10. Calculate the running total revenue for each product category.
select  p.category,
		p.product_name,
        s.sale_date,
        sum(s.total_price) over (partition by p.category order by s.sale_date ) as total_running_total 
from sales s
join products p on p.product_id=s.product_id;

-- 11. Categorize sales as “High”, “Medium”, or “Low” based on total price (e.g., > $200 is High, $100-$200 is Medium, < $100 is Low).
select sale_id,
    case 
		when total_price >200 then 'High'
        when total_price between 100 and 200 then 'Medium'
        else 'Low'
	End as Price_category
from sales;
-- 12. Identify sales where the quantity sold is greater than the average quantity sold.
select *
from sales
where quantity_sold>( select avg(quantity_sold)
					  from sales  );

-- 13. Extract the month and year from the sale date and count the number of sales for each month.
select date_format(sale_date,'%Y-%m') as month,
		count(sale_id) as sale_count
 from sales;
 
 select sale_id,sale_date,current_date()
 from sales;

-- 14. Calculate the number of days between the current date and the sale date for each sale.
SELECT sale_id, 
       DATEDIFF(CURDATE(), sale_date) AS days_since_sale
FROM Sales;

-- 15. Identify sales made during weekdays versus weekends.
select sale_id,sale_date,
case 
	when dayofweek(sale_date) in (1,7)  then 'weekend'
    else 'weekdays'
End as Week_category
from sales;
