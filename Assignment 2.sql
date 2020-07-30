#Check to see if database exists, if not create it
CREATE SCHEMA IF NOT EXISTS `DB_Assignment2` DEFAULT CHARACTER SET utf8 ;

#use the new database
USE `DB_Assignment2` ;

#check if the Customer table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_Customer` (
    `Email` VARCHAR(100) NOT NULL PRIMARY KEY UNIQUE,
    `House Number` VARCHAR(25) NOT NULL,
    `Street` VARCHAR(25) NOT NULL,
    `City` VARCHAR(25) NOT NULL,
    `Area` VARCHAR(25) NOT NULL,
    `Postcode` VARCHAR(8) NOT NULL,
    `First_Name` VARCHAR(50) NOT NULL,
    `Last_Name` VARCHAR(50) NOT NULL,
    `DoB` DATE NOT NULL,
    `Age` TINYINT(150) CHECK (Age>=16),
    `Telephone Number` VARCHAR(11) NOT NULL
);

#check if the Staff table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_Staff` (
    `Email` VARCHAR(100) NOT NULL PRIMARY KEY,
    `House Number` VARCHAR(25) NOT NULL,
    `Street` VARCHAR(25) NOT NULL,
    `City` VARCHAR(25) NOT NULL,
    `Area` VARCHAR(25) NOT NULL,
    `Postcode` VARCHAR(8) NOT NULL,
    `First_Name` VARCHAR(50) NOT NULL,
    `Last_Name` VARCHAR(50) NOT NULL,
    `DoB` DATE NOT NULL,
    `Age` TINYINT(150) CHECK (Age>=16),
    `Telephone Number` VARCHAR(11) NOT NULL
);

#check if the Suplier table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_Suplier` (
    `Email` VARCHAR(100) NOT NULL PRIMARY KEY,
    `Building Number` VARCHAR(25) NOT NULL,
    `Street` VARCHAR(25) NOT NULL,
    `City` VARCHAR(25) NOT NULL,
    `Area` VARCHAR(25) NOT NULL,
    `Postcode` VARCHAR(8) NOT NULL,
    `Name` VARCHAR(50) NOT NULL UNIQUE,
    `Telephone Number` VARCHAR(11) NOT NULL UNIQUE
);

#check if the Stock table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_Stock` (
    `Name` VARCHAR(50) NOT NULL PRIMARY KEY,
    `Description` VARCHAR(1000),
    `Price` DOUBLE NOT NULL,
    `Quantity` INT NOT NULL
);

#check if the Service - Stock table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_Service_Stock` (
    `ID_Service_Stock` INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

#check if the Service table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_Service` (
    `Name` VARCHAR(25) NOT NULL PRIMARY KEY,
    `Price` DOUBLE NOT NULL
);

#check if the Service - Customer Order table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_Service_CustomerOrder` (
    `ID_Service_CustomerOrder` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `Quantity` INT NOT NULL,
    `Price_by_Service` DOUBLE NULL
);

#check if the Purchase Order table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_PurchaseOrder` (
    `ID_PurchaseOrder` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `Quantity` INT NOT NULL,
    `Price` DOUBLE NOT NULL,
    `Total_Price` DOUBLE
);

#check if the Customer Order table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_CustomerOrder` (
    `ID_CustomerOrder` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `Service Location` ENUM('Office','Client') NOT NULL,
    `Order_Status` ENUM('Order Accepted','Recieved','In progress','Completed', 'Shipping', 'Arrived with Client') NOT NULL,
    `Discount` INT NOT NULL DEFAULT 0,
    `Order_Date-Time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `Price_of_Stock` DOUBLE DEFAULT 0,
    `Total_Price` DOUBLE DEFAULT 0
);

#check if the Invoice table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_Invoice` (
    `ID_Invoice` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `Payment_Status` ENUM('Not Paid','Payment in Progress','Paid') NOT NULL
);

#check if the Feedback table exists, and add to the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`TB_Feedback` (
    `ID_Feedback` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `Feedback` VARCHAR(1000) NOT NULL
);


