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

<title>FaceToday</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/docs.min.css" rel="stylesheet">
<link href="css/offcanvas.css" rel="stylesheet">
<link href="css/blog.css" rel="stylesheet">
<link href="css/jumbotron.css" rel="stylesheet">

<!-- custom CSS -->
<link href="css/index_donggu.css" rel="stylesheet">

<style>
img.bg {
	min-height: 60%;
	min-width: 1024px;
	width: 100%;
	height: 40%; /* auto */
	position: fixed;
	top: 0;
	left: 0;
	z-index: -100;
}
</style>
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript" src="js/fblogin.js"></script>

<%
	//로그아웃 처리
	session.invalidate();
%>


<body>
	<div class="navbar navbar-inverse navbar-fixed-top" id="bar">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-globe"></span> FaceToday</a>
			</div>
			<div class="navbar-collapse collapse">
				
				<form class="navbar-form navbar-right" id="signin" action="signin.do" method="post">

					<!-- <div class="fb-login-button" data-max-rows="2" data-size="icon" data-show-faces="false" data-auto-logout-link="false" ></div> -->
					<fb:login-button scope="public_profile,email" data-size="icon" onlogin="checkLoginState();"> </fb:login-button>					
					<div class="form-group">
						<input type="text" placeholder="Email" name="signEmail" class="form-control">
					</div>
					<div class="form-group">
						<input type="password" placeholder="Password" name="signPasswd" class="form-control">
					</div>
					<button type="submit" class="btn btn-success">Sign in</button>
				</form>
			</div>
			<!--/.navbar-collapse -->
		</div>
	</div>
	<p/>			
