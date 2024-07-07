/******************* In the Library *********************/

/*******************************************************/
/* find the number of availalbe copies of Dracula      */
/*******************************************************/
CREATE VIEW count_dracula_books_table as (
SELECT COUNT(*) as number_of_avalible_books FROM books
WHERE title = "Dracula");

CREATE VIEW non_returned_books AS(
SELECT count(*) as count_non_returned_books FROM books as b
LEFT JOIN loans as l ON b.bookid = l.bookid
WHERE b.title = "Dracula" and l.returneddate is null);

SELECT (number_of_avalible_books- count_non_returned_books )AS Avalible_Dracula_copies FROM count_dracula_books_table, non_returned_books;


#### total copies of drucala ****
select Title , count(*) as total_copies from books 
where Title  = 'Dracula';

/* current total loans of the book */ # loan Counter of Dracula book
select Title , count(*) as Loans_count_Dracula from loans as l
inner join books AS b ON l.bookid = b.BookID
where Title  = 'Dracula' and ReturnedDate IS NOT NULL;

/*******************************************************/
/* Add new books to the library                        */
/*******************************************************/

## Insert Your values
select * from books;
insert into books ( bookid, title, author, published, barcode)
VALUES 
( 201,'1984', 'George Orwell', 1949, 1234567890124),
( 202,'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 1234567890125),
(202,'Pride and Prejudice', 'Jane Austen', 1813, 1234567890126);

/*******************************************************/
/* Check out Books  ,-- Least loaned book                               */
/*******************************************************/ 
SELECT title ,count(*) AS Checkout_count FROM loans as l 
INNER JOIN books AS b ON b.BookID = l.BookID 
group by b.Title
order by Checkout_count ASC;

/********************************************************/
/* Check books for Due back                             */
/* generate a report of books due back on July 13, 2020 */
/* with patron contact information                      */
/********************************************************/
select B.Title ,P.FirstName ,P.Email ,b.Barcode,l.DueDate,l.ReturnedDate from books as b 
INNER JOIN loans as l ON l.BOOKID = b.BOOKID 
INNER JOIN patrons AS p ON l.PatronID = p.PatronID
WHERE l.DueDate = '2020-07-13';

/******************************************************/
/* Return books to the library                         */
/*******************************************************/
SELECT b.Title, COUNT(l.BookID) AS CountReturnedBooks
FROM Books AS b
INNER JOIN Loans AS l ON l.BookID = b.BookID
WHERE l.ReturnedDate IS NOT NULL
GROUP BY b.Title;
/***********************************************/
 /**Return books to the library  (6435968624)*
/*******************************************************/
SELECT * from books as b 
INNER JOIN Loans AS l ON l.BookID = b.BookID
WHERE l.ReturnedDate IS NOT NULL AND b.barcode = '6435968624';

/* Encourage Patrons to check out books                */
/* generate a report of showing 10 patrons who have
checked out the fewest books.                          */
/*******************************************************/
select p.FirstName,count(*) as lowest_checkout from loans as l
inner join patrons as p ON p.patronid = l.patronid 
group by p.patronid ,p.FirstName
order by lowest_checkout ASC
limit 10 ;

/*******************************************************/
/* Find books to feature for an event                  
 create a list of books from 1890s that are
 currently available                                    */
/*******************************************************/
select b.Published ,b.Title ,l.ReturnedDate from books as b 
left join loans as l ON L.BookID = L.BookID 
where b.Published like '189%' and l.ReturnedDate is not null ;


/*******************************************************/
/* Book Statistics 
/* create a report to show how many books were 
published each year.                                    */
/*******************************************************/
SELECT Published, COUNT(DISTINCT(Title)) AS TotalNumberOfPublishedBooks FROM Books
GROUP BY Published
ORDER BY TotalNumberOfPublishedBooks DESC;


/*************************************************************/
/* Book Statistics                                           */
/* create a report to show 5 most popular Books to check out */
/*************************************************************/
SELECT b.Title, count(loanid) as CheckoutCount  FROM BOOKS AS b
INNER JOIN LOANS AS l ON b.bookid = l.bookid 
group by b.Title 
order by CheckoutCount DESC
limit 5;







