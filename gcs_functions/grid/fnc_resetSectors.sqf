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

private _void = [_queryName] call GCS_fnc_database_executeQuery;