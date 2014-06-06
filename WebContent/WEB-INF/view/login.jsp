<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="../../assets/ico/favicon.ico">

<title>환영합니다.</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/donggu.css" rel="stylesheet">
<link href="css/offcanvas.css" rel="stylesheet">
<link href="css/blog.css" rel="stylesheet">
<link href="resource/css/signin.css" rel="stylesheet">

<script src="http://www.google.com/jsapi"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script type="text/javascript">

</script>


<script>
	google.load("webfont", "1");
	google.setOnLoadCallback(function() {
		WebFont.load({
			custom : {
				families : [ "NanumPen" ],
				 urls: [ "http://fontface.kr/NanumGothicBold/css" ],
			}
		});
	});
</script>

<script>
	google.load("webfont", "1");
	google.setOnLoadCallback(function() {
		WebFont.load({
			custom : {
				families : [ "NanumPen" ],
				 urls: [ "http://fontface.kr/NanumPen/css" ]
			}
		});
	});
</script>

<style>
img.bg {
	min-height: 100%;
	min-width: 1024px;
	width: 100%;
	height: 40%; /* auto */
	position: fixed;
	top: 0;
	left: 0;
	z-index: -100;
}

.wf-active body {
	font-family: 'NanumGothicBold';
}

h3 {
	font-family: 'NanumPen';
}
</style>


</head>

<body>
	<img src="testPic/summer.jpg" class="bg">
	<div class="navbar navbar-inverse navbar-fixed-top" id="bar">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#"> <span
					class="glyphicon glyphicon-globe"></span> FaceToday
				</a>
			</div>
		</div>
	</div>
	<p/>
	<div class="container">
	<div class="row">

		<br/><br/><br/>
		<h2 align="center">${param.name}님 환영합니다.</h2>
		<h3 align="center">로그인 후 서비스를 이용하세요.</h3>
		<br/><br/>		
		<form class="form-signin" action="signin.do" method="post">
			<h6 align="right"><a href="joinForm.jsp">아직 회원이 아니세요?</a></h6>
        	<input type="email" class="form-control" name="signEmail" placeholder="Email address" required autofocus>
        	<input type="password" class="form-control" name="signPasswd" placeholder="Password" required>
        	<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      	</form>
    
	</div>	
	</div>
	
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="resource/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/spin.min.js"></script>
	<script type="text/javascript" src="js/webcam.js"></script>
	<script src="js/tooltip.js"></script>
	<script src="js/popover.js"></script>
	
</body>
</html>