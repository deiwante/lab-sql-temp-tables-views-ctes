
-- Step 1: Create a View
-- First, create a view that summarizes rental information for each customer. 
-- The view should include the customer's ID, name, email address, and total number of rentals (rental_count).
select * FROM rental;
CREATE VIEW rental_summ AS 
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    c.email, 
    COUNT(r.customer_id) AS rental_count
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;
SELECT * FROM rental_summ;

-- Temp table that calculates total paid amount per customer total_paid
SELECT * FROM payment;
SELECT * FROM final;

CREATE TEMPORARY TABLE final
SELECT rs.*,SUM(p.amount) AS total_paid 
FROM rental_summ AS rs
JOIN payment AS p ON rs.customer_id = p.customer_id
GROUP BY  rs.customer_id;


-- CTE

WITH avg_payment AS 
(
    SELECT 
        f.customer_id, 
        ROUND(AVG(total_paid/rental_count), 2) AS cost
    FROM final f
    GROUP BY f.customer_id
)
SELECT 
    rs.*,
    ap.cost
FROM Rental_summ rs
JOIN avg_payment ap ON rs.customer_id = ap.customer_id;



