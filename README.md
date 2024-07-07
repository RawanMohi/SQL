# Library Database SQL Scripts and Python Notebooks

This repository contains SQL scripts and Jupyter notebooks for managing and analyzing a library database. The scripts include setting up views and generating various reports related to the library's books and loans.

## Overview

Managing a library involves keeping track of numerous details such as book inventories, loan records, and overdue books. This repository provides SQL scripts to facilitate these tasks by automating the creation of database views and generating useful reports. Additionally, it includes Jupyter notebooks to demonstrate how to interact with the library database programmatically using Python.

## Files in this Repository

1. **Final SQL.sql**
   - **Description**: This file contains a collection of SQL scripts designed to create views and generate detailed reports related to the library's books and loans. The scripts help in finding the number of available copies of specific books, counting non-returned books, adding new books, and generating statistics on book loans.
   - **Usage**: Run this script after setting up the database schema and inserting initial data to create views and generate various reports.
   - **Details**: The script is divided into multiple sections, each performing a specific task such as creating views, counting books, and generating loan statistics.

2. **SQL to Python-checkpoint.ipynb**
   - **Description**: This Jupyter notebook is a checkpoint file that may include partial progress of the main `SQL to Python.ipynb` notebook. It demonstrates how to connect to the library database using Python and execute SQL queries programmatically.
   - **Usage**: Open this notebook in Jupyter to review the partial progress or checkpoint of your work.
   - **Details**: This file is typically used to save interim progress while working on the main notebook.

3. **SQL to Python.ipynb**
   - **Description**: This Jupyter notebook demonstrates how to connect to the library database using Python and execute SQL queries programmatically. It includes examples of using Python libraries such as `pandas` and `sqlalchemy` to interact with the database.
   - **Usage**: Open this notebook in Jupyter and run the cells to see examples of database interactions using Python.
   - **Details**: The notebook provides a step-by-step guide to querying the database, processing the data, and generating reports using Python.

## Sample Queries from Final SQL.sql

Here are some of the operations included in the `Final SQL.sql` script, explained in detail:

- **Count Available Copies of Dracula**:
  - **Description**: This query creates views to count the total number of "Dracula" books and those that are currently loaned out. It then calculates the number of available copies.
  - **SQL Code**:
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
  - **Description**: This query calculates the total number of "Dracula" books in the library.
  - **SQL Code**:
    ```sql
    SELECT Title, COUNT(*) AS total_copies FROM books 
    WHERE Title = 'Dracula';
    ```

- **Current Total Loans of Dracula**:
  - **Description**: This query counts the number of "Dracula" books that have been loaned out and returned.
  - **SQL Code**:
    ```sql
    SELECT Title, COUNT(*) AS Loans_count_Dracula FROM loans AS l
    INNER JOIN books AS b ON l.bookid = b.BookID
    WHERE Title = 'Dracula' AND ReturnedDate IS NOT NULL;
    ```

- **Add New Books to the Library**:
  - **Description**: This query inserts new book records into the `books` table.
  - **SQL Code**:
    ```sql
    INSERT INTO books (bookid, title, author, published, barcode)
    VALUES 
    (201, '1984', 'George Orwell', 1949, 1234567890124),
    (202, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 1234567890125),
    (203, 'Pride and Prejudice', 'Jane Austen', 1813, 1234567890126);
    ```

- **Least Loaned Book**:
  - **Description**: This query finds the book with the least number of checkouts.
  - **SQL Code**:
    ```sql
    SELECT title, COUNT(*) AS Checkout_count 
    FROM loans AS l 
    INNER JOIN books AS b ON b.BookID = l.BookID 
    GROUP BY b.Title 
    ORDER BY Checkout_count ASC;
    ```

## Setting Up the Library Database

1. **Create the Database**
   - **SQL Command**:
     ```sql
     CREATE DATABASE LibraryDB;
     USE LibraryDB;
     ```

2. **Run the Schema Script**
   - Execute the SQL schema script (if available) to create the necessary tables and relationships.

3. **Insert Initial Data**
   - Execute the SQL data insertion script (if available) to populate the database with initial data.

4. **Run the Final SQL Script**
   - Execute the `Final SQL.sql` script to create views and generate reports:
     ```bash
     mysql -u root -p LibraryDB < path/to/Final SQL.sql
     ```

## Notes

- Ensure that MySQL is installed and running on your system.
- Adjust file paths in the command examples to match the actual locations of your SQL files.
- Use a MySQL client (e.g., MySQL Workbench, phpMyAdmin) for easier management of your database.

By following the instructions in this README, you can set up and manage the library database, run various queries, and generate useful reports for library management.
