/*Query 1- query used for first insight*/
SELECT c.name AS category, COUNT(r.rental_id) AS rental_count
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
JOIN inventory i
ON i.film_id=f.film_id
JOIN rental r
ON r.inventory_id=i.inventory_id
WHERE name IN ('Animation','Children','Classics','Comedy','Family','Music')
GROUP BY 1
ORDER BY 1;

/*Query 2- query used for second insight*/
SELECT standard_quartile, COUNT(film_id) AS movies_count
FROM (
    SELECT f.film_id, NTILE(4) OVER w1 AS standard_quartile
    FROM category c
    JOIN film_category fc
    ON c.category_id = fc.category_id
    JOIN film f
    ON f.film_id = fc.film_id
    WHERE c.name IN ('Animation','Children','Classics','Comedy','Family','Music')
    WINDOW w1 AS (ORDER BY f.rental_duration)
) sub
GROUP BY 1
ORDER BY 1;

/*Query 3- query used for third insight*/
SELECT DATE_TRUNC('month', r.rental_date) AS rental_date, st.store_id, COUNT(r.rental_id) AS Count_rentals
FROM rental r
JOIN staff s
ON r.staff_id = s.staff_id
JOIN store st
ON s.staff_id = st.manager_staff_id
GROUP BY 1,2
ORDER BY 1;

/*Query 4- query used for fourth insight*/
WITH t1 AS (SELECT first_name || ' '|| last_name AS fullname, SUM(amount)
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
Group By 1
Order by 2 DESC
LIMIT 10)

SELECT first_name || ' ' || last_name AS fullname, SUM(amount) AS pay_amount
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
WHERE (DATE_TRUNC('month', p.payment_date) BETWEEN '2007-01-01' AND '2007-12-01')
AND (first_name || ' ' || last_name IN (SELECT fullname From t1))
Group by 1
ORDER BY 1;
