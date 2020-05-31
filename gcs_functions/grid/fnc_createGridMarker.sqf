/*
 * Author: super-truite
 * Given an activation distance, find all the grid squares that are activated from a position
 *
 * Arguments:
 * 0: Position indices (ix, iy) <ARRAY>
 * 1: Name <STRING>
 * 2: Marker size <NUMBER>
 * 3: Color <STRING>
 * 4: Grid square size <NUMBER>
 *
 * Return Value:
 * Marker name <STRING>
 *
 * Exemple:
 * [[0,1],'grid', 1000, 'ColorRed', 1000] call GCS_fnc_grid_createGridMarker;
 *
 * Public: No
 */

params["_posGrid", "_name", "_size", "_color", "_gridSquareSize"];
private["_marker", "_pos"];

_pos = [_posGrid, _gridSquareSize] call GCS_fnc_grid_gridToPos;

/* Test Anthariels -> Displays the spawn area for each sector

	_spawnMarker = format ["%1_spawnArea_%2_%3", _name, _posGrid select 0, _posGrid select 1];
	_spawnMarker = createMarker [_spawnMarker,  _pos];
	_spawnMarker setMarkerSize [_size/(GCS_VAR_SIZE_ACTIVATION_SQUARE_GRID/1000), _size/(GCS_VAR_SIZE_ACTIVATION_SQUARE_GRID/1000)];
	_spawnMarker setMarkerShape "RECTANGLE";
	_spawnMarker setMarkerBrush "SolidBorder";
	_spawnMarker setMarkerColor "ColorRed";
	_spawnMarker setMarkerAlpha .5;

*/

_marker = format ["%1_%2_%3", _name, _posGrid select 0, _posGrid select 1];
_marker = createMarker [_marker,  _pos];
_marker setMarkerSize [(_size/2)-.1, (_size/2)-.1];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerBrush "SolidBorder";
_marker setMarkerColor _color;

_marker