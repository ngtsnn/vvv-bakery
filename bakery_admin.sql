-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: bakery
-- ------------------------------------------------------
-- Server version	8.0.22

--
-- Table structure for table `admin`
--

create database bakery;
use bakery;

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `adminID` int NOT NULL AUTO_INCREMENT,
  `adminName` varchar(50) DEFAULT NULL,
  `adminPassword` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`adminID`)
);


--
-- Table structure for table `reason`
--

DROP TABLE IF EXISTS `reason`;
CREATE TABLE `reason` (
  `reasonID` int NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`reasonID`)
);


--
-- Table structure for table `client_type`
--

DROP TABLE IF EXISTS `client_type`;
CREATE TABLE `client_type` (
  `clientTypeID` int NOT NULL AUTO_INCREMENT,
  `clientType` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `specialTreatment` float DEFAULT NULL,
  PRIMARY KEY (`clientTypeID`),
  UNIQUE KEY `clientType` (`clientType`)
);


--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `clientID` int NOT NULL AUTO_INCREMENT,
  `clientTypeID` int DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `firstName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `lastName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phoneNumber` char(10) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `cartID` int DEFAULT NULL,
  PRIMARY KEY (`clientID`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phoneNumber` (`phoneNumber`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `frg_client_type` FOREIGN KEY (`clientTypeID`) REFERENCES `client_type` (`clientTypeID`)
);


--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `cartID` int NOT NULL AUTO_INCREMENT,
  `clientID` int DEFAULT NULL,
  PRIMARY KEY (`cartID`)
);

ALTER TABLE `cart`
ADD CONSTRAINT `frg_client_cart` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`);
ALTER TABLE `client`
ADD CONSTRAINT `frg_cart_client` FOREIGN KEY (`cartID`) REFERENCES `cart` (`cartID`);


--
-- Table structure for table `cooking_type`
--

DROP TABLE IF EXISTS `cooking_type`;
CREATE TABLE `cooking_type` (
  `cookingTypeID` int NOT NULL AUTO_INCREMENT,
  `cookingType` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`cookingTypeID`),
  UNIQUE KEY `cookingType` (`cookingType`)
);


--
-- Table structure for table `product_type`
--

DROP TABLE IF EXISTS `product_type`;
CREATE TABLE `product_type` (
  `productTypeID` int NOT NULL AUTO_INCREMENT,
  `productType` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mainType` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subType` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`productTypeID`),
  UNIQUE KEY `disProductType` (`mainType`,`subType`)
);


--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `productID` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cookingTypeID` int DEFAULT NULL,
  `productTypeID` int DEFAULT NULL,
  `origin` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `unitPrice` decimal(15,2) NOT NULL,
  `unit` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`productID`),
  UNIQUE KEY `productName` (`productName`),
  CONSTRAINT `frg_cooking_type` FOREIGN KEY (`cookingTypeID`) REFERENCES `cooking_type` (`cookingTypeID`),
  CONSTRAINT `frg_product_type` FOREIGN KEY (`productTypeID`) REFERENCES `product_type` (`productTypeID`)
);


--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
CREATE TABLE `bill` (
  `billID` int NOT NULL AUTO_INCREMENT,
  `clientID` int DEFAULT NULL,
  `phoneNumber` char(10) NOT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `recievedDate` date DEFAULT NULL,
  `state` bit(1) DEFAULT NULL,
  `reasonID` int DEFAULT NULL,
  PRIMARY KEY (`billID`),
  CONSTRAINT `frg_bill_client` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`),
  CONSTRAINT `frg_bill_reason` FOREIGN KEY (`reasonID`) REFERENCES `reason` (`reasonID`)
);


--
-- Table structure for table `bill_detail`
--

DROP TABLE IF EXISTS `bill_detail`;
CREATE TABLE `bill_detail` (
  `billID` int NOT NULL,
  `productID` int NOT NULL,
  `quantity` int NOT NULL,
  `note` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`billID`,`productID`),
  CONSTRAINT `frg_bill_detail_cart` FOREIGN KEY (`billID`) REFERENCES `bill` (`billID`),
  CONSTRAINT `frg_bill_detail_product` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`)
);


--
-- Table structure for table `cart_detail`
--

