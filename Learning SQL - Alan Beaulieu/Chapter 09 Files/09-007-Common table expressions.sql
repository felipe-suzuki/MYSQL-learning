-- A Common Table Expression (CTE) is a named subquery that appears at the top of a query in a
-- with clause, which can contain multiple CTEs separated by commas.
-- Along with making queries more understandable, this feature also allows each CTE 
-- to refer to any other CTE defined above it in the same with clause. 
-- The following example includes three CTEs, where the second
-- refers to the first, and the third refers to the second:

with actors_s as 
	(select actor_id, first_name, last_name
    from actor
    where last_name like 'S%'
    ),
	actors_s_pg as
    (select s.actor_id, s.first_name, s.last_name,
		f.film_id, f.title
	from actors_s as s
		inner join film_actor as fa
        on s.actor_id = fa.actor_id
        inner join film as f
        on f.film_id = fa.film_id
        where f.rating = 'PG'
	),
    actors_s_pg_revenue as
    (select spg.first_name, spg.last_name, p.amount
    from actors_s_pg as spg
		inner join inventory as i
        on i.film_id = spg.film_id
        inner join rental as r
        on i.inventory_id = r.inventory_id
        inner join payment as p
        on r.rental_id = p.rental_id
	) -- end of with clause
    select  spg_rev.first_name, spg_rev.last_name,
		sum(spg_rev.amount) as tot_revenue
	from actors_s_pg_revenue as spg_rev
    group by spg_rev.first_name, spg_rev.last_name
    order by 3 desc;