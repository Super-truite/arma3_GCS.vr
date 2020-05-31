/*
 * Author: Anthariels
 * Adds or updates a given object for a given sector in the database
 *
 * Arguments:
 * Sector id <NUMBER>
 * Sector object name <STRING>
 * Sector object value <ARRAY>
 *
 * Return Value:
 *
 * Example:
 * [123, "UNITS", _myAIUnits] call GCS_fnc_grid_addOrUpdateSectorObject;
 *
 * Public: No
 */

params["_sectorIndex","_sectorObjectName","_sectorObjectValue"];
private _queryPriority = "HIGH";
_queryName = "";


// Pre-conditions validations
if (!assert (_sectorIndex isEqualType 0)) exitWith { ["ERROR: The given index for the sector is not valid (%1).", _sectorIndex] call BIS_fnc_logFormat; };
if (!assert ((_sectorObjectName isEqualType "") && (_sectorObjectName != ""))) exitWith { ["ERROR: The given object name for the sector is not valid (not a string or empty)."] call BIS_fnc_logFormat; };


// Retrieves the query name to use based on the given object name parameter
switch (_sectorObjectName) do
{
	case "UNITS": { _queryName = "addOrUpdateSectorUnits"; };
	case "VEHICLES": { _queryName = "addOrUpdateSectorVehicles"; };
	default { _queryName = ""; };
};


// Adds or updates the sector object in the database
if (_queryName == "") exitWith { ["ERROR: The given object name (%1) cannot be used to add or update any sector object.", _sectorObjectName] call BIS_fnc_logFormat; };
[_queryName, [_sectorIndex, _sectorObjectValue], _queryPriority] call GCS_fnc_database_addToBuffer;