--change file path
spool 'C:\Users\xyx\Desktop\OracleDB-Project\project2.txt'
--Include the full path.This will start logging to the specified file.

set echo on
--this will ensure that all input and output is logged to the file.

--Project 2

--PART IA

--DROP TABLES

DROP TABLE ORDERDETAIL_lpb;
DROP TABLE ORDER_lpb;
DROP TABLE CUSTOMER_lpb;
DROP TABLE SALESREP_lpb;
DROP TABLE PRODUCT_lpb;
DROP TABLE DEPARTMENT_lpb;
DROP TABLE COMMISSION_lpb;
DROP TABLE PRODCAT_lpb;

CREATE TABLE PRODCAT_lpb (
ProdCatId number(1),
ProdCatName Varchar(25) not null,
primary key(ProdcatId)
);



CREATE TABLE COMMISSION_lpb (
CommClass char(1),
CommRate number(5,2) not null,
primary key(CommClass)
);




CREATE TABLE DEPARTMENT_lpb (
DeptId number(2),
DeptName Varchar(20) not null,
primary key(DeptId)
);



CREATE TABLE PRODUCT_lpb (
ProdId number(3),
ProdName Varchar(25) not null,
ProdCatId number(1) not null,
ProdPrice number(7,2) not null,
primary key(ProdId),
foreign key(ProdCatId) REFERENCES PRODCAT_lpb
);

COLUMN producprice FORMAT $999.00


CREATE TABLE SALESREP_lpb (
SalesRepId number(2),
SalesRepLName Varchar(10) not null,
SalesRepFName Varchar(10) not null,
CommClass char(1) not null,
DeptId number(2) not null,
primary key(SalesRepId),
foreign key(CommClass) REFERENCES COMMISSION_lpb,
foreign key(DeptID) REFERENCES DEPARTMENT_lpb
);



CREATE TABLE CUSTOMER_lpb (
CustId varchar(5), 
CustFName Varchar(10) not null,
CustLName Varchar(10) not null,
CustPhone char(10),
SalesRepId number(2) not null,
primary key(CustId),
foreign key(SalesRepId) REFERENCES SALESREP_lpb
);




CREATE TABLE ORDER_lpb (
OrderId number(3), 
OrderDate Date not null,
CustId Varchar(5) not null,  
primary key(OrderId),
foreign key(CustId) REFERENCES CUSTOMER_lpb
);




CREATE TABLE ORDERDETAIL_lpb (
OrderId number(3), 
ProdId number(3),
ProdQty number(3) not null,  
ProdPrice number(7,2) not null,
primary key(OrderId, ProdId),
foreign key(OrderId) REFERENCES ORDER_lpb, 
foreign key(ProdId) REFERENCES PRODUCT_lpb
);

COMMIT;

--PartIB 
--Describe tables to see structure

DESCRIBE PRODCAT_lpb
DESCRIBE COMMISSION_lpb
DESCRIBE DEPARTMENT_lpb
DESCRIBE PRODUCT_lpb
DESCRIBE SALESREP_lpb
DESCRIBE CUSTOMER_lpb
DESCRIBE ORDER_lpb
DESCRIBE ORDERDETAIL_lpb

--Part IIA

INSERT INTO PRODCAT_lpb
VALUES (1, 'Hand Tools');

INSERT INTO PRODCAT_lpb
VALUES (2, 'Power Tools');

INSERT INTO PRODCAT_lpb
VALUES (3, 'Measuring Tools');

INSERT INTO PRODCAT_lpb
VALUES (4, 'Fastners');

INSERT INTO PRODCAT_lpb
VALUES (5, 'Hardware');

INSERT INTO PRODCAT_lpb
VALUES (6, 'Misc');



INSERT INTO COMMISSION_lpb
VALUES ('A', 0.10);

INSERT INTO COMMISSION_lpb
VALUES ('B', 0.08);

INSERT INTO COMMISSION_lpb
VALUES ('C', 0.05);

INSERT INTO COMMISSION_lpb
VALUES ('Z', 0.00);