<!-- 	<img src="testPic/02.jpg" class="bg">
 -->
	<div class="jumbotron" style="width:100%; height:100%; text-align:center; background-image:url(testPic/02.jpg);">
	
		<!--  이 주의 노래 -->
		<div class="container">
		<div class="col-sm-6">
		<iframe width="470" height="320" src="//www.youtube.com/embed/TI0DGvqKZTI"></iframe>
		</div>
		<!-- commentview modal -->
		<div class="col-sm-6">
		<iframe width="470" height="320" src="firstComment.jsp"></iframe>
		</div>
		</div>
	</div>
		
	
    <div class="container marketing">
      <!-- Three columns of text below the carousel -->
      <div class="row">
        <div class="col-lg-4">
          <img class="img-circle" src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNDAiIGhlaWdodD0iMTQwIj48cmVjdCB3aWR0aD0iMTQwIiBoZWlnaHQ9IjE0MCIgZmlsbD0iI2VlZSIvPjx0ZXh0IHRleHQtYW5jaG9yPSJtaWRkbGUiIHg9IjcwIiB5PSI3MCIgc3R5bGU9ImZpbGw6I2FhYTtmb250LXdlaWdodDpib2xkO2ZvbnQtc2l6ZToxMnB4O2ZvbnQtZmFtaWx5OkFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2RvbWluYW50LWJhc2VsaW5lOmNlbnRyYWwiPjE0MHgxNDA8L3RleHQ+PC9zdmc+" alt="Generic placeholder image">
          <h2>Heading</h2>
          <p>Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesent commodo cursus magna.</p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
          <img class="img-circle" src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNDAiIGhlaWdodD0iMTQwIj48cmVjdCB3aWR0aD0iMTQwIiBoZWlnaHQ9IjE0MCIgZmlsbD0iI2VlZSIvPjx0ZXh0IHRleHQtYW5jaG9yPSJtaWRkbGUiIHg9IjcwIiB5PSI3MCIgc3R5bGU9ImZpbGw6I2FhYTtmb250LXdlaWdodDpib2xkO2ZvbnQtc2l6ZToxMnB4O2ZvbnQtZmFtaWx5OkFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2RvbWluYW50LWJhc2VsaW5lOmNlbnRyYWwiPjE0MHgxNDA8L3RleHQ+PC9zdmc+" alt="Generic placeholder image">
          <h2>Heading</h2>
          <p>Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
          <img class="img-circle" src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNDAiIGhlaWdodD0iMTQwIj48cmVjdCB3aWR0aD0iMTQwIiBoZWlnaHQ9IjE0MCIgZmlsbD0iI2VlZSIvPjx0ZXh0IHRleHQtYW5jaG9yPSJtaWRkbGUiIHg9IjcwIiB5PSI3MCIgc3R5bGU9ImZpbGw6I2FhYTtmb250LXdlaWdodDpib2xkO2ZvbnQtc2l6ZToxMnB4O2ZvbnQtZmFtaWx5OkFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2RvbWluYW50LWJhc2VsaW5lOmNlbnRyYWwiPjE0MHgxNDA8L3RleHQ+PC9zdmc+" alt="Generic placeholder image">
          <h2>Heading</h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
      </div><!-- /.row -->


      <!-- START THE FEATURETTES -->

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">First featurette heading. <span class="text-muted">It'll blow your mind.</span></h2>
          <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive" src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48cmVjdCB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCIgZmlsbD0iI2VlZSIvPjx0ZXh0IHRleHQtYW5jaG9yPSJtaWRkbGUiIHg9IjI1MCIgeT0iMjUwIiBzdHlsZT0iZmlsbDojYWFhO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1zaXplOjMxcHg7Zm9udC1mYW1pbHk6QXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7ZG9taW5hbnQtYmFzZWxpbmU6Y2VudHJhbCI+NTAweDUwMDwvdGV4dD48L3N2Zz4=" alt="Generic placeholder image">
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-5">
          <img class="featurette-image img-responsive" src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48cmVjdCB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCIgZmlsbD0iI2VlZSIvPjx0ZXh0IHRleHQtYW5jaG9yPSJtaWRkbGUiIHg9IjI1MCIgeT0iMjUwIiBzdHlsZT0iZmlsbDojYWFhO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1zaXplOjMxcHg7Zm9udC1mYW1pbHk6QXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7ZG9taW5hbnQtYmFzZWxpbmU6Y2VudHJhbCI+NTAweDUwMDwvdGV4dD48L3N2Zz4=" alt="Generic placeholder image">
        </div>
        <div class="col-md-7">
          <h2 class="featurette-heading">Oh yeah, it's that good. <span class="text-muted">See for yourself.</span></h2>
          <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">And lastly, this one. <span class="text-muted">Checkmate.</span></h2>
          <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive" src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48cmVjdCB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCIgZmlsbD0iI2VlZSIvPjx0ZXh0IHRleHQtYW5jaG9yPSJtaWRkbGUiIHg9IjI1MCIgeT0iMjUwIiBzdHlsZT0iZmlsbDojYWFhO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1zaXplOjMxcHg7Zm9udC1mYW1pbHk6QXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7ZG9taW5hbnQtYmFzZWxpbmU6Y2VudHJhbCI+NTAweDUwMDwvdGV4dD48L3N2Zz4=" alt="Generic placeholder image">
        </div>
      </div>

    

      <!-- /END THE FEATURETTES -->
		<!-- 회원 가입 modal-->
		<div class="modal fade" id="sign-up" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body">
						<form method="post" enctype="multipart/form-data" action="join.do" id="joinMember">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">×</button>
								<h3 id="myModalLabel">회원가입</h3>
							</div>
							<div class="form-group">
								<!-- Username -->
								<label class="control-label" for="name">이름</label>
								<div class="form-group">
									<input type="text" id="name" name="name"
										placeholder="이름,닉네임" class="form-control" required autofocus="autofocus">
									<p class="help-block">문자와 숫자로 공백없이 입력해주시되, 닉네임도 가능합니다.</p>
								</div>
							</div>

							<div class="form-group">
								<!-- E-mail -->
								<label class="control-label" for="email">E-mail</label>
								<div class="form-group">
									<input type="email" id="email" name="email" placeholder="이메일"
										class="form-control" required>
									<p class="help-block">이메일 주소를 입력해주세요.</p>
								</div>
							</div>

							<div class="form-group">
								<!-- Password-->
								<label class="control-label" for="passwd">비밀번호</label>
								<div class="form-group">
									<input type="password" name="passwd"
										placeholder="비밀번호" class="form-control" required>
									<p class="help-block">비밀번호는 최소한 4 글자 이상으로 해주세요.</p>
								</div>
							</div>

							<div class="form-group">
								<!-- Password -->
								<label class="control-label" for="password_confirm">비밀번호(재입력)</label>
								<div class="form-group">
									<input type="password"
										name="passwd_confirm" placeholder="비밀번호(재입력)"
										class="form-control" required>
									<p class="help-block">비밀번호를 다시 입력해주세요.</p>
								</div>
							</div>
							
							<div class="form-group">
								<!-- Password-->
								<label class="control-label" for="birth">생년월일</label>
								<div class="form-group">
									<input type="date" id="birth" name="birth" class="form-control" required>
									<p class="help-block">생년월일을 입력하세요.</p>
								</div>
							</div>
							<div class='modal-footer'>
								<button type="submit" id="btnJoin" class="btn btn-success">가입하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	

		<!-- Footer
