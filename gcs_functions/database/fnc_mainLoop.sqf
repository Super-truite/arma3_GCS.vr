/*
 * Author: Anthariel
 * Returns a boolean to indicate whether or not a simple query can be executed on the SQL Server (indicating a successfull database connection and configuration)
 *
 * Arguments:
 * 1: Query name as defined in the custom SQL file <STRING>
 * 2: Parameters values to pass to the query <ARRAY>
 *
 * Return Value:
 *
 * Example:
 * [] spawn GCS_fnc_database_mainLoop;
 *
 * Public: No
 */

private _databaseState = GCS_VAR_DATABASE_ISCONNECTED;
private _highPriorityQueries = "";
private _mediumPriorityQueries = "";
private _lowPriorityQueries = "";
private _lowPriorityQueriesToRuns = [];
private _highPriorityQueriesCnt = 0;
private _mediumPriorityQueriesCnt = 0;
private _lowPriorityQueriesCnt = 0;
private _mediumQueriesDelay = .025;
private _lowQueriesDelay = .05;
private _maxLowQueryPerIteration = 50;
private _waitTimePerIteration = 1;

// Pre-conditions validation
if (!assert (_databaseState isEqualTo true)) exitWith { ["ERROR: The database is not initialized."] call BIS_fnc_logFormat; };

while {true} do {

	// Updates the database local buffer from the global buffer
	_highPriorityQueries = GCS_VAR_DATABASE_BUFFER_HIGHPRIORITY;
	_mediumPriorityQueries = GCS_VAR_DATABASE_BUFFER_MEDIUMPRIORITY;
	_lowPriorityQueries = GCS_VAR_DATABASE_BUFFER_LOWPRIORITY;

	_highPriorityQueriesCnt = count (_highPriorityQueries);
	_mediumPriorityQueriesCnt = count (_mediumPriorityQueries);
	_lowPriorityQueriesCnt = count (_lowPriorityQueries);



	/* HIGH PRIORITY */
	// Runs the high priority queries immediatly
	if (_highPriorityQueriesCnt > 0) then
	{
		for "_i" from 0 to (_highPriorityQueriesCnt-1) do {
			(_highPriorityQueries select _i) select [1, 2] call GCS_fnc_database_executeQuery;
		};

		GCS_VAR_DATABASE_BUFFER_HIGHPRIORITY = GCS_VAR_DATABASE_BUFFER_HIGHPRIORITY - _highPriorityQueries;
	};



	/* MEDIUM PRIORITY */
	// Runs the medium priority queries with some delay
	if (_mediumPriorityQueriesCnt > 0) then
	{
		for "_i" from 0 to (_mediumPriorityQueriesCnt-1) do {
			(_mediumPriorityQueries select _i) select [1, 2] spawn GCS_fnc_database_executeQuery;
			sleep _mediumQueriesDelay;
		};

		GCS_VAR_DATABASE_BUFFER_MEDIUMPRIORITY = GCS_VAR_DATABASE_BUFFER_MEDIUMPRIORITY - _mediumPriorityQueries;
	};



	/* LOW PRIORITY */
	// Runs the low priority queries with some delay and with a maximum number allowed per iteration
	if (_lowPriorityQueriesCnt > 0) then
	{
		if (_lowPriorityQueriesCnt > _maxLowQueryPerIteration) then { _lowPriorityQueriesCnt = _maxLowQueryPerIteration; };
		for "_i" from 0 to (_lowPriorityQueriesCnt-1) do {
			(_lowPriorityQueries select _i) select [1, 2] spawn GCS_fnc_database_executeQuery;

			_lowPriorityQueriesToRuns pushBack (_lowPriorityQueries select _i);
			sleep _lowQueriesDelay;
		};

		GCS_VAR_DATABASE_BUFFER_LOWPRIORITY = GCS_VAR_DATABASE_BUFFER_LOWPRIORITY - _lowPriorityQueriesToRuns;
		_lowPriorityQueriesToRuns = [];
	};

	sleep _waitTimePerIteration;
};