/*
	Author: Karel Moricky
	(modified by super-truite)
	Description:
	Save vehicle's params (textures, animations, crew)

	Parameter(s):
		0: OBJECT - saved vehicle

	Returns:
	ARRAY - saved value
*/
params["_veh"];

//--- Get current values
private ["_animations","_crew","_export"];
_animations = [];
{
	_anim = configname _x;
	_animations pushback [_anim,_veh animationphase _anim];
} foreach (configProperties [configfile >> "CfgVehicles" >> typeof _veh >> "animationSources","isclass _x",true]);
_crew = [];
{
	_member = _x select 0;
	_role = _x select 1;
	_index = if (_role == "turret") then {_x select 3} else {_x select 2};
	if (alive _member) then
	{
		_crew pushback [typeof _member,_role,_index];
	};
} foreach fullcrew _veh;

_export = [
	/* 00 */	typeof _veh,
	/* 01 */	_animations,
	/* 02 */	getobjecttextures _veh,
	/* 03 */	_crew
];
_export