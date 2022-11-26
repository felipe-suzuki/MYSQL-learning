-- Creating a new table -- 
CREATE TABLE corporation (
    corp_id SMALLINT,
    name VARCHAR(30),
    CONSTRAINT pk_corporation PRIMARY KEY (corp_id)
);

-- Inserting a row into the corporation table -- 
INSERT INTO corporation (corp_id, name)
VALUES (27, 'Acme Paper Corporation'); 

-- Using Select to retrieve the specific data inserted --
SELECT name
FROM corporation
WHERE corp_id = 27;
# Could be using just SELECT/FROM in this case, because there is only one row 
# in this table currently, but when searching into a complete table should 
# always use WHERE to indicates a specific data to retrieve.


