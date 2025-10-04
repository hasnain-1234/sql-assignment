/* 1)Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).*/

/*Write the SQL query to create the above table with all constraints*/
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000
);

/*2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints.
ans)Constraints ensure data integrity (valid and consistent data).
Types:

NOT NULL → Prevents missing values

UNIQUE → Prevents duplicate values

PRIMARY KEY → Combines NOT NULL + UNIQUE, identifies each row

CHECK → Validates condition (e.g., age ≥ 18)

DEFAULT → Provides automatic value if none given

FOREIGN KEY → Ensures referential integrity between tables 
3. Why use NOT NULL? Can Primary Key be NULL?

NOT NULL ensures a column must always have a value.

A Primary Key cannot be NULL, because it uniquely identifies each row.

If NULLs were allowed, you couldn’t reliably find a specific row. */

/*4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint*/

ALTER TABLE employees
ADD CONSTRAINT chk_age CHECK (age >= 18);

ALTER TABLE employees
DROP CHECK chk_age;

/*5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.
ans)Consequences of violating constraints

Insert/update with invalid data → Error
Example:*/

INSERT INTO employees (emp_id, emp_name, age, email)
VALUES (1, 'Alice', 15, 'alice@mail.com');

/*6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));  
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00 */
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);
/* alt1er with constraint*/
ALTER TABLE products
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

ALTER TABLE products
ALTER price SET DEFAULT 50.00;

/*7)Write a query to fetch the student_name and class_name for each student using an INNER JOIN.*/

SELECT s.student_name, c.class_name
FROM Students s
INNER JOIN Classes c
ON s.class_id = c.class_id;

/* 8)Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order 

Hint: (use INNER JOIN and LEFT JOIN)5 */

SELECT o.order_id, c.customer_name, p.product_name
FROM Products p
LEFT JOIN Orders o ON p.order_id = o.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id;

/* 9)Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function*/
SELECT p.product_name, SUM(s.amount) AS total_sales
FROM Sales s
INNER JOIN Products p
ON s.product_id = p.product_id
GROUP BY p.product_name;

/* 10) Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables. */

SELECT o.order_id, c.customer_name, od.product_id, od.quantity
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id;


/*SQL COMMANDS*/

/* 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences 

-- Primary Key: uniquely identifies a row (e.g., actor_id in actor table)
-- Foreign Key: references another table’s PK (e.g., film_id in film_actor table)
*/
/* 2)2- List all details of actors */
 SELECT * FROM actor;
 /* 3 -List all customer information from DB */
 
SELECT * FROM customer;

/*4 -List different countries.*/
 SELECT DISTINCT country FROM country;
 
/*5 -Display all active customers.*/
SELECT * FROM customer WHERE active = 1;

/*6 -List of all rental IDs for customer with ID 1*/
SELECT rental_id FROM rental WHERE customer_id = 1;

/* 7 - Display all the films whose rental duration is greater than 5 . */

SELECT * FROM film WHERE rental_duration > 5;
/*8- List the total number of films whose replacement cost is greater than $15 and less than $20 */
SELECT COUNT(*) 
FROM film 
WHERE replacement_cost > 15 AND replacement_cost < 20;

/*9 - Display the count of unique first names of actors*/
SELECT COUNT(DISTINCT first_name) FROM actor;

 /*10- Display the first 10 records from the customer table .*/
 SELECT * FROM customer LIMIT 10;
 
/*11 - Display the first 3 records from the customer table whose first name starts with ‘b’.*/
SELECT * FROM customer 
WHERE first_name LIKE 'b%' 
LIMIT 3;

/*12 -Display the names of the first 5 movies which are rated as ‘G’.*/
SELECT title 
FROM film 
WHERE rating = 'G' 
LIMIT 5;

/*13-Find all customers whose first name starts with "a".*/
SELECT * FROM customer WHERE first_name LIKE 'a%';

/*14- Find all customers whose first name ends with "a".*/
SELECT * FROM customer WHERE first_name LIKE '%a';

/*15- Display the list of first 4 cities which start and end with ‘a’ */
SELECT * FROM city WHERE city LIKE 'a%a' LIMIT 4;

/*16- Find all customers whose first name have "NI" in any position.*/
SELECT * FROM customer WHERE first_name LIKE '%Ni%';

/*17- Find all customers whose first name have "r" in the second position .*/
SELECT * FROM customer WHERE first_name LIKE '_r%';


/*18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.*/
SELECT * 
FROM customer 
WHERE first_name LIKE 'a%' 
AND LENGTH(first_name) >= 5;

/*19- Find all customers whose first name starts with "a" and ends with "o".*/
SELECT * 
FROM customer 
WHERE first_name LIKE 'a%o';

