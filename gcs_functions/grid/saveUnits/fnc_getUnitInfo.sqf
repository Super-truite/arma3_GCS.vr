/*
 * Author: super-truite
 * get array of info needed to save an unit to db
 *
 * Arguments:
 * 0: unit <OBJECT>
 * Return Value:
 * array of info (pos, name, dir etc.) <ARRAY>
 *
 * Example:
 * [_unit] call GCS_fnc_grid_saveUnits_getUnitInfo;
 *
 * Public: No
 */
params["_unit", "_group", "_groupName"];
private ["_nameUnit", "_className", "_side", "_damage", "_position", "_direction", "_unitPos"];
private ["_isleader", "_rank", "_skill", "_waypointsInfo"];
_nameUnit = name _unit;
_className = typeof _unit;
_side = side _unit;
_damage = getDammage _unit;
_position = getPosASL _unit;
_direction = getDir _unit;
_unitPos = unitPos _unit;
_isleader = ((leader _group) isEqualTo _unit);
_rank = rank _unit;
_skill = skill _unit;
// save waypoints if unit is leader
if (_isleader) then
{
	_waypointsInfo = [group _unit] call GCS_fnc_grid_saveUnits_saveWaypoints;
	[_nameUnit, _className, str _side, _damage, _position, _direction, _unitPos, _groupName, str _isleader, _rank, _skill, _waypointsInfo]
}
else
{
	[_nameUnit, _className, str _side, _damage, _position, _direction, _unitPos, _groupName, str _isleader, _rank, _skill]
};