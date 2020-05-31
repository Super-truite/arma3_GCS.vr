/*
 * Author: Anthariels
 * Backup the sector table to another table
 *
 * Arguments:
 *
 * Return Value:
 *
 * Exemple:
 * _backupState = call GCS_fnc_grid_backupSectors;
 *
 * Public: No
 */

private _queryName = "backupSectors";
private _return = "";
_isSuccess = false;

_return = ([_queryName] call GCS_fnc_database_executeQuery) select 0;
if (_return isEqualTo 1) then { _isSuccess = true; } else { _isSuccess = false; };

_isSuccess