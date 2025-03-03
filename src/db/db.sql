DROP TABLE IF EXISTS `Chemical`;
DROP TABLE IF EXISTS `Inventory`;
DROP TABLE IF EXISTS `Container`;
DROP TABLE IF EXISTS `Users`;
DROP TABLE IF EXISTS `Role`;
DROP TABLE IF EXISTS `Location`;
DROP TABLE IF EXISTS `Building`;
DROP TABLE IF EXISTS `Room`;
DROP TABLE IF EXISTS `StorageUnit`;
DROP TABLE IF EXISTS `Hazard`;
DROP TABLE IF EXISTS `Caution`;
DROP TABLE IF EXISTS `Manufacturer`;

CREATE TABLE `Hazard` (
    `Id` INT PRIMARY KEY,
    `Hazardcode` INT,
    `HazardSymbol` VARCHAR(255)
);

CREATE TABLE `Caution` (
    `Id` INT PRIMARY KEY,
    `cautionCodeId` INT
);

CREATE TABLE `Manufacturer` (
    `Id` INT PRIMARY KEY,
    `CompanyName` VARCHAR(255),
    `description` VARCHAR(255),
    `Contact` INT
);

CREATE TABLE `StorageUnit` (
    `Id` INT PRIMARY KEY,
    `UnitName` VARCHAR(255)
);

CREATE TABLE `Room` (
    `Id` INT PRIMARY KEY,
    `RoomName` VARCHAR(255),
    `StorageUnitId` INT,
    FOREIGN KEY (StorageUnitId) REFERENCES StorageUnit(Id)
);

CREATE TABLE `Building` (
    `Id` INT PRIMARY KEY,
    `buildingName` VARCHAR(255),
    `roomId` INT,
    FOREIGN KEY (roomId) REFERENCES Room(Id)
);

CREATE TABLE `Location` (
    `Id` INT PRIMARY KEY,
    `buildingsId` INT,
    FOREIGN KEY (buildingsId) REFERENCES Building(Id)
);

CREATE TABLE `Role` (
    `Id` INT PRIMARY KEY,
    `RoleName` VARCHAR(255)
);

CREATE TABLE `Users` (
    `Id` INT PRIMARY KEY,
    `Fname` VARCHAR(255),
    `Lname` VARCHAR(255),
    `Contact` INT,
    `RoleId` INT,
    `DateCreated` DATE,
    FOREIGN KEY (RoleId) REFERENCES Role(Id)
);

CREATE TABLE `Container` (
    `Id` INT PRIMARY KEY,
    `ContainerSize` INT
);

CREATE TABLE `Chemical` (
    `Id` INT PRIMARY KEY,
    `ChemicalName` VARCHAR(150),
    `FormulaName` VARCHAR(150),
    `CASNum` VARCHAR(20),  -- Changed to VARCHAR as CAS numbers contain hyphens
    `HazardId` INT,
    `CautionId` INT,
    `Barcode` INT,
    `LocationId` INT,
    `ManufacturerId` INT,
    FOREIGN KEY (HazardId) REFERENCES Hazard(Id),
    FOREIGN KEY (CautionId) REFERENCES Caution(Id),
    FOREIGN KEY (LocationId) REFERENCES Location(Id),
    FOREIGN KEY (ManufacturerId) REFERENCES Manufacturer(Id)
);

CREATE TABLE `Inventory` (
    `Id` INT PRIMARY KEY,
    `quantity` INT,
    `chemicalId` INT,
    `userId` INT,
    `containerId` INT,
    FOREIGN KEY (chemicalId) REFERENCES Chemical(Id),
    FOREIGN KEY (userId) REFERENCES Users(Id),
    FOREIGN KEY (containerId) REFERENCES Container(Id)
);

INSERT INTO `Hazard` VALUES 
(1, 201, 'Flammable'),
(2, 202, 'Toxic'),
(3, 203, 'Corrosive'),
(4, 204, 'Explosive'),
(5, 205, 'Oxidizing'),
(6, 206, 'Compressed Gas'),
(7, 207, 'Environmental Hazard'),
(8, 208, 'Health Hazard'),
(9, 209, 'Radioactive'),
(10, 210, 'Biohazard');

INSERT INTO `Caution` VALUES 
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105),
(6, 106),
(7, 107),
(8, 108);

INSERT INTO `Manufacturer` VALUES 
(1, 'Sigma-Aldrich', 'Leading supplier of research chemicals', 5551001),
(2, 'Merck', 'Global pharmaceutical company', 5551002),
(3, 'Fisher Scientific', 'Laboratory supplies and equipment', 5551003),
(4, 'VWR', 'Global laboratory supplier', 5551004),
(5, 'Thermo Fisher', 'Scientific equipment and reagents', 5551005),
(6, 'Alfa Aesar', 'Research chemicals and materials', 5551006),
(7, 'BD Biosciences', 'Life science research products', 5551007),
(8, 'Bio-Rad', 'Life science research products', 5551008),
(9, 'Agilent', 'Analytical instruments and reagents', 5551009),
(10, 'MilliporeSigma', 'Life science products', 5551010);

