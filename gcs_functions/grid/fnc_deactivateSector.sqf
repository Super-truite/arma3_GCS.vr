/*
 * Author: super-truite
 * deactivate sector (unspawn units for instance)
 *
 * Arguments:
 * 0: grid index [ix, iy] <ARRAY>
 * Return Value:
 * array of the form [[vehicle array], [drivers array], [gunners array],[turrets array], [commanders array], [cargo units array],
 * [infantery groups array]] <ARRAY>
 *
 * Example:
 * [[0,1]] call GCS_fnc_grid_deactivateSector;
 *
 * Public: No
 */
params["_gridIndex", "_disableSaving", "_disableRemove"];
private ["_center", "_tableUnits", "_isleader", "_isInside", "_className", "_damage", "_position", "_direction", "_unitPos", "_groupName", "_isleader", "_rank", "_skill", "_i"];
private _GCS_VAR_SIZE_SQUARE_GRID = GCS_VAR_SIZE_SQUARE_GRID; // Stores the local variable in a private one for performances purposes

_i = GRID_COORDINATES find _gridIndex;
if (_i == -1) exitWith {};


_start = diag_tickTime;
_center = [_gridIndex, _GCS_VAR_SIZE_SQUARE_GRID] call GCS_fnc_grid_gridToPos;
_tableUnits = [];
_unitsCount = 0;

// Remove vehicles, crew and cargo
_vehiclesArray = [];
_cargoArray = [];
{
	// delete and save vehicles only if variable "UseGrid" is defined
	if (not isNil { _x getVariable "UseGrid" }) then
	 {
	 	if (_x getVariable "UseGrid" ) then
	 	{
	 		_pos = getpos _x;
			_isInside = _pos inArea [_center, _GCS_VAR_SIZE_SQUARE_GRID/2, _GCS_VAR_SIZE_SQUARE_GRID/2, 0, true];
			if (_isInside) then
			{
				_save = [_x, 0] call GCS_fnc_grid_saveUnits_getVehicleInfo;
				if (damage _x < 1) then
				{
					_vehiclesArray pushBack _save;
				};

				if (isNil "_disableRemove") then {
					{deleteVehicle _x;}forEach crew _x;
					deleteVehicle _x;
				};
			};
		};
	 };
} forEach ([] call GCS_fnc_tools_getAllVehicles);

_tableUnits pushBack _vehiclesArray;

// Gets the player list so that we do not store any player (or playable) units
//TODO: can be removed after tests as players should not be inside deactivated area (they can be only when teleporting)
_playableList = [] call GCS_fnc_tools_getPlayerList;

_infanteryGroupsArray = [];
{
	if (not isNil { (leader _x) getVariable "UseGrid" }) then
	 {
	 	if ((leader _x) getVariable "UseGrid" ) then
	 	{
			if (not (leader _x in _playableList)) then
			{
				_isInside = (leader _x) inArea [_center, _GCS_VAR_SIZE_SQUARE_GRID/2, _GCS_VAR_SIZE_SQUARE_GRID/2, 0, true];
				if (_isInside) then {
					_group = _x;
					_groupIndex = _foreachIndex;
					{

						_groupName = format ["group_%1", _groupIndex];
						_array = [_x, _group, _groupName] call GCS_fnc_grid_saveUnits_getUnitInfo;

						// TODO: Find a way to store dead units (currently, the dead units are represented as entites so we do not store them)
						if (not ((getDammage _x) isEqualTo 1.0)) then {
							_infanteryGroupsArray pushBack _array;
							_unitsCount = _unitsCount + 1;
						};
						if (isNil "_disableRemove") then {
							deleteVehicle _x;
						};

					} forEach (units _x);
					if (isNil "_disableRemove") then {
						deleteGroup _group;
					};
				};
			};
		};
	};
} forEach allGroups;
_tableUnits pushBack _infanteryGroupsArray;

if (GCS_VAR_GRIDSYSTEM_ENABLE_DATABASE isEqualTo true) then {

	// Adds or updates the sectors units in the database if at least one unit is in the sector and the _disableSaving parameters is nil
	if (isNil "_disableSaving") then {
		if (_unitsCount > 0) then { [_i, "UNITS", _tableUnits] call GCS_fnc_grid_addOrUpdateSectorObject; };
	};

} else {

	// Updates the TABLE_INIT_UNITS local variable
	if (TABLE_INIT_DONE) then { TABLE_INIT_UNITS set [_i, _tableUnits];	};

};

_end = diag_tickTime;
if (_unitsCount > 0) then { ["Grid %1 unloaded with %2 units in %3 seconds", _gridIndex, _unitsCount, (_end - _start)] call BIS_fnc_logFormat; }; //DEBUG
_tableUnits