INSERT INTO DEPARTMENT_lpb
VALUES (10, 'Store Sales');

INSERT INTO DEPARTMENT_lpb
VALUES (14, 'Corp Sales');

INSERT INTO DEPARTMENT_lpb
VALUES (16, 'Web Sales');




INSERT INTO PRODUCT_lpb
VALUES (121, 'BD Hammer', 1, 7.00);

INSERT INTO PRODUCT_lpb
VALUES (123, 'Acme Pry Bar', 1, 5.00);

INSERT INTO PRODUCT_lpb
VALUES (124, 'Acme Hammer', 1, 6.50);

INSERT INTO PRODUCT_lpb
VALUES (228, 'Makita Power Drill', 2, 65.00);

INSERT INTO PRODUCT_lpb
VALUES (229, 'BD Power Drill', 2, 59.00);

INSERT INTO PRODUCT_lpb
VALUES (235, 'Makita Power Drill', 2, 65.00);

INSERT INTO PRODUCT_lpb
VALUES (380, 'Acme Yard Stick', 3, 1.25);

INSERT INTO PRODUCT_lpb
VALUES (407, '1# BD Screws', 4, 4.25);

INSERT INTO PRODUCT_lpb
VALUES (480, '1# BD Nails', 4, 3.00);

INSERT INTO PRODUCT_lpb
VALUES (535, 'Schlage Door Knob', 5, 7.50);

INSERT INTO PRODUCT_lpb
VALUES (610, '3M Duct Tape', 6, 1.75);

INSERT INTO PRODUCT_lpb
VALUES (618, '3M Masking Tape', 6, 1.25);




INSERT INTO SALESREP_lpb
VALUES(8,'Price', 'Kay','C',14);

INSERT INTO SALESREP_lpb
VALUES(10,'Jones', 'Alice','A',10);

INSERT INTO SALESREP_lpb
VALUES(12,'Taylor', 'Greg','B',14);

INSERT INTO SALESREP_lpb
VALUES(14,'Day', 'Sara','Z',10);

INSERT INTO SALESREP_lpb
VALUES(20,'Jackson', 'Bob','B',10);

INSERT INTO SALESREP_lpb
VALUES(22,'Moore', 'Micah','Z',16);



INSERT INTO CUSTOMER_lpb
VALUES('A120', 'Jane', 'Adams', '8175553434', 12);

INSERT INTO CUSTOMER_lpb
VALUES('B200', 'Ann', 'Brown', '9725557979', 8);

INSERT INTO CUSTOMER_lpb
VALUES('G070', 'Kate', 'Green', '8175551034', 20);

INSERT INTO CUSTOMER_lpb
(CustId,CustFName,CustLName,SalesRepId)
VALUES('J090', 'Tim', 'Jones', 14);    

INSERT INTO CUSTOMER_lpb
VALUES('S100', 'John', 'Smith', '2145551212', 10);

INSERT INTO CUSTOMER_lpb
(CustId,CustFName,CustLName,SalesRepId)
VALUES('S120', 'Nicole', 'Sims', 22); 


INSERT INTO ORDER_lpb
VALUES(100, '24-JAN-22', 'S100');

INSERT INTO ORDER_lpb
VALUES(101, '25-JAN-22', 'A120');

INSERT INTO ORDER_lpb
VALUES(102, '25-JAN-22', 'J090');

INSERT INTO ORDER_lpb
VALUES(103, '26-JAN-22', 'B200');

INSERT INTO ORDER_lpb
VALUES(104, '26-JAN-22', 'S100');

INSERT INTO ORDER_lpb
VALUES(105, '26-JAN-22', 'B200');

INSERT INTO ORDER_lpb
VALUES(106, '27-JAN-22', 'G070');

INSERT INTO ORDER_lpb
VALUES(107, '27-JAN-22', 'J090');

INSERT INTO ORDER_lpb
VALUES(108, '27-JAN-22', 'S120');


INSERT INTO ORDERDETAIL_lpb
VALUES(100, 121, 2, 8.00);

INSERT INTO ORDERDETAIL_lpb
VALUES(100, 228, 1, 65.00);

