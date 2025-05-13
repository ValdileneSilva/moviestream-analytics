SELECT
    customer_id,
    store_id,
    first_name,
    last_name,
    email,
    address_id,
    activebool AS is_active,
    create_date,
    last_update
FROM "landing_db"."public"."customer"