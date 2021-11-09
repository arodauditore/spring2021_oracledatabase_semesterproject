/* Refer to WebstoreDB.sql for table creation and Midterm portion of the database system */

/* Requirement #8 - Create a custom object. CD_DETAILS object created to give more information about products in stock such as OBI, disc number, */
/* photocard and extra notes. PHOTOCARD and OBI will have True/False values in the VARCHAR2 field type due to lack of boolean data type */

CREATE TYPE CD_DETAILS AS OBJECT(
OBI VARCHAR2(4),
DISCS NUMBER(2),
PHOTOCARD VARCHAR(4),
NOTES VARCHAR(100));
/

DROP TYPE CD_DETAILS;

ALTER TABLE PRODUCTS
ADD PRODUCT_DETAILS CD_DETAILS;

/* Requirement #6 - have two stored procedures _____________________________________________________________________________*/

/* First Procedure - Logging in with customer ID emailadr */

CREATE OR REPLACE PROCEDURE ACCOUNT_LOGIN(
    CusID IN NUMBER,
    EmailAdr IN VARCHAR2)
IS
    Info ACCOUNTS%ROWTYPE;
BEGIN
    SELECT * INTO Info FROM ACCOUNTS
    WHERE CusID = CustomerID AND EmailAdr = EMAIL;
    
    dbms_output.put_line (info.CustomerName || ', ' || info.Street || ', ' || info.City || ', ' || info.CState || ', ' || info.zip );
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('This account does not exist or your information is incorrect! Please try again!');
END;
/

EXECUTE ACCOUNT_LOGIN('1','example@gmail.com');

/* Second procedure - Used to insert a new entry into the discography table*/ 

CREATE OR REPLACE PROCEDURE NEW_DISCOGRAPHY(
    PRODUCTSKU VARCHAR2,
    RELEASENAME VARCHAR2,
    ARTISTNAME VARCHAR2,
    RELEASETYPE VARCHAR2,
    GENRE VARCHAR2
)
AS
BEGIN 
    INSERT INTO DISCOGRAPHY VALUES (PRODUCTSKU,RELEASENAME, ARTISTNAME, RELEASETYPE, GENRE);
END;

EXECUTE NEW_DISCOGRAPHY('MUS-450','TestNafme', 'TestNameName', 'Single', 'Metal');

/* 4th Requirement - Create Two Triggers _____________________________________________________________________*/

/*First trigger deletes old orders after 120 days after an insert. */

CREATE OR REPLACE TRIGGER TR_ORDERS_CLEAN
    AFTER INSERT ON ORDERS
DECLARE
    SysDateDay NUMBER(15);
    ActionDate DATE;
    ActionDateDay NUMBER(5);
BEGIN 

    SELECT ACTIONDATE INTO ActionDate FROM ORDERS;

    SysDateDay := EXTRACT(DAY FROM SYSDATE);
    ActionDateDay := EXTRACT(DAY FROM ActionDate);

    DELETE FROM ORDERS
    WHERE SysDateDay - ActionDateDay >= 120;
END;
/

INSERT INTO ORDERS VALUES('7','6', '4-MAY-21', '69.0');

DROP TRIGGER TR_ORDERS_CLEAN;


/*Second trigger which always counts each band's releases after every insert*/
CREATE OR REPLACE TRIGGER TR_DISCOGRAPHY_INSERT
    AFTER INSERT ON DISCOGRAPHY
DECLARE
    ArtistName VARCHAR2(30);
    ReleaseName VARCHAR2(50);
BEGIN 
    SELECT ArtistName, COUNT(ReleaseName) AS BandReleases INTO ArtistName, ReleaseName FROM DISCOGRAPHY
    GROUP BY ArtistName;
END;
/

DROP TRIGGER TR_DISCOGRAPHY_INSERT;
INSERT INTO DISCOGRAPHY VALUES('MUS-257','Tester', 'TestBand', 'Album', 'Symphonic Metal');

/* Fulfills Requirement 1. Script meant to lower the price on any row that has a quantity over 10. Compiles correctly but doesn't change values in table*/
DECLARE
    ProductSKU VARCHAR(10);
    Quantity NUMBER(3);
    Price NUMBER(7);
    PRODUCT_DETAILS CD_DETAILS;
BEGIN
    FOR oneRow IN (SELECT * FROM PRODUCTS)
    LOOP
        ProductSKU := oneRow.PRODUCTSKU;
        Price := oneRow.PRICE;
        Quantity := oneRow.QUANTITY;
        PRODUCT_DETAILS := oneRow.PRODUCT_DETAILS;
        
        if Quantity > 10
        THEN
            UPDATE PRODUCTS SET PRICE = PRICE - 2 WHERE PRODUCTSKU = oneRow.PRODUCTSKU;
        END IF;
    
    END LOOP;
END;
/

/*Fulfills Requirement #2. Script meant to browse for CDs within a specific genre. */

DECLARE
    ProductSKU VARCHAR2(10);
    ReleaseName VARCHAR2(50);
    GENRE VARCHAR2(20);
    Price NUMBER(7);
    CURSOR DISCO_CURSOR IS SELECT DISCOGRAPHY.ProductSKU, RELEASENAME, GENRE, PRODUCTS.Price from DISCOGRAPHY 
    JOIN PRODUCTS ON PRODUCTS.PRODUCTSKU = DISCOGRAPHY.PRODUCTSKU;
    DISCO_VALS DISCO_CURSOR%ROWTYPE;
BEGIN
    FOR DISCO_VALS IN DISCO_CURSOR
    LOOP
        ProductSKU := DISCO_VALS.ProductSKU;
        ReleaseName := DISCO_VALS.RELEASENAME;
        GENRE := DISCO_VALS.GENRE;
        Price := DISCO_VALS.PRICE;
        
        
        IF GENRE = 'Gothic Metal' THEN
             dbms_output.put_line(ProductSKU || ', ' || RELEASENAME || ', ' || PRICE);
        END IF;
        
    END LOOP;
END;
/

/*Fulfills requirement #5 - Functions ____________________________________________________________*/

/* First function prints the orders of a User*/

CREATE OR REPLACE FUNCTION FN_USER_ORDERS (
    OrderNum NUMBER
)
RETURN NUMBER
IS
    OrderNumTotal NUMBER := 0;
BEGIN
    SELECT COUNT(OrderID) 
    INTO OrderNumTotal
    From ORDERS
    WHERE CustomerID = 4;
    RETURN OrderNumTotal;
END;
/

BEGIN
    DBMS_OUTPUT.put_line(FN_USER_ORDERS(4));
END;

/* Second function prints the total number of releases for a band*/

CREATE OR REPLACE FUNCTION FN_BAND_RELEASES (
    BandReleases NUMBER
)
RETURN STRING
IS
    ArtistReleases VARCHAR2(50);
BEGIN
    SELECT COUNT(ReleaseName)
    INTO ArtistReleases
    FROM DISCOGRAPHY
    WHERE ArtistName = 'MALICE MIZER';
    RETURN ArtistReleases;
END;
/

BEGIN
    DBMS_OUTPUT.put_line(FN_BAND_RELEASES(4));
END;