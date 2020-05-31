/*
	Author: Karel Moricky
	(modified by super-truite)

	Description:
	Load vehicle look

	Parameter(s):
		0: OBJECT - object which will receive the params
		1: ARRAY saved using GCS_fnc_grid_saveUnits_modifiedSaveVehicle

	Returns:
	BOOL
*/
params["_object", "_params"];
{_x set [2,true]; _object animate _x; _object animateDoor _x;} foreach (_params select 1);
{_object setobjecttexture [_foreachindex,_x];} foreach (_params select 2);
[_object, (_params select 3), true] call GCS_fnc_grid_loadUnits_modifiedInitVehicleCrew;
