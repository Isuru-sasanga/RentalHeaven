package com.service;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;



public class VehicleServicesDAO {
	
	String dbUrl = "jdbc:mysql://172.187.178.153:3306/isec_assessment2";
	String dbUser = "isec";
	String dbPassword = "EUHHaYAmtzbv";
   
	//getting the future result set
	   public ResultSet getFutureServices(String username) throws ClassNotFoundException, SQLException{
	    	
			ResultSet futureResultSet = null;
			Connection conn = null;

		try {
			 // Load the MySQL JDBC driver
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    
		    // Establish a database connection
		    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		  


		    // Create a SQL SELECT query for future reservations
		    String futureSql = "SELECT * FROM vehicle_service WHERE username = ? AND CONCAT(date, ' ', time) >= ? ORDER BY date, time";
		    
		    // Create PreparedStatements for both queries
		    PreparedStatement futurePreparedStatement = conn.prepareStatement(futureSql);
		    futurePreparedStatement.setString(1, username);
		    
		    // Set the parameter value (current date and time)
		    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    String currentDateTime = dateTimeFormat.format(new Date());
		    futurePreparedStatement.setString(2, currentDateTime);
		    
		    // Execute the SELECT queries
			 futureResultSet = futurePreparedStatement.executeQuery();
			 
		
			}catch (SQLException e) {
				e.printStackTrace();
				
				}
		return futureResultSet;
	        
	    }  
	   
	   
	   
 //getting the past result set
public ResultSet getPastServices(String username) throws ClassNotFoundException, SQLException {
    	
		ResultSet pastResultSet = null;
	

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	// Establish a database connection
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	
// Create a SQL SELECT query for past reservations
String pastSql = "SELECT * FROM vehicle_service WHERE username = ? AND CONCAT(date, ' ', time) < ? ORDER BY date, time";

PreparedStatement pastPreparedStatement = conn.prepareStatement(pastSql);

pastPreparedStatement.setString(1, username);

// Set the parameter value (current date and time)
SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String currentDateTime = dateTimeFormat.format(new Date());
pastPreparedStatement.setString(2, currentDateTime);

// Execute the SELECT queries
pastResultSet = pastPreparedStatement.executeQuery();


	} catch (SQLException e) {
	e.printStackTrace();
	
	}

return pastResultSet;
}
    
    
    
    public int deleteServices(int bookingId) throws ClassNotFoundException {
    	PreparedStatement preparedStatement = null;

    	try {
    		Class.forName("com.mysql.cj.jdbc.Driver");
		    
    		// Establish a database connection
    		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    			  

    	   
    	    // Create a SQL DELETE query
    	    String sql = "DELETE FROM vehicle_service WHERE booking_id = ?";

    	    // Create a PreparedStatement
    	    preparedStatement = conn.prepareStatement(sql);

    	    // Set the parameter value (booking id)
    	    preparedStatement.setInt(1, bookingId);

    	    // Execute the DELETE query
    	    int rowsAffected = preparedStatement.executeUpdate();
    	    
    	    
    	    // Check the number of rows affected to determine if the delete was successful
    	    conn.close();
    	    return rowsAffected;
    	}catch (SQLException e) {
    	    e.printStackTrace();
    	    return -1;
    	} 
    }
    
    
    public int insertService(String location, String mileageStr, String vehicle_no, String message, String userName, String dateStr, String timeStr) throws ParseException, ClassNotFoundException {

  	   try {
  	        // Convert mileage string to integer
  	        int mileage = Integer.parseInt(mileageStr);

  	        // Parse date and time strings
  	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
  	        Date date = dateFormat.parse(dateStr);
  	     
  	        
  	        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("h:mm a");

  	        // Parse the input time string to LocalTime
  	        LocalTime localTime = LocalTime.parse(timeStr, inputFormatter);

  	        // Convert LocalTime to SQL Time
  	        Time time = Time.valueOf(localTime);


  	        // Establish database connection
  	        Class.forName("com.mysql.cj.jdbc.Driver");
  	        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

  	        // Create a SQL INSERT statement
  	        String sql = "INSERT INTO vehicle_service (date, time, location, mileage, vehicle_no, message, username) VALUES (?, ?, ?, ?, ?, ?, ?)";

  	        // Create a PreparedStatement
  	        PreparedStatement preparedStatement = conn.prepareStatement(sql);

  	        // Set the parameter values (after applying HTML escaping)
  	        preparedStatement.setDate(1, new java.sql.Date(date.getTime()));
  	        preparedStatement.setTime(2, time);
  	        preparedStatement.setString(3, location);
  	        preparedStatement.setInt(4, mileage);
  	        preparedStatement.setString(5, vehicle_no);
  	        preparedStatement.setString(6, message);
  	        preparedStatement.setString(7, userName);

  	        // Execute the INSERT statement
  	        int rowsInserted = preparedStatement.executeUpdate();
  	        conn.close();

  	        // Check if the insertion was successful
  	        return rowsInserted;
  	    } catch (SQLException e) {
  	        e.printStackTrace();
  	        return -1; // Error during insertion
  	    }
     }
}