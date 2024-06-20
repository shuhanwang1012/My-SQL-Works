--1
select orders.id,accounts.name, orders.total
from accounts
join orders
on accounts.id=orders.account_id
where accounts.name = 'Walmart';

select o.id,a.name, o.total
from accounts as a
join orders as o
on a.id=o.account_id
where a.name = 'Walmart';

select o.id,a.name, total
from accounts a
join orders o
on a.id=o.account_id and name = 'Walmart';

--2
select *
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id;

--The comma operator is equivalent to an [INNER] JOIN operator
--The comma is the older style join operator

--3
select r.name,a.name, round(o.total_amt_usd / (o.total+0.01),2) unit_price
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id;
join orders o
on a.id = o.account_id
order by unit_prices;

select r.name,a.name, round(o.total_amt_usd / o.total),2) unit_price
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id;
join orders o
on a.id = o.account_id
where total >0
order by unit_prices;

--4
select r.name region,s.name rep, a.name
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id and r.name = 'Midwest'
limit 10;

--5
select o.occurred_at, a.name, o.total, o.total_amt_usd
from accounts a
join oders o
on a.id = o.account_id
--where 0.occurred_at between '01-01-2015' and '12-31-2015'
where o.occurred_at between '01-01-2015' and '01-01-2016'
order by o.occurred_at desc

select o.occurred_at, a.name, o.total, o.total_amt_usd
from accounts a
join oders o
on a.id = o.account_id
where o.occurred_at >= '01-01-2015' and o.occurred_at >= '12-31-2016'
order by o.occurred_at desc

--7
select count(*)
from accounts;

select count(name)
from accounts;

--8
select sum(standard_qty)
from orders;

--14
select round(avg(standard_qty),2)
from orders o
join accounts a
on o.account_id = a.id
where a.name = 'Ford Notor';

--18
select w.channel, count (*)
from web_events w
group by channel

--20
select a.name, min(total_amt_usd) smallest_order
from accounts a
join orders o
on a.id = o.account_id
group by a.name
order by smallest_order

--22
select a.name, round(avg(standard_qty),2) avg_standard,
		       round(avg(o.gloss_qty),2) avg_gloss,
			   round(avg(o.poster_qty),2) avg_poster
from accounts a
join orders o
on a.id = o.account_id
group by a.name

--23
select s.name, w.channel, count(*)
from web_events w
join accounts a
on w.account_id = a.id
join sales_reps s
on s.id = a.sales_rep_id
group by s.name, w.channel
order by count(*) desc

select s.name, w.channel, count(*) num_events
from web_events w
join accounts a
on w.account_id = a.id
join sales_reps s
on s.id = a.sales_rep_id
group by s.name, w.channel
group by 1,2
order by 3 desc

--24
select r.id,  r.name, w.channel, COUNT(x) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
Join sales_reps

--25
select count(*)
from accounts a
join sales_reps s
on s.id = a.sales_reps_id
join regionn r
on r.id = s.region_id

--26
select *
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r

--27
select s.name, count(*)
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
group by s.name
having count(*)>5
