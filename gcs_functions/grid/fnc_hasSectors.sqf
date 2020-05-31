/*
 * Author: Anthariels
 * Returns wheter or not one or more sector is stored in the database
 * This can be used to decide if we should overwrite sectors data for example
 *
 * Arguments:
 *
 * Return Value:
 * False if no sectors is stored, true otherwise <BOOLEAN>
 *
 * Example:
 * call GCS_fnc_grid_hasSectors;
 *
 * Public: No
 */

private _queryName = "hasSectors";
_queryResult = 0;
_return = false;

_queryResult = ([_queryName] call GCS_fnc_database_executeQuery) select 0;
if ((_queryResult isEqualType 0) && (_queryResult > 0)) then { _return = true; } else { _return = false; };

_return