#Add the foreign keys and constraints into the Service - Stock table
ALTER TABLE `TB_Service_Stock`
#link to the Service name
Add `FK_SS_Service_Name` VARCHAR(25) Not Null,
ADD CONSTRAINT `FK_SS_Service_Name`
FOREIGN KEY (`FK_SS_Service_Name`)   
REFERENCES `TB_Service`(`Name`)
ON UPDATE CASCADE
ON DELETE CASCADE,
#link to the Stock name
Add `FK_SS_Stock_Name` VARCHAR(50),
ADD CONSTRAINT `FK_SS_Stock_Name`
FOREIGN KEY (`FK_SS_Stock_Name`)   
REFERENCES `TB_Stock`(`Name`)
ON UPDATE CASCADE 
ON DELETE CASCADE;

#Add the foreign keys and constraints into the Feedback table
ALTER TABLE `TB_Feedback`
#link to the Customer email
Add `FK_Feedback_Customer_Email` VARCHAR(100) UNIQUE,
ADD CONSTRAINT `FK_Feedback_Customer_Email`   
FOREIGN KEY (`FK_Feedback_Customer_Email`)   
REFERENCES `TB_Customer`(`Email`)
ON UPDATE CASCADE 
ON DELETE CASCADE, 
#link to the Staff email
Add `FK_Feedback_Staff_Email` VARCHAR(100),
ADD CONSTRAINT `FK_Feedback_Staff_Email`   
FOREIGN KEY (`FK_Feedback_Staff_Email`)   
REFERENCES `TB_Staff`(`Email`)
ON UPDATE CASCADE 
ON DELETE CASCADE;

#Add the foreign keys and constraints into the Purchase Order table
ALTER TABLE `TB_PurchaseOrder`
#link to the Stock name
Add `FK_PurchaseOrder_Stock_Name` VARCHAR(50),
ADD CONSTRAINT `FK_PurchaseOrder_Stock_Name`   
FOREIGN KEY (`FK_PurchaseOrder_Stock_Name`)   
REFERENCES `TB_Stock`(`Name`)
ON UPDATE CASCADE 
ON DELETE CASCADE,
#link to the Suplier email
Add `FK_PurchaseOrder_Suplier_Email` VARCHAR(100),
ADD CONSTRAINT `FK_PurchaseOrder_Suplier_Email`   
FOREIGN KEY (`FK_PurchaseOrder_Suplier_Email`)   
REFERENCES `TB_Suplier`(`Email`)
ON UPDATE CASCADE 
ON DELETE CASCADE,
#link to the Staff email
Add `FK_PurchaseOrder_Staff_Email` VARCHAR(100),
ADD CONSTRAINT `FK_PurchaseOrder_Staff_Email`
FOREIGN KEY (`FK_PurchaseOrder_Staff_Email`)   
REFERENCES `TB_Staff`(`Email`)
ON UPDATE CASCADE 
ON DELETE CASCADE;

#Add the foreign keys and constraints into the Customer Order table
ALTER TABLE `TB_CustomerOrder`
#link to the Customer email
Add `FK_CustomerOrder_Customer_Email` VARCHAR(100),
ADD CONSTRAINT `FK_CustomerOrder_Customer_Email`   
FOREIGN KEY (`FK_CustomerOrder_Customer_Email`)   
REFERENCES `TB_Customer`(`Email`)
ON UPDATE CASCADE 
ON DELETE CASCADE,
#link to the Staff email
Add `FK_CustomerOrder_Staff_Email` VARCHAR(100),
ADD CONSTRAINT `FK_CustomerOrder_Staff_Email`   
FOREIGN KEY (`FK_CustomerOrder_Staff_Email`)   
REFERENCES `TB_Staff`(`Email`)
ON UPDATE CASCADE 
ON DELETE CASCADE;

#Add the foreign keys and constraints into the Service - Customer Order table
ALTER TABLE `TB_Service_CustomerOrder`
#link to the Service name
Add `FK_SCO_Service_Name` VARCHAR(25),
ADD CONSTRAINT `FK_SCO_Service_Name`   
FOREIGN KEY (`FK_SCO_Service_Name`)   
REFERENCES `TB_Service`(`Name`)
ON UPDATE CASCADE 
ON DELETE CASCADE,
Add `FK_SCO_CustomerOrder_ID` INT,
#link to the Customer Order ID
ADD CONSTRAINT `FK_SCO_CustomerOrder_ID`   
FOREIGN KEY (`FK_SCO_CustomerOrder_ID`)   
REFERENCES `TB_CustomerOrder`(`ID_CustomerOrder`)
ON UPDATE CASCADE 
ON DELETE CASCADE;

