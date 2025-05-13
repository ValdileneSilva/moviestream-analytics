
  create view "landing_db"."public"."stg_inventory__dbt_tmp"
    
    
  as (
    SELECT
    inventory_id,
    film_id,
    store_id,
    last_update
FROM "landing_db"."public"."inventory"
  );