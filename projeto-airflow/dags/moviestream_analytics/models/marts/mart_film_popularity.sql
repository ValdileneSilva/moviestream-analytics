SELECT
    f.film_id,
    f.title,
    DATE_PART('year', r.rental_date) AS rental_year,
    DATE_PART('month', r.rental_date) AS rental_month,
    COUNT(r.rental_id) AS rental_count
FROM {{ ref('stg_film') }} f
JOIN {{ ref('stg_inventory') }} i ON f.film_id = i.film_id
JOIN {{ ref('stg_rental') }} r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title, rental_year, rental_month