#Add the foreign keys and constraints into the Invoice table
ALTER TABLE `TB_Invoice`
#link to the Customer Order ID
Add `FK_Invoice_CustomerOrder_ID` INT UNIQUE,
ADD CONSTRAINT `FK_Invoice_CustomerOrder_ID`   
FOREIGN KEY (`FK_Invoice_CustomerOrder_ID`)   
REFERENCES `TB_CustomerOrder`(`ID_CustomerOrder`)
ON UPDATE CASCADE 
ON DELETE CASCADE,
#link to the Staff email
Add `FK_Invoice_Customer_Email` VARCHAR(100),
ADD CONSTRAINT `FK_Invoice_Customer_Email`   
FOREIGN KEY (`FK_Invoice_Customer_Email`)   
REFERENCES `TB_Customer`(`Email`)
ON UPDATE CASCADE 
ON DELETE CASCADE;

#Add Customers to the customer table
INSERT INTO `TB_Customer`
(
`Email`,
`House Number`,
`Street`,
`City`,
`Area`,
`Postcode`,
`First_Name`,
`Last_Name`,
`DoB`,
`Telephone Number`
)
VALUES
(
'GregoryS@hotmail.co.uk',
'53',
'St George Way',
'A Real City',
'Humberside',
'HU20 5TY',
'Gregory',
'Smithy',
'1999-12-02',
'01582653985'
),
(
'ABond@gmail.com',
'96',
'Kent Street',
'Scunthorpe',
'North Lincolnshire',
'KA1 3SL',
'Adam',
'Bond',
'1981-06-04',
'07977105431'
),
(
'NHobbs84@gmail.com',
'113',
'High Street',
'Thrigby',
'Yorkshire',
'NR29 7TD',
'Naomi',
'Hobbs',
'1984-12-09',
'07866805868'
),
(
'CBarnes@hotmail.com',
'77',
'Wrexham Rd',
'Evie',
'Lincolnshire',
'KW17 4YN',
'Charlotte',
'Barnes',
'1995-08-21',
'07705224177'
);

#Add Staff to table
INSERT INTO `TB_Staff`
(
`Email`,
`House Number`,
`Street`,
`City`,
`Area`,
`Postcode`,
`First_Name`,
`Last_Name`,
`DoB`,
`Telephone Number`
)
VALUES
(
'AHarris@hotmail.com',
'67',
'West Street',
'Lincoln',
'Lincolnshire',
'LN51 3AB',
'Alex',
'Harris',
'1990-10-09',
'01658951452'
),
(
'JBall@hotmail.com',
'60',
'Emerson Road',
'Kirkburn',
'Yorkshire',
'YO25 4AP',
'Jordan',
'Ball',
'1993-12-28',
'07042244910'
),
(
'Lucas1983@hotmail.co.uk',
'58',
'Old Chapel Road',
'Lincoln',
'Lincolnshire',
'PH33 0AF',
'Lucas',
'Perry',
'1983-07-23',
'07864677037'
);

#Add Customer Orders to table
INSERT INTO `TB_CustomerOrder`
(
`Service Location`,
`Order_Status`,
`FK_CustomerOrder_Customer_Email`,
`FK_CustomerOrder_Staff_Email`,
`Price_of_Stock`
)
VALUES
(
'Office',
'Recieved',
'GregoryS@hotmail.co.uk',
'AHarris@hotmail.com',
0
),
(
'Office',
'In progress',
'ABond@gmail.com',
'JBall@hotmail.com',
0
),
(
'Office',
'Shipping',
'CBarnes@hotmail.com',
'JBall@hotmail.com',
350
),
(
'Client',
'Arrived with Client',
'GregoryS@hotmail.co.uk',
'AHarris@hotmail.com',
0
),
(
'Client',
'Arrived with Client',
'NHobbs84@gmail.com',
'Lucas1983@hotmail.co.uk',
150
);

#Add Services to table
INSERT INTO `TB_Service`
(
`Name`,
`Price`
)
VALUES
(
'Upgrade',
20
),
(
'Hardware Repair',
25
),
(
'Software Repair',
35
),
(
'Networking',
35
),
(
'Internet',
25
),
(
'Training',
50
),
(
'Backup',
100
),
(
'Anti-Virus',
30
),
(
'Maintanance',
20
);

