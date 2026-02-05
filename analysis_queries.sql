USE sales_analysis;

-- Check number of records
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_orders FROM orders;

-- Preview data
select * from customers limit 10;
select * from orders limit 10;

-- Total Sales, Profit and Quantity
select 
	round(sum(sales),2) as total_sales,
	round(sum(profit),2) as total_profit,
    sum(quantity) as total_quantity
from orders;

-- Monthly Sales Trend
select 
	year(order_date) as year,
    month(order_date) as month,
    round(sum(sales),2) as monthly_sales
from orders
group by year,month
order by year,month;

-- Average Delivery Time
select 
	round(avg(datediff(ship_date,order_date)),2) as avg_delivery_days
    from orders;
    
-- Regional Performance Analysis
select 
	region,
	round(sum(sales),2) as total_sales,
	round(sum(profit),2) as total_profit
from orders
group by region
order by total_sales desc;

-- Category-wise Performance
select 
	category,
	round(sum(sales),2) as total_sales,
	round(sum(profit),2) as total_profit
from orders
group by category
order by total_sales desc;

-- Sub-Category Performance
select 
	sub_category,
	round(sum(sales),2) as total_sales,
	round(sum(profit),2) as total_profit
from orders
group by sub_category
order by total_sales desc;

-- Customer-level Analysis
select 
	c.customer_id,
	c.customer_name,
    c.segment,
    c.loyalty_status,
    round(sum(o.sales),2) as total_sales,
	round(sum(o.profit),2) as total_profit
from customers c 
join orders o
	on c.customer_id=o.customer_id
group by 
    c.customer_id,
	c.customer_name,
    c.segment,
    c.loyalty_status
order by total_sales desc;

-- top customers
select
	c.customer_name,
    round(sum(o.sales),2) as total_sales
from customers c
join orders o
	 on c.customer_id=o.customer_id
group by c.customer_name
order by total_sales desc
limit 10;

-- repeat customer analysis
select 
	customer_id,
    count(order_id) as order_count,
    round(sum(sales),2) as total_sales
from orders
group by customer_id
having count(order_id)>1
order by total_sales desc;

-- discount vs profit analysis
select
	discount,
    round(sum(sales),2) as total_sales,
    round(sum(profit),2) as total_profit
from orders
group by discount
order by discount;
    
-- Best & Worst Month by Sales
WITH monthly_sales AS (
    SELECT
        YEAR(order_date)  AS year,
        MONTH(order_date) AS month,
        SUM(sales) AS monthly_sales
    FROM orders
    GROUP BY YEAR(order_date), MONTH(order_date)
)
-- best month
SELECT *
FROM monthly_sales
ORDER BY monthly_sales desc
limit 1;

-- worst month
SELECT *
FROM monthly_sales
ORDER BY monthly_sales asc
limit 1;

-- payment mode performance
select 
	payment_mode,
    count(order_id) as total_orders,
    round(sum(sales),2) as total_sales
from orders
group by payment_mode 
order by total_sales desc;

-- loss-making orders
select
	order_id,
    category,
    sub_category,
    discount,
    profit
from orders
where profit<0
order by profit;

-- Monthly Profit Trend
SELECT
    YEAR(order_date)  AS year,
    MONTH(order_date) AS month,
    ROUND(SUM(profit),2) AS monthly_profit
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- High-value customers
with customer_sales as(
	select 
		customer_id,
		sum(sales) as total_sales
		from orders
    group by customer_id
    )
select * from customer_sales
where total_sales>10000
order by total_sales desc;

-- customer sales ranking
select
	customer_id,
    round(sum(sales),2) as total_sales,
    RANK() over (order by sum(sales) desc) as sales_rank
from orders
group by customer_id;

-- loyalty analysis
select 
	c.loyalty_status,
    round(sum(o.sales),2) as total_sales,
	round(sum(o.profit),2) as total_profit
from customers c 
join orders o
	on c.customer_id=o.customer_id
group by c.loyalty_status
order by total_sales desc;

-- Monthly Sales by Region
SELECT
    YEAR(order_date)  AS year,
    MONTH(order_date) AS month,
    region,
    ROUND(SUM(sales),2) AS monthly_sales
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date), region
ORDER BY YEAR(order_date), MONTH(order_date), monthly_sales DESC;

-- Running Sales Trend
with monthly_sales as(
	select
		year(order_date) as year,
        month(order_date) as month,
        sum(sales) as monthly_sales
        from orders
        group by year(order_date),month(order_date)
	)
select
	*,
    sum(monthly_sales) over (order by year,month) as cumulative_sales
from monthly_sales
order by year,month;
    
