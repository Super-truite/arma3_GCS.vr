/*
 * Author: super-truite
 * Activates sector, i.e. spawns units that were cached for this sector
 *
 * Arguments:
 * 0: Grid index [ix, iy] <ARRAY>
 *
 * Return Value:
 *
 *
 * Exemple:
 * [[0,1]] spawn GCS_fnc_grid_activateSector;
 *
 * Public: No
 */
 params["_gridIndex"];
 private ["_i", "_tableUnits", "_groups", "_side", "_className", "_damage", "_position", "_direction",
  "_unitPos", "_groupName", "_isleader", "_rank", "_skill", "_groupsNames", "_group0"];

// get index of grid
_start = diag_tickTime;
_i = GRID_COORDINATES find _gridIndex;

if (_i == -1) exitWith {};

// Gets the units to spawn for this specific sector
if(GCS_VAR_GRIDSYSTEM_ENABLE_DATABASE isEqualTo true) then
{

	// Retrieves the units from the database
	_tableUnits = [_i, "UNITS"] call GCS_fnc_grid_getSectorObject;

} else {

	// Retrieves the units from the local variable
	_tableUnits = TABLE_INIT_UNITS select _i;

};

// create vehicles first

// Creates the units for the given sector

if (!(isNil "_tableUnits")) then {
	_vehicleArray = _tableUnits select 0;
	_infanteryGroupsArray = _tableUnits select 1;
	// Create vehicles
	[_vehicleArray] call GCS_fnc_grid_loadUnits_createVehicles;
	// Create infantery groups
	[_infanteryGroupsArray] call GCS_fnc_grid_loadUnits_createInfanteryGroups;


	_end = diag_tickTime;
	["Grid %1 loaded with %2 units in %3 seconds", _gridIndex, count _infanteryGroupsArray, (_end - _start)] call BIS_fnc_logFormat; //DEBUG
};
