select title, name
from film full join language
on language.language_id  = film.language_id 

select
    film_actor.actor_id,
    film_actor.film_id,
    film.film_id, 
    film.title,
    actor.actor_id,
    actor.first_name,
    actor.last_name 
from film_actor
inner join film on film_actor.film_id = film.film_id
inner join actor on film_actor.actor_id = actor.actor_id
where film.film_id = '508'


select count(actor_id)
from film 
inner join film_actor on film.film_id = film_actor.film_id 
where film.film_id = 384

select distinct district
from address
where district like 'K%' and district like '%a' and district not like '% %';

select *
from payment
where payment_date between '2007-03-17' and '2007-03-20' and amount > 1.00
order by payment_date;

select *
from payment
order by payment_date desc
limit 10;

select concat(last_name,' ', first_name) as фамилия_имя, 
length(email) as почта, 
last_update::date as обновление
from customer;

select upper(first_name), upper(last_name)
from customer
where first_name = 'Willie' or first_name = 'Kelly' and active = 1;

select *
from film
where rental_rate between 0.0 and 3.0 
and rating = 'PG-13';

select
    language.name,
    film.title
from language
full join film ON film.language_id = language.language_id;

select f.title, count(fa.actor_id), f.description 
from film as f
inner join film_actor as fa on f.film_id = fa.film_id 
group by f.film_id 
having count (fa.actor_id) > 10

select  
	concat(cl.first_name,' ', cl.last_name) as Имя_Фамилия,
	a.address as Адрес, 
	c.city as Город,
	co.country as Страна
from customer as cl
left join address as a on cl.address_id = a.address_id 
left join city as c on a.city_id = c.city_id
left join country as co on c.country_id = co.country_id 

select 
	s.store_id as ID_магазина,
	count(c.customer_id) as Количество_покупателей,
	ci.city as Город,
	concat(st.last_name, ' ',st.first_name) as Фамилия_и_имя_продавца
from store as s
inner join customer c on c.store_id = s.store_id
inner join address a on s.address_id = a.address_id
inner join city ci on a.city_id = ci.city_id 
inner join staff st on st.staff_id = s.manager_staff_id 
group by s.store_id, a.address_id, ci.city_id, st.last_name, st.first_name 
having count(c.customer_id) > 300


select 
	concat(c.last_name, ' ',c.first_name) as Фамилия_и_имя_покупателя,
	count(rental_id) as Количество_фильмов
from customer as c
inner join rental as r on r.customer_id = c.customer_id 
group by c.customer_id 
order by count(rental_id)
desc limit 5

select 
	concat(c.last_name, ' ',c.first_name) as Фамилия_и_имя_покупателя,
	count(r.rental_id) as Количество_фильмов,
	sum(p.amount) as Сумма,
	min(p.amount) as Минимальная_стоимость,
	max(p.amount) as Максимальная_стоимость
from customer as c
inner join rental as r on r.customer_id = c.customer_id 
inner join payment as p on p.customer_id = c.customer_id 
group by c.customer_id


select 
	customer_id as ID_покупателя,
	round(avg(CAST(return_date AS date) - CAST(rental_date AS date)),2) 
		as Срдн_колво_дней_на_возврат
from rental
group by ID_покупателя
order by ID_покупателя

select 
	c.city as city_1,
	ci.city as city_2
from city as c
cross join city as ci 
where c.city_id <> ci.city_id

create table author (
author_id primary key,
full_name varchar(50) unique not null,
pseudonim varchar(50),
date_of_birth timestamp not null,
date_of_creation timestamp default now()
)

drop table author

inser into author (full_name, pseudonim, date_of_birth)
values ('Jules Verne', null, '08.02.1828'),
('Mikhail Lermontov','Something','03.10.1814')

alter table author add column born_place varchar(50)

update author
set born_place = 'France'
where id = 1

update author
set born_place = 'Russian Empire'
where id = 2

update author
set born_place = 'Japan'
where id = 3

create table books (
	book_id serial primary key,
	book_name varchar (150) not null,
	book_year int2 not null check (book_year >= 0 and book_year >= 2100),
	author_id int2 references author(id),
	create_date timestamp default (now)	
)

insert into books (book_name, book_year,author_id) 
values ('Двадцать тысяч лье под водой', 1916, 1),
('Бородино', 1837, 2),
('Норвежский лес', 1980,3)

delete from author
where id = 1