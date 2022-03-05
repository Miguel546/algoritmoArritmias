function [conn] = conexion(dbname, username, password, driver, dburl)
% dbname = 'mitarrythmiadatabase'; 
% username = 'user';
% password = 'pass';
% driver = 'com.mysql.jdbc.Driver';
% dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('mysql-connector-java-5.1.47.jar');
conn = database(dbname, username, password, driver, dburl);
