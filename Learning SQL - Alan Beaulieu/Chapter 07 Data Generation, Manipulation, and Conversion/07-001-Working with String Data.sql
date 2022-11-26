# When working with string data, you will be using one of
# the following character data types:
# -> char
# -> varchar
# -> text

# Creating the table used for the next examples
CREATE TABLE string_tbl (
    char_fld CHAR(30),
    vchar_fld VARCHAR(30),
    text_fld TEXT
);

-- STRING GENERATION -------------------------------------------
# The simplest way to populate a character column is to enclose a string in quotes
INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES ('This is char data',
'This is varchar data',
'This is text data');

# When inserting string data into a table if the length of the string
# exceeds the maximum size for the character column the server will throw an exception.

# To demonstrate how MySQL handles this situation, the following update statement
# attempts to modify the vchar_fld column, whose maximum length is defined as 30,
# with a string that is 46 characters in length:
UPDATE string_tbl 
SET 
    vchar_fld = 'This is a piece of extremely long varchar data';

-- INCLUDING SINGLE QUOTES --------------------------------------------------
# Since strings are demarcated by single quotes, you will need to be alert 
# for strings that include single quotes or apostrophes.
# You can escape a single quote by adding another single quote directly before
UPDATE string_tbl
SET 
	text_fld = 'This string didn''t work, but it does now';
    
# Oracle Database and MySQL users may also choose to escape a single
# quote by adding a backslash character immediately before, as in:
UPDATE string_tbl 
SET 
    text_fld = 'This string didn\'t work, but it does now';
    
# if you are retrieving the string to add to a file that another program will
# read, you may want to include the escape as part of the retrieved string.
# If you are using MySQL, you can use the built-in function quote()
SELECT 
    QUOTE(text_fld)
FROM
    string_tbl;
