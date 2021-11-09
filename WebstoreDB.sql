/* All Tables & Indexes Declared Below */
/* Product Table AT THE TIME OF FINISHING, UNABLE TO RECREATE*/
DROP TABLE PRODUCTS;

CREATE TABLE PRODUCTS (
ProductSKU VARCHAR2(10) PRIMARY KEY NOT NULL,
Price DECIMAL(7,2),
QUANTITY NUMBER(3),
FOREIGN KEY (ProductSKU) REFERENCES DISCOGRAPHY(ProductSKU),

CHECK(Price>0)
);

/*Insert starting values into Products table*/
INSERT INTO PRODUCTS VALUES('MUS-1','20.0','5'); 
INSERT INTO PRODUCTS VALUES('MUS-2','20.0','2');
INSERT INTO PRODUCTS VALUES('MUS-3','15.0','1');
INSERT INTO PRODUCTS VALUES('MUS-4','10.0','1');
INSERT INTO PRODUCTS VALUES('MUS-5','15.0','3');
INSERT INTO PRODUCTS VALUES('MUS-6','10.0','7');
INSERT INTO PRODUCTS VALUES('MUS-7','11.0','2');
INSERT INTO PRODUCTS VALUES('MUS-8','25.0','4');
INSERT INTO PRODUCTS VALUES('MUS-9','35.0','1');
INSERT INTO PRODUCTS VALUES('MUS-10','20.0','5');
INSERT INTO PRODUCTS VALUES('MUS-11','10.0','14');
INSERT INTO PRODUCTS VALUES('MUS-12','20.0','5');
INSERT INTO PRODUCTS VALUES('MUS-13','16.0','10');
INSERT INTO PRODUCTS VALUES('MUS-14','17.0','12');
INSERT INTO PRODUCTS VALUES('MUS-15','20.0','3');
INSERT INTO PRODUCTS VALUES('MUS-16','22.0','5');
INSERT INTO PRODUCTS VALUES('MUS-17','10.0','9');
INSERT INTO PRODUCTS VALUES('MUS-18','8.0','10');
INSERT INTO PRODUCTS VALUES('MUS-19','12.0','25');
INSERT INTO PRODUCTS VALUES('MUS-20','50.0','2');



/*Discography Table*/
DROP TABLE DISCOGRAPHY;

CREATE TABLE DISCOGRAPHY (
ProductSKU VARCHAR2(10) PRIMARY KEY NOT NULL,
ReleaseName VARCHAR2(50),
ArtistName VARCHAR2(30),
ReleaseType VARCHAR2(20),
Genre VARCHAR2(20)

);

/*Insert starting values into Discography table*/
INSERT INTO DISCOGRAPHY VALUES('MUS-1','Merveilles','MALICE MIZER','Album','Rock');
INSERT INTO DISCOGRAPHY VALUES('MUS-2','Bara no Seidou', 'MALICE MIZER', 'Album','Darkwave');
INSERT INTO DISCOGRAPHY VALUES('MUS-3','Macabre', 'Dir en Grey', 'Album', 'Rock');
INSERT INTO DISCOGRAPHY VALUES('MUS-4','Missa', 'Dir en Grey', 'Mini-Album', 'Rock');
INSERT INTO DISCOGRAPHY VALUES('MUS-5','Gauze', 'Dir en Grey', 'Album', 'Rock');
INSERT INTO DISCOGRAPHY VALUES('MUS-6','Singles', 'Luna Sea', 'Compilation Album', 'Rock');
INSERT INTO DISCOGRAPHY VALUES('MUS-7','Lunacy', 'Luna Sea', 'Album', 'Rock');
INSERT INTO DISCOGRAPHY VALUES('MUS-8','Blue Blood', 'X-Japan', 'Album', 'Metal');
INSERT INTO DISCOGRAPHY VALUES('MUS-9','EVE OF THE REVOLUTiON', 'Yura', 'Single', 'J-Pop');
INSERT INTO DISCOGRAPHY VALUES('MUS-10','Holy Grail', 'Versailles', 'Album', 'Symphonic Metal');
INSERT INTO DISCOGRAPHY VALUES('MUS-11','Jubilee', 'Versailles', 'Album', 'Symphonic Metal');
INSERT INTO DISCOGRAPHY VALUES('MUS-12','Wind', 'Heize', 'EP', 'K-Pop');
INSERT INTO DISCOGRAPHY VALUES('MUS-13','Late Autumn','Heize','EP','K-Pop');
INSERT INTO DISCOGRAPHY VALUES('MUS-14','Pageant','Moi dix Mois','Single','Gothic Metal');
INSERT INTO DISCOGRAPHY VALUES('MUS-15','Dialogue Symphonie','Moi dix Mois','Single','Gothic Metal');
INSERT INTO DISCOGRAPHY VALUES('MUS-16','Lamentful Miss','Moi dix Mois','Single','Gothic Metal');
INSERT INTO DISCOGRAPHY VALUES('MUS-17','Shadows Temple','Moi dix Mois','Single','Gothic Metal');
INSERT INTO DISCOGRAPHY VALUES('MUS-18','Horror','Xaa Xaa','Single','Metal');
INSERT INTO DISCOGRAPHY VALUES('MUS-19','Nosferatu', 'KAMIJO', 'Single','Symphonic Metal');
INSERT INTO DISCOGRAPHY VALUES('MUS-20','Material Pain','Phantasmagoria','Single','Rock');


