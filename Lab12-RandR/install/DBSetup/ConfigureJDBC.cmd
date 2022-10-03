@rem ConfigureJDBC
@rem (c) Copyright IBM Corp. 2015 
@rem US Government Users Restricted Rights - Use duplication or
@rem disclosure restricted by GSA ADP Schedule Contract with
@rem IBM Corp

mqsicreateconfigurableservice IIBNODE_WITHQM -c JDBCProviders -o TRADES -n databaseName -v TRADES
mqsichangeproperties IIBNODE_WITHQM -c JDBCProviders -o TRADES -n databaseType -v DB2
mqsichangeproperties IIBNODE_WITHQM -c JDBCProviders -o TRADES -n connectionUrlFormat -v "jdbc:db2://[serverName]:[portNumber]/[databaseName]:user=[user];password=[password];"
mqsichangeproperties IIBNODE_WITHQM -c JDBCProviders -o TRADES -n serverName -v localhost
mqsichangeproperties IIBNODE_WITHQM -c JDBCProviders -o TRADES -n portNumber -v 50000
mqsichangeproperties IIBNODE_WITHQM -c JDBCProviders -o TRADES -n jarsURL -v "%DB2PATH%\java"
mqsichangeproperties IIBNODE_WITHQM -c JDBCProviders -o TRADES -n type4DatasourceClassName -v com.ibm.db2.jcc.DB2XADataSource
mqsichangeproperties IIBNODE_WITHQM -c JDBCProviders -o TRADES -n type4DriverClassName -v com.ibm.db2.jcc.DB2Driver
mqsisetdbparms IIBNODE_WITHQM -n TRADES -u iibadmin -p web1sphere
mqsisetdbparms IIBNODE_WITHQM -n jdbc::JDBC -u iibadmin -p web1sphere 
mqsistop IIBNODE_WITHQM
mqsistart IIBNODE_WITHQM

mqsireportproperties IIBNODE_WITHQM -c JDBCProviders -o TRADES -r

