
  create view "landing_db"."public"."stg_store__dbt_tmp"
    
    
  as (
    SELECT
    store_id,
    manager_staff_id,
    address_id,
    last_update
FROM "landing_db"."public"."store"
  );