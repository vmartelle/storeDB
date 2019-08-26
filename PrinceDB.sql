CREATE DATABASE  IF NOT EXISTS `princedb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `princedb`;
-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: princedb
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aisle`
--

DROP TABLE IF EXISTS `aisle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `aisle` (
  `Name` varchar(20) NOT NULL,
  `A_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`A_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aisle`
--

LOCK TABLES `aisle` WRITE;
/*!40000 ALTER TABLE `aisle` DISABLE KEYS */;
INSERT INTO `aisle` VALUES ('Snack',1),('Deli',2),('Health',3),('Toys',4),('Drugs',5),('example',6),('example',7);
/*!40000 ALTER TABLE `aisle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer` (
  `C_id` varchar(45) NOT NULL,
  `Fname` varchar(45) NOT NULL,
  `Lname` varchar(45) NOT NULL,
  `Address` varchar(45) NOT NULL,
  PRIMARY KEY (`C_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('aertbie@amail.com','Cathy','Mccoy','3976 Cliffside Drive, Andover,  RI'),('atbabi@amail.com','Carys','Bernard','2827 Owen Lane, Grand Rapids,  RI'),('brandi100@zmail.com','Brandi','McDowell','100 Thor St, Dallas,  RI'),('by7imr69w4@zmail.com','Marnie','Robertson','2463 Orphan Road, Appleton,  RI'),('bysrt@zmail.com','Karis','Graham','1095 Winding Way, Providence,  RI'),('danisaur@zmail.com','Danielle','Frank','34 Mineral St, Houston,  RI'),('dishwasher1@amail.com','Sean','Washington','222 Leon Dr, Dallas,  RI'),('ersnysui@zmail.com','Mae','Rodgers','4003 Modoc Alley, Clayton,  RI'),('miuyomr7@amail.com','Owen','Washington','3716 Murry Street, Norfolk,  RI'),('ncarter88@amail.com','Naomi','Carter','5 Lincoln Ave, Houston,  RI'),('nsnant@zmail.com','Karina ','Kennedy','554 Francis Mine, Sacramento,  RI'),('nudtydni@amail.com','Maryon','Middleton','3293 Tori Lane, Salt Lake City,  RI'),('NUYIF@zmail.com','Teagan','Barnett','2852 Upton Avenue, Bangor,  RI'),('POHSTR@amail.com','Syed','Reilly','4841 McDowell Street, Nashville,  RI'),('SNRTNI@zmail.com','Jocelyn','Holt','1113 Happy Hollow Road, Jacksonville,  RI'),('sofynus@zmail.com','Miley','Hopkins','2188 Spirit Drive, Port Orange,  RI'),('sunso@zmail.com','Jorja ','Griffith','3000 Melville Street, Jackson,  RI'),('WEARV@amail.com','Catrin','Le','2968 Indiana Avenue, Honolulu,  RI'),('YMUF@zmail.com','Manisha','Ramsey','1447 Geneva Street, North Kingstown,  RI'),('zbro420@zmail.com','Zachary','Zeeter','123 Drake St, Bellaire,  RI');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `employee` (
  `Fname` varchar(15) NOT NULL,
  `Lname` varchar(15) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `address` varchar(45) NOT NULL,
  `SSN` int(9) unsigned NOT NULL,
  `start_date` datetime NOT NULL,
  `wage` double unsigned NOT NULL,
  `super_ssn` int(9) unsigned DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  KEY `super_ssn_idx` (`super_ssn`),
  CONSTRAINT `EmployeeSuper_ssnConstraint` FOREIGN KEY (`super_ssn`) REFERENCES `employee` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('John','Smith','M','731 Fordren, Houston,  RI',123456789,'2018-01-09 00:00:00',10,666884444),('Rex','Holt','F','4404 Amethyst Drive, Okemos,  RI',125636953,'2018-05-10 00:00:00',10,666884444),('Reece','Le','M','2428 Main Street, Everett,  RI',175895271,'2018-04-15 00:00:00',10,666884444),('Joy','Owen','M','1714 Brown Street, Concord,  RI',235737337,'2018-06-25 00:00:00',10,666884444),('Franklin','Wong','M','638 Voss, Houston,  RI',333445555,'2018-01-25 00:00:00',10,666884444),('Ayat','Rodgers','F','3851 Musgrave Street, Oklahoma City,  RI',346129779,'2018-07-19 00:00:00',10,999887777),('Maddox','Griffith','M','272 Timberbrook Lane, Greeley,  RI',450545748,'2018-08-09 00:00:00',10,666884444),('Ramesh','Narayan','M','975 Fire Oak, Humble,  RI',666884444,'2018-02-15 00:00:00',15,NULL),('Noah','Hopkins','F','2062 Better Street, Leavenworth,  RI',675437849,'2018-07-10 00:00:00',10,999887777),('Karim','Graham','F','2944 Overlook Drive, Muncie,  RI',707891926,'2018-04-10 00:00:00',10,666884444),('Tegan','Mccoy','M','943 Twin Oaks Drive, Alba,  RI',711287226,'2018-08-25 00:00:00',10,666884444),('Kerry','Barnett','M','3877 Farnum Road, New York,  RI',712378336,'2018-04-09 00:00:00',10,666884444),('Adnan','Ramsey','F','4757 Sugar Camp Road, Mabel,  RI',780848644,'2018-05-19 00:00:00',10,999887777),('Skye','Bernard','M','1006 Lighthouse Drive, Pittsburg,  RI',843128808,'2018-07-15 00:00:00',10,999887777),('Gerard','Kennedy','M','1338 Rosemont Avenue, Melbourne,  RI',936564361,'2018-06-09 00:00:00',10,666884444),('Dalton','Reilly','M','4684 Yorkie Lane, Savannah,  RI',941622569,'2018-05-25 00:00:00',10,666884444),('Abdullah','Middleton','M','2141 Chenoweth Drive, Crossville,  RI',955611513,'2018-06-15 00:00:00',10,999887777),('Jennifer','Wallace','F','291 Berry, Bellaire,  RI',987654321,'2018-03-19 00:00:00',10,999887777),('Robin','Robertson','F','2872 Arrowood Drive, Jacksonville,  RI',998061589,'2018-08-19 00:00:00',10,999887777),('Alicia','Zelaya','F','3321 Castle, Spring,  RI',999887777,'2018-03-10 00:00:00',15,NULL);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_from`
--

DROP TABLE IF EXISTS `orders_from`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orders_from` (
  `Essn` int(10) unsigned NOT NULL,
  `Supplier_id` int(10) unsigned NOT NULL,
  `Total_cost` double NOT NULL,
  `Quantity_ordered` int(10) unsigned NOT NULL,
  `Date` datetime NOT NULL,
  PRIMARY KEY (`Essn`,`Supplier_id`),
  KEY `fk_Employee_has_Supplier_Supplier1_idx` (`Supplier_id`),
  KEY `fk_Employee_has_Supplier_Employee1_idx` (`Essn`),
  CONSTRAINT `Orders_fromEssnConstraint` FOREIGN KEY (`Essn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `Orders_fromSupplier_idConstraint` FOREIGN KEY (`Supplier_id`) REFERENCES `supplier` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_from`
--

LOCK TABLES `orders_from` WRITE;
/*!40000 ALTER TABLE `orders_from` DISABLE KEYS */;
INSERT INTO `orders_from` VALUES (125636953,11,477.47,40,'2018-09-01 00:00:00'),(125636953,12,729.63,17,'2018-09-01 00:00:00'),(125636953,13,468.45,29,'2018-10-01 00:00:00'),(346129779,14,435.17,14,'2018-10-25 00:00:00'),(346129779,15,220.24,16,'2018-10-25 00:00:00'),(450545748,17,994.27,17,'2018-11-01 00:00:00'),(666884444,1,123.45,40,'2018-08-01 00:00:00'),(666884444,2,450.39,17,'2018-08-01 00:00:00'),(666884444,3,750.49,29,'2018-08-01 00:00:00'),(675437849,16,284.12,40,'2018-11-01 00:00:00'),(707891926,6,815.95,40,'2018-07-01 00:00:00'),(707891926,7,222.43,17,'2018-07-01 00:00:00'),(712378336,4,390.78,14,'2018-08-25 00:00:00'),(712378336,8,342.86,29,'2018-07-01 00:00:00'),(712378336,9,105.8,14,'2018-09-25 00:00:00'),(712378336,10,415.12,16,'2018-09-25 00:00:00'),(843128808,19,346.63,14,'2018-12-25 00:00:00'),(998061589,18,820.86,29,'2018-11-01 00:00:00'),(998061589,20,275.85,16,'2018-12-25 00:00:00'),(999887777,5,500.5,16,'2018-07-25 00:00:00');
/*!40000 ALTER TABLE `orders_from` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product` (
  `Name` varchar(20) NOT NULL,
  `Barcode` int(10) unsigned NOT NULL,
  `Price` double unsigned NOT NULL,
  `Type` varchar(45) NOT NULL,
  `manufacturer` varchar(45) NOT NULL,
  `Aisle_id` int(10) unsigned NOT NULL,
  `Transaction_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`Barcode`),
  KEY `aisle_id_idx` (`Aisle_id`),
  KEY `transaction_id_idx` (`Transaction_id`),
  CONSTRAINT `ProductAisle_idConstraint` FOREIGN KEY (`Aisle_id`) REFERENCES `aisle` (`a_id`),
  CONSTRAINT `ProductTransaction_idConstraint` FOREIGN KEY (`Transaction_id`) REFERENCES `transaction` (`t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('Uncle Ray\'s',11320164,15.8,'Snack','8X8 Incorporated',3,8),('Snickers',14219220,1.12,'Candy','Mars',1,5),('shoes',17507916,40.04,'Clothes','Levi\'s',3,13),('League Of Legends',24458531,45,'Video Game','Riot',4,6),('A-10 Cuba!',38983717,5.8,'Video Game','Levi\'s',3,18),('Airport Tycoon 2',41204889,2.1,'Video Game','Mars',1,19),('Doritos',46773147,3.49,'Snack','Frito Lay',1,1),('Jacket',47020268,10.62,'Clothes','Levi\'s',3,3),('Kaypro',52957109,7.1,'Video Game','Fisherman',2,17),('Oreos',55464271,44.68,'Food','Fisherman',2,12),('Zapp\'s',64371529,21.31,'Candy','Tostitos',4,10),('Tastykake',66245996,33.35,'Snack','3M Company',2,7),('Tuna',70173226,6.2,'Food','Fisherman',2,2),('sweater',74945618,4.6,'Clothes','Coach',1,16),('Wazoo',83575381,22.87,'Candy','Fritos',1,9),('Age of Empires',84281835,8.1,'Video Game','wargames',4,20),('shirts ',85775090,44.43,'Clothes','Nike',1,14),('Tasty Bite',91068463,75.6,'Snack','3Com Corporation',1,4),('Old Dutch Foods',93914477,64.1,'Snack','Tostitos',1,11),('dressing ',96742369,91.45,'Clothes','Old Navy',4,15);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocks`
--

DROP TABLE IF EXISTS `stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `stocks` (
  `Essn` int(9) unsigned NOT NULL,
  `Aisle_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Essn`,`Aisle_id`),
  KEY `fk_Employee_has_Aisle_Aisle1_idx` (`Aisle_id`) /*!80000 INVISIBLE */,
  KEY `fk_Employee_has_Aisle_Employee1_idx` (`Essn`),
  CONSTRAINT `StocksAisle_idConstraint` FOREIGN KEY (`Aisle_id`) REFERENCES `aisle` (`a_id`),
  CONSTRAINT `StocksEssnConstraint` FOREIGN KEY (`Essn`) REFERENCES `employee` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocks`
--

LOCK TABLES `stocks` WRITE;
/*!40000 ALTER TABLE `stocks` DISABLE KEYS */;
INSERT INTO `stocks` VALUES (123456789,1),(123456789,2),(125636953,1),(125636953,2),(125636953,3),(333445555,3),(333445555,4),(346129779,4),(346129779,5),(450545748,2),(675437849,1),(707891926,1),(707891926,2),(712378336,3),(712378336,4),(712378336,5),(843128808,4),(987654321,5),(998061589,3),(998061589,5);
/*!40000 ALTER TABLE `stocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `supplier` (
  `Name` varchar(45) NOT NULL,
  `Phone` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `S_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`S_id`),
  UNIQUE KEY `Phone_UNIQUE` (`Phone`),
  UNIQUE KEY `adress_UNIQUE` (`address`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES ('Frito Lay','4017897896','5631 Rice, houston,  RI',1),('Blunder And Gobble','4011234569','980 Dallas, houston,  TX',2),('Fish of Dubai','4012369874','450 Stone, houston,  GA',3),('Fish and Co','4012948515','15 Rica, houston,  CA',4),('The Blunder Council','4012331414','230 Stone, houston,  CA',5),('Fish Corp','7875555','1310 Bond Street, Newport,  RI',6),('Levi\'s','8421753','4576 Meadow View Drive, Hartford,  GA',7),('Game Distribution, INC','7022872','2233 Birch  Street, El Paso,  RI',8),('HealthCorp','9780133','906 Skips Lane, Flagstaff,  RI',9),('Mars','8979067','230 Stone, houston,  RI',10),('Maud Fish Associates','1644370','4565 Monroe Street, Houston,  GA',11),('Building Schmuilding','9993007','4419 Victoria Street, North Chicago,  CA',12),('McForest Gobbles','1894764','2085 Burke Street, Revere,  RI',13),('Gobble Unlimited','4881354','3174 Woodland Terrace, Sacramento,  GA',14),('Build Build Build','7928820','472 Sampson Street, Denver,  TX',15),('Blunder Industries','8218596','4063 Massachusetts Avenue, Washington,  TX',16),('Build the Lily','9550037','3987 Mount Street, Midland,  RI',17),('Gobble Unlimited','7269024','4242 Marietta Street, Oakland,  CA',18),('Sale of Years','7100194','3041 Deer Haven Drive, Abbeville,  RI',19),('Beyond the Sale','2670035','4467 Stroop Hill Road, Atlanta,  GA',20);
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplies`
--

DROP TABLE IF EXISTS `supplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `supplies` (
  `Supplier_id` int(10) unsigned NOT NULL,
  `Product_barcode` int(10) unsigned NOT NULL,
  `ship_date` datetime NOT NULL,
  `Quantity_shipped` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Supplier_id`,`Product_barcode`),
  KEY `fk_Supplier_has_Product_Product1_idx` (`Product_barcode`),
  KEY `fk_Supplier_has_Product_Supplier1_idx` (`Supplier_id`),
  CONSTRAINT `SuppliesProduct_barcodeConstraint` FOREIGN KEY (`Product_barcode`) REFERENCES `product` (`barcode`),
  CONSTRAINT `SuppliesSupplier_idConstraint` FOREIGN KEY (`Supplier_id`) REFERENCES `supplier` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplies`
--

LOCK TABLES `supplies` WRITE;
/*!40000 ALTER TABLE `supplies` DISABLE KEYS */;
INSERT INTO `supplies` VALUES (1,46773147,'2018-08-03 00:00:00',40),(2,70173226,'2018-08-05 00:00:00',17),(3,24458531,'2018-08-04 00:00:00',29),(4,47020268,'2018-08-01 00:00:00',14),(5,14219220,'2018-08-30 00:00:00',16),(6,91068463,'2018-09-03 00:00:00',96),(7,66245996,'2018-09-05 00:00:00',12),(8,11320164,'2018-09-04 00:00:00',54),(9,83575381,'2018-10-01 00:00:00',47),(10,64371529,'2018-10-30 00:00:00',35),(11,93914477,'2018-10-03 00:00:00',53),(12,55464271,'2018-11-05 00:00:00',82),(13,85775090,'2018-11-04 00:00:00',33),(14,17507916,'2018-11-01 00:00:00',88),(15,96742369,'2018-11-30 00:00:00',52),(16,74945618,'2018-12-03 00:00:00',31),(17,52957109,'2018-12-05 00:00:00',47),(18,38983717,'2018-08-04 00:00:00',61),(19,41204889,'2018-09-01 00:00:00',15),(20,84281835,'2018-10-30 00:00:00',61);
/*!40000 ALTER TABLE `supplies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transaction` (
  `Date` datetime NOT NULL,
  `Total_price` double NOT NULL,
  `T_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Essn` int(9) unsigned NOT NULL,
  `C_id` varchar(45) NOT NULL,
  PRIMARY KEY (`T_id`),
  KEY `Essn_idx` (`Essn`),
  KEY `C_id_idx` (`C_id`),
  CONSTRAINT `TransactionC_idConstraint` FOREIGN KEY (`C_id`) REFERENCES `customer` (`c_id`),
  CONSTRAINT `TransactionEssnConstraint` FOREIGN KEY (`Essn`) REFERENCES `employee` (`ssn`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES ('2018-08-15 00:00:00',15.9,1,123456789,'brandi100@zmail.com'),('2018-08-16 00:00:00',49.63,2,333445555,'ncarter88@amail.com'),('2018-08-17 00:00:00',9.99,3,333445555,'zbro420@zmail.com'),('2018-08-17 00:00:00',1.07,4,987654321,'dishwasher1@amail.com'),('2018-08-19 00:00:00',35.36,5,987654321,'danisaur@zmail.com'),('2018-08-15 00:00:00',37.36,6,707891926,'bysrt@zmail.com'),('2018-08-15 00:00:00',32.72,7,175895271,'WEARV@amail.com'),('2018-08-16 00:00:00',2.56,8,712378336,'NUYIF@zmail.com'),('2018-08-17 00:00:00',15.36,9,941622569,'POHSTR@amail.com'),('2018-08-16 00:00:00',19.72,10,780848644,'YMUF@zmail.com'),('2018-08-15 00:00:00',65.31,11,125636953,'SNRTNI@zmail.com'),('2018-08-18 00:00:00',39.19,12,955611513,'nudtydni@amail.com'),('2018-08-17 00:00:00',35.53,13,936564361,'nsnant@zmail.com'),('2018-08-18 00:00:00',46.53,14,235737337,'miuyomr7@amail.com'),('2018-08-19 00:00:00',71.6,15,346129779,'ersnysui@zmail.com'),('2018-08-15 00:00:00',46.06,16,675437849,'sofynus@zmail.com'),('2018-08-17 00:00:00',7.66,17,843128808,'atbabi@amail.com'),('2018-08-17 00:00:00',49.5,18,450545748,'sunso@zmail.com'),('2018-08-19 00:00:00',53.46,19,711287226,'aertbie@amail.com'),('2018-08-18 00:00:00',69.71,20,998061589,'by7imr69w4@zmail.com');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `user_name` varchar(45) NOT NULL,
  `password` binary(60) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin',_binary '$2b$10$BHxhrbCdpMV8738yVIJHeeVEB8VIG2rHEJBj9z2WjY.jAqGzmjEfm',1),('johnny',_binary '$2b$10$lfqwUvkk/ZsH0qDBbvUJqurht1u4SXvV9x4JMDohQrrhxioWkJkpi',1),('samy',_binary '$2b$10$GYR0SAqkQoGhPbv287vdqOcq048GLxd6rGpvzrCEBrobk9hJeWQ9a',1),('victor',_binary '$2b$10$z76Dv9rH60JYB0rNNy1ALOY4X24TDVPQB5j1CRtc1NUF74k80/oKa',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-26 16:36:21
