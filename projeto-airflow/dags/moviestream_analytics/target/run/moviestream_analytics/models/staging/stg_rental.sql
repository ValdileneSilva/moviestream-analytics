
  create view "landing_db"."public"."stg_rental__dbt_tmp"
    
    
  as (
    SELECT
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    last_update
FROM "landing_db"."public"."rental"
  );