/*Accounts Table*/
DROP TABLE ACCOUNTS;

CREATE TABLE ACCOUNTS(

CustomerID NUMBER(4) PRIMARY KEY NOT NULL,
CustomerName VARCHAR2(50),
Street VARCHAR2(40),
City VARCHAR2(30),
CState CHAR(2),
Zip NUMBER(10),
EMail VARCHAR(30)

);

/*Insert starting values into accounts table*/
INSERT INTO ACCOUNTS VALUES('1','Johnny Doe','123 Example Street','Buffalo','NY','12345','example@gmail.com');
INSERT INTO ACCOUNTS VALUES('2','Eros S.M.','2436 Water Crk','Austin','TX','26362','erossm@gmail.com');
INSERT INTO ACCOUNTS VALUES('3','Sinjin H','5633 High Ave','Los Angeles','CA','96511','sinjindinh@yahoo.com');
INSERT INTO ACCOUNTS VALUES('4','Alexander R','471 Animal Ln','Indianapolis','IN','46222','arod@iu.edu');
INSERT INTO ACCOUNTS VALUES('5','Jae N','678 Cheese Av','Trenton','NJ','76538','jnahmy@yahoo.com');

/*Orders Table  */
DROP TABLE ORDERS;

CREATE TABLE ORDERS(

OrderID NUMBER(5) PRIMARY KEY NOT NULL,
CustomerID NUMBER(4),
DateOrdered DATE,
OrderTotal DECIMAL(7,2),

FOREIGN KEY (CustomerID) REFERENCES ACCOUNTS(CustomerID),
CHECK(OrderTotal>0.0)
);

/*Insert starting values into ORDERS table*/

INSERT INTO ORDERS VALUES('1','4','10-JAN-21','145.0'); /*MUS-1,2,9,10,20 Alex*/
INSERT INTO ORDERS VALUES('2','4','16-JAN-21','15.0'); /*MUS-3* Alex*/
INSERT INTO ORDERS VALUES('3','1','17-JAN-21','16.0'); /*MUS-13* Johnny*/
INSERT INTO ORDERS VALUES('4','2','19-JAN-21','25.0'); /*MUS-8  Eros*/
INSERT INTO ORDERS VALUES('5','5','22-JAN-21','36.0'); /*MUS-12 13 Jae*/
INSERT INTO ORDERS VALUES('6','3','03-FEB-21','54.0'); /*MUS-15, 16, 19 Sinjin*/


/*ORDER_PRODUCTS table*/
DROP TABLE ORDER_PRODUCTS;

CREATE TABLE ORDER_PRODUCTS(

OrderID NUMBER(5),
ProductSKU VARCHAR2(10),

FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID),
FOREIGN KEY (ProductSKU) REFERENCES PRODUCTS(ProductSKU)

);

/*Insert starting values into ORDER_PRODUCTS*/
INSERT INTO ORDER_PRODUCTS VALUES('1','MUS-1');
INSERT INTO ORDER_PRODUCTS VALUES('1','MUS-2');
INSERT INTO ORDER_PRODUCTS VALUES('1','MUS-9');
INSERT INTO ORDER_PRODUCTS VALUES('1','MUS-10');
INSERT INTO ORDER_PRODUCTS VALUES('1','MUS-20');
INSERT INTO ORDER_PRODUCTS VALUES('2','MUS-3');
INSERT INTO ORDER_PRODUCTS VALUES('3','MUS-13');
INSERT INTO ORDER_PRODUCTS VALUES('4','MUS-8');
INSERT INTO ORDER_PRODUCTS VALUES('5','MUS-12');
INSERT INTO ORDER_PRODUCTS VALUES('5','MUS-13');
INSERT INTO ORDER_PRODUCTS VALUES('6','MUS-15');
INSERT INTO ORDER_PRODUCTS VALUES('6','MUS-16');
INSERT INTO ORDER_PRODUCTS VALUES('6','MUS-19');

