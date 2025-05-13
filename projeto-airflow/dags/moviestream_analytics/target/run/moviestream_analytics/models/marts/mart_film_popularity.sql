
  
    

  create  table "landing_db"."public"."mart_film_popularity__dbt_tmp"
  
  
    as
  
  (
    SELECT
    f.film_id,
    f.title,
    DATE_PART('year', r.rental_date) AS rental_year,
    DATE_PART('month', r.rental_date) AS rental_month,
    COUNT(r.rental_id) AS rental_count
FROM "landing_db"."public"."stg_film" f
JOIN "landing_db"."public"."stg_inventory" i ON f.film_id = i.film_id
JOIN "landing_db"."public"."stg_rental" r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title, rental_year, rental_month
  );
  