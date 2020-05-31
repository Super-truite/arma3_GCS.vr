/*
 * Author: super-truite
 * Create an unit
 *
 * Arguments:
 * 0: Name of the unit <STRING>
 * 1: Class name <STRING>
 * 2: Side <STRING>
 * 3: Damage <NUMBER>
 * 4: Position <ARRAY>
 * 5: Direction <NUMBER>
 * 6: Unit Pos ("UP", "DOWN", "MIDDLE", "AUTO") <STRING>
 * 7: Group  <OBJECT>
 * 8: Leader <OBJECT>
 * 9: Rank <NUMBER>
 * 10: Skill <NUMBER>
 *
 * Return Value:
 * Unit <OBJECT>
 *
 * Example:
 * ["Alfred", "O_Soldier_F", EAST, 1, [3923.97,2935.87,0], 150, "CROUCH", _group, 1, "LIEUTENANT", 0.5, 0.6] call GCS_fnc_grid_loadUnits_createUnit;
 *
 * Public: No
 */

params["_name", "_type", "_side", "_damage", "_position", "_direction", "_unitPos", "_group","_leader", "_rank", "_skill"];

_unit = _group createUnit [_type, _position, [], 0, "CAN_COLLIDE"];
_unit setName _name;
_unit setDir _direction;
_unit setPosASL _position;
_unit setRank _rank;
_unit setSkill _skill;
_unit setUnitPos _unitPos;
_unit setDamage _damage;

if ((alive _unit) && !(isnull _leader)) then
{
	[_unit] join (group _leader);
};

_unit