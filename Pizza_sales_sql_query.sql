use [Pizza sales DB];

Select * from pizza_sales;

--Total Revenue generated:
select ROUND(SUM(total_price),2) as Total_revenue
from pizza_sales


-- Avg Order Value:
select ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) as avg_order_value
from pizza_sales


--Total Pizzas Sold:
select SUM(quantity) as total_pizzas_sold
from pizza_sales

--Total Orders Placed:
select COUNT(Distinct order_id) As Total_orders
from pizza_sales


-- Average pizzas sold per order:
select CAST(CAST(SUM(quantity) as DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id)as DECIMAL(10,2)) as DECIMAL(10,2)) as avg_pizza_per_order
from pizza_sales


--CHARTS:

--Daily Trend for Orders

SELECT  DATENAME(WEEKDAY,order_date)as order_day,COUNT(DISTINCT order_id) as Orders
FROM pizza_sales
Group by DATENAME(WEEKDAY,order_date)
order by DATENAME(WEEKDAY,order_date) desc


--Hourly Trend for total Orders:

SELECT DATEPART(HOUR,order_time) as hourly_trend,COunt(DIstinct order_id) as Orders
FROM pizza_sales
GROUP By DATEPART(HOUR,order_time)
ORDER BY DATEPART(HOUR,order_time)

-- Monthly Trend for total_orders:

select DATENAME(MONTH, order_date) as Month_Name, COUNT(DISTINCT order_id) as Total_Orders
from pizza_sales
group by DATENAME(MONTH, order_date)
order by Total_Orders desc

-- Weekly Trend for total_orders:

select DATENAME(ISO_WEEK, order_date) as Week_Number, COUNT(DISTINCT order_id) as Total_Orders
from pizza_sales
group by DATENAME(ISO_WEEK, order_date)
order by Total_Orders desc


-- Percentage of sales by pizza Category:
SELECT pizza_category, ROUND(SUM(total_price),2) as total_sales,
	ROUND(SUM(total_price)/(SELECT SUM(total_price) from pizza_sales)*100,2) as percent_sales
From pizza_sales
group by pizza_category

--Percentage of sales by pizza Size:

SELECT pizza_size, ROUND(SUM(total_price),2) as total_sales,
	ROUND(SUM(total_price)/(SELECT SUM(total_price) from pizza_sales)*100,2) as percent_sales
From pizza_sales
group by pizza_size
order by percent_sales desc

-- Total pizza sold by pizza category:

SELECT pizza_category, SUM(quantity) as Total_quantity
from pizza_sales
group by pizza_category


-- Top 5 best pizzas by revenue;

SELECT TOP 5 pizza_name, SUM(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc


-- Bottom 5 worst pizza by revenue:

SELECT TOP 5 pizza_name, SUM(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue


-- Top 5 best pizzas by quantity sold;

SELECT TOP 5 pizza_name, SUM(quantity) as total_quantity_sold
from pizza_sales
group by pizza_name
order by total_quantity_sold desc


-- Bottom 5 worst pizza by quantity sold:

SELECT TOP 5 pizza_name, SUM(quantity) as total_quantity_sold
from pizza_sales
group by pizza_name
order by total_quantity_sold



-- Top 5 best pizzas by total orders;

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders desc


-- Bottom 5 worst pizza by total orders:

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders