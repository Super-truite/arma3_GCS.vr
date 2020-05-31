/*
 * Author: Anthariels
 * Generates a random string based on a given length
 *
 * Arguments:
 * String lenght <NUMBER>
 *
 * Return Value:
 * String <STRING>
 *
 * Example:
 * _myRandomString = [40] call GCS_fnc_tools_getRandomString;
 *
 * Public: No
 */

private _stringLenght = _this select 0;
private _randomList = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
private _newString = [];

for "_i" from 1 to _stringLenght do { _newString pushBack (selectRandom _randomList); };

_newString joinString "";