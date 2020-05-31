/*
 * Author: Anthariels
 * Initializes a connection to a specified database
 * Connection state can be retrieved with the 'GCS_VAR_DATABASE_ISCONNECTED' local variable
 *
 * Arguments:
 *
 * Return Value:
 *
 * Example:
 * call GCS_fnc_database_connect;
 *
 * Public: No
 */


// Database connection
GCS_VAR_DATABASE_INSTANCE = dbCreateConnection GCS_VAR_DATABASE_NAME;
GCS_VAR_DATABASE_ISCONNECTED = dbPing GCS_VAR_DATABASE_INSTANCE;

if (GCS_VAR_DATABASE_ISCONNECTED isEqualTo false) then {	"An error occured while trying to connect to the database, please see previous logs for more details." call BIS_fnc_log; };