#Add Stock to table
INSERT INTO `TB_Stock`
(
`Name`,
`Description`,
`Price`,
`Quantity`
)
VALUES
(
'PSU',
'A 500w Power supply',
50,
185
),
(
'AMD GPU',
'An AMD Graphics Card',
200,
66
),
(
'Nvidea GPU',
'A Nvidea Graphics Card',
200,
52
),
(
'Intel Motherboard',
'An intel based motherboard',
100,
178
),
(
'AMD MotherBoard',
'An amd based motherboard',
100,
156
),
(
'Ram',
'1x8gb stick of DDR4 RAM',
50,
1624
),
(
'AMD CPU',
'An AMD based CPU',
150,
128
),
(
'INTEL CPU',
'An Intel based CPU',
150,
153
),
(
'Anti-Virus',
'An antivirus installation disk',
30,
123
),
(
'Operating System',
'An OS lisence and installation disk',
20,
84
);

#Add Customer Order - Services to table
INSERT INTO `TB_Service_CustomerOrder`
(
`Quantity`,
`FK_SCO_Service_Name`,
`FK_SCO_CustomerOrder_ID`
)
VALUES
(
1,
'Anti-Virus',
1
),
(
1,
'Training',
1
),
(
1,
'Software Repair',
2
),
(
1,
'Hardware Repair',
3
),
(
2,
'Upgrade',
3
),
(
1,
'Maintanance',
3
),
(
1,
'Backup',
4
),
(
1,
'Hardware Repair',
5
);

#Add Service - Stock to table

INSERT INTO `TB_Service_Stock`
(
`FK_SS_Service_Name`,
`FK_SS_Stock_Name`
)
VALUES
(
'Anti-Virus',
'Operating System'
),
(
'Training',
NULL
),
(
'Software Repair',
'Operating System'
),
(
'Software Repair',
'Anti-Virus'
),
(
'Upgrade',
'AMD CPU'
),
(
'Upgrade',
'INTEL CPU'
),
(
'Upgrade',
'PSU'
),
(
'Upgrade',
'Ram'
),
(
'Upgrade',
'AMD MotherBoard'
),(
'Upgrade',
'Intel Motherboard'
),
(
'Upgrade',
'AMD GPU'
),
(
'Upgrade',
'Nvidea GPU'
),
(
'Hardware Repair',
'AMD CPU'
),
(
'Hardware Repair',
'INTEL CPU'
),
(
'Hardware Repair',
'PSU'
),
(
'Hardware Repair',
'Ram'
),
(
'Hardware Repair',
'AMD MotherBoard'
),(
'Hardware Repair',
'Intel Motherboard'
),
(
'Hardware Repair',
'AMD GPU'
),
(
'Hardware Repair',
'Nvidea GPU'
),
(
'Maintanance',
NULL
),
(
'Networking',
NULL
),
(
'Internet',
NULL
),
(
'Backup',
NULL
);

#Add Feedback to table
INSERT INTO `TB_Feedback`
(
`Feedback`,
`FK_Feedback_Customer_Email`,
`FK_Feedback_Staff_Email`
)
VALUES
(
'It was pretty good',
'ABond@gmail.com',
'AHarris@hotmail.com'
),
(
'I liked it',
'GregoryS@hotmail.co.uk',
'JBall@hotmail.com'
),
(
'It was good, but could be better',
'CBarnes@hotmail.com',
'Lucas1983@hotmail.co.uk'
),
(
'It was absoloutly terrible',
'NHobbs84@gmail.com',
'Lucas1983@hotmail.co.uk'
);

#Add Supliers to table
INSERT INTO `TB_Suplier`
(
`Email`,
`Building Number`,
`Street`,
`City`,
`Area`,
`Postcode`,
`Name`,
`Telephone Number`
)
VALUES
(
'Contact@BestPowerSuplies.co.uk',
'1',
'Long Rd',
'Meldenhall',
'Yorkshire',
'SN8 0QE',
'Best Power Suplies',
'07885135535'
),
(
'Sales@AMD.com',
'22',
'Hendford Hill',
'London',
'Greater London',
'LO13 9ON',
'AMD',
'07024566280'
),
(
'Sales@Nvidea.com',
'18',
'Wern Lane',
'Ludstock',
'Lancashire',
'LA8 8ZT',
'Nvidea',
'07965215367'
),
(
'Sales@Intel.com',
'1',
'Long Rd',
'Meldenhall',
'Yorkshire',
'SN8 0QE',
'Intel',
'07135162535'
),
(
'Contact@WeSellRAM.co.uk',
'166',
'Industrial Way',
'Lincoln',
'Lincolnshire',
'LN6 5LE',
'We Sell RAM',
'01685158576'
),
(
'Contact@AntiVirusSelect.eu',
'57',
'Fraserburgh Rd',
'Lincoln',
'Lincolnshire',
'LN2 3AZ',
'Anti-Virus Select',
'07718594127'
),
(
'Sales@Windows.com',
'59',
'Bath Rd',
'Wolverton',
'Buckinghamshire',
'RG26 2NG',
'Microsoft',
'07745889565'
);

