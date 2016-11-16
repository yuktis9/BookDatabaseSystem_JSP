# BookDatabaseUsingJSP
This is a application to manage the Book Database using JSP technology. I have made this project in my Advance Java computing Class. A User can add Books Data like its Title, ISBN code, Copyright, Edition no and its Author(Author can be multiple). A User can then edit, delete and search the Data.

It Uses following technology.

Front End: HTML, CSS, Javascipt, JSP.
Service Layer: JSP Custom Tag
Back End: JDBC

Assignment is as follows:

1. Develop JSP

Design and develop Java JSPs to process the Book client requests.

1. Develop a dbConnection JavaBean class that will be used to connect to the Book database. 
 You may call the dbConnection from a JSP using <java:useBean ...> 
(Use a Http session in the JSP to store the database login, password, and database connection.)

2. Develop a dbQuery JSP to process the data query request from the client.
 You should try to create the similar GUI as in the previous assignments. 
 The JSP should use a custom tag to process the data query from the database to hide the SQL operation details. 
The custom tag should use the same database connection object stored in the Http session.
3. Develop a dbUpdate JSP to process the data update request from the client.
You should try to create the similar GUI as in the previous assignments. 
The JSP should use a custom tag to process the data update from the database to hide the SQL operation details.  
 - The custom tag should use the same database connection object stored in the Http session.
2. Deploy and Test the Three-Tier JSP Client-Servlet/Custom Tags Server-Database System

Combine the above into a three-tier client/application server/database application.


Apllication has three tables: Titles, Authors and AuthorISBN

SQL:

CREATE TABLE Authors
(
   AuthorID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   FirstName varchar(30) NOT NULL,
   LastName varchar(30) NOT NULL
);

CREATE TABLE Titles
(
   ISBN varchar(20) NOT NULL PRIMARY KEY,
   Title varchar(100) NOT NULL,
   EditionNumber int NOT NULL,
   Copyright varchar(4) NOT NULL
);

CREATE TABLE AuthorISBN
(
   AuthorID int NOT NULL,
   ISBN varchar(20) NOT NULL,
   FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
   FOREIGN KEY (ISBN) References Titles(ISBN)
);
