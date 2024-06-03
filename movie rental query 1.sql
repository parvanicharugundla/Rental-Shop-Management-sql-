select count(*)
from payment
where customer_id=100

select
first_name,
last_name 
from customer
where first_name = 'ERICA'

select * from payment
where amount >10
order by amount desc

select count(*)
from rental
where return_date is null

select payment_id,amount
from payment
where amount <= 2

select *
from payment
where (customer_id=322 or
customer_id=346 or
customer_id=354)
and 
(amount <2 or amount>10)
order by customer_id asc , amount desc

select * from rental
where rental_date between '2005-05-24' and '2005-05-26'
order by rental_date desc

select count(*)
from payment
where amount between 1.99 and 3.99
and payment_date between '2020-01-26' and '2020-01-28'

select * from customer 
where customer_id in (123,212,323,243,353,432)

select * from payment
where customer_id in(12,25,67,93,124,234)
and amount in(4.99,7.99,9.99) and payment_date between'2020-01-01' and '2020-02-01' 

select * from film
where description like '%Drama%'
and title like '_T%'

select count(*)
from film
where description like '%Documentary%'

select count(*)
from customer
where first_name like '___'
and (last_name like '%X'
or last_name like '%Y')

select title,
description as description_of_movie,
release_year
from film
where description like '%Documentary%'

select count(*) as num_of_movie
from film
--where description like '%Documentry%'

select count(*) as no_of_movies
from film
where description like '%Saga%'
and (title like 'A%' 
or title like '%R')

select * from customer
where first_name like '%ER%'
and first_name like '_A%'
order by last_name desc

select count (*)
from payment
where(amount =0 or amount between 3.99 and 7.99)
and payment_date between '2020-05-01' and '2020-05-02'

--aggregate
select 
sum(amount),
round(avg(amount),2) as average
from payment

select 
min(replacement_cost),
max(replacement_cost),
round(avg(replacement_cost),2),
sum(replacement_cost)
from film

--grouping , groupby
select 
customer_id,
sum(amount),
max(amount)
from payment
group by customer_id

select
staff_id,
sum(amount),
count(*)
from payment
where amount!=0
group by staff_id
order by sum(amount) desc

select
staff_id,
customer_id,
sum(amount),
count(*)
from payment
group by staff_id,customer_id
order by count(*) desc

select *,
date(payment_date)
from payment

select
staff_id,
date(payment_date),
sum(amount),
count(*)
from payment
where amount!=0
group by staff_id,date(payment_date)
order by count(*) desc

select
count(*)
from payment
where amount !=0
group by staff_id,date(payment_date)
having count(*)= 28 or count(*)=29
order by count(*) desc

select 
customer_id,
date(payment_date),
round(avg(amount),2) as avg_amount,
count(*)
from payment
where date(payment_date) in ('2020-04-28','2020-04-29','2020-04-30')
group by customer_id,date(payment_date)
having count(*)>1
order by avg(amount) desc

select
lower(email) as email_lower,
email,
length(email)
from customer
where length(email) < 30


select 
lower(first_name),
lower(last_name),
lower(email)
from customer
where length(first_name) >10
or length(last_name) > 10

select
left(first_name,2),
right(first_name,2)
from customer
--nesting functions
select
right(left(first_name,2),1),
first_name
from customer

select
left(right(email,4),1)
from customer

select
right(email,4)
from customer

select
left(first_name,1) || '.' || left(last_name,1)
from customer

select
left(email,1) || '***' || right(email,19)
from customer

--@sakilacustomer.org

select
left(email,1) || '***' || '@sakilacustomer.org'
from customer
--position
select
left(email,position('@' in email)-1),
email
from customer

select
left(email,position('.'in email)-1) ||','|| last_name
from customer
--substring
select
email,
substring(email from position('.'in email)+1 for 3)
from customer

select
email,
substring(email from position('.'in email)+1 for length(last_name))
from customer

select
email,
substring(email from position('.'in email)+1 for position('@' in email)-position('.' in email)-1 )
from customer

select
left(email,1) || '***' || substring(email from position('.' in email)for 2)
|| '***'
|| substring(email from position('@' in email))
from customer

select
'***'||
substring(email from position('.' in email)-1 for 3)
||'***'
||substring(email from position('@' in email))
from customer
--extract
--extract(field from date/time/interval)
select
extract(day from rental_date),
count(*)
from rental
group by extract(day from rental_date)
order by count(*) desc

select * from payment

select
extract(month from payment_date),
sum(amount) as total
from payment
group by extract(month from payment_date)
order by total desc
--tochar
select *,
extract(month from payment_date),
to_char(payment_date,'YYYY/MM')
from payment

select
sum(amount),
to_char(payment_date,'Day,Month YYYY')
from payment
group by to_char(payment_date,'Day,Month YYYY')

select * from payment

select 
sum(amount) as total,
to_char(payment_date,'dy,DD-MM-YYYY') as day
from payment
group by day
order by total desc

select 
sum(amount) as total,
to_char(payment_date,'mon,YYYY') as monandyear
from payment
group by monandyear
order by total desc

select 
sum(amount) as total,
to_char(payment_date,'dy,HH:MI') as day
from payment
group by day
order by total desc

select current_date
select current_timestamp

select
current_date,
rental_date
from rental

select 
current_timestamp,
current_timestamp-rental_date
from rental

select
current_timestamp,
extract(day from return_date-rental_date)
from rental

select
current_timestamp,
extract(day from return_date-rental_date)*24
+extract(hour from return_date-rental_date) || 'hours'
from rental

