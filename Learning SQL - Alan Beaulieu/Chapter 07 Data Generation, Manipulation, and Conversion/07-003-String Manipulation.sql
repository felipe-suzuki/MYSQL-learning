-- Reset the data in the string_tbl table to the following:
DELETE FROM string_tbl;

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES ('This string is 28 characters',
'This string is 28 characters',
'This string is 28 characters');

-- String functions that return numbers ---------------------
# The following query applies the length()
# function to each column in the string_tbl table
SELECT 
    LENGTH(char_fld) char_length,
    LENGTH(vchar_fld) varchar_length,
    LENGTH(text_fld) text_length
FROM
    string_tbl;

-- POSITION() ------------------------------------------------------
# If you want to find the position at which the string 'characters' 
# appears in the vchar_fld column, you could use the  position()
# function, as demonstrated by the following
SELECT 
    POSITION('characters' IN vchar_fld)
FROM
    string_tbl;
    
-- LOCATE() -----------------------------------------------
# Retrieves the position of the string 'is' starting at the 
# fifth character in the vchar_fld column
SELECT 
    LOCATE('is', vchar_fld, 5)
FROM
    string_tbl;

-- STRCMP() -------------------------------------------
# Takes two strings as arguments and returns one of the following:
# • −1 if the first string comes before the second string in sort order
# • 0 if the strings are identical
# • 1 if the first string comes after the second string in sort order

# Cleaning the table
DELETE FROM string_tbl;

# Inserting new data
INSERT INTO string_tbl(vchar_fld)
VALUES ('abcd'),
('xyz'),
('QRSTUV'),
('qrstuv'),
('12345');

# Using STRCMP()
#MySQL’s strcmp() function is caseinsensitive, 
# which is something to remember when using the function.
SELECT 
    STRCMP('12345', '12345') 12345_12345,
    STRCMP('abcd', 'xyz') abcd_xyz,
    STRCMP('abcd', 'QRSTUV') abcd_QRSTUV,
    STRCMP('qrstuv', 'QRSTUV') qrstuv_QRSTUV,
    STRCMP('12345', 'xyz') 12345_xyz,
    STRCMP('xyz', 'qrstuv') xyz_qrstuv;
    
# This example below retrieves all the category names, along with
# an expression that returns 1 if the name ends in “y” or 0 otherwise
SELECT 
    name, name LIKE '%y' ends_in_y
FROM
    category;
    
-- String functions that return strings ------------------------
# Reseting the table
DELETE FROM string_tbl;

INSERT INTO string_tbl (text_fld)
VALUES ('This string was 29 characters');

# Using the CONCAT() function to append additional
# characters to a stored string
UPDATE string_tbl 
SET 
    text_fld = CONCAT(text_fld, ', but now it is longer');

# Retrieve the result    
SELECT 
    text_fld
FROM
    string_tbl;
    
# Using CONCAT() to build a string from individual pieces of data
SELECT 
    CONCAT(first_name,
            ' ',
            last_name,
            ' has been a customer since ',
            DATE(create_date)) AS cust_narrative
FROM
    customer;
    
-- INSERT() -------------------------------------------------
# MySQL includes the insert() function, which takes four arguments: 
# the original string, the position at which to start, the number of 
# characters to replace, and the replacement string.
SELECT INSERT('goodbye world', 9, 0, 'cruel ') AS string;

# In this example, all characters starting from position 9 
# are pushed to the right, and the string 'cruel' is inserted. 
# If the third argument is greater than zero, then that
# number of characters is replaced with the replacement string.
SELECT INSERT('goodbye world', 1, 7, 'hello') AS string;

-- SUBSTRING() --------------------------------------------------
-- To extract a substring from a string
# The following example extracts five characters from a string starting at the 9th position
SELECT SUBSTRING('goodbye cruel world', 9, 5);