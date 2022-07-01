-- Creating the Person Table with predefined variable types --
# ENUM data type constrains the allowable values for a particular column -- 
# Using ENUM to constraint the eye_color to BR, BL and GR only.
# PRIMARY KEY constraint tells database what column or columns will serve as the primary key for the table
# A PRIMARY KEY is created to the column person_id and given the name pk_person
CREATE TABLE person (
    person_id SMALLINT UNSIGNED,
    fname VARCHAR(20),
    lname VARCHAR(20),
    eye_color ENUM('BR','BL','GR'),
    birth_date DATE,
    street VARCHAR(30),
    city VARCHAR(20),
    state VARCHAR(20),
    country VARCHAR(20),
    postal_code VARCHAR(20),
    CONSTRAINT pk_person PRIMARY KEY (person_id)
); 

-- Creating the favorite_food Table --
# Since a person can have more than one favorite food
# a two-column PRIMARY KEY constraint is attributed
# The foreign key constraint constrains the values of the person_id column in the
# favorite_food table to include only values found in the person table.
 CREATE TABLE favorite_food (
    person_id SMALLINT UNSIGNED,
    food VARCHAR(20),
    CONSTRAINT pk_favorite_food PRIMARY KEY (person_id , food),
    CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id)
        REFERENCES person (person_id)
);