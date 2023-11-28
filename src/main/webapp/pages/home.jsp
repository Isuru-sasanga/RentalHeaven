<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.service.*" %>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.InputStream, java.io.IOException" %>
<%@ page import="java.util.Properties" %>	
<%@ page import="java.io.FileInputStream, java.io.IOException, java.util.Properties" %>

<%
			// Initialize a Properties object
			Properties properties = new Properties();
			
			//Load the properties file
			try {
				 InputStream inputStream = application.getResourceAsStream("/WEB-INF/application.properties");
				 properties.load(inputStream);
				} catch (IOException e) {
				    e.printStackTrace();
				} 						
%>

<% 

		VehicleServicesDAO service = new VehicleServicesDAO();
		// Database connection parameters
		String dbUrl = "jdbc:mysql://172.187.178.153:3306/isec_assessment2";
		String dbUser = "isec"; 
		String dbPassword = "EUHHaYAmtzbv";
		ResultSet pastResultSet = null;
		ResultSet futureResultSet = null;
		
	    		
		try {
		   		 
			Class.forName("com.mysql.cj.jdbc.Driver");		    
		    // Establish a database connection
		    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			//when the service for submitted
			
    	if (request.getParameter("submit") != null) {
	        String location = request.getParameter("location");
	        String mileageStr = request.getParameter("mileage");
	        String vehicle_no = request.getParameter("vehicle");
	        String message = request.getParameter("message");
	        String userName = request.getParameter("usernameField");
	        String dateStr = request.getParameter("date");
	        String timeStr = request.getParameter("time");
	    	
			System.out.println("Username: " + userName);
		    System.out.println("location: " + location);
		    System.out.println("Mileage: " + mileageStr);
		    System.out.println("Message: " + message);
		    System.out.println("Vehicle No: " + vehicle_no);
	
	        // insert data to the database
	        int rowsInserted =  service.insertService(location,  mileageStr, vehicle_no,  message,  userName,  dateStr,  timeStr);
	        if (rowsInserted > 0) {
	        	String successMessage = "Data inserted successfully.";
	            request.setAttribute("successMessage", successMessage);
	            response.sendRedirect(request.getRequestURI() + "#service");
	             
	         }else if(rowsInserted == -1){
	        	 out.println("Invalid time format. Please enter time in hh:mm format.");
	         }
	         else if(rowsInserted == -2){
	        	 out.println("Error parsing time");
	        	 	   
	         }
	        
	        else {
	        	 out.println("Failed to insert data.");
	         }
	         
    	}
    	//When the delete button is clicked
	    if (request.getParameter("delete") != null){
	    	
	    	String bookingId = request.getParameter("bookingID");
	    	
	    	int id = Integer.parseInt(bookingId);
	    	//System.out.println("Hello");
	    	//out.println(bookingId);
	    	//delete the row
	    	int rowsAffected = service.deleteServices(id);
	    	
	    	if (rowsAffected > 0) {
	    		//refresh the site  
	    		 response.sendRedirect(request.getRequestURI());
		         
		    }else if(rowsAffected == -1){
		    	out.println("Error in the databse. Try again later");
		    } else {
		        out.println("No data found for the given booking ID");
		    }
	    	
	    	
	    } 
	    
	    
	    if (request.getParameter("pastRes") != null){
	    	
	    	 String userName = request.getParameter("usernameField2");
	    	 System.out.println("Hello");
	    	 System.out.println(userName);
	    	 pastResultSet = service.getPastServices(userName);	   	    	
	    }
	    
	    if (request.getParameter("futureRes") != null){
	    	
	    	 String userName = request.getParameter("usernameField3");
	    	 
	    	 //get the services from the database
	    	  System.out.println("Hello");
			System.out.println(userName);
			futureResultSet = service.getFutureServices(userName);

	    }      
	
	}catch (ClassNotFoundException e) {
		e.printStackTrace();
			
		}
	
%>

