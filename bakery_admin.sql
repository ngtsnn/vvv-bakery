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
INSERT INTO `product_type` VALUES (1,'Bánh kem','banh','kem'),(2,'Bánh mì','mì','bánh'),(3,'Các loại bánh khác','Khác','Khác');
UNLOCK TABLES;


--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
INSERT INTO `product` VALUES (1,'Bánh Kem Khúc Cây',3,1,'1609071470326FBAE0258-E9F6-4053-AE8B-8F9E4BFF3EB9-600x600.jpeg',680000.00,'Cái','The Log Cake – Sưởi ấm đêm Giáng Sinh'),(3,'Bánh kem pony',2,1,'1609071004582B011FBC1-9F46-41EB-98EE-E372BC0F197A-600x600.jpeg',300000.00,'Cái','Lớp kem sử dụng bên ngoài là kem phô mai nhập khẩu cao cấp của Elle & Vire'),(4,'Bánh Sinh Nhật Cao Tầng Red Velvet',3,1,'16090711350595F016EA6-5FD6-4136-B29E-3BF98AE147DD-600x600.jpeg',550000.00,'Cái','Thanh lịch, sang trọng, quý phái và vô cùng quyến rũ – đó chỉ có thể là Red Velvet Cake! '),(5,'Bánh Cà Rốt Óc Chó Với Kem Phô Mai',3,2,'16090713924511A1E38A1-9F21-4ECF-A6DE-D2280296E686-600x600.jpeg',160000.00,'Cái','Thành Phần: cà rốt, óc chó, phô mai, trứng, sữa, bột mì…'),(6,'Bánh Sinh Nhật Cao Tầng Chuối Hạt Óc Chó',2,1,'160907156476171676884_3535984126415490_6033746554806861824_n-1-600x592.jpg',580000.00,'Cái','Có một loại bánh không cầu kỳ, không lộng lẫy nhưng thơm ngon theo một hương vị rất riêng biệt.'),(7,'Bánh Mì Giàu Chất Xơ',2,2,'160907169873517DF5837-9F6B-422A-B296-F472913E4118-600x600.jpeg',75000.00,'Cái','_Fiber là chất xơ!\r\n– High Fiber là Giàu chất xơ!'),(8,'Bánh Sinh Nhật Cao Tầng Cà Rốt',3,1,'160909696887571676884_3535984126415490_6033746554806861824_n-1-600x592.jpg',590000.00,'Cái','Nếu bạn là tín đồ của mùi hương và sự giản đơn thì Carrot Cake là sự lựa chọn tuyệt vời nhất để chiều chuộng vị giác.'),(9,'Bánh Lúa Mạch Đen Đan Mạch',3,2,'16090971265596F0AAF51-2233-498A-AEFC-49DEE1DAED07-600x600.jpeg',89000.00,'Cái','Mãi là một trong những vị bánh Âu lâu đời và đặc sắc nhất.'),(10,'Bánh Mỳ Mật Ong ',3,2,'16090972456355CE53523-B335-40CF-B73B-3CFC4F9D2E4E-600x600.jpeg',56000.00,'Cái','Bánh đặc biệt mềm dai, thơm ngon nên các em bé cực kỳ yêu thích.'),(11,'Bánh Lúa Mạch Đen Đức',2,1,'1609097596389F173CD3F-F7F3-469F-A3E4-AB5245FC7E4A-600x600.jpeg',70000.00,'Cái','Bánh đặc biệt tốt cho hệ tim mạch cũng như giàu dinh dưỡng đặc trưng ở quá trình ăn kiêng, hỗ trợ giảm cân bồi đắp cho một nền tảng sức khoẻ lành mạnh, bền bỉ.'),(12,'Bánh Tinh Than Tre Nguyên Cám',2,2,'160909782058963DF4A12-2B60-4D73-9ECB-739F4AEC6840-600x653.jpeg',88000.00,'Cái',''),(13,'Bánh Mỳ Vòng Ngũ Cốc Nguyên Cám',2,2,'1609097902978Group-2-Copy-4-600x600.jpg',89000.00,'',''),(14,'Bánh Mỳ Pita Nguyên Cám của Hy Lạp',2,2,'1609097972995Group-3-Copy-5-600x600.jpg',89000.00,'Cái',''),(15,'Set Mini Bốn Mùa',2,2,'160909807992140ABF8D3-550B-424D-81E2-13E740A107E2-600x600.jpeg',125000.00,'Cái',''),(16,'Scones',1,3,'16090982205085289E50E-DE67-457E-B62A-74D0EFAE0198-600x600.jpeg',10000.00,'','Là dòng bánh hoàng tộc.'),(17,'Chocolate Chip',2,3,'16090982855878034910E-3A1C-4867-82BF-17B6212F8130-600x600.jpeg',20000.00,'Cái',''),(18,'Brownie',2,3,'1609098350659brownie-600x600.jpg',35000.00,'Cái',''),(19,'Bánh Quy Yến Mạch Ngũ Cốc (Túi Zip 8 Cái)',2,3,'1609098464719choco-multiseed-oatmeal-cookies-600x600.jpg',65000.00,'Túi',''),(20,'Bánh Sinh Nhật Cao Tầng Vương Miện',3,1,'1609098557651A343D42D-8308-443A-8F7F-080E956CA111-600x600.jpeg',790000.00,'Cái',''),(21,'Bánh Kem Trực Thăng',2,1,'1609098609334CE197695-5A20-4F87-B039-026856998DC6-600x600.jpeg',890000.00,'Cái',''),(22,'Bánh Sinh Nhật Cao Tầng (Chocolate – Phiên Bản Nâu)',2,1,'1609098850045279ABBF8-272F-43DE-88EC-67E249F5F363-600x600.jpeg',450000.00,'Cái',''),(23,'Bánh Bóng Bay',2,1,'160909892480689555166_4081210795226151_3931267601358913536_o-600x600.jpg',670000.00,'Cái',''),(24,'Bánh Kem Our Night',2,1,'1609098996046F40D3E41-923D-49D6-95CF-C212EEDDA68E-600x600.jpeg',780000.00,'Cái','');
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
