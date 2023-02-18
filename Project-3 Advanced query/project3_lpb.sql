-- change file path
spool 'C:\Users\xyz\OracleDB-Project\project3.txt'

set echo on
--Project 3

--Part I

SET LINESIZE 150 

COLUMN CustFirstName FORMAT a15
COLUMN CustLastName FORMAT a15 
COLUMN SalesRepFirstName FORMAT a18
COLUMN SalesRepLastName FORMAT a18
COLUMN "Commission Class" FORMAT a18 
COLUMN SalesRepLName FORMAT a25
COLUMN SalesRepFName FORMAT a25
COLUMN CustId FORMAT a15
COLUMN CustFName FORMAT a20
COLUMN CustLName FORMAT a20
COLUMN CustPhone FORMAT a15
COLUMN Commission_Class FORMAT a17
COLUMN Avg_price FORMAT a15
COLUMN "Cust ID" FORMAT a10
COLUMN "Customer ID" FORMAT a13

--4
INSERT INTO CUSTOMER_lpb
VALUES ('T104','Wes','Thomas','4695551215',22);

--5
INSERT INTO PRODUCT_lpb
VALUES (246,'Milwaukee Power Drill',2,179);

--6
INSERT INTO ORDER_lpb
VALUES((select (MAX(orderID)+1) from order_lpb), '28-Jan-22','T104');


INSERT INTO ORDERDETAIL_lpb
Values((select MAX(orderId) from order_lpb), 618,1, (select prodprice from product_lpb where prodID=618));

INSERT INTO ORDERDETAIL_lpb
Values((select MAX(orderId) from order_lpb), 407,2, (select prodprice from product_lpb where prodID=407));

INSERT INTO ORDERDETAIL_lpb
Values((select MAX(orderId) from order_lpb), 124,1, (select prodprice from product_lpb where prodID=124));

--7
INSERT INTO ORDER_lpb
VALUES((select (MAX(orderID)+1) from order_lpb), '29-Jan-22','S100');

INSERT INTO ORDERDETAIL_lpb
Values((select MAX(orderId) from order_lpb), 535,3, (select prodprice from product_lpb where prodID=535));

INSERT INTO ORDERDETAIL_lpb
Values((select MAX(orderId) from order_lpb), 246,1, (select prodprice from product_lpb where prodID=246));

INSERT INTO ORDERDETAIL_lpb
Values((select MAX(orderId) from order_lpb), 610,2, (select prodprice from product_lpb where prodID=610));

--8
UPDATE CUSTOMER_lpb
SET CustPhone = '8175558918'
WHERE CustId = 'B200';

--9
COMMIT;

--PART II
--1

 
SELECT (SalesRepFName|| ' ' || SalesRepLName) AS "SalesRep Name", SalesRepID AS "Sales RepID", S.CommClass AS "Commission Class", CommRate AS "Commission Rate"
FROM SALESREP_lpb S, COMMISSION_lpb C
WHERE S.CommClass = C.CommClass
ORDER BY SalesRepLName;

--2
SELECT OrderId as "Order ID", ProdId AS "Product ID", ProdQty AS "Qty", TO_CHAR(ProdPrice,'$999.99') AS "Price"
FROM ORDERDETAIL_lpb
ORDER BY OrderId, ProdId;

--3
SELECT CustId AS "CustID",CustFName AS "CustFirstName", CustLName AS "CustLName",('('||SUBSTR(CustPhone,1,3)||')'||SUBSTR(CustPhone,4,3)||'-'|| SUBSTR(CustPhone,7,4)) AS "CustPhone",S.SalesRepId AS "SalesRepID", SalesRepFName AS "SalesRepFirstName", SalesRepLName AS "SalesRepLastName"
FROM CUSTOMER_lpb C, SALESREP_lpb S
WHERE C.SalesRepId = S.SalesRepId
ORDER BY CustId;


--4

 Select S.deptID AS "Dept_ID", deptname AS "Dept_Name", salesrepID AS "Sales_Rep_ID", salesrepFname AS "First_Name", salesrepLname AS "Last_Name", S.commclass AS "Commission_Class", commrate AS "Commission_Rate"
  From DEPARTMENT_lpb D, SALESREP_lpb S, COMMISSION_lpb C
  where D.deptid = S.deptid AND
  S.commclass = C.commclass AND
 (S.deptID, commrate) IN (select S.DeptID, Max(commrate) from SALESREP_lpb S JOIN COMMISSION_lpb C
 ON S.commClass = C.commClass
 group by DeptID);
  

--5

Select O.prodID as "Product_ID", Prodname as "Product_Name", prodcatname As "Category", '$'|| O.prodprice as "Price"
From PRODUCT_lpb P, PRODCAT_lpb PC, ORDERDETAIL_lpb O
Where P.prodcatID= PC.prodcatID AND
P.prodID= O.prodID AND
(orderID, O.prodprice) = (select OrderID, Max(O.prodprice)
FROM ORDERDETAIL_lpb O where orderID=100 
group by orderID); 


--6
Select deptname as "Dept_Name", count(salesrepID) as "Sales_Rep_Count"
From DEPARTMENT_lpb D, SALESREP_lpb S
WHERE D.deptId = S.deptId 
group by deptname
order by count(salesrepID);


