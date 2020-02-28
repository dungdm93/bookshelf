SET autocommit = OFF;
START TRANSACTION;
USE sakila;

-- Add user #201
INSERT INTO actor (first_name,last_name)
	VALUES ('Ace','Portgas D.');

-- Modify user #200
UPDATE actor
	SET first_name='Robin',last_name='Nico'
	WHERE actor_id=200;

-- Modify user #199
UPDATE actor
	SET first_name='Sanji',last_name='Vinsmoke'
	WHERE actor_id=199;

-- Add user #202
INSERT INTO actor (first_name,last_name)
	VALUES ('Law','Trafalgar D. Water');

-- Delete user #199
DELETE FROM actor
	WHERE actor_id=199;

-- Modify user #202
UPDATE actor
	SET first_name='Hancock',last_name='Boa'
	WHERE actor_id=202;

-- Delete user #201
DELETE FROM actor
	WHERE actor_id=201;

-- Add user #203
INSERT INTO actor (first_name,last_name)
	VALUES ('Luffy','Monkey D.');

-- Delete user #198
DELETE FROM actor
	WHERE actor_id=198;

-- for 10 records change
UPDATE actor
	SET first_name='Dung',last_name='Dang Minh'
	WHERE actor_id=197;

-- 201: add -> delete
-- 200: modify
-- 199: modify -> delete
-- 202: add -> modify
-- 203: add
-- 198: delete
COMMIT;