select customer_id,
return_date-rental_date
from rental
where customer_id=35

select customer_id,
avg(return_date-rental_date) as rental_duration
from rental
group by customer_id
order by rental_duration desc

select
film_id,
rental_rate as old_rental_rate,
ceiling(rental_rate*1.4)-0.01 as new_rental_rate
from film

select
film_id,
round(rental_rate/replacement_cost *100,2) as percentage
from film
where round(rental_rate/replacement_cost *100,2) < 4
order by 2 asc

select
title,
case
when rating in ('PG','PG-13') or length>210 then 'great rating'
when description like '%Drama%' and length >90 then 'long drama'
when description like '%Drama%' then 'short drama'
when rental_rate<1 then 'very cheap'
end as tier_list
from film
where
case
when rating in ('PG','PG-13') or length>210 then 'great rating'
when description like '%Drama%' and length >90 then 'long drama'
when description like '%Drama%' then 'short drama'
when rental_rate<1 then 'very cheap'
end is not null


select * from film

select
sum(case
when rating in ('PG','G') then 1
else 0
end)
from film

select
rating,
count(*)
from film
group by rating

select
sum(case when rating='PG' then 1 else 0 end) as "PG",
sum(case when rating='PG-13' then 1 else 0 end) as "PG-13",
sum(case when rating='NC-17' then 1 else 0 end) as "NC-17",
sum(case when rating='G' then 1 else 0 end) as "G",
sum(case when rating='R' then 1 else 0 end) as "R"
from film

select
rental_date,
coalesce(cast(rental_date-return_date as varchar),'not returned')
from rental
order by rental_date desc

select *
from payment
inner join customer
on payment.customer_id=customer.customer_id

select payment.*,
first_name,
last_name
from payment
inner join customer
on payment.customer_id=customer.customer_id

select payment_id,
payment.customer_id,amount,
staff_id,
first_name,
last_name
from payment
inner join customer
on payment.customer_id=customer.customer_id

select payment.*,first_name,last_name,email
from payment
inner join staff
on staff.staff_id=payment.staff_id
where staff.staff_id=1

--joins
select * from address

select first_name,last_name,
phone,district
from customer c
left join address a
on c.address_id=a.address_id
where a.district= 'Texas'

select first_name,last_name,email,co.country from customer cu
left join address ad
on cu.address_id=ad.address_id
left join city ci
on ci.city_id=ad.city_id
left join country co
on co.country_id=ci.country_id
where country='Brazil'

select first_name,last_name,title,count(*)
from customer cu
inner join rental r
on cu.customer_id=r.customer_id
inner join inventory i
on r.inventory_id=i.inventory_id
inner join film f
on i.film_id=f.film_id
group by first_name,last_name,title
order by 4 desc

select first_name,'actor' from actor
union all
select first_name,'customer' from customer
order by first_name

select first_name,'actor' from actor
union
select first_name,'customer' from customer
union
select first_name,'staff' from staff
order by 2 desc

select *
from payment
where amount > (select avg(amount) from payment)

select *
from payment
where customer_id=(select customer_id from customer where first_name='ADAM' )

select film_id,title from film
where length >( select avg(length) from film)

select * from film
where film_id
in (select film_id from inventory
where store_id=2
group by film_id
having count(*) >3)

select first_name,last_name from customer
where customer_id in
(select customer_id from payment where date(payment_date)='2020-01-25')

select first_name,email from customer
where customer_id in (select customer_id from payment
	  group by customer_id
	  having sum(amount)>30)
	  
select first_name,email from customer
where customer_id in (select customer_id from payment
	  group by customer_id
	  having sum(amount)>100)
and customer_id in (select customer_id
				   from customer
				   inner join address
				   on address.address_id=customer.address_id
				   where district='California')
				   
				   
select  min(replacement_cost) from film			   
				   
select * from film

select count(*),
case
when replacement_cost<=19.99 then 'low'
when replacement_cost<=24.99 then 'medium'
else 'high'
end as groupr
from film
group by groupr

select c.name,count(*)
from film f
inner join film_category fc
on f.film_id=fc.film_id
inner join category c
on c.category_id=fc.category_id
group by c.name
order by count(*) desc

select first_name,last_name,count(*)
from film f
inner join film_actor fa
on f.film_id=fa.film_id
inner join actor a
on a.actor_id=fa.actor_id
group by first_name,last_name
order by count(*) desc

select *
from address a
left join customer c
on c.address_id=a.address_id
where customer_id is null

select city,sum(amount)
from customer c
left join payment p
on p.customer_id=c.customer_id
left join address a
on a.address_id=c.address_id
left join city ci
on ci.city_id=a.city_id
group by city
order by sum(amount) desc

select country,city, sum(amount)
from customer c
left join payment p
on p.customer_id=c.customer_id
left join address a
on a.address_id=c.address_id
left join city ci
on ci.city_id=a.city_id
left join country co
on ci.country_id=co.country_id
group by country,city
order by sum(amount) 

select avg(total),staff_id
from 
(select staff_id,customer_id,
sum(amount) as total
from payment
group by staff_id,customer_id
order by 2) sub
group by staff_id

--DDL { create,alter ,drop, truncate}
--DML {INSERT,UPDATE,DELETE}

update customer
set last_name='BROWN'
where customer_id=1

select * from customer
order by customer_id

update customer
set email=lower(email)

update film
set rental_rate=1.99
where rental_rate=0.99
select * from film

alter table customer
add column initials varchar(4)

update customer
set initials = left(first_name,1)||'.'||left(last_name,1)

select * from customer

