# Library Database SQL Scripts and Python Notebooks

This repository contains SQL scripts and Jupyter notebooks for managing and analyzing a library database. The scripts include setting up the database schema, inserting initial data, and running various queries for library management tasks.

## Files in this Repository

1. **Final SQL.sql**
   - Description: This file contains SQL scripts designed to create views and generate detailed reports related to the library's books and loans. It includes commands to find the number of available copies of specific books, count non-returned books, and generate statistics on book loans and popular books.
   - Usage: Run this script after setting up the database schema and inserting initial data to create views and generate various reports.
   - Sample Queries:
     - **Count Available Copies of Dracula**:
       ```sql
       CREATE VIEW count_dracula_books_table AS (
           SELECT COUNT(*) AS number_of_available_books FROM books
           WHERE title = "Dracula"
       );

       CREATE VIEW non_returned_books AS (
           SELECT COUNT(*) AS count_non_returned_books FROM books AS b
           LEFT JOIN loans AS l ON b.bookid = l.bookid
           WHERE b.title = "Dracula" AND l.returneddate IS NULL
       );

       SELECT (number_of_available_books - count_non_returned_books) AS available_dracula_copies
       FROM count_dracula_books_table, non_returned_books;
       ```
     - **Total Copies of Dracula**:
       ```sql
       SELECT Title, COUNT(*) AS total_copies FROM books 
       WHERE Title = 'Dracula';
       ```
     - **Current Total Loans of Dracula**:
       ```sql
       SELECT Title, COUNT(*) AS Loans_count_Dracula FROM loans AS l
       INNER JOIN books AS b ON l.bookid = b.BookID
       WHERE Title = 'Dracula';
       ```

2. **SQL to Python-checkpoint.ipynb**
   - Description: This Jupyter notebook is a checkpoint file that may include partial progress of the main `SQL to Python.ipynb` notebook. It demonstrates how to connect to the library database using Python and execute SQL queries programmatically.
   - Usage: Open this notebook in Jupyter to review the partial progress or checkpoint of your work.

3. **SQL to Python.ipynb**
   - Description: This Jupyter notebook demonstrates how to connect to the library database using Python and execute SQL queries programmatically. It includes examples of using Python libraries such as `pandas` and `sqlalchemy` to interact with the database.
   - Usage: Open this notebook in Jupyter and run the cells to see examples of database interactions using Python.
   - Sample Code:
     - **Connecting to the Database**:
       ```python
       import pandas as pd
       from sqlalchemy import create_engine

       # Create an engine instance
       engine = create_engine('mysql+mysqlconnector://root:password@localhost/LibraryDB')

       # Connect to the database
       connection = engine.connect()
       ```
     - **Querying the Database**:
       ```python
       query = "SELECT * FROM Books"
       books_df = pd.read_sql(query, connection)
       books_df.head()
       ```
     - **Generating Reports**:
       ```python
       query = """
       SELECT b.Title, COUNT(l.LoanID) AS CheckoutCount
       FROM Books AS b
       INNER JOIN Loans AS l ON b.BookID = l.BookID
       GROUP BY b.Title
       ORDER BY CheckoutCount DESC
       LIMIT 5;
       """
       popular_books_df = pd.read_sql(query, connection)
       popular_books_df
       ```

## Setting Up the Library Database

1. **Create the Database**
   ```sql
   CREATE DATABASE LibraryDB;
   USE LibraryDB;
