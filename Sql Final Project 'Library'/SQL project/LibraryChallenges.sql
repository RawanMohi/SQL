/******************* In the Library *********************/

/*******************************************************/
/* find the number of availalbe copies of Dracula      */
/*******************************************************/
..code..

/* check total copies of the book */
..code..

/* current total loans of the book */
..code..

/* total available book */
..code..



/*******************************************************/
/* Add new books to the library                        */
/*******************************************************/
..code..


/*******************************************************/
/* Check out Books                                     */
/*******************************************************/
..code..


/********************************************************/
/* Check books for Due back                             */
/* generate a report of books due back on July 13, 2020 */
/* with patron contact information                      */
/********************************************************/
..code..



/*******************************************************/
/* Return books to the library                         */
/*******************************************************/
..code..


/*******************************************************/
/* Encourage Patrons to check out books                */
/* generate a report of showing 10 patrons who have
checked out the fewest books.                          */
/*******************************************************/
..code..


/*******************************************************/
/* Find books to feature for an event                  
 create a list of books from 1890s that are
 currently available                                    */
/*******************************************************/
..code..


/*******************************************************/
/* Book Statistics 
/* create a report to show how many books were 
published each year.                                    */
/*******************************************************/
SELECT Published, COUNT(DISTINCT(Title)) AS TotalNumberOfPublishedBooks
FROM Books
GROUP BY Published
ORDER BY TotalNumberOfPublishedBooks DESC;


/*************************************************************/
/* Book Statistics                                           */
/* create a report to show 5 most popular Books to check out */
/*************************************************************/
SELECT b.Title, b.Author, b.Published, COUNT(b.Title) AS TotalTimesOfLoans
FROM Books b
JOIN Loans l
ON b.BookID = l.BookID
GROUP BY b.Title
ORDER BY 4 DESC
LIMIT 5;
