/*
 * Author: super-truite
 * Transforms a position to the grid coordinates
 *
 * Arguments:
 * 0: Position  <ARRAY>
 * 1: Grid size of squares in meters <NUMBER>
 *
 * Return Value:
 * Grid position (i, j) <ARRAY>
 *
 * Example:
 * [getPos player, GCS_VAR_SIZE_SQUARE_GRID] call GCS_fnc_grid_posToGrid;
 *
 * Public: No
 */

params['_pos', '_gridSquareSize'];
[floor((_pos select 0) / _gridSquareSize), floor((_pos select 1) / _gridSquareSize)]