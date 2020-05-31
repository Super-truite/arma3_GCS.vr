/*
 * Author: Anthariel
 * Adds a query to the buffer, use this only for queries that can have a differed execution and where no returns is expected or needed
 * Todo -> Use QueryAsync instead
 *
 * Arguments:
 * 1: Query name <STRING>
 * 2: Query parameter(s) <ARRAY>
 * 3: Query priority <STRING> (LOW, MEDIUM, HIGH)
 *
 * Return Value:
 *
 * Example:
 * ["myQuery", [west, (getPos player), "myString", [1234.12, 4321.21, 100], 10.1, 10], "HIGH"] call GCS_fnc_database_addToBuffer;
 *
 * Public: No
 */

params["_queryName", "_queryParameters", "_priority"];
private _queryId = [40] call GCS_fnc_tools_getRandomString;


// Run a simple pre-defined SQL query into the database
switch (_priority) do {
    case "HIGH": { GCS_VAR_DATABASE_BUFFER_HIGHPRIORITY pushBack [_queryId, _queryName, _queryParameters]; };
    case "MEDIUM": { GCS_VAR_DATABASE_BUFFER_MEDIUMPRIORITY pushBack [_queryId, _queryName, _queryParameters]; };
    case "LOW": { GCS_VAR_DATABASE_BUFFER_LOWPRIORITY pushBack [_queryId, _queryName, _queryParameters]; };
    default { GCS_VAR_DATABASE_BUFFER_LOWPRIORITY pushBack [_queryId, _queryName, _queryParameters]; };
};