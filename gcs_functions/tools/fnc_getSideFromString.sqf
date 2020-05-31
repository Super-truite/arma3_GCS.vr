/*
 * Author: super-truite
 * get side from side string
 *
 * Arguments:
 * 0: side string <STRING>
 * Return Value:
 * side <SIDE>
 * Example:
 * ["WEST"] call GCS_fnc_tools_getSideFromString;
 *
 * Public: No
 */
 params["_sideString"];
_keys = ["WEST","EAST","GUER","CIV"];
_values = [west,east,independent,civilian];
_values select (_keys find _sideString)