CREATE PROCEDURE `addOrUpdateSectorVehicles`(
	IN GridIdParam INT,
	IN VehiclesParams TEXT
)
BEGIN
	IF EXISTS(
		SELECT GridId FROM sectors WHERE GridId = GridIdParam
    ) 
    THEN 
		BEGIN
			UPDATE sectors SET Vehicles = VehiclesParams WHERE GridId = GridIdParam;
		END;
    ELSE
		BEGIN
			INSERT INTO `sectors`
			(`GridId`,	`Vehicles`)
			VALUES
			(GridIdParam, VehiclesParams);
		END;
    END IF;
END;