--7

Select SalesRepID as "Sales_Rep_ID", SalesrepFname as "First_Name", SalesRepLname as "Last_Name", ((commrate*100)||'%') as "Commission_Rate"
From COMMISSION_lpb C JOIN SALESREP_lpb S
ON C.commclass=S.commclass
WHERE commrate > 0 AND Commrate <=0.05
ORDER BY Commrate DESC; 

--8
Select orderId, TO_CHAR(orderDate,'mm/dd/yy') as "DATE", O.custId, custFName, custLName, S.salesRepId, salesRepFName, salesRepLName
FROM ORDER_lpb O, CUSTOMER_lpb C, SALESREP_lpb S
WHERE O.custId = C.custId AND
C.SalesRepId = S.salesRepId
ORDER BY OrderId;


--9
SELECT orderId AS "OrderID", O.prodId AS "ProdID", prodName AS "ProdName", ProdCatId AS "CatID", '$' || O.prodPrice AS "Price", prodQty AS "Qty", '$'|| (O.prodPrice*prodQty) AS "ExtPrice"
FROM ORDERDETAIL_lpb O JOIN PRODUCT_lpb P
ON O.prodId = P.prodId
WHERE orderId = 104
ORDER BY (O.prodPrice*prodQty);

--10

Select D.deptID AS "DeptID", deptname AS "DeptName", Count(salesrepID) AS "SalesRepCount", ((AVG(commrate)*100) ||'%') AS "AvgCommRate"
From COMMISSION_lpb C, SALESREP_lpb S, DEPARTMENT_lpb D
WHERE D.deptId = S.deptId AND
	S.commClass = C.commClass
	GROUP BY D.deptID, deptName 
	ORDER BY (AVG(commrate)*100);

--11
SELECT SalesRepId AS "Sales Rep ID", salesRepFName AS "First Name", salesRepLName AS "Last Name", deptName AS "Department Name",S.commClass AS "Commission Class", (commRate*100)||'%' AS "Commission Rate"
FROM SALESREP_lpb S 
Join DEPARTMENT_lpb D on S.deptId = D.deptID 
Join COMMISSION_lpb C on C.commClass = S.commClass 
WHERE commRate > 0.00
ORDER BY salesRepID;

--12
SELECT salesRepId AS "SalesRep ID", (SalesRepFName ||' '|| salesRepLName) AS "SalesRep_Name", S.deptID AS "Department ID", deptName AS "Department Name" 
FROM SALESREP_lpb S JOIN DEPARTMENT_lpb D
ON S. deptID = D.deptID
WHERE commClass = 'A'
ORDER BY S.deptId, salesRepId;

--13
SELECT orderID AS "Order_ID", '$'||SUM(prodQty*prodPrice) AS "Order_Total"
FROM ORDERDETAIL_lpb
WHERE OrderID = 104
GROUP BY OrderID;

--14

SELECT TO_CHAR(AVG(prodPrice),'$99.99') AS "Avg_Price"
FROM ORDERDETAIL_lpb;

-----15
SELECT OD.prodID AS "ProductID", prodName AS "Name", '$'||sum(OD.prodPrice) AS "Price"
FROM PRODUCT_lpb P JOIN ORDERDETAIL_lpb OD
ON P.prodID = OD.prodID
group by od.prodID, prodname
Having count(OD.orderid) IN (select max(count(OD.orderid)) from orderdetail_lpb group by orderid);


--16
SELECT prodCatID AS "Cat_ID", prodID AS "Prod_ID", prodName AS "Prod_Name", '$' || prodPrice AS "Price"
FROM PRODUCT_lpb 
where (prodcatID, prodprice) in (SELECT prodCatId, MIN(prodPrice) FROM Product_lpb group by prodCatId);

--17
SELECT prodID, prodName, prodCatName,('$'||prodPrice) as "Price"
FROM PRODUCT_lpb P JOIN PRODCAT_lpb PC
ON P.prodCatId = PC. prodCatID 
Where prodPrice >(SELECT AVG(prodPrice) FROM PRODUCT_lpb); 


--18
SELECT OrderId AS "Order ID", TO_CHAR(OrderDate,'mm-dd-yyyy') AS "Order Date", C.custID AS "Cust ID", (custFName|| ' '|| custLName) AS "Name", CustPhone AS "Phone"
fROM ORDER_lpb O JOIN CUSTOMER_lpb C
ON O.custID = C.custID
WHERE OrderDate <= '26-JAN-22'
Order BY OrderDate, C.CustId;

--19
SELECT custId AS "CustID", custFName AS "FirstName", custLName AS "LastName"
FROM CUSTOMER_lpb
WHERE custFName LIKE 'A%'
Order BY custLName;

--20
SELECT custID AS "Customer ID", (custFName|| ' '||custLName) As "Name", SUBSTR(custPhone,1,3) || '-'|| SUBSTR(custPhone,4,3) || '-'|| SUBSTR(custPhone,7,4) AS "Phone"
FROM CUSTOMER_lpb
WHERE salesRepID = 12;

set echo off
spool off


