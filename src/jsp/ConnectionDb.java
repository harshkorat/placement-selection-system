package jsp;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionDb {
	public static Connection connect()
	{
		try
		{				
			Class.forName("com.mysql.jdbc.Driver");  
			
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/placement","root","root");   
			
			return con;
		}
		catch(Exception ex){
			System.out.println("An Connection: " + ex);
		}
		
		return null;
	}
}	
