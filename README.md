# PostgreSQL
PostgreSQL Tutorial

##### install PostgreSQL on windows with zip file #####
1) Download and extract zip file from following url
https://www.enterprisedb.com/download-postgresql-binaries
2) Set environment variables for PostgreSQL bin and lib in system variables
3) Check PostgreSQL version using command 
~ postgres --version
4) Create "data" folder into "pgsql" and use following command
5) Set new system environment variable for database directory i.e. variable name : PGDATA  variable value : D:\postgresql-16.2-1-windows-x64-binaries\pgsql\data
6) Run following command according to initdb.exe and data folder path
~ D:\postgresql-16.2-1-windows-x64-binaries\pgsql\bin\initdb.exe -U postgres -A password -E utf8 -W -D D:\postgresql-16.2-1-windows-x64-binaries\pgsql\data
7) Set password for superuser 
8) Start PostgreSQL
~ pg_ctl -l logfile start
9) Stop PostgreSQL
~ pg_ctl -l logfile stop
10) Restart PostgreSQL
~ pg_ctl -l logfile restart

##### How to use pgAdmin4 from browser #####
1) Open pgadmin4 
2) Navigate to Open File > Runtime > View Log
	Scroll untill the bottom then you will find the following Application Server URL: http://127.0.0.1:{PORT_NUMBER}/?key={YOUR_KEY}
	http://127.0.0.1:59931/?key=YOUR_KEY 
	Copy this and open in your browser               



