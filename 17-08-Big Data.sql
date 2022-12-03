#Big Data
-- The set of technologies pioneered by companies like Amazon, Google, Facebook, and Twitter 
-- (and others) has been branded as big data, which has become an industry buzzword but has 
-- several possible definitions. One way to define the boundaries of big data is with the “3 Vs”:

#Volume
-- In this context, volume generally means billions or trillions of data points.
#Velocity
-- This is a measure of how quickly data arrives.
#Variety
-- This means that data is not always structured (as in rows and columns in a relational
-- database) but can also be unstructured (e.g., emails, videos, photos, audio -- files, etc.).

#Hadoop
-- Hadoop is best described as an ecosystem, or a set of technologies and tools that work
-- together. Some of the major components of Hadoop include:

#Hadoop Distributed File System (HDFS)
-- Like the name implies, HDFS enables file management across a large number of servers.

#MapReduce
-- This technology processes large amounts of structured and unstructured data by breaking a 
-- task into many small pieces that can be run in parallel across many servers.

#YARN
-- This is a resource manager and job scheduler for HDFS. 

-- Together, these technologies allow for the storage and processing of files across hundreds
-- or even thousands of servers acting as a single logical system. While Hadoop is widely used, 
-- querying the data using MapReduce generally requires a programmer, which has led to the 
-- development of several SQL interfaces, including Hive, Impala, and Drill.

#NoSQL and Document Databases
-- What happens if the structure of the data isn’t known beforehand or if the structure is known but 
-- changes frequently? The answer for many companies is to combine both the data and schema definition 
-- into documents using a format such as XML or JSON and then store the documents in a database.

-- Document databases are a subset of what are called NoSQL databases, which typically store data using 
-- a simple key-value mechanism. For example, using a document database such as MongoDB, you could utilize
-- the customer ID as the key to store a JSON document containing all of the customer’s data, and other 
-- users can read the schema stored within the document to make sense of the data stored within.

#Cloud Computing
-- Prior to the advent of big data, most companies had to build their own data centers to house the 
-- database, web, and application servers used across the enterprise. With the advent of cloud computing, 
-- you can choose to essentially outsource your data center to platforms such as Amazon Web Services (AWS),
-- Microsoft Azure, or Google Cloud. One of the biggest benefits to hosting your services in the cloud is 
-- instant scalability, which allows you to quickly dial up or down the amount of computing power needed 
-- to run your services.

-- As far as databases are concerned, a quick look at AWS’s database and analytics offerings yields 
-- the following options:
-- • Relational databases (MySQL, Aurora, PostgreSQL, MariaDB, Oracle, and SQL Server)
-- • In-memory database (ElastiCache)
-- • Data warehousing database (Redshift)
-- • NoSQL database (DynamoDB)
-- • Document database (DocumentDB)
-- • Graph database (Neptune)
-- • Time-series database (TimeStream)
-- • Hadoop (EMR)
-- • Data lakes (Lake Formation)