DROP TABLE IF EXISTS `cart_detail`;
CREATE TABLE `cart_detail` (
  `clientID` int NOT NULL,
  `productID` int NOT NULL,
  `quantity` int NOT NULL,
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`clientID`,`productID`),
  CONSTRAINT `frg_cart_detail_cart` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`),
  CONSTRAINT `frg_cart_detail_product` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`)
);






/*insert data*/

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
INSERT INTO `admin` VALUES (1,'admin1','admin2','yenchi070600@gmail.com'),(2,'admin2','2admin','admin2@site.com');
UNLOCK TABLES;


--
-- Dumping data for table `reason`
--

LOCK TABLES `reason` WRITE;
UNLOCK TABLES;


--
-- Dumping data for table `client_type`
--

LOCK TABLES `client_type` WRITE;
UNLOCK TABLES;


--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
INSERT INTO `client` VALUES (3,NULL,'nhut','123',NULL,NULL,NULL,NULL,NULL,NULL),(4,NULL,'nhutabc','123',NULL,NULL,NULL,NULL,NULL,NULL),(5,NULL,'Chi','123',NULL,NULL,NULL,NULL,NULL,NULL);
UNLOCK TABLES;


--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
UNLOCK TABLES;


--
-- Dumping data for table `cooking_type`
--

LOCK TABLES `cooking_type` WRITE;
INSERT INTO `cooking_type` VALUES (2,'chien'),(1,'hap'),(3,'nuong');
UNLOCK TABLES;


--
-- Dumping data for table `product_type`
--

LOCK TABLES `product_type` WRITE;
INSERT INTO `product_type` VALUES (1,'B??nh kem','banh','kem'),(2,'B??nh m??','m??','b??nh'),(3,'C??c lo???i b??nh kh??c','Kh??c','Kh??c');
UNLOCK TABLES;


