CREATE PROCEDURE `addOrUpdateSectorUnits`(
	IN GridIdParam INT,
	IN UnitsParams TEXT
)
BEGIN
	IF EXISTS(
		SELECT GridId FROM sectors WHERE GridId = GridIdParam
    ) 
    THEN 
		BEGIN
			UPDATE sectors SET Units = UnitsParams WHERE GridId = GridIdParam;
		END;
    ELSE
		BEGIN
			INSERT INTO `sectors`
			(`GridId`,	`Units`)
			VALUES
			(GridIdParam, UnitsParams);
		END;
    END IF;
END;