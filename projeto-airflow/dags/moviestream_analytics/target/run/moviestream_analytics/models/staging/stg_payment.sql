
  create view "landing_db"."public"."stg_payment__dbt_tmp"
    
    
  as (
    SELECT
    payment_id,
    customer_id,
    staff_id,
    rental_id,
    amount,
    payment_date
FROM "landing_db"."public"."payment"
  );