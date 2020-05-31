/*
 * Author: super-truite
 * spawn infantery groups from db array
 *
 * Arguments:
 * 0: array of units <ARRAY>
 * Return Value:
 *
 * Example:
 * [_array] call GCS_fnc_grid_loadUnits_createInfanteryGroups;
 *
 * Public: No
 */
params["_infanteryGroupsArray"];
private ["_groups", "_groupsNames", "_leaders", "_nameUnit", "_className", "_side", "_damage", "_position", "_direction", "_unitPos"];
private ["_groupName", "_isleader", "_rank", "_skill", "_group0", "_unit", "_index"];
_groups = [];
_groupsNames = [];
_leaders = [];
{
	_nameUnit = _x select 0;
	_className = _x select 1;
	_side = [_x select 2] call GCS_fnc_tools_getSideFromString;
	_damage = _x select 3;
	_position = _x select 4;
	_direction = _x select 5;
	_unitPos = _x select 6;
	_groupName = _x select 7;
	_isleader = call compile (_x select 8);
	_rank = _x select 9;
	_skill = _x select 10;

	if (_isleader) then
	{
		_waypointsInfo = _x select 11;
		_group0 = createGroup [_side, false];
		_groups pushBack _group0;
		_groupsNames pushBack _groupName;
		_unit = [_nameUnit, _className, _side, _damage, _position, _direction, _unitPos, _group0, objNull, _rank, _skill] call GCS_fnc_grid_loadUnits_createUnit;
		_unit setVariable ["UseGrid", True];
		_leaders pushBack _unit;
		if (count _waypointsInfo > 1) then
		{
			[_group0, _waypointsInfo] call GCS_fnc_grid_loadUnits_setWaypoints;
		};

	}
	else{
		_index = _groupsNames find _groupName;
		if (_index != -1) then
		{
			_unit = [_nameUnit, _className, _side, _damage, _position, _direction, _unitPos, _groups select _index, _leaders select _index, _rank, _skill] call GCS_fnc_grid_loadUnits_createUnit;
			_unit setVariable ["UseGrid", True];
		};
	};

} forEach _infanteryGroupsArray;
