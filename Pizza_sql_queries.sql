SELECT * FROM pizza_sales

-- avg order value
select sum(total_price) / count(DISTINCT order_id) as Avg_Order_value from pizza_sales

-- total pizza sold
select sum(quantity) as Total_pizza_sold from pizza_sales

-- total orders
select count(distinct order_id) as Total_orders from pizza_sales

-- avg pizzas per order
select cast(CAST(sum(quantity) AS decimal(10,2)) / 
CAST(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_pizzas_per_order from pizza_sales

-- Daily trend
select DATENAME(DW, order_date) as Order_day, count(DISTINCT order_id) as Total_order
from pizza_sales
group by DATENAME(DW, order_date)

-- Hourly trend
select DATEPART(HOUR, order_time) as order_hours, count(distinct order_id) as Total_order
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

-- percentage of sales by pizza category
select pizza_category as Pizza_category, 
sum(total_price) *100 / (select sum(total_price) from pizza_sales) as percentage_sales_cate,
sum(total_price) as total_sales
from pizza_sales
group by pizza_category

-- percentage of sales by pizza size
select pizza_size as Pizza_size, 
cast(sum(total_price) *100 / (select sum(total_price) from pizza_sales where datepart(quarter, order_date) =1) as decimal(10,2) ) as percentage_sales_cate,
cast(sum(total_price) as decimal(10,2)) as total_sales
from pizza_sales
where datepart(quarter, order_date) =1 
group by pizza_size
order by percentage_sales_cate

-- total pizzas sold by cate
select pizza_category, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_category

-- top 5 best seller
select top 5 pizza_name, sum(quantity) as Total_sold
from pizza_sales
group by pizza_name
order by sum(quantity) desc

-- top 5 worst seller
select top 5 pizza_name, sum(quantity) as Total_sold
from pizza_sales
group by pizza_name
order by sum(quantity) asc