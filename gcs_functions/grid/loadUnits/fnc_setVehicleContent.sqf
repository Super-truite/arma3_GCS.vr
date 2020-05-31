/*
 * Author: super-truite
 * get array of vehicle cargo content to save it to db
 *
 * Arguments:
 * 0: vehicle <OBJECT>
 * 1: array of magazines, weapons, backpacks, items <ARRAY>
 * Return Value:
 *
 *
 * Example:
 * [_veh, _array] call GCS_fnc_grid_loadUnits_setVehicleContent;
 *
 * Public: No
 */
params["_veh", "_array"];
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;
clearBackpackCargoGlobal _veh;
clearItemCargoGlobal _veh;
{
	_veh addMagazineCargoGlobal _x;
} forEach (_array select 0);
{
	_veh addWeaponCargoGlobal _x;
} forEach (_array select 1);
{
	_veh addBackpackCargoGlobal _x;
} forEach (_array select 2);
{
	_veh addItemCargoGlobal _x;
} forEach (_array select 3);

