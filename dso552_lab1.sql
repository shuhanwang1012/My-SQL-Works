-----------Lab 1--------------

---Question 1
---done

---Question 2
select *
from accounts
limit 5;

---Question 3
select id,name
from sales_reps;

---Question 4
select id, account_id, occurred_at
from orders;

---Question 5
select *
from orders
order by occurred_at desc
limit 10;

---Question 6*
select id,occurred_at, total_amt_usd
from orders
order by occurred_at
limit 10;

---Question 7
select id, total_amt_usd
from orders
order by total_amt_usd desc
limit 5;

---Question 8
select *
from orders
order by account_id, total_amt_usd desc;

---Question 9
select id, total, total_amt_usd
from orders
order by total desc, total_amt_usd desc
limit 5;

---Question 10
select *
from orders
where account_id = 4251;

---Question 11
select *
from orders
where total_amt_usd <= 500
limit 5;

---Question 12
select name, website, primary_poc
from accounts
where name = 'Exxon Mobil';

---Question 13
select account_id, occurred_at, gloss_qty + poster_qty as non_standard_qty
from orders;

---Question 14 **
select id, account_id, round((100*standard_qty/(total+0.00001)),2) as pctg_standard
from orders;

select id, account_id, round(100.00*standard_qty/(total),2) as pctg_standard
from orders
where total<>0 ---why 100.00?
limit 5;

---Question 15
select name, website
from accounts
where name like '%Whole%';

---Questiom 16
select name
from accounts
where name like '%one%';

---Question 17
select name
from accounts
where name like '%C%';

---Question 18
select name, id
from accounts
where name in ('Apple', 'Walmart');

select name, id
from accounts
where name like 'Apple' or name like 'Walmart';

---Question 19
select *
from web_events
where channel in ('organic', 'Edword');

---Question 20
select name, primary_poc, sales_rep_id
from accounts
where name not in ('Walmart', 'Target', 'Nordstrom');

---Question 21
select name, id,primary_poc
from accounts
where primary_poc not in ('twitter', 'adwords');

---Question 22
select *
from accounts
where name not like 'C%'
limit 5;

---Question 23
select *
from orders
where occurred_at between '04-01-2016' and '09-01-2016'
limit 5;

---Question 24
select *
FROM orders
WHERE standard_qty >1000 AND poster_qty = 0 AND gloss_qty = 0

---Question 25
select *
from web_events
WHERE channel in (’organic’, ’adwords’) and occurred_at between ’01-01-2016’ and ’01-01-2017’
order by occurred_at desc;

---Question 26
SELECT *
FROM orders
WHERE standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0 LIMIT 5;

---Question 27