INSERT INTO ORDERDETAIL_lpb
VALUES(100, 480, 2, 3.00);

INSERT INTO ORDERDETAIL_lpb
VALUES(100, 407, 1, 4.25);

INSERT INTO ORDERDETAIL_lpb
VALUES(101, 610, 200, 1.75);

INSERT INTO ORDERDETAIL_lpb
VALUES(101, 618, 100, 1.25);

INSERT INTO ORDERDETAIL_lpb
VALUES(102, 380, 2, 1.25);

INSERT INTO ORDERDETAIL_lpb
VALUES(102, 121, 1, 7.00);

INSERT INTO ORDERDETAIL_lpb
VALUES(102, 535, 4, 7.50);

INSERT INTO ORDERDETAIL_lpb
VALUES(103, 121, 50, 7.00);

INSERT INTO ORDERDETAIL_lpb
VALUES(103, 123, 20, 6.25);

INSERT INTO ORDERDETAIL_lpb
VALUES(104, 229, 1, 50.00);

INSERT INTO ORDERDETAIL_lpb
VALUES(104, 610, 200, 1.75);

INSERT INTO ORDERDETAIL_lpb
VALUES(104, 380, 2, 1.25);

INSERT INTO ORDERDETAIL_lpb
VALUES(104, 535, 4, 7.50);

INSERT INTO ORDERDETAIL_lpb
VALUES(105, 610, 200, 1.75);

INSERT INTO ORDERDETAIL_lpb
VALUES(105, 123, 40, 5.00);

INSERT INTO ORDERDETAIL_lpb
VALUES(106, 124, 1, 6.50);

INSERT INTO ORDERDETAIL_lpb
VALUES(107, 229, 1, 59.00);

INSERT INTO ORDERDETAIL_lpb
VALUES(108, 235, 1, 65.00);


COMMIT;


--PART IIB

SELECT * FROM PRODCAT_lpb;
SELECT * FROM COMMISSION_lpb;
SELECT * FROM DEPARTMENT_lpb;
SELECT * FROM PRODUCT_lpb;
SELECT * FROM SALESREP_lpb;
SELECT * FROM CUSTOMER_lpb;
SELECT * FROM ORDER_lpb;
SELECT * FROM ORDERDETAIL_lpb;


--Part III

UPDATE CUSTOMER_lpb
SET CustPhone = '2145551234'
WHERE CustId = 'B200';

INSERT INTO CUSTOMER_lpb
(CustId,CustFName,CustLName,SalesRepId)
VALUES('G119','Amanda', 'Green',14);

UPDATE ORDER_lpb
SET OrderDate = '28-JAN-22'
WHERE OrderId = 108;

INSERT INTO ORDER_lpb
VALUES(109, '28-JAN-22', 'G119');

UPDATE ORDERDETAIL_lpb
SET ProdPrice = 62.00
WHERE OrderId = 108 AND ProdId = 235;

INSERT INTO ORDERDETAIL_lpb
VALUES(108,407, 1, 5.25);

INSERT INTO ORDERDETAIL_lpb
VALUES(108, 618, 2, 2.15);

INSERT INTO ORDERDETAIL_lpb
VALUES(109, 121, 1, 8.25);

INSERT INTO ORDERDETAIL_lpb
VALUES(109, 480, 1, 3.75);

COMMIT;

--Part IV

SELECT * FROM PRODCAT_lpb
ORDER BY ProdCatId;

SELECT * FROM COMMISSION_lpb
ORDER BY CommClass;

SELECT * FROM DEPARTMENT_lpb
ORDER BY DeptId;

SELECT * FROM PRODUCT_lpb
ORDER BY ProdId;

SELECT * FROM SALESREP_lpb
ORDER BY SalesRepId;

SELECT * FROM CUSTOMER_lpb
ORDER BY CustId;

SELECT * FROM ORDER_lpb
ORDER BY OrderId;

SELECT * FROM ORDERDETAIL_lpb
ORDER BY OrderId, ProdId;




set echo off
--This will turn off logging.
spool off
-- This will close the file.
