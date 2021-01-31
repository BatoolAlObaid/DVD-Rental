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
