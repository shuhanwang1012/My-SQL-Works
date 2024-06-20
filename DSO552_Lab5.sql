---Lab 5---

---1
---1st query: group account id in orders table,
---find totals of amt_usd
select account_id, sum(total_amt_usd)
from orders 
group by account_id
order by 2 desc
limit 10;

select round(avg(sum),2)
from(
	select account_id, sum(total_amt_usd)
	from orders 
	group by account_id
	order by 2 desc
	limit 10) as t1;
---we cannot nest aggregate functions
---2
---average total amt usd by account
select avg(total_amt_usd)
from orders 
group by account_id
---having avg(total_amt_usd) > ...
---average of all orders
select avg (total_amt_usd)
from orders;

---average of all accounts where average > than average of all orders
select avg(total_amt_usd)
from orders 
group by account_id
having avg(total_amt_usd) > (select avg(total_amt_usd
									   from orders);)
									   
select avg(averages)
from(select avg(total_amt_usd) averages
	 from orders
	 group by account_id
	 having avg(total_amt_usd) > (select avg(total_amt_usd)
								 from orders)) as t1

---3
---top customer
select a.name,sum(total_amt_usd)
from accounts a
join orders o
group by 2
order by 2 desc
limit 1
---we only needs name of a top customer
select name
from(
	select a.name,sum(total_amt_usd)
	from accounts a
	join orders o
	group by 2
	order by 2 desc
	limit 1 t1)
---number of events by customer and channel
select a.name,w.channel,count(*)
from accounts a 
join web_events w
on a.id = w.account_id
group by 1,2
---show nuber of events by channel for only top customer
select a.name,w.channel,count(*)
from accounts a 
join web_events w
on a.id = w.account_id
group by 1,2
having a.name = (select a.name
				from accounts a
				join orders o
				on a.id = o.account_id
				group by 1
				order by sum(total_amt_usd) desc
				limit 1)
				
---4
---region that has the largest total sales
select r.name, sum(total_amt_usd)
from orders o
join accounts a
on o.account_id = a.id
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id
group by r.name
order by 2 desc
limit 1;
---number of orders by region
select r.name, count(total_amt_usd)
from orders o
join accounts a
on o.account_id = a.id
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id
group by r.name
---number of orders 

---5
---for the account that purchased the most standard_qty
select count(*)
from   (select account_id, sum(total)
		from orders
		group by account_id
		having sum(total) > (select sum(total)
					 		from orders
					 		group by account_id
					 		order by sum(standard_qty) desc
					 		limit 2 )) as something;

---6
select s.name, r.name, sum(o.total_amt_usd)
from orders 
join accounts a
on a.account_id = a.id
join sales_rep s
on a.sales_rep_id =s.id
join region r
on s.region_id = r.id
group by 1