INSERT INTO `StorageUnit` VALUES 
(1, 'Fume Hood A'),
(2, 'Flammable Cabinet 1'),
(3, 'Acid Cabinet'),
(4, 'Base Cabinet'),
(5, 'Refrigerator 1'),
(6, 'Freezer 1'),
(7, 'Storage Shelf A'),
(8, 'Flammable Cabinet 2'),
(9, 'Bio Hazard Cabinet'),
(10, 'Cold Room Storage');

INSERT INTO `Room` VALUES 
(1, 'Lab 101', 1),
(2, 'Lab 102', 2),
(3, 'Storage Room 1', 3),
(4, 'Prep Room', 4),
(5, 'Lab 201', 5),
(6, 'Lab 202', 6),
(7, 'Storage Room 2', 7),
(8, 'Analytical Suite', 8),
(9, 'Biosafety Lab', 9),
(10, 'Chemical Stockroom', 10);

INSERT INTO `Building` VALUES 
(1, 'Chemistry Building', 1),
(2, 'Science Center', 3),
(3, 'Research Building A', 5),
(4, 'Research Building B', 8),
(5, 'Biosciences Building', 9);

INSERT INTO `Location` VALUES 
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 4),
(8, 4),
(9, 5),
(10, 5);

INSERT INTO `Role` VALUES 
(1, 'Lab Manager'),
(2, 'Research Scientist'),
(3, 'Lab Technician'),
(4, 'Student'),
(5, 'Stockroom Manager');

INSERT INTO `Users` VALUES 
(1, 'John', 'Smith', 5552001, 1, '2021-01-15'),
(2, 'Jane', 'Doe', 5552002, 2, '2021-02-20'),
(3, 'Robert', 'Johnson', 5552003, 2, '2021-03-10'),
(4, 'Emily', 'Williams', 5552004, 3, '2021-04-05'),
(5, 'Michael', 'Brown', 5552005, 3, '2021-05-15'),
(6, 'Sarah', 'Miller', 5552006, 4, '2022-01-10'),
(7, 'David', 'Anderson', 5552007, 4, '2022-02-15'),
(8, 'Jennifer', 'Taylor', 5552008, 4, '2022-03-20'),
(9, 'Christopher', 'Thomas', 5552009, 5, '2022-04-25'),
(10, 'Jessica', 'Jackson', 5552010, 2, '2022-05-30'),
(11, 'Daniel', 'White', 5552011, 3, '2022-06-05'),
(12, 'Lisa', 'Harris', 5552012, 1, '2022-07-10');

INSERT INTO `Container` VALUES 
(1, 100),
(2, 250),
(3, 500),
(4, 1000),
(5, 2000),
(6, 5000),
(7, 10000),
(8, 20000);

