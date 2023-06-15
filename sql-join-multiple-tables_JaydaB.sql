use sakila;

#1. Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, co.country
from store s
left join address a on s.address_id = a.address_id
left Join city c on a.city_id = c.city_id
left join country co on c.country_id = co.country_id
Limit 0, 1000;

#2. Write a query to display how much business, in dollars, each store brought in.

select s.store_id, sum(p.amount) as total_amount
from store s
left join staff st on s.store_id = st.store_id
left join payment p on st.staff_id = p.staff_id
group by s.store_id;

#3. What is the average running time of films by category?
select c.name as category, avg(f.length) as average_running_time
from category c
left join film f on c.category_id = f.film_id
Group by c.name;

#4. Which film categories are longest?
select c.name as category, avg(f.length) as average_running_time, max(f.length) as longest_films
from category c
left join film f on c.category_id = f.film_id
group by c.name
order by 3 desc;

#5. Display the most frequently rented movies in descending order.
select f.film_id, f.title, count(r.rental_id) as rental_frequency
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id, f.title
order by rental_frequency desc;

#6. List the top five genres in gross revenue in descending order.
select c.name as genre, sum(p.amount) as gross_revenue
from category c
left join film_category fc on c.category_id = fc.category_id
left join inventory i on fc.film_id = i.film_id
left join rental r on i.inventory_id = r.inventory_id
left join payment p on r.rental_id = p.rental_id
group by c.name
order by gross_revenue desc
limit 5;

#7. Is "Academy Dinosaur" available for rent from Store 1? (Answer: No, when 0 is returned it means no)
select count(*) as availability
from rental r
left join inventory i on r.inventory_id = i.inventory_id
left join store s on i.store_id = s.store_id
left join film f on i.film_id = f.film_id
where f.title = 'academy dinosaur' and s.store_id = 1 and r.return_date is null;