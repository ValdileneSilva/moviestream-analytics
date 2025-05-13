-- 1. Top 5 clientes por receita no último ano
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
WHERE p.payment_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY c.customer_id, customer_name
ORDER BY total_revenue DESC
LIMIT 5;

-- 2. Média de dias entre aluguel e devolução por categoria de filme
SELECT 
    cat.name AS category_name,
    AVG(RETURN_DATE - RENTAL_DATE) AS avg_days_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE r.return_date IS NOT NULL
GROUP BY cat.name
ORDER BY avg_days_rented DESC;

-- 3. Top 3 cidades com maior volume de locações
SELECT 
    ci.city,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city
ORDER BY total_rentals DESC
LIMIT 3;

-- 4. Ticket médio por loja
SELECT 
    s.store_id,
    ROUND(SUM(p.amount) / COUNT(DISTINCT p.payment_id), 2) AS avg_ticket
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;

-- 5. Receita mensal dos últimos 24 meses
SELECT 
    DATE_TRUNC('month', p.payment_date) AS month,
    SUM(p.amount) AS total_revenue
FROM payment p
WHERE p.payment_date >= CURRENT_DATE - INTERVAL '24 months'
GROUP BY month
ORDER BY month;