--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
INSERT INTO `product` VALUES (1,'B??nh Kem Kh??c C??y',3,1,'1609071470326FBAE0258-E9F6-4053-AE8B-8F9E4BFF3EB9-600x600.jpeg',680000.00,'C??i','The Log Cake ??? S?????i ???m ????m Gi??ng Sinh'),(3,'B??nh kem pony',2,1,'1609071004582B011FBC1-9F46-41EB-98EE-E372BC0F197A-600x600.jpeg',300000.00,'C??i','L???p kem s??? d???ng b??n ngo??i l?? kem ph?? mai nh???p kh???u cao c???p c???a Elle & Vire'),(4,'B??nh Sinh Nh???t Cao T???ng Red Velvet',3,1,'16090711350595F016EA6-5FD6-4136-B29E-3BF98AE147DD-600x600.jpeg',550000.00,'C??i','Thanh l???ch, sang tr???ng, qu?? ph??i v?? v?? c??ng quy???n r?? ??? ???? ch??? c?? th??? l?? Red Velvet Cake! '),(5,'B??nh C?? R???t ??c Ch?? V???i Kem Ph?? Mai',3,2,'16090713924511A1E38A1-9F21-4ECF-A6DE-D2280296E686-600x600.jpeg',160000.00,'C??i','Th??nh Ph???n: c?? r???t, ??c ch??, ph?? mai, tr???ng, s???a, b???t m?????'),(6,'B??nh Sinh Nh???t Cao T???ng Chu???i H???t ??c Ch??',2,1,'160907156476171676884_3535984126415490_6033746554806861824_n-1-600x592.jpg',580000.00,'C??i','C?? m???t lo???i b??nh kh??ng c???u k???, kh??ng l???ng l???y nh??ng th??m ngon theo m???t h????ng v??? r???t ri??ng bi???t.'),(7,'B??nh M?? Gi??u Ch???t X??',2,2,'160907169873517DF5837-9F6B-422A-B296-F472913E4118-600x600.jpeg',75000.00,'C??i','_Fiber l?? ch???t x??!\r\n??? High Fiber l?? Gi??u ch???t x??!'),(8,'B??nh Sinh Nh???t Cao T???ng C?? R???t',3,1,'160909696887571676884_3535984126415490_6033746554806861824_n-1-600x592.jpg',590000.00,'C??i','N???u b???n l?? t??n ????? c???a m??i h????ng v?? s??? gi???n ????n th?? Carrot Cake l?? s??? l???a ch???n tuy???t v???i nh???t ????? chi???u chu???ng v??? gi??c.'),(9,'B??nh L??a M???ch ??en ??an M???ch',3,2,'16090971265596F0AAF51-2233-498A-AEFC-49DEE1DAED07-600x600.jpeg',89000.00,'C??i','M??i l?? m???t trong nh???ng v??? b??nh ??u l??u ?????i v?? ?????c s???c nh???t.'),(10,'B??nh M??? M???t Ong ',3,2,'16090972456355CE53523-B335-40CF-B73B-3CFC4F9D2E4E-600x600.jpeg',56000.00,'C??i','B??nh ?????c bi???t m???m dai, th??m ngon n??n c??c em b?? c???c k??? y??u th??ch.'),(11,'B??nh L??a M???ch ??en ?????c',2,1,'1609097596389F173CD3F-F7F3-469F-A3E4-AB5245FC7E4A-600x600.jpeg',70000.00,'C??i','B??nh ?????c bi???t t???t cho h??? tim m???ch c??ng nh?? gi??u dinh d?????ng ?????c tr??ng ??? qu?? tr??nh ??n ki??ng, h??? tr??? gi???m c??n b???i ?????p cho m???t n???n t???ng s???c kho??? l??nh m???nh, b???n b???.'),(12,'B??nh Tinh Than Tre Nguy??n C??m',2,2,'160909782058963DF4A12-2B60-4D73-9ECB-739F4AEC6840-600x653.jpeg',88000.00,'C??i',''),(13,'B??nh M??? V??ng Ng?? C???c Nguy??n C??m',2,2,'1609097902978Group-2-Copy-4-600x600.jpg',89000.00,'',''),(14,'B??nh M??? Pita Nguy??n C??m c???a Hy L???p',2,2,'1609097972995Group-3-Copy-5-600x600.jpg',89000.00,'C??i',''),(15,'Set Mini B???n M??a',2,2,'160909807992140ABF8D3-550B-424D-81E2-13E740A107E2-600x600.jpeg',125000.00,'C??i',''),(16,'Scones',1,3,'16090982205085289E50E-DE67-457E-B62A-74D0EFAE0198-600x600.jpeg',10000.00,'','L?? d??ng b??nh ho??ng t???c.'),(17,'Chocolate Chip',2,3,'16090982855878034910E-3A1C-4867-82BF-17B6212F8130-600x600.jpeg',20000.00,'C??i',''),(18,'Brownie',2,3,'1609098350659brownie-600x600.jpg',35000.00,'C??i',''),(19,'B??nh Quy Y???n M???ch Ng?? C???c (T??i Zip 8 C??i)',2,3,'1609098464719choco-multiseed-oatmeal-cookies-600x600.jpg',65000.00,'T??i',''),(20,'B??nh Sinh Nh???t Cao T???ng V????ng Mi???n',3,1,'1609098557651A343D42D-8308-443A-8F7F-080E956CA111-600x600.jpeg',790000.00,'C??i',''),(21,'B??nh Kem Tr???c Th??ng',2,1,'1609098609334CE197695-5A20-4F87-B039-026856998DC6-600x600.jpeg',890000.00,'C??i',''),(22,'B??nh Sinh Nh???t Cao T???ng (Chocolate ??? Phi??n B???n N??u)',2,1,'1609098850045279ABBF8-272F-43DE-88EC-67E249F5F363-600x600.jpeg',450000.00,'C??i',''),(23,'B??nh B??ng Bay',2,1,'160909892480689555166_4081210795226151_3931267601358913536_o-600x600.jpg',670000.00,'C??i',''),(24,'B??nh Kem Our Night',2,1,'1609098996046F40D3E41-923D-49D6-95CF-C212EEDDA68E-600x600.jpeg',780000.00,'C??i','');
UNLOCK TABLES;


--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
INSERT INTO `bill` VALUES (1,3,'0448473427','ktx khu B',NULL,NULL,NULL);
UNLOCK TABLES;


--
-- Dumping data for table `bill_detail`
--

LOCK TABLES `bill_detail` WRITE;
INSERT INTO `bill_detail` VALUES (1,1,3,NULL),(1,3,2,NULL);
UNLOCK TABLES;


--
-- Dumping data for table `cart_detail`
--

LOCK TABLES `cart_detail` WRITE;
INSERT INTO `cart_detail` VALUES (3,3,1,NULL),(3,4,1,NULL),(3,18,1,NULL),(4,1,2,NULL);
UNLOCK TABLES;