#Add Purchase Orders to table
INSERT INTO `TB_PurchaseOrder`
(
`Quantity`,
`Price`,
`FK_PurchaseOrder_Stock_Name`,
`FK_PurchaseOrder_Suplier_Email`,
`FK_PurchaseOrder_Staff_Email`
)
VALUES
(
50,
150,
'AMD GPU',
'Sales@AMD.com',
'Lucas1983@hotmail.co.uk'
),
(
50,
150,
'Nvidea GPU',
'Sales@Nvidea.com',
'Lucas1983@hotmail.co.uk'
),
(
25,
30,
'PSU',
'Contact@BestPowerSuplies.co.uk',
'Lucas1983@hotmail.co.uk'
),
(
50,
75,
'AMD Motherboard',
'Sales@AMD.com',
'Lucas1983@hotmail.co.uk'
),
(
50,
100,
'AMD CPU',
'Sales@AMD.com',
'Lucas1983@hotmail.co.uk'
);

#Add Invoices to table
INSERT INTO `TB_Invoice`
(
`Payment_Status`,
`FK_Invoice_CustomerOrder_ID`,
`FK_Invoice_Customer_Email`
)
VALUES
(
'Payment in Progress',
1,
'GregoryS@hotmail.co.uk'
),
(
'Not Paid',
2,
'ABond@gmail.com'
),
(
'Paid',
3,
'CBarnes@hotmail.com'
),
(
'Paid',
4,
'GregoryS@hotmail.co.uk'
),
(
'Paid',
5,
'NHobbs84@gmail.com'
);

#Set customer and staff ages
UPDATE `TB_Customer`
SET `Age`=TIMESTAMPDIFF(YEAR, `DoB`, CURDATE())
WHERE `Age` IS NULL;
UPDATE `TB_Staff`
SET `Age`=TIMESTAMPDIFF(YEAR, `DoB`, CURDATE())
WHERE `Age` IS NULL;

#Delete a customers feedback
DELETE FROM `TB_Feedback` WHERE `FK_Feedback_Customer_Email`='NHobbs84@gmail.com';

#Update customer feedback
UPDATE `TB_Feedback` SET `Feedback`='*EDIT* It is still pretty good'
WHERE `FK_Feedback_Customer_Email`='ABond@gmail.com';

#Add total price of purchase orders
UPDATE `TB_PurchaseOrder`
SET `Total_Price`= `Quantity`*`Price`;

#Set discount where location is at clients home
UPDATE `TB_CustomerOrder` SET `Discount`=10
WHERE `Service Location` = 'Client';

#Set price by service on service - customer orders table
UPDATE `TB_Service_CustomerOrder`,`TB_Service`
SET `TB_Service_CustomerOrder`.`Price_by_Service`= `TB_Service`.`Price`
WHERE `TB_Service_CustomerOrder`.`FK_SCO_Service_Name` = `TB_Service`.`Name`;

#Update total price on customer order from price of stock and services requested
UPDATE `TB_CustomerOrder`,`TB_Service_CustomerOrder`
SET `TB_CustomerOrder`.`Total_Price`= `TB_CustomerOrder`.`Price_of_Stock` + 
(
	SELECT SUM(`TB_Service_CustomerOrder`.`Price_by_Service`)
	WHERE `TB_Service_CustomerOrder`.`FK_SCO_CustomerOrder_ID` = `TB_CustomerOrder`.`ID_CustomerOrder`
)
WHERE  `TB_CustomerOrder`.`ID_CustomerOrder` = `TB_Service_CustomerOrder`.`FK_SCO_CustomerOrder_ID`;