INSERT INTO `Chemical` VALUES 
(1, 'Acetone', 'C3H6O', '67-64-1', 1, 1, 100001, 1, 1),
(2, 'Methanol', 'CH3OH', '67-56-1', 1, 2, 100002, 2, 1),
(3, 'Ethanol', 'C2H5OH', '64-17-5', 1, 1, 100003, 2, 2),
(4, 'Hydrochloric Acid', 'HCl', '7647-01-0', 3, 3, 100004, 3, 3),
(5, 'Sodium Hydroxide', 'NaOH', '1310-73-2', 3, 3, 100005, 4, 3),
(6, 'Sulfuric Acid', 'H2SO4', '7664-93-9', 3, 3, 100006, 3, 2),
(7, 'Acetic Acid', 'CH3COOH', '64-19-7', 3, 1, 100007, 3, 1),
(8, 'Toluene', 'C7H8', '108-88-3', 1, 2, 100008, 1, 1),
(9, 'Hexane', 'C6H14', '110-54-3', 1, 2, 100009, 1, 1),
(10, 'Acetonitrile', 'CH3CN', '75-05-8', 1, 2, 100010, 2, 4),
(11, 'Dichloromethane', 'CH2Cl2', '75-09-2', 2, 2, 100011, 2, 1),
(12, 'Chloroform', 'CHCl3', '67-66-3', 2, 2, 100012, 2, 1),
(13, 'Diethyl Ether', 'C4H10O', '60-29-7', 1, 4, 100013, 1, 2),
(14, 'Tetrahydrofuran', 'C4H8O', '109-99-9', 1, 4, 100014, 1, 1),
(15, 'Dimethyl Sulfoxide', 'C2H6OS', '67-68-5', 8, 1, 100015, 5, 1),
(16, 'Formaldehyde', 'CH2O', '50-00-0', 2, 3, 100016, 9, 5),
(17, 'Hydrogen Peroxide', 'H2O2', '7722-84-1', 5, 3, 100017, 4, 3),
(18, 'Potassium Permanganate', 'KMnO4', '7722-64-7', 5, 3, 100018, 6, 2),
(19, 'Sodium Chloride', 'NaCl', '7647-14-5', 8, 1, 100019, 7, 3),
(20, 'Calcium Chloride', 'CaCl2', '10043-52-4', 8, 1, 100020, 7, 3),
(21, 'Magnesium Sulfate', 'MgSO4', '7487-88-9', 8, 1, 100021, 7, 3),
(22, 'Sodium Bicarbonate', 'NaHCO3', '144-55-8', 8, 1, 100022, 7, 3),
(23, 'Ammonium Chloride', 'NH4Cl', '12125-02-9', 8, 1, 100023, 7, 2),
(24, 'Potassium Chloride', 'KCl', '7447-40-7', 8, 1, 100024, 7, 2),
(25, 'Silver Nitrate', 'AgNO3', '7761-88-8', 3, 5, 100025, 6, 2),
(26, 'Lead Acetate', 'Pb(CH3COO)2', '301-04-2', 2, 5, 100026, 6, 6),
(27, 'Mercury(II) Chloride', 'HgCl2', '7487-94-7', 2, 5, 100027, 6, 6),
(28, 'Benzene', 'C6H6', '71-43-2', 2, 2, 100028, 2, 1),
(29, 'Phenol', 'C6H5OH', '108-95-2', 3, 2, 100029, 3, 1),
(30, 'Aniline', 'C6H7N', '62-53-3', 2, 2, 100030, 2, 1),
(31, 'Sodium Azide', 'NaN3', '26628-22-8', 2, 4, 100031, 8, 2),
(32, 'Potassium Cyanide', 'KCN', '151-50-8', 2, 4, 100032, 8, 2),
(33, 'Bromine', 'Br2', '7726-95-6', 3, 3, 100033, 3, 7),
(34, 'Iodine', 'I2', '7553-56-2', 5, 3, 100034, 6, 7),
(35, 'Phosphorus', 'P', '7723-14-0', 4, 4, 100035, 8, 7),
(36, 'Sodium Metal', 'Na', '7440-23-5', 4, 4, 100036, 8, 7),
(37, 'Potassium Metal', 'K', '7440-09-7', 4, 4, 100037, 8, 7),
(38, 'Lithium Metal', 'Li', '7439-93-2', 4, 4, 100038, 8, 7),
(39, 'Nitric Acid', 'HNO3', '7697-37-2', 3, 5, 100039, 3, 3),
(40, 'Perchloric Acid', 'HClO4', '7601-90-3', 5, 5, 100040, 3, 3);

INSERT INTO `Inventory` VALUES 
(1, 2500, 1, 1, 3),
(2, 3000, 2, 1, 3),
(3, 5000, 3, 1, 4),
(4, 1500, 4, 2, 3),
(5, 2000, 5, 2, 3),
(6, 1000, 6, 2, 2),
(7, 2500, 7, 3, 3),
(8, 1500, 8, 3, 2),
(9, 2000, 9, 3, 3),
(10, 1000, 10, 4, 2),
(11, 500, 11, 4, 1),
(12, 500, 12, 4, 1),
(13, 1000, 13, 5, 2),
(14, 1000, 14, 5, 2),
(15, 1500, 15, 5, 2),
(16, 1000, 16, 6, 2),
(17, 500, 17, 6, 1),
(18, 250, 18, 6, 1),
(19, 5000, 19, 7, 4),
(20, 2500, 20, 7, 3),
(21, 2500, 21, 7, 3),
(22, 5000, 22, 7, 4),
(23, 1000, 23, 8, 2),
(24, 1000, 24, 8, 2),
(25, 250, 25, 8, 1),
(26, 100, 26, 9, 1),
(27, 100, 27, 9, 1),
(28, 500, 28, 9, 1),
(29, 500, 29, 10, 1),
(30, 250, 30, 10, 1),
(31, 100, 31, 11, 1),
(32, 100, 32, 11, 1),
(33, 250, 33, 11, 1),
(34, 250, 34, 12, 1),
(35, 100, 35, 12, 1),
(36, 100, 36, 12, 1),
(37, 100, 37, 9, 1),
(38, 100, 38, 9, 1),
(39, 1000, 39, 10, 2),
(40, 500, 40, 10, 1);