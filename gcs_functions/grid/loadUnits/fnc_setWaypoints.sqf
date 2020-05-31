/*
 * Author: super-truite
 * create waypoint from a list of waypoints properties
 *
 * Arguments:
 * 0: group that will get the waypoints <GROUP>
 * 0: array of waypoint properties <ARRAY>
 * Return Value:
 *
 *
 * Example:
 * [_group, _waypointsInfo] call GCS_fnc_grid_loadUnits_setWaypoints;
 *
 * Public: No
 */
 params["_group", "_waypointsInfo"];
{
	_waypoint = _group addWaypoint [_x select 2, _x select 3/*, _x select 0, _x select 4*/];
	_waypoint setWaypointType (_x select 1);
	_waypoint setWaypointBehaviour (_x select 5);
	_waypoint setWaypointFormation (_x select 6);
	//_waypoint setWaypointStatements (_x select 7);
	//_waypoint setWaypointStatements ["true","format[""%1"", random 1] remoteExec [""systemChat""];"];
	_waypoint setWaypointTimeout (_x select 8);
	_waypoint setWaypointScript (_x select 9);
} forEach  _waypointsInfo;


