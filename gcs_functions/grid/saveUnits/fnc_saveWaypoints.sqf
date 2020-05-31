/*
 * Author: super-truite
 * save the list of waypoints of a group and their properties
 *
 * Arguments:
 * 0: group <OBJECT>
 * Return Value:
 * array of waypoints <ARRAY>
 *
 * Example:
 * [_group] call GCS_fnc_grid_saveUnits_saveWaypoints;
 *
 * Public: No
 */
 params["_group"];
_waypointsInfo = [];
{
	_waypoint = [];
	_waypoint pushBack _foreachIndex;
	_waypoint pushBack (waypointType _x);
	_waypoint pushBack (waypointPosition _x);
	_waypoint pushBack ( waypointCompletionRadius _x);
	_waypoint pushBack (waypointName _x);
	_waypoint pushBack (waypointBehaviour _x);
	_waypoint pushBack (waypointFormation _x);
	_waypoint pushBack (waypointStatements _x);
	_waypoint pushBack (waypointTimeout _x);
	_waypoint pushBack (waypointScript _x);

	if (_foreachIndex > 0) then
	{
		_waypointsInfo pushBack _waypoint;
	};

} forEach  waypoints _group;
_waypointsInfo