package utils;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * @author quocb
 */
public class DBUtils {

    public static Connection makeConnection() throws Exception {
        Connection cn = null;
//        String IP="localhost";
//        String instanceName="BAROX-LAP\\BAROX2";
//        String port="1433";
//        String uid="sa";
//        String pwd="12345";
//        String db="ULMDatabase";
//        String driver="com.microsoft.sqlserver.jdbc.SQLServerDriver";
//        String url= "jdbc:sqlserver://localhost:1433;databaseName=ULMDatabase";
//        String url="jdbc:sqlserver://" +IP+"\\"+ instanceName+":"+port 
//                 +";databasename="+db+";user="+uid+";password="+pwd;
        String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        String password = "Fullstack123";
        String url = "jdbc:sqlserver://ulm-server.database.windows.net:1433;database=ULMDatabase;user=ulmteam@ulm-server;password=" + password + ";encrypt=true;trustServerCertificate=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;useUnicode=true;characterEncoding=UTF-8";
        Class.forName(driver);
        cn = DriverManager.getConnection(url);
        return cn;
    }
}