use sakila;

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column).
-- Select only columns title, length and rank in your output.

select * from film;

select title, length,
rank() over (order by length desc) as 'rank' 
from film 
where length is not null or ' '; -- There aren't any nan value or zero.

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).
--  In your output, only select the columns title, length, rating and rank.

select title, length, rating,
rank() over (order by rating, length desc) as 'rank'
from film
where length is not null or ' ';

-- 3. How many films are there for each of the categories in the category table?

select * from category;
select * from film_category;

select c.category_id, c.name, count(f.film_id) from film_category f
left join category c on f.category_id = c.category_id
group by name
order by category_id asc;

-- 4. Which actor has appeared in the most films?

select * from actor;
select * from film_actor;

select a.first_name, a.last_name, a.actor_id, count(f.film_id)
from actor a
left join film_actor f on a.actor_id = f.actor_id
group by actor_id
order by count(f.film_id) desc limit 1;

-- 5. Which is the most active customer (the customer that has rented the most number of films)?
select * from customer;
select * from rental;

select c.first_name, c.last_name, c.customer_id, count(r.rental_id)
from customer c
left join rental r on c.customer_id = r.customer_id
group by r.customer_id
order by count(r.rental_id) desc limit 1;