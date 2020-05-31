/*
 * Author: super-truite
 * spawn vehicles from db array
 *
 * Arguments:
 * 0: array of vehicle properties <ARRAY>
 * Return Value:
 *
 * Example:
 * [_array] call GCS_fnc_grid_loadUnits_createVehicles;
 *
 * Public: No
 */
params["_vehicleArray"];
private ["_nameVehicle", "_className", "_damage", "_position", "_direction", "_veh"];
{
	_basicInfo = _x select 0;
	_saveVehicle = _x select 1;
	_saveCargo = _x select 2;

	_nameVehicle = _x select 0;
	_className = _basicInfo select 1;
	_damage = _basicInfo select 2;
	_position = _basicInfo select 3;
	_direction = _basicInfo select 4;

	if (((_className isKindOf "plane") or (_className isKindOf "helicopter")) and ((_position select 2) > 10)) then
	 {
	 	_veh = createVehicle [_className, _position, [], 0, "FLY"];
	 }
	 else
	 {
		_veh = createVehicle [_className, _position, [], 0, "CAN_COLLIDE"];
	 };


	_veh setDamage _damage;
	_veh setDir _direction;

	_unitsveh = [_veh, _saveVehicle] call GCS_fnc_grid_loadUnits_modifiedLoadVehicle;
	waitUntil {not isNil '_unitsveh'};
	[_veh, _saveCargo] call GCS_fnc_grid_loadUnits_setVehicleContent;

	if (not isNull (driver _veh)) then
	{
		_waypointsDriver = _x select 3;
		[group driver _veh, _waypointsDriver] call GCS_fnc_grid_loadUnits_setWaypoints;
	};

	_veh setVariable ["UseGrid", True];
	{
		_x setVariable ["UseGrid", True];
	} forEach crew _veh;

} forEach _vehicleArray;
