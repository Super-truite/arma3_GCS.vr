/*
 * Author: Anthariel
 * Returns a boolean to indicate whether or not a simple query can be executed on the SQL Server (indicating a successfull database connection and configuration)
 *
 * Arguments:
 * 1: Query name as defined in the custom SQL file <STRING>
 * 2: Parameters values to pass to the query <ARRAY>
 *
 * Return Value:
 * Boolean, Return (depends on the query return and nil if the query failed)
 *
 * Example:
 * _queryResult = ["myQuery", [1, 2.123, "hi", west, [1234.012,4321.210,100.00]]] call GCS_fnc_database_executeQuery;
 * diag_log format ["myQuery result is: %1 and return content is: %2!", (_queryResult select 0), (_queryResult select 1)];
 *
 * Public: No
 */

params["_queryName","_queryParameters"];
_unPreparedQueryIndex = -1;
_unPreparedQuery = "";
_preparedQuery = "";

// Retrieves the query in the global array of queries
_unPreparedQueryIndex = GCS_VAR_DATABASE_QUERIES find _queryName;
if (_unPreparedQueryIndex >= 0) then { _unPreparedQuery = GCS_VAR_DATABASE_QUERIES select _unPreparedQueryIndex+1; };

// Prepares the query with given (or not) parameters
if (!(isNil "_queryParameters")) then {
	_preparedQuery = dbPrepareQuery [_unPreparedQuery, _queryParameters];
};
if (_preparedQuery isEqualType "") then { _preparedQuery = dbPrepareQuery _unPreparedQuery; };

dbResultToParsedArray (GCS_VAR_DATABASE_INSTANCE dbExecute _preparedQuery) select 0;