/*Creating a Table from an existing table. Made to anticipate more KPop CDs due to their high demand. They will require their own table*/
CREATE TABLE KPopReleases 
AS (SELECT ReleaseName, ArtistName, ReleaseType
FROM DISCOGRAPHY
WHERE Genre = 'K-Pop');

DROP TABLE KPopReleases;

/*AutoNumber Sequence. Not connected to any tables*/
CREATE SEQUENCE account_seq
MINVALUE 1
MAXVALUE 999999
INCREMENT BY 1
NOCACHE
NOCYCLE;

/* Indexes*/

/*Index for products on products table*/
CREATE INDEX Stock ON PRODUCTS (ProductSKU, Price);

/*Indexes for Musical Artists, Releases, and Genres for individual filtering*/
CREATE INDEX Genres ON DISCOGRAPHY (Genre);
CREATE INDEX Music ON DISCOGRAPHY (ReleaseName);
CREATE INDEX Artists ON DISCOGRAPHY (ArtistName);

/*Index for Accounts in order for quick lookup*/
CREATE INDEX RegisteredAccounts ON ACCOUNTS (CustomerID, CustomerName, EMail);

/*--------------------------Views and Related Queries----------------------------------*/

/*First View which shows all Albums in the web stores discography */
DROP VIEW ALBUMS;

CREATE VIEW ALBUMS AS
SELECT ProductSKU, ReleaseName, ArtistName, ReleaseType, Genre
FROM DISCOGRAPHY
WHERE ReleaseType = 'Album';

/*Second view which shows all expensive releases ($25 or more)*/
DROP VIEW EXPENSIVE_RELEASES;

CREATE VIEW EXPENSIVE_RELEASES AS
SELECT ProductSKU, Price, Quantity
FROM PRODUCTS
WHERE PRICE > 25.0;

/*Third View which shows all Orders made in January*/
DROP VIEW JAN_ORDERS;

CREATE VIEW JAN_ORDERS AS
SELECT OrderID, DateOrdered
FROM ORDERS
WHERE DateOrdered LIKE '%-JAN-%';

/*Fourth View which shows all music releases that are of the rock genre in the web stores discography */
DROP VIEW ROCK_RELEASES;

CREATE VIEW ROCK_RELEASES AS
SELECT ProductSKU, ReleaseName, ArtistName, ReleaseType, Genre
FROM DISCOGRAPHY
WHERE Genre = 'Rock';

/*Fifth View which shows all releases that are cheaply priced (less than $10)*/
DROP VIEW CHEAP_RELEASES;

CREATE VIEW CHEAP_RELEASES AS
SELECT ProductSKU, Price, Quantity
FROM PRODUCTS
WHERE PRICE < 10.0;

/*----------------Queries-------------------------------*/

/*First String Function - CONCAT in order to concatanate all registered accounts addresses */
SELECT CustomerID, CustomerName, CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(Street, ', '), City),', '), CState),' '), Zip) AS CustomerAddress
FROM ACCOUNTS;

/*Second String Function - CONCAT artist and release names in order to format all rows to be easily readable  */
SELECT (CONCAT(CONCAT(ArtistName, ' - '), ReleaseName)) AS FormattedRelease
FROM DISCOGRAPHY;

/*First Numeric Function (Multiplication *)- Returns the total value of all Releases multipled by their quantity if quantity is more than 1. Used to find out the total
value of current product stock of one specific item.*/
SELECT ProductSKU, Price, Quantity, (Price*Quantity) AS Value
FROM PRODUCTS
WHERE Quantity > 1;

/*GROUP BY Query to count each available release and grouping it to its respective artist */
SELECT ArtistName, COUNT(ReleaseName) AS BandReleases
FROM DISCOGRAPHY
GROUP BY ArtistName;

