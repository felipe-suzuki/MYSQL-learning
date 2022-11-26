# When working with the French and German languages, for example,
# you might need to include accented characters such as é and ö
# The SQL Server and MySQL servers include the built-in function
# char() so that you can build strings from any of the 255 characters
SELECT 
    'abcdefg',
    CHAR(97, 98, 99, 100, 101, 102, 103 USING UTF8MB4);

# The 97th character in the ASCII character set is the letter a. 
SELECT CHAR(128 USING UTF8MB4);

# use the concat() function to concatenate individual strings, some 
# of which you can type while others you can generate via the char()
# function. For example, the following shows how to build
# the phrase danke schön using the concat() and char() functions
SELECT 
    CONCAT('danke sch',
            CHAR(148 USING UTF8MB4),
            'n');

-- If you have a character and need to find its ASCII equivalent, you can use the
-- ascii() function, which takes the leftmost character in the string and returns a
-- number:
-- mysql> SELECT ASCII('ö');
-- +------------+
-- | ASCII('ö') |
-- +------------+
-- | 148 		|
-- +------------+