================================================== -->
		<footer class="bs-docs-footer" role="contentinfo">
			<div class="container">
				<div class="bs-docs-social">
					<ul class="bs-docs-social-buttons">
						<li><iframe class="github-btn"
								src="http://ghbtns.com/github-btn.html?user=cloud9water4&amp;repo=facetoday&amp;type=watch&amp;count=true"
								width="100" height="20" title="Star on GitHub"></iframe></li>
						<li><iframe class="github-btn"
								src="http://ghbtns.com/github-btn.html?user=cloud9water4&amp;repo=facetoday&amp;type=fork&amp;count=true"
								width="102" height="20" title="Fork on GitHub"></iframe></li>
						<!-- <li class="follow-btn"><a
							href="https://twitter.com/twbootstrap"
							class="twitter-follow-button" data-link-color="#0069D6"
							data-show-count="true">Follow @twbootstrap</a></li> -->
						<li class="tweet-btn"><a href="https://twitter.com/share"
							class="twitter-share-button"
							data-count="horizontal" data-via="twbootstrap"
							target="_blank">Tweet</a></li>
					</ul>
				</div>
				
				<p>
					Maintained by the <a href="https://github.com/cloud9water4?tab=members" target="_blank">core
						team</a> with the help of <a
						href="https://github.com/cloud9water4/facetoday/graphs/contributors">our
						contributors</a>.
				</p>
				<p>
					Code licensed under <a
						href="https://github.com/cloud9water4/facetoday/blob/master/LICENSE"
						target="_blank">BSD</a>, documentation under <a
						href="http://creativecommons.org/licenses/by/3.0/">CC BY 3.0</a>.
				</p>
				<ul class="bs-docs-footer-links muted">
					<li>Currently v1.0.0</li>
					<li>&middot;</li>
					<li><a href="https://github.com/cloud9water4/facetoday/" target="_blank">GitHub</a></li>
					<li>&middot;</li>
					<li><a href="http://yobi.d2fest.kr/cloud9water4/projectFacetoday" target="_blank">Yobi</a></li>
					<li>&middot;</li>
					<li><a href="../about/">About</a></li>
					<li>&middot;</li>
					<li><a
						href="https://github.com/cloud9water4/facetoday/issues?state=open" target="_blank">Issues</a></li>
					<li>&middot;</li>
					<li><a href="https://github.com/cloud9water4/facetoday/releases" target="_blank">Releases</a></li>
				</ul>
			</div>
		</footer>

		<!-- Bootstrap core JavaScript
    ================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script src="resource/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/spin.min.js"></script>
</body>
</html>