-- Retail sales Analysis
create database sql_project_p2;


-- create table
create table retail_sales 
      (
            transactions_id	 Int primary key,
            sale_date 	date,
            sale_time    time,	
            customer_id	 int,
            gender     varchar(15),
            age	int,
            category	varchar(15),
            quantiy	int,
            price_per_unit	float,
             cogs	float,
            total_sale float
       );
select * from retail_sales
limit 10;
-- Data Cleaning
select * from retail_sales
where transactions_id is null
          or  sale_date is null
           or sale_time is null	
           or customer_id	 is null
           or gender is null
           or age	is null
            or category is null
            or quantiy	is null
           or  price_per_unit	is null
            or cogs is null
            or total_sale is null;

delete from  retail_sales
where 
            transactions_id	 is null
           or sale_date is null
            or sale_time is null	
            or customer_id	 is null
           or  gender  is null
           or  age	is null
           or  category is null
            or quantiy	is null
            or price_per_unit	is null
            or cogs is null
           or total_sale is null;


select count(*)
from retail_sales;

-- Exploratory data analysis

select count(*) as total_sales from retail_sales;

select count(distinct customer_id) from retail_sales;

select distinct category from retail_sales;

-- Data Analysts
-- 1
select * from retail_sales
where sale_date = '2022-11-05';

-- 2
select * from retail_sales
where 
category = 'Clothing'
and
to_char(sale_date,'YYYY-MM')='2022-11'
and quantiy >= 4 ;

-- 3
select category,sum(total_sale) as total_sales from retail_sales
group by category;

-- 4
select round(avg(age),2) from retail_sales
where category = 'Beauty' ;

-- 5
select * from retail_sales
where total_sale > 1000;

-- 6
select count(*) as trans , gender,category from retail_sales
group by category,gender;

-- 7
select 
year,
month,
avg_sale
from(
select
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale,
rank() over(partition by extract(month from sale_date)  order by avg(total_sale) desc) as ran
from retail_sales
group by year,month) as t1
where ran=1;

-- 8
select  sum(total_sale)as top,customer_id 
from retail_sales
group by customer_id
order by top
limit 5;

--9
select count(distinct customer_id), category
from retail_sales
group by category;

-- 10
select count(*) as total_orders,
case
when extract(Hour from sale_time) < 12 then 'Morning'
when extract(Hour from sale_time) between 12 and 17 then 'Afternoon'
else 'evening'
end as Shift
from retail_sales
group by shift;








	   