/*20 - Get the films with pg and pg-13 rating using IN operator.*/
SELECT * 
FROM film 
WHERE rating IN ('PG', 'PG-13');

/*21 - Get the films with length between 50 to 100 using between operator.*/
SELECT * 
FROM film 
WHERE length BETWEEN 50 AND 100;

/*22 - Get the top 50 actors using limit operator.*/
SELECT * FROM actor LIMIT 50;

/*23 - Get the distinct film ids from inventory table.*/
SELECT DISTINCT film_id FROM inventory;


/* FUNCTION */


/*Question 1:
Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function.*/

SELECT COUNT(*) AS total_rentals FROM rental;

/*Question 2:
Find the average rental duration (in days) of movies rented from the Sakila database.
Hint: Utilize the AVG() function.*/

SELECT AVG(rental_duration) AS avg_duration FROM film;

/*String Functions:

Question 3:
Display the first name and last name of customers in uppercase.
Hint: Use the UPPER () function. */

SELECT UPPER(first_name), UPPER(last_name) FROM customer;

/*Question 4:
Extract the month from the rental date and display it alongside the rental ID.
Hint: Employ the MONTH() function.*/
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

/*Question 5:
Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
Hint: Use COUNT () in conjunction with GROUP BY.*/
SELECT customer_id, COUNT(*) AS rentals
FROM rental
GROUP BY customer_id;

/*Question 6:
Find the total revenue generated by each store.
Hint: Combine SUM() and GROUP BY.*/
SELECT store_id, SUM(amount) AS revenue
FROM payment
GROUP BY store_id;

/*Question 7:
Determine the total number of rentals for each category of movies.
Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.*/
SELECT c.name AS category, COUNT(*) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

/*Question 8:
Find the average rental rate of movies in each language.
Hint: JOIN film and language tables, then use AVG () and GROUP BY. */
SELECT l.name AS language, AVG(f.rental_rate) AS avg_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

/* JOINS
Questions 9 -
Display the title of the movie, customer s first name, and last name who rented it.
Hint: Use JOIN between the film, inventory, rental, and customer tables. */
SELECT f.title, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

/*Question 10:
Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Hint: Use JOIN between the film actor, film, and actor tables.*/
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

/*Question 11:
Retrieve the customer names along with the total amount they've spent on rentals.
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY */
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

/*Question 12:
List the titles of movies rented by each customer in a particular city (e.g., 'London').
Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY */
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN country cn ON ct.country_id = cn.country_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ct.city = 'London';

/*Question 13:
Display the top 5 rented movies along with the number of times they've been rented.
Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.*/
SELECT f.title, COUNT(*) AS times_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 5;

/*Question 14:
Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.*/
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;


/* WINDOW FUNCTION*/


/*1. Rank the customers based on the total amount they've spent on rentals.*/
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

/*2. Calculate the cumulative revenue generated by each film over time.*/
SELECT 
    f.film_id,
    f.title,
    r.rental_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id;

/*3. Determine the average rental duration for each film, considering films with similar lengths*/
SELECT 
    f.film_id,
    f.title,
    f.length,
    f.rental_duration,
    AVG(f.rental_duration) OVER (PARTITION BY f.length) AS avg_duration_for_length
FROM film f;

/*4. Identify the top 3 films in each category based on their rental counts.*/
SELECT *
FROM (
    SELECT 
        c.name AS category,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rnk
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title
) ranked
WHERE rnk <= 3;

/*4. Identify the top 3 films in each category based on their rental counts.*/
SELECT *
FROM (
    SELECT 
        c.name AS category,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rnk
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title
) ranked
WHERE rnk <= 3;

/*5. Calculate the difference in rental counts between each customer's total rentals and the average rentals
across all customers.*/
WITH customer_rentals AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(r.rental_id) AS total_rentals
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, customer_name
)
SELECT 
    customer_id,
    customer_name,
    total_rentals,
    ROUND(AVG(total_rentals) OVER (), 2) AS avg_rentals_all_customers,
    total_rentals - AVG(total_rentals) OVER () AS difference_from_avg
FROM customer_rentals
ORDER BY difference_from_avg DESC;

/*6. Find the monthly revenue trend for the entire rental store over time.*/
SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    SUM(p.amount) AS monthly_revenue,
    SUM(SUM(p.amount)) OVER (ORDER BY DATE_FORMAT(p.payment_date, '%Y-%m')) AS cumulative_revenue
FROM payment p
GROUP BY DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY month;

/*7. Identify the customers whose total spending on rentals falls within the top 20% of all customers*/
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        SUM(p.amount) AS total_spent,
        NTILE(5) OVER (ORDER BY SUM(p.amount) DESC) AS spending_percentile
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
)
SELECT * 
FROM customer_spending
WHERE spending_percentile = 1;

