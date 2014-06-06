		// This is called with the results from from FB.getLoginStatus().
		function statusChangeCallback(response) {
			console.log('statusChangeCallback');
			console.log(response);
			
			if (response.status === 'connected') {
				// Logged into your app and Facebook.
				logout();
				testAPI();
			} else if (response.status === 'not_authorized') {
				// The person is logged into Facebook, but not your app.
				document.getElementById('status').innerHTML = 'Please log '
						+ 'into this app.';
			} else {
				// The person is not logged into Facebook, so we're not sure if
				// they are logged into this app or not.
				document.getElementById('status').innerHTML = 'Please log '
						+ 'into Facebook.';
			}
		}
	
		// This function is called when someone finishes with the Login
		// Button.  See the onlogin handler attached to it in the sample
		// code below.
		function checkLoginState() {
			FB.getLoginStatus(function(response) {
				statusChangeCallback(response);
			});
		}

		window.fbAsyncInit = function() {
			FB.init({
				appId : 745943598760630,
				cookie : true, // enable cookies to allow the server to access 
				// the session
				xfbml : true, // parse social plugins on this page
				version : 'v2.0' // use version 2.0
			});

			// Now that we've initialized the JavaScript SDK, we call 
			// FB.getLoginStatus().  This function gets the state of the
			// person visiting this page and can return one of three states to
			// the callback you provide.  They can be:
			//
			// 1. Logged into your app ('connected')
			// 2. Logged into Facebook, but not your app ('not_authorized')
			// 3. Not logged into Facebook and can't tell if they are logged into
			//    your app or not.
			//
			// These three cases are handled in the callback function.

			FB.Event.subscribe('auth.logout', function(response) {
			    document.location.reload();
			});
		};

		// Load the SDK asynchronously
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));

		// Here we run a very simple test of the Graph API after login is
		// successful.  See statusChangeCallback() for when this call is made.
		
		function logout() {
			FB.logout(function(response) {
		        // Person is now logged out
				alert("로그아웃");
		    });
		}
		
		function testAPI() {
			console.log('Welcome!  Fetching your information.... ');
			FB.api('/me', function(response) {
				
				$("<input type='hidden' name='email' value='"+response.email+"'>").appendTo("#facebookForm");
				$("<input type='hidden' name='email' value='"+response.name+"'>").appendTo("#facebookForm");

				location.href="social.do?email=" + response.email + "&name="+ response.name;
			});
		}
		
		

	
		
		
		
		
		
		
		
		