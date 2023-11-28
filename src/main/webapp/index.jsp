<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet"  href ="styles/index.css">
	<title>Login</title>
</head>

<body>
	<div class ="login-center">
		<div class="login-container">
			<h1><span>Rental</span>Heaven</h1>
			<img class="login_img" src="">
		 	<p class="login_p1">Login into your Account</p>
		 	
		 	<button class="login_btn" type="button" 
		 	onclick ="window.location.href='https://api.asgardeo.io/t/rentalheaven/oauth2/authorize?scope=openid%20address%20email%20phone%20profile&response_type=code&redirect_uri=http://localhost:8080/VehicleService/authorize.jsp&client_id=HJ2JDA2fOn0s2fszRnDw07CHTVka&login_hint=isurusasanga1999@gmail.com'">SIGN IN</button>
		 	
		 	<p class="login_p1"> Don't have an Account?</p>
		 	<button class="signup" type="button" onclick="window.location.href ='https://console.asgardeo.io/'" >CREATE</button>
		
		</div>	 	
	</div>
</body>

</html>