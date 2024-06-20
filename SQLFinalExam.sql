---1
select gender, stylename, count(*)
from(select e.entertainerid, gender, ms.stylename
from musical_styles ms
join entertainer_styles es
on ms.styleid = es.styleid
join entertainers e
on es.entertainerid = e.entertainerid
join entertainer_members em
on e.entertainerid = em.entertainerid
join members m
on em.memberid = m.memberid)t1
group by 1,2
having count(*) > 6

---2
select count(*)
from agents a
left join engagements e
on a.agentid = e.agentid
left join customers c
on e.customerid = c.customerid
left join musical_preferences mp
on c.customerid = mp.customerid
left join musical_styles ms
on mp.styleid = ms.styleid
left join entertainer_styles es
on ms.styleid = es.styleid
left join entertainers et
on es.entertainerid = et.entertainerid
where e.engagementnumber is null

---3
select avg(contractprice)
from (select contractprice
		from engagements
		where contractprice > (select avg(contractprice)
								from engagements)) t1
								
---4
select quartile, avg(contractprice)
from (select *,
	ntile(4) over (order by contractprice) quartile
	from engagements) t1
group by quartile
having avg(contractprice) > 1000
order by quartile
---5
select round(avg(contractprice),2) first_four_average_contract_price
from (select entertainerid, startdate, contractprice
		from(select e.entertainerid, eg.startdate, eg.contractprice, 
				row_number (*) over(partition by e.entertainerid order by eg.startdate, eg.starttime) as engagement_booked
			from entertainers e
			join entertainer_styles es
			on e.entertainerid = es.entertainerid
			join musical_styles ms
			on es.styleid = ms.styleid
			join musical_preferences mp
			on ms.styleid = mp.styleid
			join customers c
			on mp.customerid = c.customerid
			join engagements eg
			on c.customerid = eg.customerid)t1
		where engagement_booked = 1 or engagement_booked = 2 or engagement_booked = 3 or engagement_booked = 4)t2

---6
select first_four_average_contract_price,
	case when first_four_average_contract_price = 1134.33 then 'First Four Engagements' end as engagement_category
from (select round(avg(contractprice),2) first_four_average_contract_price
		from (select entertainerid, startdate, contractprice
				from(select e.entertainerid, eg.startdate, eg.contractprice, 
						row_number (*) over(partition by e.entertainerid order by eg.startdate, eg.starttime) as engagement_booked
					from entertainers e
					join entertainer_styles es
					on e.entertainerid = es.entertainerid
					join musical_styles ms
					on es.styleid = ms.styleid
					join musical_preferences mp
					on ms.styleid = mp.styleid
					join customers c
					on mp.customerid = c.customerid
					join engagements eg
					on c.customerid = eg.customerid)t1
				where engagement_booked = 1 or engagement_booked = 2 or engagement_booked = 3 or engagement_booked = 4)t2)t3
---7
select t2.*, (contractprice * 1.2) as adjusted_contractprice
from(select t1.*, row_number() over(partition by entertainerid order by startdate)
	from(select eg.engagementnumber, eg.startdate,eg.enddate,eg.starttime,eg.stoptime,eg.contractprice,eg.customerid,eg.agentid,eg.entertainerid, e.entstagename
			from entertainers e
				join entertainer_styles es
				on e.entertainerid = es.entertainerid
				join musical_styles ms
				on es.styleid = ms.styleid
				join musical_preferences mp
				on ms.styleid = mp.styleid
				join customers c
				on mp.customerid = c.customerid
				join engagements eg
				on c.customerid = eg.customerid)t1)t2
where row_number = 9
order by engagementnumber