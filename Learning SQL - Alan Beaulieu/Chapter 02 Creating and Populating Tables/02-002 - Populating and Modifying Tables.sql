-- ALTER TABLE 'table name'/MODIFY ----------------------------------------------------
# Modifying the person_id column to turn the auto-increment feature
# IMPORTANT! 
#The ALTER TABLE must be applied before assigning person_id as foreign key, or it won't!
ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;

# Use DESC to describe the table to check if it worked
DESC person;

-- INSERT INTO ----------------------------------------------------
# Adding data to the table using INSERT
INSERT INTO person
(person_id, fname, lname, eye_color, birth_date)
VALUES (null, 'William', 'Turner', 'BR', '1972-05-27');

# Checking the data
SELECT person_id, fname, lname, birth_date
FROM person;

# Retrieving using WHERE clause to specify the row (person_id = 1)
SELECT 
    person_id, fname, lname, birth_date
FROM
    person
WHERE
    person_id = 1;
    
# Retrieving using WHERE clause to specify the row (lname = 'Turner')
SELECT 
    person_id, fname, lname, birth_date
FROM
    person
WHERE
    lname = 'Turner';
    
# Inserting favorite foods of William Turner person_id = 1
INSERT INTO favorite_food (person_id, food)
VALUES (1, 'pizza'); 

INSERT INTO favorite_food (person_id, food)
VALUES (1, 'cookies');

INSERT INTO favorite_food (person_id, food)
VALUES (1, 'nachos');

# Retrieves William’s favorite foods in alphabetical order using an order by clause
SELECT 
    food
FROM
    favorite_food
WHERE
    person_id = 1
ORDER BY food;

# insert statement to add Susan Smith to the person table
INSERT INTO person
(person_id, fname, lname, eye_color, birth_date,
street, city, state, country, postal_code)
VALUES (null, 'Susan','Smith', 'BL', '1975-11-02',
'23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

# Quick check on the table
SELECT person_id, fname, lname, birth_date
FROM person;

-- UPDATE 'table name'/SET ----------------------------------------------------
# Updating person_id = 1 address
UPDATE person 
SET 
    street = '1225 Tremont St.',
    city = 'Boston',
    state = 'MA',
    country = 'USA',
    postal_code = '02138'
WHERE
    person_id = 1;
    
-- DELETE FROM 'table name' ----------------------------------------------------
DELETE FROM person 
WHERE
    person_id = 2;
 
 -- COMMON ERRORS ----------------------------------------------------
#ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
INSERT INTO person
(person_id, fname, lname, eye_color, birth_date)
VALUES (1, 'Charles','Fulton', 'GR', '1968-01-15');

#ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
INSERT INTO favorite_food (person_id, food)
VALUES (999, 'lasagna');

#ERROR 1265 (01000): Data truncated for column 'eye_color' at row 1
UPDATE person 
SET 
    eye_color = 'ZZ'
WHERE
    person_id = 1;
    
#ERROR 1292 (22007): Incorrect date value: 'DEC-21-1980' for column 'birth_date' at row 1
UPDATE person 
SET 
    birth_date = 'DEC-21-1980'
WHERE
    person_id = 1;
    
-- DATE CONVERSIONS ----------------------------------------------------
UPDATE person 
SET 
    birth_date = STR_TO_DATE('DEC-21-1980', '%b-%d-%Y')
WHERE
    person_id = 1;
    
-- %a The short weekday name, such as Sun, Mon, ...
-- %b The short month name, such as Jan, Feb, ...
-- %c The numeric month (0..12)
-- %d The numeric day of the month (00..31)
-- %f The number of microseconds (000000..999999)
-- %H The hour of the day, in 24-hour format (00..23)
-- %h The hour of the day, in 12-hour format (01..12)
-- %i The minutes within the hour (00..59)
-- %j The day of year (001..366)
-- %M The full month name (January..December)
-- %m The numeric month
-- %p AM or PM
-- %s The number of seconds (00..59)
-- %W The full weekday name (Sunday..Saturday)
-- %w The numeric day of the week (0=Sunday..6=Saturday)
-- %Y The four-digit year