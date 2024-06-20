-------------LAB 4------------------
---1
select *
from customers c
join orders o
on c.customerid - o.customerid
join employees e
on o.employeeid = e.employeeid

select concat (e.empfirstname,' ',e.emplast_name) employee_name
concat (c.custfirstname,' ',c.custlast_name)customer_name,
from customers c
join orders o
on c.customerid = o.customerid
join employees e
on o.employeeid=e.employeeid
---order by 1,2;
order by employee_name,customer_name;

---2
select count(*)
from orders o
join employees e
on o.employeeid==e.employeeid
--where concat ('e.empfirstname',' ','e.emplastname');
where e.empfirstname = 'kathryin' and e.emplastname = 'Patterson';
select count(*)
from orders o
join employees e
on o.employeeid=e.employeeid
where e.employeeid=707;

---3
select od.ordernumber, p.productname,
od.quotedprice*od.quantityordered amount_owed
from products p
join order_details od
on p.productnumber = od.productnumber
where od.quotedprice*pd.quantityordered >100;

select od.ordernumber, p.productname,
od.quotedprice*od.quantityordered amount_owed
from products p
join order_details od
on p.productnumber = od.productnumber
join orders 0
on o.ordernumber = od.ordernumber
where od.quotedprice*pd.quantityordered >100;

---4
select *
from customers c
left join employees e
on c.custripcode = e.empripcode

select c.custermerid, 
concat(c.custfirstname,' ',c.custlastname) customer_name,
c.custripcode
from customers c
left join employees e
on c.custripcode = e.empripcode
where e.employeeid is null;

---5
select p.productnumber, p.productname, od.ordernumber
from products p
join order_details od
on p.productnumber = od.productnumber
where p.quantityonhand > 10 and od.ordernumber is null;

---9
select date_trunc('month',occurred_at) ord_date,
		sum (o.gloss_amt_usd) tot_spent
from accounts a 
join orders o
on a.id = o.account_id
group by 1
order by 2 desc
limit 1;

---10
select a.name,sum(o.total_amt_usd),
case when sum(o.total_amt_usd)  > 200000 then 'top'
	 when sum(o.total_amt_usd)  > 100000 then 'middle'
	 else 'low' end as customer_level
from accounts a 
join orders o
on a.id = o.account_id
group by 1
order by 2 desc;

---additional requirements
--for top at least 10 orders
--for middle at least 5 orders
--for low at least 2 orders

select a.name,sum(o.total_amt_usd),
case when sum(o.total_amt_usd)  > 200000 and count(*) >= 20 then 'top'
	 when sum(o.total_amt_usd)  > 100000 and count(*) >= 5 then 'middle'
	 else 'low' end as customer_level
from accounts a 
join orders o
on a.id = o.account_id
group by 1
order by 2 desc;