<!DOCTYPE html>
<html>
<head>
		<meta charset="ISO-8859-1">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
		<link rel="stylesheet"  href ="../styles/nav.css">
		<link rel="stylesheet"  href ="../styles/home.css">
		<link rel="stylesheet"  href ="../styles/user.css">
		<link rel="stylesheet" href="../styles/reservation.css">
		<link rel="stylesheet" href="../styles/reservationDetails.css">
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script type='text/javascript' src='../js/home.js'></script>
		
		<script>
		    document.addEventListener('DOMContentLoaded', function () {
		        // Getting data from localStorage
		        var username = localStorage.getItem('username');		       
		
		        document.getElementById('submit').addEventListener('click', function () {
		            // Set the username as a hidden field value in the form
		            document.getElementById('usernameField').value = username;
		         });
		        
		        document.getElementById('pastRes').addEventListener('click', function () {
		            //console.log("Hello world");
		            document.getElementById('usernameField2').value = username;
		            console.log('Value retrieved: ' + usernameField2);
		        });
		        
		        document.getElementById('futureRes').addEventListener('click', function () {
		           // console.log("Hello world");
		            document.getElementById('usernameField3').value = username;
		        });
		    });
		    
		</script>
		<title>Rental Heaven</title>
</head>

<body>
		<section id="home">
			<nav>
				  <span class="rental">Rental </span><span class="heaven">Heaven</span>
				  <a class="active" href="#"><i class="fas fa-home"></i><span>Home</span></a>
				  <a href="#reservation"><i class="fas fa-taxi"></i><span>Services</span></a>
				  <a href="#reservationDetails"><i class="fas fa-list"></i><span>Reservations</span></a>
				  <a href="#info"><i class="fas fa-user"></i><span>Profile</span></a>
			</nav>
		
			<div class="home_content">
				<div class="homeBgImage"></div>
					<div class="home_text">
						<h1>Welcome</h1><h3>To the best </h3><p>Vehicle service Reservation Center</p>
						<span>Rental Heaven</span>
					</div>
			</div>
		</section>

		<section id="info">
		
			<div class="profile_img">
			    <i class="fas fa-user-circle"></i>
			    <span class="prof_name" id = 'name'></span>
			</div>
			
		  	<div class="profile_container">
		  
				 <ul>				      
					    <li><span class="profli">First Name&emsp;&nbsp;: </span><span class="prof_li" id="given_name"></span></li>
					    <li><span class="profli">Last Name&emsp;&nbsp; : </span><span class="prof_li" id="family_name"></span></li>
					    <li><span class="profli">User Name&emsp;&nbsp; : </span><span class="prof_li" id="username"></span></li>
					    <li><span class="profli">Email &emsp;&emsp; &emsp; : </span><span class="prof_li" id="email"></span></li>
					    <li><span class="profli">Country &emsp;&emsp; : </span><span class="prof_li" id="address"></span></li>
					    <li><span class="profli">Contact&emsp; &emsp;&nbsp; : </span><span class="prof_li" id="phone"></span></li>				
				  </ul>
				  
			  	  <div class="actions">
			  		
					  	<form id="logout-form" action='<%= properties.getProperty("logoutEndpoint") %>' method="POST">
					        <input type="hidden" id="client-id" name="client_id" value="">
					        <input type="hidden" id="post-logout-redirect-uri" name="post_logout_redirect_uri" value="">
					        <input type="hidden" id="state" name="state" value="">
					        <button type="submit">Logout</button>
					    </form>
				    
			  	  </div>
		  	</div> 		
		</section>

		<section id="reservation">
		
			<div class="content-inside">
				<div class="container">
				      <div class="fulldiv">
				        <div class="indiv">
				          <div class="div3">
			
				            <h3>Service Form</h3>
				            	<form class="form" method="post" id="contactForm" name="contactForm">
				              		<div class="mainRow">
				              			<div class="row">
				                   			<label for="birthday" class="label">Date *</label>
			  								<input type="date" id="date" name="date" min="<%= java.time.LocalDate.now() %>" required>
				                		</div>
				               			<br>
				                	<div class="service_content">
								  			<label for="time" class="label">Select a time * </label>			  	  			
									  	  	<select id="time" name="time" required="required">
									  	  		  	<option selected>Time</option>
									  	  		   	<option value="10:00 AM">10:00 AM</option>
									               	<option value="11:00 AM">11:00 AM</option>
									               	<option value="12:00 AM">12:00 PM</option>
									  	  	</select>
									</div>
									<br>
				                	<div class="row">
				                  			<label for="" class="label">Location *</label>
						                    <select class="custom-select" id="location" name="location" required>
												    <option selected>Choose...</option>
												    <option value="Colombo">Colombo</option>
										            <option value="Gampaha">Gampaha</option>
										            <option value="Kalutara">Kalutara</option>
										            <option value="Kandy">Kandy</option>
										            <option value="Matale">Matale</option>
										            <option value="Nuwara Eliya">Nuwara Eliya</option>
										            <option value="Galle">Galle</option>
										            <option value="Matara">Matara</option>
										            <option value="Hambantota">Hambantota</option>
										            <option value="Jaffna">Jaffna</option>
										            <option value="Kilinochchi">Kilinochchi</option>
										            <option value="Mannar">Mannar</option>
										            <option value="Vavuniya">Vavuniya</option>
										            <option value="Mullaitivu">Mullaitivu</option>
										            <option value="Batticaloa">Batticaloa</option>
										            <option value="Ampara">Ampara</option>
										            <option value="Trincomalee">Trincomalee</option>
										            <option value="Kurunegala">Kurunegala</option>
										            <option value="Puttalam">Puttalam</option>
										            <option value="Anuradhapura">Anuradhapura</option>
										            <option value="Polonnaruwa">Polonnaruwa</option>
										            <option value="Badulla">Badulla</option>
										            <option value="Monaragala">Monaragala</option>
										            <option value="Ratnapura">Ratnapura</option>
										            <option value="Kegalle">Kegalle</option>
											</select>
				
								  </div>
								  <br>
								  <div class="row">
							                <div class="service_content">
											      <label for="vehicle" class="label">Vehicle Number *</label>				
											      <input type="text" class="form-control" name="vehicle" placeholder="vehicle number" required="required">
											</div>
				              	 </div>
								 <br>
				                 <div class="row">
						                  <label for="" class="label">Mileage *</label>
						                  <input type="number" step="1" min="1" pattern="\d+" class="form-control" name="mileage" id="mileage"  placeholder="Enter the total mileage" required>
				                 </div>
				                 <br>
				                
				                 		  <input type="hidden" id="usernameField" name="usernameField" value="" >
				              	</div>
				                <br>				
				              
				              	<div class="mainRow">
					                <div class="row">
						                  <label for="message" class="label">Message *</label>
						                  <textarea class="form-control" name="message" id="message" cols="30" rows="4"  placeholder="Write your message"></textarea>
					                </div>
				              	</div>
				              	<div class="row">
					                <div class="col-md-12 form-group">
					                <br>
						                  <input type="submit" value="Submit" id="submit" name="submit" class="btn btn-primary rounded-0 py-2 px-4">
						                  <span class="submitting"></span>
					                </div>
				              	</div>
				            </form>				
				          </div>
				        </div>
				      </div>
				    </div>
				</div>		
		</section>

		<section id = "reservationDetails">
				<div class="ResDet-title">
					<h1>To check the Reservations Details.Click below</h1>
				</div>
				
				<div class="Res-form">
						<form class="form1" method="post" id="myForm" onclick="document.getElementById('past').style.display='block'" >
							<input type="hidden" id="usernameField2" name="usernameField2" value="" >	              
							<input type="submit" class="res" id="pastRes" name= "pastRes" value="Past Reservation" >
						</form>
					<br>
					<br>
						<form class="form1" method="post" id="myForm" onclick="document.getElementById('future').style.display='block'"  >
							<input type="hidden" id="usernameField3" name="usernameField3" value="" >	              
							<input type="submit" class="res" id="futureRes" name="futureRes" value= "Future Reservation" >
						</form>
				</div>
		
				<br><br>
				<div class="past" id="past">
						<h2 id="t-Name">Past Reservations</h2>
						<br>
				 		<table class="table">
					        <tr>
					            <th>Booking ID</th>
					            <th>Date</th>
					            <th>Time</th>
					            <th>Location</th>
					            <th>Mileage</th>
					            <th>Vehicle Number</th>
					            <th>Message</th>
					        </tr>
					      <%
				        
				        Date currentDate = new Date();
					          
				        if (pastResultSet != null) {
				        	
				            while (pastResultSet.next()) {
				            	
				            	Date date = pastResultSet.getDate("date");
				            	if(!date.before(currentDate)){
				            		 continue;
				            	}
				                int bookingId = pastResultSet.getInt("booking_id");
				                Time time = pastResultSet.getTime("time");
				                String location = pastResultSet.getString("location");
				                int mileage = pastResultSet.getInt("mileage");
				                String vehicleNo = pastResultSet.getString("vehicle_no");
				                String message1 = pastResultSet.getString("message");
				                
				            
				        %>
					        <tr>
					            <td><%= bookingId %></td>
					            <td><%= date %></td>
					            <td><%= time %></td>
					            <td><%= location %></td>
					            <td><%= mileage %></td>
					            <td><%= vehicleNo %></td>
					            <td><%= message1 %></td>
					        </tr>
					        <% 
					            }}
					            
					    %>
					    </table>
					    
				</div>
				 				
				 						
				<div class="future" id="future">
					<h2 id="t-Name1">Future Reservations</h2>
					<br>
				<table class="table">
				        <tr>
				            <th>Booking ID</th>
				            <th>Date</th>
				            <th>Time</th>
				            <th>Location</th>
				            <th>Mileage</th>
				            <th>Vehicle Number</th>
				            <th>Message</th>
				            <th>Action</th>
				        </tr>
				       <% 
					  Date currentDate1 = new Date();
				        if (futureResultSet != null) {
				            while (futureResultSet.next()) {
				            	
				            	Date date = futureResultSet.getDate("date");
				            	
				            	if(date.before(currentDate1)){
				            		 continue;
				            	}
				                int bookingId = futureResultSet.getInt("booking_id");
				                Time time = futureResultSet.getTime("time");
				                String location = futureResultSet.getString("location");
				                int mileage = futureResultSet.getInt("mileage");
				                String vehicleNo = futureResultSet.getString("vehicle_no");
				                String message0 = futureResultSet.getString("message");
				                
				            
				        %>
				        <tr>
				            <td><%= bookingId %></td>
				            <td><%= date %></td>
				            <td><%= time %></td>
				            <td><%= location %></td>
				            <td><%= mileage %></td>
				            <td><%= vehicleNo %></td>
				            <td><%= message0 %></td>
				            <td><button onclick="document.getElementById('id01').style.display='block';  document.getElementById('bookingID').value = <%= bookingId %>;" class="delete">Delete</button></td>
				        </tr>
				        <% 
				            }}
				            
				    %>
				    </table>
			</div>
		
		
			<div id="id01" class="del-res">
		  			<span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">×</span>
		  			<form class="del-content" method="post" >
		    
		    <div class="del-container">
			      	<h1>Delete Reservation</h1>
			      	<p>Are you sure you want to delete your reservation?</p>
			    	<input type="hidden" id="bookingID" name="bookingID" value="" >
			    	
			        <div class="cancel-content">
				        <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
				        <input type="submit" value="Delete" name="delete" onclick="document.getElementById('id01').style.display='none'" class="deletebtn">
			        </div>
		    </div>
		  </form>
		</div>					
	</section>
</body>

</html>