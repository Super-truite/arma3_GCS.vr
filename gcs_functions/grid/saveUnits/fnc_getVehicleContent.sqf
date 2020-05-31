/*
 * Author: super-truite
 * get array of vehicle cargo content to save it to db
 *
 * Arguments:
 * 0: vehicle <OBJECT>
 * Return Value:
 * array of magazines, weapons, backpacks and items <ARRAY>
 *
 * Example:
 * [_veh] call GCS_fnc_grid_saveUnits_getVehicleContent;
 *
 * Public: No
 */
params["_veh"];
[(getMagazineCargo _veh) call GCS_fnc_tools_arrayMerge,
 (getWeaponCargo _veh) call GCS_fnc_tools_arrayMerge,
 (getBackpackCargo _veh) call GCS_fnc_tools_arrayMerge ,
 (getItemCargo _veh) call GCS_fnc_tools_arrayMerge]
