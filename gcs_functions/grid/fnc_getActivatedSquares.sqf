/*
 * Author: super-truite
 * Given an activation distance, find all the grid squares that are activated from a position
 *
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Grid size of squares in meters <NUMBER>
 * 2: Activation "squares" distance <NUMBER>
 *
 * Return Value:
 * Grid position (i, j) <ARRAY>
 *
 * Example:
 * [getPos player, 1000, 1500] call GCS_fnc_grid_getActivatedSquares;
 *
 * Public: No
 */

params['_pos', '_gridSquareSize', '_activationDistance'];
private ["_maxIndex_x", "_maxIndex_y", "_activatedSquares"];

// x axis
_maxIndex_x = floor(((_pos select 0) + _activationDistance/2 - _gridSquareSize/2) / _gridSquareSize);
_minIndex_x = floor(((_pos select 0) - _activationDistance/2 + _gridSquareSize/2) / _gridSquareSize);
// y axis
_maxIndex_y = floor(((_pos select 1) + _activationDistance/2 - _gridSquareSize/2) / _gridSquareSize);
_minIndex_y = floor(((_pos select 1) - _activationDistance/2 + _gridSquareSize/2) / _gridSquareSize);


_activatedSquares = [];
for "_i" from  _minIndex_x to _maxIndex_x step 1 do
{
	for "_j" from _minIndex_y to _maxIndex_y step 1 do
	{
		_activatedSquares pushBack [_i, _j];
	};
};

 _activatedSquares