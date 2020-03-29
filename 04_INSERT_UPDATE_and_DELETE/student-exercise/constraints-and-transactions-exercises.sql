-- Write queries to return the following:
-- The following changes are applied to the "dvdstore" database.**
-- 1. Add actors, Hampton Avenue, and Lisa Byway to the actor table.

INSERT INTO actor (first_name, last_name)
VALUES ('HAMPTON', 'Avenue');
 
INSERT INTO actor (first_name, last_name)
VALUES ('LISA', 'Byway');
 
-- 2. Add "Euclidean PI", "The epic story of Euclid as a pizza delivery boy in
-- ancient Greece", to the film table. The movie was released in 2008 in English.
-- Since its an epic, the run length is 3hrs and 18mins. There are no special
-- features, the film speaks for itself, and doesn't need any gimmicks.

INSERT INTO film(title, description, release_year, language_id, length)
VALUES ('EUCLIDEAN PI', 'The epic story of Euclid as a pizza delivery boy in ancient Greece', 2008,
    (SELECT language_id FROM language WHERE name = 'English'), 198);

SELECT film.title FROM film 
WHERE  film.title = 'EUCLIDEAN PI';
   
--SELECT * FROM film WHERE title = 'EUCLIDEAN PI';

-- 3. Hampton Avenue plays Euclid, while Lisa Byway plays his slightly
-- overprotective mother, in the film, "Euclidean PI". Add them to the film.
INSERT INTO film_actor (actor_id, film_id)
VALUES (201, 1001);

INSERT INTO film_actor (actor_id, film_id)
VALUES (202, 1001);

-- 4. Add Mathmagical to the category table.

INSERT INTO category (name)
VALUES ('Mathmagical');

-- 5. Assign the Mathmagical category to the following films, "Euclidean PI",
-- "EGG IGBY", "KARATE MOON", "RANDOM GO", and "YOUNG LANGUAGE"
INSERT INTO film_category (film_id, category_id)
VALUES ((SELECT film_id FROM film WHERE film.title = 'EUCLIDEAN PI'), (SELECT category_id FROM category WHERE name = 'Mathmagical'));

UPDATE film_category
   SET category_id =(SELECT category_id FROM category WHERE name = 'Mathmagical')
WHERE film_id = (SELECT film_id FROM film WHERE film.title = 'EUCLIDEAN PI')
OR    film_id = (SELECT film_id FROM film WHERE film.title = 'EGG IGBY')
OR    film_id = (SELECT film_id FROM film WHERE film.title = 'KARATE MOON')
OR    film_id = (SELECT film_id FROM film WHERE film.title = 'RANDOM GO')
OR    film_id = (SELECT film_id FROM film WHERE film.title = 'YOUNG LANGUAGE');

-- 6. Mathmagical films always have a "G" rating, adjust all Mathmagical films
-- accordingly.
-- (5 rows affected)
UPDATE film
   SET rating = 'G'
WHERE film.title = 'EUCLIDEAN PI'
OR    film.title = 'EGG IGBY'
OR    film.title = 'KARATE MOON'
OR    film.title = 'RANDOM GO'
OR    film.title = 'YOUNG LANGUAGE';

-- 7. Add a copy of "Euclidean PI" to all the stores.
INSERT INTO inventory (film_id, store_id)
SELECT film_id, store.store_id FROM film
JOIN store ON store_id IS NOT NULL
WHERE film.title = 'EUCLIDEAN PI';

--This is another way to go
--INSERT INTO inventory (film_id, store_id)
--SELECT (SELECT film_id FROM film WHERE title = 'EUCLIDEAN PI'), store_id FROM store;
--can choose each one for two above 

-- 8. The Feds have stepped in and have impounded all copies of the pirated film,
-- "Euclidean PI". The film has been seized from all stores, and needs to be
-- deleted from the film table. Delete "Euclidean PI" from the film table.
-- (Did it succeed? Why?)
-- <YOUR ANSWER HERE>
DELETE FROM film
WHERE film_id = 1001;
-----ANSWER----this failed because the record is tied to film_actor table.

-- 9. Delete Mathmagical from the category table.
-- (Did it succeed? Why?)
-- <YOUR ANSWER HERE>
DELETE FROM category
WHERE name = 'Mathmagical';
-----ANSWER----this failed because the record is tied to film_category table.

-- 10. Delete all links to Mathmagical in the film_category tale.
-- (Did it succeed? Why?)
-- <YOUR ANSWER HERE>
DELETE FROM film_category
WHERE category_id = (SELECT category_in from category WHERE name = 'Mathmagical')
-----ANSWER----this success  because the record is not tied to any table.

-- 11. Retry deleting Mathmagical from the category table, followed by retrying
-- to delete "Euclidean PI".
-- (Did either deletes succeed? Why?)
-- <YOUR ANSWER HERE>
DELETE FROM category
WHERE name = 'Mathmagical';
-----ANSWER----this success  because the record is not tied to any table.

-- 12. Check database metadata to determine all constraints of the film id, and
-- describe any remaining adjustments needed before the film "Euclidean PI" can
-- be removed from the film table.
DELETE FROM film_actor
WHERE actor_id = 201;

DELETE FROM film_actor
WHERE actor_id = 202;

DELETE FROM film
WHERE film_id = 1001;

DELETE FROM actor
WHERE actor_id = 201;

DELETE FROM actor
WHERE actor_id = 202;

DELETE FROM film
WHERE film_id = 1001;

DELETE FROM inventory
WHERE film_id = 1001;

DELETE FROM film
WHERE film_id = 1001;
--Delete success--
---ANSWER---Total 3 tied table still remain, they are inventory table, actor table and film_actor table.
