
  
    

  create  table "landing_db"."public"."mart_store_performance__dbt_tmp"
  
  
    as
  
  (
    SELECT
    s.store_id,
    COUNT(DISTINCT r.rental_id) AS total_rentals,
    SUM(p.amount) AS total_revenue,
    COUNT(DISTINCT c.customer_id) AS num_customers
FROM "landing_db"."public"."stg_store" s
JOIN "landing_db"."public"."stg_inventory" i ON s.store_id = i.store_id
JOIN "landing_db"."public"."stg_rental" r ON i.inventory_id = r.inventory_id
JOIN "landing_db"."public"."stg_payment" p ON r.rental_id = p.rental_id
JOIN "landing_db"."public"."stg_customer" c ON c.customer_id = r.customer_id
GROUP BY s.store_id
  );
  