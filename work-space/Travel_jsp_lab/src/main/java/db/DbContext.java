package db;
import java.sql.Connection;
import java.sql.DriverManager;
public class DbContext {
	public Connection getConnection() throws Exception {
        String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName;
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, userID, password);
    }

	private final String serverName = "127.0.0.1";
	private final String dbName = "travel_db";
	private final String portNumber = "3306";
	private final String userID = "root";
	private final String password = "1234";
}
