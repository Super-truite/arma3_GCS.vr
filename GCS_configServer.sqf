/*
 * General Grid Caching System (GCS) parameters.
 */

 /* Activate database or save locally. Use true to have presistent storage, false otherwise. If true, please read the database configuration documentation
 * If set to false, non persistent storage will save units properites in arrays to have persistence for the duration of a session, but
 * will be lost once the server or mission restart
 */
GCS_VAR_GRIDSYSTEM_ENABLE_DATABASE = false;



GCS_VAR_MONITORING_FREQUENCY_SECS = 1;

/* Grid cells parameters. Be careful when modifying this:
 * - making too small grid elements will use more ressources
 * - Using too large unspawn squareswith relatively small
 * squares for activation will let a lot of squares activated
 * at the same time
 * - sizeSquareGrid < sizeActivationSquareGrid <
 * sizeUnSpawnSquares must be true
 */
GCS_VAR_SIZE_SQUARE_GRID = 500;
GCS_VAR_SIZE_ACTIVATION_SQUARE_GRID = 1500;
GCS_VAR_SIZE_UNSPAWN_SQUARES = 2000;

// Show debug markers
GCS_VAR_GRIDSYSTEM_DEBUG_MARKERS = false;

/*
 * Database parameters.
 * These parameters are only used when the variable 'GCS_VAR_GRIDSYSTEM_ENABLE_DATABASE' is set to true (located in functions\gcs_compile_server.sqf)
 */

if (GCS_VAR_GRIDSYSTEM_ENABLE_DATABASE isEqualTo true) then
{
	GCS_VAR_DATABASE_NAME = "maindb";
	GCS_VAR_DATABASE_INSTANCE = "";
	GCS_VAR_DATABASE_ISCONNECTED = false; // Server variable used to indicate wheter or not the connection to the database is established, do not change the default value false!

	GCS_VAR_DATABASE_BUFFER_HIGHPRIORITY = []; // This array is used to store the queries to execute from the buffer with a high priority
	GCS_VAR_DATABASE_BUFFER_MEDIUMPRIORITY = []; // This array is used to store the queries to execute from the buffer with a medium priority
	GCS_VAR_DATABASE_BUFFER_LOWPRIORITY = []; // This array is used to store the queries to execute from the buffer with a low priority

	GCS_VAR_DATABASE_QUERIES = [

		// Sector related queries
		"hasSectors",
			"SELECT COUNT(*) FROM sectors",
		"addOrUpdateSectorUnits",
			"CALL addOrUpdateSectorUnits(?, ?)",
		"addOrUpdateSectorVehicles",
			"CALL addOrUpdateSectorVehicles(?, ?)",
		"getSectorUnits",
			"SELECT s.Units FROM sectors s WHERE s.GridId = ?",
		"getSectorVehicles",
			"SELECT s.Vehicles FROM sectors s WHERE s.GridId = ?",
		"resetSectors",
			"DELETE FROM sectors",
		"backupSectors",
			"CALL sectorBackup()"
	];
}