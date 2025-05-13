
  create view "landing_db"."public"."stg_film__dbt_tmp"
    
    
  as (
    SELECT
    film_id,
    title,
    description,
    release_year,
    language_id,
    rental_duration,
    rental_rate,
    length,
    replacement_cost,
    rating,
    last_update
FROM "landing_db"."public"."film"
  );