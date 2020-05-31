CREATE TABLE `GCSARMA`.`sectors` (
  `GridId` int NOT NULL,
  `Units` text,
  `Vehicles` text,
  PRIMARY KEY (`GridId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='This table will hold any sectors (grid) related date (vehicles, units, ...).';