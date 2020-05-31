/*
 * Author: super-truite
 * Saves every units and delete them
 *
 * Arguments:
 *
 * Return Value:
 * Array of units <ARRAY>
 *
 * Example:
 * [] call GCS_fnc_grid_cacheAll;
 *
 * Public: No
 */

// number of grid squares on each axis
params["_disableSaving"];
_N = ceil(worldSize / GCS_VAR_SIZE_SQUARE_GRID);

// define a variable in each unit namespace. Only those units will be handled by grid
{
	if (isNil { _x getVariable "UseGrid" }) then
	{
		_x setVariable ["UseGrid", True];
	}
} forEach (allUnits+vehicles);

// deleting and saving units for each sectors
_tableUnitsAllGrid = [];
for "_ix" from 0 to (_N - 1) step 1 do
{
	for "_iy" from 0 to (_N - 1) step 1 do
	{
		_tableUnits = [];
		if (isNil "_disableSaving") then
		{
			_tableUnits = [[_ix, _iy]] call GCS_fnc_grid_deactivateSector;
		} else {
			_tableUnits = [[_ix, _iy], _disableSaving] call GCS_fnc_grid_deactivateSector;
		};
		//diag_log str _tableUnits;
		_tableUnitsAllGrid pushBack _tableUnits;
	};
};
TABLE_INIT_DONE = true;
_tableUnitsAllGrid