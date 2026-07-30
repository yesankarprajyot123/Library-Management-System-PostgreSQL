select * from Books;
select * from Branch;
select * from Employees;
select * from Issued_status;
select * from return_status;
select * from Members;

-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO Books(isbn,book_title,category,rental_price,status,author,publisher)
VALUES('978-1-60129-456-2','To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '125 Main St'
WHERE member_id ='C101';

select * from Members;

-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

Select * from issued_status
WHERE issued_id ='IS121';

DELETE FROM issued_status
WHERE issued_id ='IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

select * from issued_status
Where issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

select 
issued_emp_id
-- count(issued_id) as total_book
from Issued_status
Group by issued_emp_id
HAVING COUNT(issued_id)>1;

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

CREATE TABLE Book_cnts
as 
select 
b.isbn,
b.book_title,
COUNT(ist.issued_id) as no_issued
from Books as b 
JOIN 
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1,2 ;

select * from book_cnts;

-- Task 7. **Retrieve All Books in a Specific Category:

select * from Books
where category = 'Classic';

-- Task 8: Find Total Rental Income by Category:

Select b.category,
SUM(b.rental_price),
COUNT(*)
FROM Books as b
JOIN 
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1;


-- Task 9. **List Members Who Registered in the Last 180 Days**:

select * from Members;

INSERT INTO Members(member_id,member_name,member_address,reg_date)
VALUES
('C126','sam','145 Main St','2026-05-01'),
('C160','John','133 Main St','2026-04-01');

DELETE FROM members
WHERE member_id IN ('C126', 'C160');

UPDATE Members
SET reg_date= '2026-05-01'
WHERE member_id = 'C118';

UPDATE Members
SET reg_date = '2026-04-01'
WHERE member_id = 'C119';

select * from Members
WHERE reg_date >= Current_Date -Interval '180 Days';

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:

Select 
e1.*,
b.manager_id,
e2.emp_name as manager
from Employees as e1
JOIN 
branch as b
ON b.branch_id = e1.branch_id
JOIN 
Employees as e2
ON b.manager_id=e2.Emp_id;


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7 USD:

create table  Books_price_greater_than_seven 
as
select * from Books
 where rental_price > 7;

select * from Books_price_greater_than_seven;


-- Task 12: Retrieve the List of Books Not Yet Returned

select 
DISTINCT ist.issued_book_name
From Issued_status as ist
LEFT JOIN 
return_status as rs
ON ist.Issued_id = rs.Issued_id
where rs.return_id IS NULL;

select * from return_status;