#Apply discount (if any) to total price
UPDATE `TB_CustomerOrder`
SET `TB_CustomerOrder`.`Total_Price`= `TB_CustomerOrder`.`Total_Price` - (`TB_CustomerOrder`.`Total_Price`*(1/`TB_CustomerOrder`.`Discount`))
WHERE `TB_CustomerOrder`.`Discount` != 0;

#drop procedure if it already exists
drop procedure if exists UpdateAges;

#change the delimitter
DELIMITER !

#create a new procedure for updating ages
CREATE PROCEDURE UpdateAges()
BEGIN
	UPDATE TB_Customer
    SET Age = TIMESTAMPDIFF(YEAR, DoB, CURDATE());
	
    UPDATE TB_Staff
    SET Age = TIMESTAMPDIFF(YEAR, DoB, CURDATE());
END!

#change back delimitter
DELIMITER ;

#schedule database to update ages once every day
CREATE EVENT autoUpdateAges ON SCHEDULE EVERY 1 DAY DO CALL UpdateAges();

#Copy the database
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_Customer` LIKE `DB_Assignment2`.`TB_Customer`;
INSERT `Copy_of_TB_Customer` SELECT * FROM `DB_Assignment2`.`TB_Customer`;

CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_CustomerOrder` LIKE `DB_Assignment2`.`TB_CustomerOrder`;
INSERT `Copy_of_TB_CustomerOrder` SELECT * FROM `TB_CustomerOrder`;

CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_Feedback` LIKE `DB_Assignment2`.`TB_Feedback`;
INSERT `Copy_of_TB_Feedback` SELECT * FROM `TB_Feedback`;

CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_Invoice` LIKE `DB_Assignment2`.`TB_Invoice`;
INSERT `Copy_of_TB_Invoice` SELECT * FROM `TB_Invoice`;

CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_PurchaseOrder` LIKE `DB_Assignment2`.`TB_PurchaseOrder`;
INSERT `Copy_of_TB_PurchaseOrder` SELECT * FROM `TB_PurchaseOrder`;

CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_Service` LIKE `DB_Assignment2`.`TB_Service`;
INSERT `Copy_of_TB_Service` SELECT * FROM `TB_Service`;

CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_Service_CustomerOrder` LIKE `DB_Assignment2`.`TB_Service_CustomerOrder`;
INSERT `Copy_of_TB_Service_CustomerOrder` SELECT * FROM `TB_Service_CustomerOrder`;

CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_Service_Stock` LIKE `DB_Assignment2`.`TB_Service_Stock`;
INSERT `Copy_of_TB_Service_Stock` SELECT * FROM `TB_Service_Stock`;
 
CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_Staff` LIKE `DB_Assignment2`.`TB_Staff`;
INSERT `Copy_of_TB_Staff` SELECT * FROM `TB_Staff`;

CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_Stock` LIKE `DB_Assignment2`.`TB_Stock`;
INSERT `Copy_of_TB_Stock` SELECT * FROM `TB_Stock`;

CREATE TABLE IF NOT EXISTS `DB_Assignment2`.`Copy_of_TB_Suplier` LIKE `DB_Assignment2`.`TB_Suplier`;
INSERT `Copy_of_TB_Suplier` SELECT * FROM `TB_Suplier`;

