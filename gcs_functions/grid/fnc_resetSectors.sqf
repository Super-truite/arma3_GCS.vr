/*
 * Author: Anthariels
 * Removes all the sectors in the database (can be used to reset a mission for example)
 *
 * Arguments:
 * Make a backup (copy table) in the database before the reset <BOOLEAN>
 *
 * Return Value:
 *
 * Exemple:
 * [true] call GCS_fnc_grid_resetSectors;
 *
 * Public: No
 */

params ["_doBackup"];
private _queryName = "resetSectors";
/*
if (_doBackup isEqualTo true) then {
	_backupState = call GCS_fnc_grid_backupSectors;
	if (_backupState isEqualTo false) exitWith { "ERROR, could not reset the sectors, an error occurred while trying to backup the sector table!" call BIS_fnc_log; };
};*/

private _void = [_queryName] call GCS_fnc_database_executeQuery;