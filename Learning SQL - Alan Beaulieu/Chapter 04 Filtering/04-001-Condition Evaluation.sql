-- WHERE -----------------------------------------------------
# Retrieve the rows where first_name = 'STEVEN' and create_date > '2006-01-01'
-- WHERE first_name = 'STEVEN' AND create_date > '2006-01-01'

# Retrieve the rows where first_name = 'STEVEN' or create_date = '2006-01-01'
-- WHERE first_name = 'STEVEN' OR create_date > '2006-01-01'

-- USING PARENTHESES ------------------------------------------
# where clause that checks if the first name is Steven or the last
# name is Young, and the creation date is after January 1, 2006
-- WHERE (first_name = 'STEVEN' OR last_name = 'YOUNG')
-- AND create_date > '2006-01-01'

-- USING THE NOT OPERATOR --------------------------------------
# retrieving only rows where the first name is not Steven or the last name is not
# Young whose record was created after January 1, 2006.
-- WHERE NOT (first_name = 'STEVEN' OR last_name = 'YOUNG')
-- AND create_date > '2006-01-01'

# ANOTHER OPTION IS TO USE <> INTEAD OF = AND REMOVE THE NOT OPERATOR
-- WHERE (first_name <> 'STEVEN' OR last_name <> 'YOUNG')
-- AND create_date > '2006-01-01'
