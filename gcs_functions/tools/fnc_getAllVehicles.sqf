/*
 * Author: super-truite
 * get all vehicles of type Air, Ship or Land Vehicle
 *
 * Arguments:
 * Return Value:
 * list of vehicles <ARRAY>
 *
 * Example:
 * [] call GCS_fnc_tools_getAllVehicles;
 *
 * Public: No
 */
private['_vehicles'];
_vehicles = [];
 {
 	if ((_x isKindOf "Air") or(_x isKindOf "LandVehicle") or (_x isKindOf "Ship")) then
 	{
 		_vehicles pushBack _x;
 	};
 } forEach vehicles;
 _vehicles