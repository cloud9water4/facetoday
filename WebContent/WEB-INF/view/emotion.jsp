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

<!-- Bootstrap core CSS -->
<link href="resource/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/site.min.css">

<!-- Custom styles for this template -->
<link href="css/donggu.css" rel="stylesheet">
<link href="css/offcanvas.css" rel="stylesheet">
<link href="css/blog.css" rel="stylesheet">


<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<script type="text/javascript">	
	google.load("visualization", "1", {packages : [ "corechart" ]});
	google.setOnLoadCallback(drawChart);
	
	function drawChart() {
		var data = google.visualization.arrayToDataTable([
				[ 'Time', '기분 변화', '평균' ], [ '00', 1000, 700 ],
				[ '04', 1170, 700 ], [ '08', 100, 700 ], [ '12', 1030, 700 ],
				[ '16', 1000, 700 ], [ '20', 1170, 700 ], [ '24', 660, 700 ] ]);

		var options = {
			title : 'feelings',
			curveType : 'function',
			aggregationTarget : 'none',
			animation : {
				easing : 'inAndOut'
			},
			legend : {
				position : 'bottom'
			}
		};

		var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
		chart.draw(data, options);
	}

</script>

<title>Test Web Page</title>
</head>

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
				<a class="navbar-brand" href="#"> <span
					class="glyphicon glyphicon-globe"></span> FaceToday
				</a>
			</div>
			<form class="navbar-form navbar-left">
				<div class="form-group">
					<input type="text" class="form-control"
						placeholder="관심있는 친구나 지역을 검색하세요." style="width: 350px;">
				</div>
				<button type="submit" class="btn btn-default">Submit</button>
			</form>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">관리 <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#">Action</a></li>
						<li><a href="#">Another action</a></li>
						<li><a href="#">Something else here</a></li>
						<li class="divider"></li>
						<li><a href="index.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
		</div>
	</div>
	
	<p/>
	
	<div class="container">

		<div class="row">

			<div class="col-sm-8 blog-main">
				
				<div class="panel panel-info">
					<!-- Default panel contents -->
					<div class="panel-heading text-center"><strong>기분 판단 요소</strong></div>
					<div class="panel-body">
						<p>아래의 목록은 시간에 따라 작성한 회원님의 글을 토대로 분석하여 기분에 영향을 끼친 단어들을 모은 것입니다.
						주요 키워드는 기분에 직접적인 영향을 주었다고 판단된 요소로써, 형태소 단위로 분해되어 입력한 본래의 단어가 반영되지 않을 수 있습니다.</p>
					</div>
					
					<!-- 테이블-->
					<table class="table table-hover" id="listTable">
						<tr>
							<td>시간</td>
							<td>주요 키워드</td>
							<td>예상 수치</td>
						</tr>

						<c:forEach items="${EmotionList}" var="list">
							<tr>
								<td>${list.write_date}</td>
								<td>${list.keyword}</td>
								<td>${list.state}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				
				<!-- 그래프 -->
				<div id="chart_div"></div>
				
			</div>
			<!-- /.blog-main -->

			<div class="col-sm-3 col-sm-offset-1 blog-sidebar">
				
				<!-- 개인 정보 설정 -->
				<div class="media">
					<a class="pull-left" href="#"> 
						<img class="media-object img-rounded" src="testPic/photo-1.jpg">
					</a>
					<div class="media-body">
						<h4 class="media-heading">정동구</h4>
						<a href="main.jsp"><h6>프로필 편집</h6></a>
					</div>
				</div>
				
				<div class="sidebar-module">
					<h4>Archives</h4>
					<ol class="list-unstyled">
						<li><a href="#">January 2014</a></li>
						<li><a href="#">December 2013</a></li>
						<li><a href="#">November 2013</a></li>
						<li><a href="#">October 2013</a></li>
						<li><a href="#">September 2013</a></li>
						<li><a href="#">August 2013</a></li>
						<li><a href="#">July 2013</a></li>
						<li><a href="#">June 2013</a></li>
						<li><a href="#">May 2013</a></li>
						<li><a href="#">April 2013</a></li>
						<li><a href="#">March 2013</a></li>
						<li><a href="#">February 2013</a></li>
					</ol>
				</div>
				<div class="sidebar-module">
					<h4>Elsewhere</h4>
					<ol class="list-unstyled">
						<li><a href="#">GitHub</a></li>
						<li><a href="#">Twitter</a></li>
						<li><a href="#">Facebook</a></li>
					</ol>
				</div>
			</div>
			<!-- /.blog-sidebar -->

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->

	<div class="blog-footer">
		<p>
			Test for Spring Web MVC, <a href="wesdw2002@naver.com">DG Jung</a>.
		</p>
		<p>
			<a href="#">Back to top</a>
		</p>
	</div>
	
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="resource/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/spin.min.js"></script>
	
</body>

</html>