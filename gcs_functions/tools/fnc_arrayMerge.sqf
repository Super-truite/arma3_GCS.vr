/*
 * Author: super-truite
 * combine 2 arrays [a_0, a_1, ...] and [b_0, b_1, ...]
 * into : [[a_0, b_0], [a_1, b_1], ...]
 * Arguments:
 * 0: array_1 <ARRAY>
 * 1: array_2 <ARRAY>
 * Return Value:
 * <ARRAY>
 *
 * Example:
 * [_array1, _array2] call GCS_fnc_tools_arrayMerge;
 *
 * Public: No
 */
params["_array1", "_array2"];
private _array = [];
{
	_array pushBack [_x, _array2 select _foreachIndex];
} forEach _array1;
_array