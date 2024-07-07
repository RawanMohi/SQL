# Library Database SQL Scripts

This repository contains SQL scripts for managing a library database. The scripts cover a variety of operations, including setting up the database schema, inserting initial data, and running various queries for library management tasks.

## Files in this Repository

1. **Final SQL.sql**
   - Description: This file contains SQL scripts for creating views and generating reports related to the library's books and loans. It includes commands to find the number of available copies of specific books, count non-returned books, and generate statistics on loans.
   - Usage: Run this script to create views and generate reports on the library database.

## Sample Queries from Final SQL.sql

Here are some of the operations included in the `Final SQL.sql` script:

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
