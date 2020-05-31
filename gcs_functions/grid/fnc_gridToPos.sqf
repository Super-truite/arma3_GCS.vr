/*
 * Author: super-truite
 * Transforms a position in grid coordinates [ix, iy] to [X,Y,Z] coordinates
 *
 * Arguments:
 * 0: Position [ix, iy]  <ARRAY>
 * 1: Grid size of squares in meters <NUMBER>
 *
 * Return Value:
 * Position [X, Y, 0] <ARRAY>
 *
 * Example:
 * [[0, 0], 1000] call GCS_fnc_grid_gridToPos;
 *
 * Public: No
 */

params['_pos', '_gridSquareSize'];
[(_pos select 0) * _gridSquareSize + _gridSquareSize/2, (_pos select 1) * _gridSquareSize + _gridSquareSize/2, 0]