
  
    

  create  table "landing_db"."public"."mart_customer_lifetime_value__dbt_tmp"
  
  
    as
  
  (
    SELECT
    c.customer_id,
    MIN(r.rental_date) AS first_rental_date,
    MAX(r.rental_date) AS last_rental_date,
    COUNT(r.rental_id) AS total_rentals,
    SUM(p.amount) AS total_spent,
    DATE_PART('day', CURRENT_DATE - MIN(r.rental_date)) AS days_since_first_rental
FROM "landing_db"."public"."stg_customer" c
JOIN "landing_db"."public"."stg_rental" r ON c.customer_id = r.customer_id
JOIN "landing_db"."public"."stg_payment" p ON r.rental_id = p.rental_id
GROUP BY c.customer_id
  );
  