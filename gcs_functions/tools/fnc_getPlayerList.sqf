/*
 * Author: Super-truite
 * Get player list ( compatible with single player, multiplayer dedicated or not)
 *
 * Arguments:
 * Return Value:
 * player list <ARRAY>
 *
 * Example:
 * [] call GCS_fnc_tools_getPlayerList
 *
 * Public: No
 */
if (!isMultiplayer) then
{
	 switchableUnits
}
else
{
	if (isDedicated) then
	{
		 ((call BIS_fnc_listPlayers) - entities "HeadlessClient_F")
	}
	else
	{
		(allPlayers - entities "HeadlessClient_F")
	};
};