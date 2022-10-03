-- drop, create and connect to TRADES@
echo *******************************************************@
echo the following command may fail because the database did@
echo NOT previously exist, this is an acceptable error@
echo *******************************************************@
drop database TRADES  @
create database TRADES   @
connect to TRADES   @

-- catalog TRADES as a odbc data source
catalog system odbc data source TRADES  @

-- create the schema
CREATE SCHEMA IIBADMIN  @


commit @