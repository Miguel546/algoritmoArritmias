function [conn] = conexion(dbname, username, password, driver, dburl)
% dbname = 'mitarrythmiadatabase'; 
% username = 'root';
% password = 'root';
% driver = 'com.mysql.jdbc.Driver';
% dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('mysql-connector-java-5.1.47.jar');
%javaclasspath('C:\mysql\mysql-connector-java-8.0.13\mysql-connector-java-8.0.13.jar');
conn = database(dbname, username, password, driver, dburl);
