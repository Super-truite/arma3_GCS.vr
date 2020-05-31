/*
	Author: Karel Moricky
	(modified by super-truite)
	Description:
	Moves units into vehicle seats.
	When units don't exist, it will create them in a group of vehicle's side

	Parameter(s):
		0: OBJECT - vehicle
		1: ARRAY in format
			0: OBJECT or STRING - unit or unit type (will be created)
			1: STRING - role, can be "driver", "turret" or cargo"
			2: NUMBER or ARRAY - cargo index or turret path
		2 (Optional): BOOL - True to delete existing crew (default: false)
		3 (Optional): BOOL - When desired seats are occuppied, move crew in the vehicle to any other available seat (default: false)
		4 (Optional): BOOL - True to create units as agents (default: false)

	Returns:
	ARRAY of OBJECTS - units
*/

params
[
	["_veh",objnull,[objnull]],
	["_crew",[],[[]]],
	["_deleteExisting",false,[false]],
	["_moveInAny",false,[false]],
	["_createAgents",false,[false]]
];

private _grp = grpnull;
private _units = [];

if (_deleteExisting) then
{
	{_veh deletevehiclecrew _x;} foreach crew _veh;
};

private _occuppiedCargo = [];
{
	if ((_x select 1) == "cargo") then {_occuppiedCargo pushback (_x select 2);};
}
foreach (fullcrew _veh);

//--- ToDo: Ignore locked seats
private _fnc_getUnit =
{
	if (typename _unit == typename "") then
	{
		_unit = if (_createAgents) then
		{
			createagent [_unit,position _veh,[],0,"none"];
		}
		else
		{
			if (isnull _grp) then
			{
				private _vehSide = [_veh,true] call bis_fnc_objectSide;
				createcenter _vehSide;
				_grp = creategroup _vehSide;
			};
			_grp createunit [_unit,position _veh,[],0,"none"];
		};
		_units pushback _unit;
		_unit
	}
	else
	{
		_units pushback _unit;
		_unit
	};
};

{
	_x params
	[
		["_unit",[],["",objnull]],
		["_role","",[""]],
		["_index",0,[0,[]]]
	];

	switch (tolower _role) do
	{
		case "driver":
		{
			if (_veh emptypositions _role > 0) then
			{
				_unit = call _fnc_getUnit;
				_unit moveindriver _veh;
				_moveInAny = false;
			};
		};
		case "commander":
		{
			if (_veh emptypositions _role > 0) then
			{
				_unit = call _fnc_getUnit;
				_unit moveInCommander _veh;
				_moveInAny = false;
			};
		};
		case "gunner":
		{
			if (_veh emptypositions _role > 0) then
			{
				_unit = call _fnc_getUnit;
				_unit moveInGunner _veh;
				_moveInAny = false;
			};
		};
		case "turret":
		{
			if (isnull (_veh turretunit _index) && _index in allturrets _veh) then
			{
				_unit = call _fnc_getUnit;
				_unit moveinturret [_veh,_index];
				_moveInAny = false;
			};
		};
		case "cargo":
		{
			if (!(_index in _occuppiedCargo) && _veh emptypositions "cargo" > 0) then
			{
				_unit = call _fnc_getUnit;
				_unit moveincargo [_veh,_index];
				_moveInAny = false;
			};
		};
	};
	if (_moveInAny) then
	{
		_unit = call _fnc_getUnit;
		_unit moveinany _veh;
	};
}
foreach _crew;

_units