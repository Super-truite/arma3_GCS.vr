/*
 * Author: super-truite
 * get array of info needed to save a vehicle to db
 *
 * Arguments:
 * 0: vehicle <OBJECT>
 * 1: index of the vehicle in sector <INT>
 * Return Value:
 * array of info (pos, name, dir etc.) <ARRAY>
 *
 * Example:
 * [_veh, 0] call GCS_fnc_grid_saveUnits_getVehicleInfo;
 *
 * Public: No
 */
params["_veh", "_index"];
private ["_nameVehicle", "_className", "_damage", "_position", "_direction", "_basicInfo", "_saveVehicle", "_saveCargo"];
_nameVehicle = format ["%1_%2", typeof _veh, _index];
_className = typeof _veh;
_damage = getDammage _veh;
_position = getPosATL _veh;
_direction = getDir _veh;
_basicInfo = [_nameVehicle, _className, _damage, _position, _direction];
_saveVehicle = [_veh] call GCS_fnc_grid_saveUnits_modifiedSaveVehicle;
_saveCargo =  [_veh] call GCS_fnc_grid_saveUnits_getVehicleContent;

if (not isNull (driver _veh)) then
{
	_waypointsDriver = [group driver _veh] call GCS_fnc_grid_saveUnits_saveWaypoints;
	[_basicInfo, _saveVehicle, _saveCargo, _waypointsDriver]
}
else
{
	[_basicInfo, _saveVehicle, _saveCargo]
};