/*Second Group By Query with Having. Used to return the total amount of orders a customer (e.g. Customer ID #4) has placed */
SELECT CustomerID, COUNT(OrderID) AS CustomerOrders
FROM ORDERS
GROUP BY CustomerID
HAVING CustomerID = 4;

/*First Date Function and second numeric function - Get Current date and subtract current date from the first order date in February.*/
SELECT DateOrdered, (ROUND(CURRENT_DATE - DateOrdered)) AS HowLongAgo
FROM ORDERS
WHERE OrderID = 6;

/*Second Date Function - Get current date and subtract current dates month from first sale ever made to see how many months ago was the first sale*/
SELECT DateOrdered, EXTRACT(MONTH FROM CURRENT_DATE)- EXTRACT(MONTH FROM DateOrdered) AS FirstSale
FROM ORDERS
WHERE OrderID = 1;

/*Decode Function meant to signify which ProductSKUs are IDs to CDs w/ unusual genres in the web stores stock. 
Also uses a Full Outer Join to return values not in PRODUCTS table*/
SELECT PRODUCTS.ProductSKU,DISCOGRAPHY.ReleaseName, DISCOGRAPHY.Genre, DECODE(PRODUCTS.ProductSKU, 'MUS-2', 'Unusual', 'MUS-9', 'Unusual',
'MUS-12', 'Unusual','MUS-13', 'Unusual' , 'Usual') UnusualCD
FROM PRODUCTS
INNER JOIN DISCOGRAPHY ON PRODUCTS.ProductSKU = DISCOGRAPHY.ProductSKU;

/*Assuming each order ID only contains a quantity of 1 CD (hence the lack of a quantity field), 
show price of ProductSKU that is being added to an Order ID*/
SELECT ORDER_PRODUCTS.OrderID, ORDER_PRODUCTS.ProductSKU, PRODUCTS.Price
FROM ORDER_PRODUCTS
INNER JOIN PRODUCTS ON ORDER_PRODUCTS.ProductSKU = PRODUCTS.ProductSKU
ORDER BY ORDERID;

/*Outer Join to combine ACCOUNTS and ORDERS tables in order to show which Order IDs (if any) are tied to Customer IDs*/
SELECT ACCOUNTS.CustomerID, ACCOUNTS.CustomerName, ORDERS.OrderID
FROM ACCOUNTS
FULL OUTER JOIN ORDERS ON ACCOUNTS.CustomerID = ORDERS.CustomerID;

/*Average Price of CDs*/
SELECT AVG(Price)
FROM PRODUCTS;

/*First Query with Subquery. Returns all CDs in PRODUCTS table that are less than the average price for CDs*/
SELECT ProductSKU, Price
FROM PRODUCTS
WHERE PRICE < (
SELECT AVG(Price)
FROM PRODUCTS)
GROUP BY ProductSKU, Price;

/*Second Query with Subquery. Returns all CDs in PRODUCTS table that are more than the average price for CDs */
SELECT ProductSKU, Price
FROM PRODUCTS
WHERE PRICE > (
SELECT AVG(Price)
FROM PRODUCTS)
GROUP BY ProductSKU, Price;

/*--------------------------------Table/View Modifying-------------------------------*/

/*Insert a new Rock single into Rock_Releases View. Fulfills Insert through a view requirement*/
INSERT INTO ROCK_RELEASES VALUES('MUS-21', 'Cage', 'Dir en Grey', 'Single', 'Rock');

/*Update DISCOGRAPHY table because one entry may fall under rock instead of Darkwave due to its musical elements */
UPDATE DISCOGRAPHY
SET Genre = 'Rock'
WHERE ProductSKU = 'MUS-2';
SAVEPOINT GenreUpdate;

/*Alternate UPDATE script since MUS-2's musical elements also have metal elements. It's a very weird album that's hard to put a genre on!*/
UPDATE DISCOGRAPHY
SET Genre = 'Metal'
WHERE ProductSKU = 'MUS-2';
SAVEPOINT GenreUpdateAlt;

ROLLBACK TO SAVEPOINT GenreUpdate;
ROLLBACK TO SAVEPOINT GenreUpdateAlt;

/*Delete Rows from PRODUCTS due to having little quantity (not enough to sell) or price is too low and won't sell anyway 
DOESN'T WORK FOR SOME REASON*/
DELETE FROM PRODUCTS WHERE PRICE < 15.0 OR Quantity < 3;
SAVEPOINT MusicDelete;

ROLLBACK TO SAVEPOINT MusicDelete;

COMMIT;