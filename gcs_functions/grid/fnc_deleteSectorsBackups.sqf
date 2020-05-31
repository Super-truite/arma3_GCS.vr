/*
 * Author: Anthariels
 * Deletes all the database backups in relation with the sectors table
 *
 * Arguments:
 *
 * Return Value:
 * Deletion status <BOOLEAN>
 *
 * Exemple:
 * _isRemoved = call LB_fnc_grid_deleteSectorsBackups;
 *
 * Public: No
 */

private _queryName = "deleteSectorsBackups";
private _return = "";
_isSuccess = false;

_return = ([_queryName] call LB_fnc_database_executeQuery) select 0;
if (_return isEqualTo 1) then { _isSuccess = true; } else { _isSuccess = false; };

_isSuccess