<?php
/*
// mysql_connect("database-host", "username", "password")
$conn = mysql_connect("localhost","root","root") 
			or die("cannot connected");

// mysql_select_db("database-name", "connection-link-identifier")
@mysql_select_db("test2",$conn);
*/

/**
 * mysql_connect is deprecated
 * using mysqli_connect instead
 */

$databaseHost = '127.0.0.1';
$databaseName = 'test';
$databaseUsername = 'prueba';
$databasePassword = 'Password.123';

$mysqli = new mysqli($databaseHost, $databaseUsername, $databasePassword, $databaseName); 
	
?>
