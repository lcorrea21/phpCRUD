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

$databaseHost = 'localhost:3306';
$databaseName = 'php_mysql_crud';
$databaseUsername = 'prueba';
$databasePassword = 'Password.123';

$mysqli = mysqli_connect($databaseHost, $databaseUsername, $databasePassword, $databaseName); 
	
?>
