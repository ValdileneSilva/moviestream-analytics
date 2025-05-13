SELECT
    s.store_id,
    COUNT(DISTINCT r.rental_id) AS total_rentals,
    SUM(p.amount) AS total_revenue,
    COUNT(DISTINCT c.customer_id) AS num_customers
FROM {{ ref('stg_store') }} s
JOIN {{ ref('stg_inventory') }} i ON s.store_id = i.store_id
JOIN {{ ref('stg_rental') }} r ON i.inventory_id = r.inventory_id
JOIN {{ ref('stg_payment') }} p ON r.rental_id = p.rental_id
JOIN {{ ref('stg_customer') }} c ON c.customer_id = r.customer_id
GROUP BY s.store_id