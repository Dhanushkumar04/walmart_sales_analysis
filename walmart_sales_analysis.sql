drop table walmart;
select * from walmart;
select count(*) from walmart;

select DISTINCT payment_method from walmart

select payment_method, count(*) from walmart
group by payment_method

select count(distinct branch) from walmart

select max(quantity) from walmart

-- Find different payment method and number of transactions, number of qty sold

select payment_method, count(*) as no_of_transactions, sum(quantity) as no_of_qty from walmart
group by payment_method

--Identify the highest-rated category in each branch, displaying the branch, category AVG RATING

select * from (
	select branch,category, avg(rating) as avg_rating, 
	rank() over(partition by branch order by avg(rating) desc) as rank from walmart
	group by branch, category
)
where rank=1

--Identify the busiest day for each branch based on the number of transactions

-- select date,to_date(date,'DD/MM/YY') as formated_date
-- from walmart

-- select date, to_char(to_date(date,'DD/MM/YY'),'Day') as day_name
-- from walmart

select * from(
	select branch,to_char(to_date(date,'DD/MM/YY'),'Day') as day_name, count(*) as no_transactions,
	rank() over(partition by branch order by count(*) desc) as rank
	from walmart
	group by branch, day_name
)
where rank=1

--Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.

select distinct payment_method, sum(quantity) as total_qty
from walmart
group by payment_method

--Determine the average, minimum, and maximum rating of category for each city. 
-- List the city, average_rating, min_rating, and max_rating.

select city, category, min(rating) as min_rating, max(rating) as max_rating, avg(rating) as avg_rating
from walmart
group by 1, 2

--Calculate the total profit for each category by considering total_profit as
-- (unit_price * quantity * profit_margin). 
-- List category and total_profit, ordered from highest to lowest profit.

select category, sum(total) as total_revenue, sum(total * profit_margin) as profit
from walmart
group by category
order by 1,3 desc

-- Determine the most common payment method for each Branch. 
-- Display Branch and the preferred_payment_method.

select * from(
	select branch, payment_method, count(*) as total_trans, rank() over(partition by branch order by count(*) desc) as rank
	from walmart
	group by 1,2
)
where rank=1

-- Categorize sales into 3 group MORNING, AFTERNOON, EVENING 
-- Find out each of the shift and number of invoices

select 
branch,
case when extract(hour from (time::time)) <12 then 'Morning'
	when extract(hour from (time::time)) between 12 and 17 then 'Afternoon'
	else 'Evening'
	end day_time,
	count(*)
from walmart
group by 1,2
order by 1, 3 desc

--Identify 5 branch with highest decrese ratio in 
-- revevenue compare to last year(current year 2023 and last year 2022)

-- rdr == last_rev-cr_rev/ls_rev*100

SELECT *,
EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) as formated_date
FROM walmart

-- 2022 sales
WITH revenue_2022
AS
(
	SELECT 
		branch,
		SUM(total) as revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022 -- psql
	-- WHERE YEAR(TO_DATE(date, 'DD/MM/YY')) = 2022 -- mysql
	GROUP BY 1
),

revenue_2023
AS
(

	SELECT 
		branch,
		SUM(total) as revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
	GROUP BY 1
)

SELECT 
	ls.branch,
	ls.revenue as last_year_revenue,
	cs.revenue as cr_year_revenue,
	ROUND(
		(ls.revenue - cs.revenue)::numeric/
		ls.revenue::numeric * 100, 
		2) as rev_dec_ratio
FROM revenue_2022 as ls
JOIN
revenue_2023 as cs
ON ls.branch = cs.branch
WHERE 
	ls.revenue > cs.revenue
ORDER BY 4 DESC
LIMIT 5