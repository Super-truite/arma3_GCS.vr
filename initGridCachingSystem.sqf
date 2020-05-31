// Functions compilation
_handle = execVM "GCS_configServer.sqf";
waitUntil { scriptDone _handle };
call compile preprocessFileLineNumbers "gcs_functions\gcs_compile_server.sqf";

// Grid indices
_N = ceil(worldSize / GCS_VAR_SIZE_SQUARE_GRID);
GRID_COORDINATES = [];
for "_ix" from 0 to (_N - 1) step 1 do
{
	for "_iy" from 0 to (_N - 1) step 1 do
	{
		GRID_COORDINATES pushBack [_ix, _iy];
	};
};

// Database connection and main loop
if(GCS_VAR_GRIDSYSTEM_ENABLE_DATABASE isEqualTo true) then {
	call GCS_fnc_database_connect;

	if (GCS_VAR_DATABASE_ISCONNECTED isEqualTo true) then {
		if (("PersistenceResetOnStart" call BIS_fnc_getParamValue) isEqualTo 1) then
		{
			diag_log "Database will be reseted (PersistenceResetOnStart has been set to true in the mission parameters)";
			if (("MakeBackupOnReset" call BIS_fnc_getParamValue) isEqualTo 1) then
			{
				[true] call GCS_fnc_grid_resetSectors;
			} else {
				[false] call GCS_fnc_grid_resetSectors;
			};
		};

		[] spawn GCS_fnc_database_mainLoop;
	};
};

// Cache all units
if (GCS_VAR_GRIDSYSTEM_ENABLE_DATABASE isEqualTo false) then {
	TABLE_INIT_DONE = false;
	TABLE_INIT_UNITS = [];
	TABLE_INIT_UNITS = call GCS_fnc_grid_cacheAll;

	waitUntil{ sleep 2; TABLE_INIT_DONE };
} else {

	// If the database is to be used, then we check to see if any sector has been previously stored, if not, cache all the data
	if (call GCS_fnc_grid_hasSectors isEqualTo true) then {
		diag_log "Sectors detected, we will not cache all the units due to the fact that sectors are already saved.";
		[true] call GCS_fnc_grid_cacheAll;
	} else {
		call GCS_fnc_grid_cacheAll;
	};

	waitUntil{ sleep 2; TABLE_INIT_DONE };
};

// Waits for the initial caching to be done, then starts the grid monitoring
[GCS_VAR_SIZE_SQUARE_GRID,GCS_VAR_SIZE_ACTIVATION_SQUARE_GRID, GCS_VAR_SIZE_UNSPAWN_SQUARES] spawn GCS_fnc_grid_monitorGrid;