#Relink the foreign keys and constraints to the appropriate copy_of table
ALTER TABLE `Copy_of_TB_Service_Stock`
ADD CONSTRAINT `CFK_SS_Service_Name` FOREIGN KEY (`FK_SS_Service_Name`) REFERENCES `Copy_of_TB_Service`(`Name`) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT `CFK_SS_Stock_Name` FOREIGN KEY (`FK_SS_Stock_Name`) REFERENCES `Copy_of_TB_Stock`(`Name`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `Copy_of_TB_Feedback`
ADD CONSTRAINT `CFK_Feedback_Customer_Email` FOREIGN KEY (`FK_Feedback_Customer_Email`) REFERENCES `Copy_of_TB_Customer`(`Email`) ON UPDATE CASCADE ON DELETE CASCADE, 
ADD CONSTRAINT `CFK_Feedback_Staff_Email` FOREIGN KEY (`FK_Feedback_Staff_Email`) REFERENCES `Copy_of_TB_Staff`(`Email`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `Copy_of_TB_PurchaseOrder`
ADD CONSTRAINT `CFK_PurchaseOrder_Stock_Name` FOREIGN KEY (`FK_PurchaseOrder_Stock_Name`) REFERENCES `Copy_of_TB_Stock`(`Name`) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT `CFK_PurchaseOrder_Suplier_Email` FOREIGN KEY (`FK_PurchaseOrder_Suplier_Email`) REFERENCES `Copy_of_TB_Suplier`(`Email`) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT `CFK_PurchaseOrder_Staff_Email` FOREIGN KEY (`FK_PurchaseOrder_Staff_Email`) REFERENCES `Copy_of_TB_Staff`(`Email`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `Copy_of_TB_CustomerOrder` 
ADD CONSTRAINT `CFK_CustomerOrder_Customer_Email` FOREIGN KEY (`FK_CustomerOrder_Customer_Email`) REFERENCES `Copy_of_TB_Customer`(`Email`) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT `CFK_CustomerOrder_Staff_Email` FOREIGN KEY (`FK_CustomerOrder_Staff_Email`) REFERENCES `Copy_of_TB_Staff`(`Email`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `Copy_of_TB_Service_CustomerOrder` 
ADD CONSTRAINT `CFK_SCO_Service_Name` FOREIGN KEY (`FK_SCO_Service_Name`) REFERENCES `Copy_of_TB_Service`(`Name`) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT `CFK_SCO_CustomerOrder_ID` FOREIGN KEY (`FK_SCO_CustomerOrder_ID`) REFERENCES `Copy_of_TB_CustomerOrder`(`ID_CustomerOrder`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `Copy_of_TB_Invoice`
ADD CONSTRAINT `CFK_Invoice_CustomerOrder_ID` FOREIGN KEY (`FK_Invoice_CustomerOrder_ID`) REFERENCES `Copy_of_TB_CustomerOrder`(`ID_CustomerOrder`) ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT `CFK_Invoice_Customer_Email` FOREIGN KEY (`FK_Invoice_Customer_Email`) REFERENCES `Copy_of_TB_Customer`(`Email`) ON UPDATE CASCADE ON DELETE CASCADE;

#delete user if exists
DROP USER IF EXISTS'user'@'%';

#Create new user
CREATE USER 'user'@'%' IDENTIFIED BY 'password';

#only grant them select permissions
GRANT SELECT ON `DB_Assignment2`.* TO 'user'@'%';

#Join stock, suplier and purchase order to see all current purchase orders
SELECT `TB_Stock`.`Name`,`TB_Suplier`.`Name`,`TB_PurchaseOrder`.`Quantity`
FROM ((`TB_Stock`
INNER JOIN `TB_PurchaseOrder` ON `TB_Stock`.`name` = `TB_PurchaseOrder`.`FK_PurchaseOrder_Stock_Name`)
INNER JOIN `TB_Suplier` ON `TB_PurchaseOrder`.`FK_PurchaseOrder_Suplier_Email` = `TB_Suplier`.`Email`);

#Join Services, stock and service stock to see what stock each service requires
SELECT `TB_Service`.`Name`,`TB_Stock`.`Name`
FROM ((`TB_Service`
LEFT JOIN `TB_Service_Stock` ON `TB_Service`.`Name` = `TB_Service_Stock`.`FK_SS_Service_Name`)
LEFT JOIN `TB_Stock` ON  `TB_Service_Stock`.`FK_SS_Stock_Name` = `TB_Stock`.`Name`);

#Join Customer, ServiceList and Customer Order to see all customer orders and the services requested
SELECT `TB_Customer`.`First_Name`,`TB_Customer`.`Last_Name`,`TB_Service_CustomerOrder`.`FK_SCO_Service_Name`,`TB_Service_CustomerOrder`.`Quantity`,`TB_CustomerOrder`.`Order_Status`
FROM ((`TB_Service_CustomerOrder`
RIGHT JOIN `TB_CustomerOrder` ON `TB_Service_CustomerOrder`.`FK_SCO_CustomerOrder_ID` = `TB_CustomerOrder`.`ID_CustomerOrder`)
RIGHT JOIN `TB_Customer` ON `TB_CustomerOrder`.`FK_CustomerOrder_Customer_Email` = `TB_Customer`.`Email`);

#Union all customers who have submitted feedback
SELECT `Email` FROM `TB_Customer`
UNION
SELECT `FK_Feedback_Customer_Email` FROM `TB_Feedback`
ORDER BY `Email`;