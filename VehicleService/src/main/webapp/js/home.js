const infoUrl ="https://api.asgardeo.io/t/rentalheaven/oauth2/userinfo";
       const client_ID ='HJ2JDA2fOn0s2fszRnDw07CHTVka';
       const client_secret = 'uKfeWBSixfkCKwVq4N1PEZKIS1VWbHw3frNYxgGlZLoa';
       
       
       const introspectionEndpointUrl = 'https://api.asgardeo.io/t/rentalheaven/oauth2/userinfo';
        const accessToken = localStorage.getItem('access_token');
        const idToken = localStorage.getItem('id_token');
        
        if(accessToken && idToken){
        	
        var settings = {
            "url":infoUrl,
            "method": "GET",
            "timeout": 0,
            "headers": {
                "Authorization": "Bearer " + accessToken
            },
        };

        $.ajax(settings)
            .done(function (response) {
                console.log(response);
                var username =  response.username;         
                var given_name = response.given_name;
                var family_name = response.family_name;
                var phone = response.phone_number;
                var email = response.email;               
                var country = response.address.country;
                var fullName = given_name + " " + family_name;
                
                   
                localStorage.setItem('username', username);
                
                document.getElementById('submit').addEventListener('click', function () {
                    // Set the username as a hidden field value in the form
                    document.getElementById('usernameField').value = username;
                 });
                    
            
                
                console.log(username);
                document.getElementById('username').textContent = username;
                document.getElementById('name').textContent = fullName;
                document.getElementById('given_name').textContent = given_name;
                document.getElementById('family_name').textContent = family_name;
                document.getElementById('email').textContent = email;
                document.getElementById('phone').textContent = phone;
                document.getElementById('address').textContent = country;
             
             
					
                            
            
                
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                // Handle any errors here
                console.error('Error:', errorThrown);
                alert("There is an Error in Authorization Login again!");
                console.log(errorThrown)
                window.location.href = "../index.jsp";
            });
            
            console.log(localStorage.getItem('username'));
        }
        else{
        	window.location.href = "../index.jsp";	
        }