/*8. Calculate the running total of rentals per category, ordered by rental count.*/
SELECT 
    c.name AS category,
    COUNT(r.rental_id) AS rental_count,
    SUM(COUNT(r.rental_id)) OVER (ORDER BY COUNT(r.rental_id)) AS running_total
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name;

/*9. Find the films that have been rented less than the average rental count for their respective categories*/
WITH film_rentals AS (
    SELECT 
        f.film_id,
        f.title,
        c.name AS category,
        COUNT(r.rental_id) AS rental_count,
        AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.name) AS avg_category_rentals
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY f.film_id, f.title, c.name
)
SELECT * 
FROM film_rentals
WHERE rental_count < avg_category_rentals;

/*10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.*/
SELECT *
FROM (
    SELECT 
        DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
        SUM(p.amount) AS monthly_revenue,
        RANK() OVER (ORDER BY SUM(p.amount) DESC) AS rnk
    FROM payment p
    GROUP BY DATE_FORMAT(p.payment_date, '%Y-%m')
) ranked
WHERE rnk <= 5;

/* NORMALISATION & CTE */

/*1. First Normal Form (1NF):

 a. Identify a table in the Sakila database that violates 1NF. Explain how you
 would normalize */
 
 CREATE TABLE customer_phone (
    customer_id INT,
    phone_number VARCHAR(15),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
/*2. Second Normal Form (2NF):
 a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
 If it violates 2NF, ex 
 
 Second Normal Form (2NF):
Example: In film_category, if extra attributes like category_name were stored, it depends only on category_id not the composite key.
Normalization: Move category_name into category table.

-- Already normalized in Sakila:
-- film_category (film_id, category_id)
-- category (category_id, name)
*/

/* 3. Third Normal Form (3NF):
 a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
 present and outline the steps to normalize the table to 3NF 
 
 ams) Third Normal Form (3NF):
Example: If customer table stored zip_code and city_name, but city depends on zip_code → Transitive dependency.
Normalization: Keep zip_code in customer and create address/city tables linked by foreign keys. */

/*4. Normalization Process:
 a. Take a specific table in Sakila and guide through the process of normalizing it from the initial 
 unnormalized form up to at least 2NF 
 
 ans)Normalization Process Example (Up to 2NF):
Start: Table → rental(customer_id, customer_name, film_id, film_title, category_name)
1NF → Split repeating groups into separate rows.
2NF → Remove partial dependency (film info separated into film table). */

/*5. CTE Basics:
 a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
 have acted in from the */
 
 WITH ActorFilms AS (
    SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT * FROM ActorFilms;

/*6. CTE with Joins:
 a. Create a CTE that combines information from the film and language tables to display the film title, 
 language name, and  rental rate.*/
 
 WITH FilmLang AS (
    SELECT f.film_id, f.title, l.name AS language_name, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM FilmLang;

/* CTE for Aggregation:
 a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
 from the customer and payment tables. */

WITH CustomerRevenue AS (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT * FROM CustomerRevenue;

/* 8)CTE with Window Functions:
 a. Utilize a CTE with a window function to rank films based on their rental duration from the film table. */
 
WITH FilmRank AS (
    SELECT film_id, title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS rank_order
    FROM film
)
SELECT * FROM FilmRank;

/* 9) CTE and Filtering:

 a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
 customer table to retrieve additional custom.*/
WITH RentalCount AS (
    SELECT customer_id, COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
)
SELECT rc.customer_id, c.first_name, c.last_name, rc.total_rentals
FROM RentalCount rc
JOIN customer c ON rc.customer_id = c.customer_id;

/* 10 ) CTE for Date Calculations:
 a. Write a query using a CTE to find the total number of rentals made each month, considering the 
 rental_date from the rental*/
 WITH MonthlyRentals AS (
    SELECT MONTH(rental_date) AS month, COUNT(*) AS total_rentals
    FROM rental
    GROUP BY MONTH(rental_date)
)
SELECT * FROM MonthlyRentals;

/* 11)CTE and Self-Join:
 a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
 together, using the film_actor table. */
 WITH FilmActors AS (
    SELECT film_id, actor_id
    FROM film_actor
)
SELECT f1.actor_id AS actor1, f2.actor_id AS actor2, f1.film_id
FROM FilmActors f1
JOIN FilmActors f2 
  ON f1.film_id = f2.film_id AND f1.actor_id < f2.actor_id;

/* 12). CTE for Recursive Search:
 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
 considering the reports_to column */
 WITH RECURSIVE StaffHierarchy AS (
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE reports_to IS NULL
    UNION ALL
    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    INNER JOIN StaffHierarchy sh ON s.reports_to = sh.staff_id
)
SELECT * FROM StaffHierarchy;














