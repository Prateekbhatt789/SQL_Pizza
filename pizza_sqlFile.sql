create database pizzahut;

select * from pizzahut.pizzas;
select * from pizzahut.pizza_types;
select * from pizzahut.order_details;
select * from pizzahut.orders;
-- Basic:
-- 1. Retrieve the total number of orders placed.
select count(order_id) as total_order 
from pizzahut.orders;

-- 2.Calculate the total revenue generated from pizza sales.
select sum(order_details.quantity * pizzas.price) as total_revenue
from pizzahut.pizzas join pizzahut.order_details 
on pizzas.pizza_id=order_details.pizza_id;

-- 3. Identify the highest-priced pizza.
select pizza_types.name, pizzas.price
from pizzahut.pizza_types join pizzahut.pizzas 
on pizzas.pizza_type_id=pizza_types.pizza_type_id
order by pizzas.price desc
limit 1;

-- 4. Identify the most common pizza size ordered.
select pizzas.size, count(order_details.order_details_id) as order_count
from pizzahut.pizzas join pizzahut.order_details
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size
order by order_count desc limit 1;
 
-- 5. List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name ,sum( order_details.quantity) as order_quantity
from pizzahut.pizzas join pizzahut.pizza_types
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join pizzahut.order_details on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by order_quantity desc limit 5;

-- Intermediate:
-- 6. Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category, sum(order_details.quantity) as Pizza_ordered
from pizzahut.pizza_types join pizzahut.pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join pizzahut.order_details on pizzas.pizza_id=order_details.pizza_id
group by pizza_types.category
order by pizza_ordered desc;

-- 7. Determine the distribution of orders by hour of the day.
select hour(time) as Hours, count(order_id) as orders from pizzahut.orders
group by hour(time);

-- 8. Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) as pizza_type
from pizzahut.pizza_types
group by category;

-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(quantity) from 
(select orders.date, sum(order_details.quantity) as quantity
from pizzahut.orders join pizzahut.order_details 
on orders.order_id=order_details.order_id
group by orders.date) as order_quantity;

-- 10. Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name , sum(order_details.quantity*pizzas.price) as revenue
from pizzahut.pizzas join pizzahut.pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join pizzahut.order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by revenue desc limit 3;

-- Advanced:
-- 1. Calculate the percentage contribution of each pizza type to total revenue.
select pizza_types.category , Round((sum(order_details.quantity*pizzas.price)/(select round(sum(order_details.quantity * pizzas.price),2) as total_revenue
from pizzahut.pizzas join pizzahut.order_details 
on pizzas.pizza_id=order_details.pizza_id))*100,2) as Percent_Revenue
from pizzahut.pizzas join pizzahut.pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join pizzahut.order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category
order by Percent_Revenue desc ;

-- 2. Analyze the cumulative revenue generated over time.
select date, sum(revenue) over(order by date) as cum_revenue
from
(select orders.date, sum(order_details.quantity*pizzas.price) as revenue
from pizzahut.pizzas join pizzahut.order_details 
on pizzas.pizza_id=order_details.pizza_id
join pizzahut.orders
on orders.order_id=order_details.order_id
group by orders.date) as sales;

-- 5. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name,revenue from
(select category,name,revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select pizza_types.category, pizza_types.name,
sum((order_details.quantity)*(pizzas.price)) as revenue
from pizzahut.pizza_types join pizzahut.pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join pizzahut.order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category,pizza_types.name) as a) as b
where rn<=3;


