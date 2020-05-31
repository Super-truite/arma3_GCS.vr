/*
 * Author: Anthariels
 * Returns a sector object value
 *
 * Arguments:
 * Sector ID <NUMBER>
 * Sector Object <STRING>
 *
 * Return Value:
 * Sector object value <ANY>
 *
 * Example:
 * [150, "UNITS"] call GCS_fnc_grid_getSectorUnits;
 *
 * Public: No
 */

params["_sectorIndex", "_sectorObjectName"];
private _queryName = "";
_queryResult = [];


// Pre-conditions validations
if (!assert (_sectorIndex isEqualType 0)) exitWith { ["ERROR: The given index for the sector is not valid (%1).", _sectorIndex] call BIS_fnc_logFormat; };


// Retrieves the query name to use based on the given object name parameter
switch (_sectorObjectName) do {
    case "UNITS": { _queryName = "getSectorUnits"; };
    case "VEHICLES": { _queryName = "getSectorVehicles"; };
    default {};
};


// Retrieves the sector object in the database
if (_queryName isEqualTo "") exitWith { ["ERROR: The given object name (%1) cannot be used to retrieves any sector object.", _sectorObjectName] call BIS_fnc_logFormat; };

_queryResult = [_queryName, [_sectorIndex]] call GCS_fnc_database_executeQuery;
if (!(isNil "_queryResult")) then { _queryResult select 0 };