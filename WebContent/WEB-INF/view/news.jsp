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

<title>Facetoday Main</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/donggu.css" rel="stylesheet">
<link href="css/offcanvas.css" rel="stylesheet">
<link href="css/blog.css" rel="stylesheet">

</head>

<style>
/* 로딩 중 영역 스타일  */
#preview {
	background: rgb(250, 250, 250);
	margin: 0px 20px 20px 0px;
	border-radius: 10px;
	position: absolute;
	z-index: 1;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	color: rgb(255, 255, 255);
	float: left;
}

#map_canvas {
	width: 546px;
	height: 295px;
}

.box {
	width: 565px;
	height: 320px;
	border: 1px solid #ccc;
	padding: 10px;
	box-shadow: 1px 1px 3px #ccc;
}

.search input[type=text] {
	float: left;
	width: 503px;
	padding: 8px;
	border: 1px solid #4B8EFA;
}

.search input[type=button] {
	margin-top: 7px;
	background-color: #4B8EFA;
	border: 0;
	display: block;
	color: white;
	padding: 8px;
	cursor: pointer;
}

#SideTab {
	position: fixed;
	right: 18%;
	top: 110px;
	margin-left: -640px;
	text-align: center;
	width: 170px;
}
</style>

<script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=false"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 

<script type="text/javascript">
	var confirmArray = new Array();
	$(document).ready(function(){
		//글 등록
		var target = document.getElementById('preview');
		var spinner = new Spinner();
				
		//tag 순환
		var splitCnt = 0;
		
		//실시간 위치 추적/ 바뀌는 IP에 한해 // 날씨
		var lat,lon;
		var nation=null;
		var country=null;
		var state=null;
		var updateInfo=null;
		var wind=null;
		var temp=null;
		var humidity=null;
		var ultraViolet=null;
		
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition, showError);
		} else {
			alert("실시간 위치 정보를 지원하지 않는 브라우저를 사용 중입니다.");
		}
		
		function showPosition(position) {
			lat = position.coords.latitude;
			lon = position.coords.longitude;	
			getWeatherInto(lat,lon);
		}
		
		$('#UploadForm').ajaxForm(function() { 
            alert("사진이 등록되었습니다.");
			$('#Upload').modal('hide');
            getData();
        }); 
		
		function getWeatherInto(lat,lon){
			  $.ajax({
			  	// 결과를 한글로 받을 수 있다.
			  url : "http://api.wunderground.com/api/2d769320347dd67c/geolookup/conditions/lang:KR/q/"+lat+","+lon+".json",
			  dataType : "jsonp",
			  success : function weather(parsed_json) {
			  	 // location
			  	 var location = parsed_json.location;
			  	 var nation = location.country_name;
			  	 var country= location.city;
			  	 
				 var str1="<p>"+nation+"   "+country+"</p>";
			  	 // 관측지 정보
			  	 var observ = parsed_json.current_observation;
			  	 // 날씨정보
				 var updateInfo = observ.observation_time;
				 var state=observ.weather;
				 var state_image="<img src='"+observ.icon_url+"'/>";
				 var temp=observ.temperature_string;
				 var humidity=observ.relative_humidity;
		         var wind=observ.wind_string;
				 var ultraViolet=observ.UV;
				 
				 
				var str2=str1+"</br>"+updateInfo+"</br>"+"날씨 :"+state+state_image+
				 "</br>"+"온도 : "+temp+"</br>"+"습도 :"+humidity+"</br>"+"바람 :"+wind+"</br>"
				 +"자외선 :"+ultraViolet+"</br>";
			    $("#weatherSpec").append(str2);
			      
				var info = temp;
			    $("#weatherInfo").append(info);
			    
			    var location = lat+","+lon;
			    		    
			    $("<a href='http://www.wunderground.com/cgi-bin/findweather/getForecast?query="+location+"&sp=IGYEONGG3' target='_blank'>날씨 자세히 보기</a>").appendTo("#wunderground");
			  }
			  
			  });	  
			  
		}
		
		$("#btnPost").click(function(){
			target.style.display = "block";
			target.width = document.body.scrollWidth + 'px';
			target.height = document.body.scrollHeight + 'px';
			setOpacity(target, 50);
			spinner.spin(target);
		});
		
		//업로드
		$(function(){
			$('#UploadForm').ajaxForm({
				success: function(data){
					$('#upload').modal('hide');
					$("<input type='hidden' name='time' id='time' value='"+data+"'>").appendTo("#tagForm");
			    }
			});
		});
		
		//새 글 쓰기
		$(function(){
			$('#newPostForm').ajaxForm({
				success: function(data){
					if (data > 0) {
						alert("등록되었습니다.");
						$("input[type=text]").val("");
						$('#screen').attr('src',"");
						$('#screenModal').attr('src',"");
						$('#hiddenImage').remove();
						$('#time').remove();
						$('#tagString').remove();
						$("#latHidden input").remove();
						$("#lonHidden input").remove();
						
						for(var i=0; i<splitCnt; i++) {
							$('#tagSplit').remove();	
						}
						splitCnt = 0;
						
						getData();
						setOpacity(target, 0);
						target.style.display = "none";
						spinner.stop(target);
					}
				}
			});
		});
		
		$('#imageTooltip').tooltip({
		  	selector: "a[rel=image]"
			});
		$('#locTooltip').tooltip({
		  	selector: "a[rel=location]"
			}); 	
		
		//새 글 작성폼
		$(document).on("click","#tagLabel", function(){ 
			$('#tagModal').modal('show');			
		});
		$(document).on("click","#tagPlus", function(){ 
			var str = $("#tagName").val();
			var res = str.split(",");
			$("<input type='hidden' name='tagString' id='tagString' value='"+res+"'>").appendTo("#tagForm");
			for(var i=0; i<res.length; i++) {
				$("<span class='label label-info' id='tagSplit'>"+res[i]+"</span><span>&nbsp</span>").appendTo("#tagForm");
				splitCnt++;
			}
				
			$('#tagModal').modal('hide');
		});
		$(document).ready(function() {
			function readURL(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#screen').attr('src', e.target.result);
						$('#screenModal').attr('src', e.target.result);
					}
					reader.readAsDataURL(input.files[0]);
				}
			}
			$("#imgInp").change(function() {
				readURL(this);	
				$("<input type='hidden' name='filename' id='hiddenImage' value='"+this.value+"'>").appendTo("#tagForm");
			});
		});
		
		function getData() {
			
			$.ajax({
				url:"selectAll.do",
				type:"post",
				data:$("#userInfo").serialize(),
				dataType:"json",
				success:function(data) {
					var table="";
					
				    $("#listTable tr:gt(0)").remove();
					$(data.list).each(function(index,item){
								
						table+="<tr>";
						table+="<td><img class='media-object img-rounded' src='testPic/photo-1.jpg'></td>";
						if (item.image!="" && item.lat!="") {
							table+="<td id='contentTable"+item.board_num+"'><h4>"+item.name+"</h4>"+item.content+"<button class='btn btn-link' onclick='positionTable("+item.lat+","+item.lon+","+item.board_num+")'>위치 보기</button><span class='hidden'>"+item.board_num+"</span><img class='img-responsive img-rounded' src='http://localhost:9000/projectSpring/facetodayDB/"+item.image+"'><span class='label label-info'>"+item.tag+"</span></td>";
						} else if (item.image!="") {
							table+="<td><h4>"+item.name+"</h4>"+item.content+"<span class='hidden'>"+item.board_num+"</span><img class='img-responsive img-rounded' src='http://localhost:9000/projectSpring/facetodayDB/"+item.image+"'><span class='label label-info'>"+item.tag+"</span></td>";
						} else if (item.lat!="") {
							table+="<td id='contentTable"+item.board_num+"'><h4>"+item.name+"</h4>"+item.content+"<button class='btn btn-link' onclick='positionTable("+item.lat+","+item.lon+","+item.board_num+")'>위치 보기</button><span class='hidden'>"+item.board_num+"</span></td>";
						} else {
							table+="<td><h4>"+item.name+"</h4>"+item.content+"<span class='hidden'><span class='hidden'>"+item.board_num+"</span><span class='label label-info'>"+item.tag+"</span></td>";
						}
						table+="<td><h6>"+item.write_date+"</h6></td>";
/* 				    	table+="<td><th><input class='btn btn-danger' type='button' value='삭제' id='del' name='"+item.board_num+"'><p/><input class='btn' type='button' value='수정' data-toggle='modal' data-target='#myModal' id='upd' name='"+item.board_num+"'></th>";
 */				    	table+="</td>";
						table+="</tr>";
						table+="<tr align='right'>";
						table+="<td colspan='5' style='border-top:0px;'>";
						table+="<span class='glyphicon glyphicon-heart'>&nbsp</span>";
						table+="<span class='glyphicon glyphicon-comment' onclick='writeComment("+item.board_num+")'></span>";
						table+="<button class='btn btn-link' onclick='viewComment("+item.board_num+")'><h6>댓글"+item.c_num+"개</h6></button></td>";
						table+="</tr>";
						
					});
					
				    $("#listTable tr:eq(0)").after(table);
				},
				error : function(err){
					alert("데이터를 가져오는 중 오류가 발생했습니다.");
				}
			});
		}
		
		$(document).on("click","#del", function(){ 
			$.ajax({
				url:"delete.do",
				type:"post",
				dataType : "text", 
				data: "board_num="+ $(this).attr("name"),
				
				success : function(data){
					if(data>0){
						alert("삭제되었습니다.");
						getData();
					}else{
						alert("삭제하는 과정에서 오류가 발생했습니다.");
						alert("삭제되지 않았습니다.");
					}
				 },
				 error : function(err){
					 alert("삭제하는 과정에서 오류가 발생했습니다.");
					 alert("삭제되지 않았습니다.");
				 }
			   });
		   });
		
		$(document).on("click","#upd", function(){ 
			
			$('#myModal').modal('show');
			$.ajax({
				url:"updateSupport.do",
				type:"post",
				dataType : "text", 
				data: "board_num="+ $(this).attr("name")
			}); 
		});
		
		
		$("#update").click(function(){
			$.ajax({
				url:"update.do",
				type:"post",
				dataType:"text",
				data:$("#updatePost").serialize()
			});
		});
		
		// 댓글 달기
		$('#commentView').ajaxForm({
			success: function(data){
				$('#commentModal').modal('hide');
				getData();
		    },
		 	error : function(err){
			 	alert("댓글을 입력하는 과정에서 오류가 발생했습니다.");
		 	}
		});
		$('#searchUserForm').ajaxForm({
			success: function(data){
				$('#searchUserModal').modal('show');
				getUserData(data);
		    }
		});
		
		$('#CommentViewForm').ajaxForm({
			success: function(data){
				getCommentData(data);
				getData();
		    },
		 	error : function(err){
			 	alert("댓글을 입력하는 과정에서 오류가 발생했습니다.");
		 	}
		});
				
		getData();
	});
	
	function getUserData() {
		$.ajax({
			url:"searchUser.do",
			type:"post",
			data:$("#searchUserForm").serialize(),
			dataType:"json",
			success:function(data) {
				var table="";
				
			    $("#searchUserTable tr:gt(0)").remove();
				$(data.searchUserlist).each(function(index,item){
					
					table+="<tr>";
					table+="<td>"+item.email+"</td>";
					table+="<td>"+item.social+"</td>";
					table+="<td>"+item.name+"</td>";
					table+="<td>"+item.birth+"</td>";
					table+="<td><a href=javascript:addFriends('"+item.email+"','"+item.social+"')>추가</a></td>";

					table+="</tr>";                           
				});
				
			    $("#searchUserTable tr:eq(0)").after(table);
			},
			error : function(err){
				alert("데이터를 가져오는 중 오류가 발생했습니다.");
			}
		});
	}
	function getCommentData(board_num) {
		$.ajax({
			url:"commentView.do",
			type:"post",
			data:"board_num="+board_num,
			dataType:"json",
			success:function(data) {
				var table="";
				
			    $("#CommentTable tr:gt(0)").remove();
				$(data.Commentlist).each(function(index,item){
					
					table+="<tr>";
					table+="<td>"+item.name+"</td>";
					table+="<td>"+item.content+"</td>";
					table+="<td>"+item.write_date+"</td>";
					table+="</tr>";
				});
				
			    $("#CommentTable tr:eq(0)").after(table);
			},
			error : function(err){
				alert("데이터를 가져오는 중 오류가 발생했습니다.");
			}
		});
	}
	
	
	function addFriends(email,social) {
		$.ajax({
			url:"addFriend.do",
			type:"post",
			data:$("#userInfo").serialize()+"&emailFriend="+email+"&socialFriend="+social,
			dataType:"text",
			success:function(data) {
				if(data>0) {
					$('#searchUserModal').modal('hide');
					alert("추가되었습니다.");
					getData();
				}
			},
			error : function(err){
				alert("추가되지 않았습니다.");
			}
		});
	}
	
	function writeComment(board_num) {
		$('#commentBoardNum').attr('value', board_num);
		$('#commentModal').modal('show');
	}
	
	function viewComment(board_num) {
		$('#commentBoardNum2').attr('value', board_num);
		$('#commentViewModal').modal('show');
		getCommentData(board_num);
	}
	
	function setOpacity(obj, vOpacity) {
		obj.style.filter = 'alpha(opacity=' + vOpacity + ')';
		obj.style.opacity = (vOpacity == 0 ? 0 : (vOpacity / 100));
	}
	
	function positionTable(lat,lon,num) {
		
		var location = new google.maps.LatLng(lat, lon);
		var flag = 0;
				
		for(var i=0; i<=confirmArray.length;i++) {
			if(confirmArray[i]==num) {
				alert("으아ㅡ,ㅡ 반복해서 누르지마라 아프당");
				flag = 1;
				break;
			}
		}
		
		if (flag!=1) {
			confirmArray.unshift(num);
			$("<div id='subMap_canvas"+location+"' style='width:250px; height:200px;'></div>").appendTo("#contentTable"+num);
			$("<button class='btn btn-link' onclick='setPosition("+lat+","+lon+")'><span class='glyphicon glyphicon-plus'></span>내 위치 추가</button>").appendTo("#contentTable"+num);
			
			
			var myOptions = {
				center : location,
				zoom : 15,
				mapTypeId : google.maps.MapTypeId.ROADMAP,
				mapTypeControl : false,
				navigationControlOptions : {
					style : google.maps.NavigationControlStyle.SMALL
				}
			};
			var map = new google.maps.Map(document.getElementById("subMap_canvas"+location),
					myOptions);
			var marker = new google.maps.Marker({
				position : location,
				map : map,
				title : "회원님은 현재 여기에 있습니다."
			});
		}
	}
	
	function setPosition(lat,lon) {
		alert(lat+","+lon);
	}
</script>

<!-- 검색한 위치 설정 -->
<script type="text/javascript">
	function initialize(address) {
		var geoCoder = new google.maps.Geocoder(address);
		var request = {
			address : address
		};
		geoCoder.geocode(request, function(result, status) {
			var location = new google.maps.LatLng(result[0].geometry.location
					.lat(), result[0].location.lng());
			
			$("<input type='hidden' class='form-control' name='location' value='"+result[0].location.lat()+"'><button class='btn btn-link' onclick='positionTable("+item.lat+","+item.lon+","+item.board_num+")'>위치 보기</button>").appendTo("#latHidden");
			$("<input type='hidden' class='form-control' name='location' value='"+result[0].location.lng()+"'><button class='btn btn-link' onclick='positionTable("+item.lat+","+item.lon+","+item.board_num+")'>위치 보기</button>").appendTo("#lonHidden");
			
			var myOptions = {
				zoom : 15,
				center : location,
				mapTypeId : google.maps.MapTypeId.ROADMAP
			};
			var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
			var marker = new google.maps.Marker({
				position : location,
				map : map,
				title : "회원님은 현재 여기에 있습니다."
			});
		})
	}
</script>

<script>
	$(document).ready(function() {
		initialize(' ');
		$('#search').bind('click', function() {
			initialize($('#address').val());
		})
	})
</script>
<!-- 검색한 위치 설정 끝 -->

<!-- 위치 정보 표시의 html5 실시간 위치 추적 -->
<script>
	var x = document.getElementById("map_canvas");
	
	function getLocation() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition, showError);
		} else {
			x.innerHTML = "Geolocation is not supported by this browser.";
		}
	}

	function showPosition(position) {
		var lat = position.coords.latitude;
		var lon = position.coords.longitude;
		var location = new google.maps.LatLng(lat,lon);
		
		$("<input type='hidden' class='form-control' name='lat' value='"+lat+"'>").appendTo("#latHidden");
		$("<input type='hidden' class='form-control' name='lon' value='"+lon+"'>").appendTo("#lonHidden");
		
		var mapholder = document.getElementById('map_canvas');
		mapholder.style.height = '295px';
		mapholder.style.width = '570px';
		var myOptions = {
			center : location,
			zoom : 15,
			mapTypeId : google.maps.MapTypeId.ROADMAP,
			mapTypeControl : false,
			navigationControlOptions : {
				style : google.maps.NavigationControlStyle.SMALL
			}
		};
		var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
		var marker = new google.maps.Marker({
			position : location,
			map : map,
			title : "회원님은 현재 여기에 있습니다."
		});
		
		var mapholder1 = document.getElementById('map_canvas1');
		mapholder1.style.height = '250px';
		mapholder1.style.width = '350px';
		var myOptions1 = {
			center : location,
			zoom : 15,
			mapTypeId : google.maps.MapTypeId.ROADMAP,
			mapTypeControl : false,
			navigationControlOptions : {
				style : google.maps.NavigationControlStyle.SMALL
			}
		};
		var map1 = new google.maps.Map(document.getElementById("map_canvas1"),myOptions1);
		var marker1 = new google.maps.Marker({
			position : location,
			map : map1,
			title : "회원님은 현재 여기에 있습니다."
		});
	}

	function showError(error) {
		switch (error.code) {
		case error.PERMISSION_DENIED:
			x.innerHTML = "User denied the request for Geolocation.";
			break;
		case error.POSITION_UNAVAILABLE:
			x.innerHTML = "Location information is unavailable.";
			break;
		case error.TIMEOUT:
			x.innerHTML = "The request to get user location timed out.";
			break;
		case error.UNKNOWN_ERROR:
			x.innerHTML = "An unknown error occurred.";
			break;
		}
	}
</script>
<!-- html5 실시간 위치 추적 끝 -->

<body>
	<!-- modal Tag  -->
	<div class="modal fade" id="tagModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<form>
						<div class="input-group">
							<input id="tagName" type="text" class="form-control" placeholder="ex)맛집,사물,배경... 쉼표로 태그를 구분할 수 있습니다.">
							<span class="input-group-btn">
								<input class="btn btn-primary" type="button" value="add" id="tagPlus">
							</span>
							<p/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- modal comment -->
	<div class="modal fade" id="commentModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<form action="writeComment.do" method="post" id="commentView">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="ex)댓글을 입력하세요." name="content">
							<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
							<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
							<input id="commentBoardNum" type="hidden" value="" name="board_num">
							<span class="input-group-btn">
								<input class="btn btn-primary" type="submit" value="입력">
							</span>
							<p/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 유저 정보 보낼라꼬 -->
	<form id="userInfo" method="post">
		<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
		<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
	</form>
	<!-- 유저 정보 보낼라꼬 -->

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
			<form class="navbar-form navbar-left" id="searchUserForm">
				<div class="form-group">
					<input type="text" class="form-control" name="keyword" id="keyword"
						placeholder="관심있는 친구의 이름이나 아이디를 검색하세요." style="width: 350px;">
					<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
					<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
				</div>
				<button type="submit" class="btn btn-default">Submit</button>
			</form>
			
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">
				<span id="weatherInfo"></span></a>
				<ul class="dropdown-menu">
						<li><span id="weatherSpec"></span></li>
						<li class="divider"></li>
						<li><span id="wunderground"></span></li>
				</ul></li>
				
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><span
					class="glyphicon glyphicon-bell"></span>&nbsp<span class="badge pull-right" id="alarm"></span></a>
					<ul class="dropdown-menu">
						<li >
						<c:forEach items="${requestScope.checkFollower}" var="checkFollower">
							${checkFollower.email}님이 나를 따르고 있습니다.
						</c:forEach>
						<c:if test="${requestScope.checkFollower == null}">
							알림이 없습니다.
						</c:if>
						</li>
						<li class="divider"></li>
						<li><a href="#">알림 설정</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><span
					class="glyphicon glyphicon-cog"></span><b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#">프로필 편집</a></li>
						<li><a href="#">음악 설정</a></li>
						<li><a
						href="https://github.com/cloud9water4/facetoday/issues?state=open" target="_blank">개발팀에게 문의하기</a></li>
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
				<div id="preview" style='display:none;'></div>
				<div class="well">
					
					<span id="imageTooltip">
						<a data-toggle='modal' data-target='#upload' rel="image" data-original-title="사진을 올려보세요." data-placement="top" onclick="return false;">	
						<span class="glyphicon glyphicon-picture"></span>image &nbsp</a>
					</span>
					
					<span id="locTooltip">
					<a data-toggle='modal' data-target='#locationModal' href="#" rel="location" data-original-title="지금 어디 계신가요?" data-placement="top" onclick="return false;">
					<span class="glyphicon glyphicon-road"></span>location</a>
					</span>
					<!-- </button> -->

				<!-- 새 글 작성 -->
				<form action="insert.do" method="post" id="newPostForm">
					<input type="text" class="form-control" placeholder="새 글 작성하기" name="content" id="content">
					<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
					<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
					<div id="latHidden"></div>
					<div id="lonHidden"></div>
					<span class="label label-default" id="tagLabel">태그<span class="glyphicon glyphicon-plus"></span></span>
					<img id="screen" src="" class="img-responsive img-rounded">
					<div id="map_canvas1"></div><p/>
					<span id="tagForm"></span>
					<input class="btn btn-default right" type="submit" value="Go!" id="btnPost">
				</form>
				
				</div>
				<p />
				
				<!-- 글 목록 나오기 -->
				<table class="table table-hover" id="listTable" >
					<tr>
						<td colspan="5" align="center">
							<p class="text-center"> new Post!
						</td>
					</tr>
				</table>
				<p />
			</div>
			
			<!-- /.blog-main -->

			<div class="col-sm-3 col-sm-offset-1 blog-sidebar" id="SideTab">
				
				<form action="songSelectAll.do" method="post">
					<input type="hidden" name="email" value="${sessionScope.userInfo.email}">
					<input type="hidden" name="name" value="${sessionScope.userInfo.name}">
					<input type="hidden" name="social" value="${sessionScope.userInfo.social}">
					<button class="btn btn-link" type="submit"><h6><span
						class="glyphicon glyphicon-headphones"></span>음악 관련 설정</h6></button>
				</form>
				
					
				<c:choose>
				<c:when test="${requestScope.sources!=null}">
					<iframe width="220" height="180"
					src="//www.youtube.com/embed/?feature=player_embedded&autoplay=1&autohide=1&loop=1&playlist=${requestScope.sources}"> </iframe>
				</c:when>
				<c:when test="${requestScope.check!=null}">
					<iframe width="220" height="180"
					src="//www.youtube.com/embed/?feature=player_embedded&autoplay=1&autohide=1&loop=1&playlist=${requestScope.check}"> </iframe>
				</c:when>
				<c:otherwise>
					<script type="text/javascript">
						alert("최근 들은 노래가 없습니다. 음악 관련 설정에서 노래를 설정해주세요.");
					</script>
				</c:otherwise>
				</c:choose>
			
				<!-- 개인 정보 설정 -->
				<div class="media">
					<form class="pull-left" action="main.do" method="post"> 
						<img class="media-object img-rounded" src="testPic/photo-1.jpg" onclick="submit()">
						<input type="hidden" name="email" value="${sessionScope.userInfo.email}">
						<input type="hidden" name="name" value="${sessionScope.userInfo.name}">
						<input type="hidden" name="social" value="${sessionScope.userInfo.social}">
					</form>
					<div class="media-body">
						<h4 class="media-heading">${sessionScope.userInfo.name}</h4>
						<a href="config.jsp"><h6>프로필 편집</h6></a>
					</div>
				</div>
			</div>

			<!-- /.blog-sidebar -->
</div>

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->
	
	<div class="blog-footer">
		<p>
			<a href="#">Back to top</a>
		</p>
	</div>

	<!-- upload modal -->
	<div class="modal fade" id="upload" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<form id="UploadForm" action="upload.do" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
							<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
							<input type="file" name="file" id="imgInp">
							<img id="screenModal" src="" class="img-responsive img-rounded">
						</div>
						<div class='modal-footer'>
							<input type="submit" class="btn btn-success" value="확인"/>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- commentview modal -->
	<div class="modal fade" id="commentViewModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<form id="CommentViewForm" action="writeComment.do" method="post" enctype="multipart/form-data">
						<table class="table table-hover" id="CommentTable">
								<tr>
								</tr>
						</table>					
						<div class="input-group">
							<input type="text" class="form-control" placeholder="댓글을 입력하세요." name="content">
						<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
						<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
						<input id="commentBoardNum2" type="hidden" value="" name="board_num">
						<span class="input-group-btn">
							<input class="btn btn-primary" type="submit" value="입력">
						</span>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Location modal define -->
	<div class="modal fade" id="locationModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="myModalLabel">위치 정보를 담으세요. <button class="btn btn-link" onclick="getLocation()">실시간 위치를 사용하려면 클릭!</button> </h4>
				</div>
				
				<div class="modal-body">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="위치를 입력하세요.ex)부산대학교" id="address">
						<span class="input-group-btn">
							<input class="btn btn-primary" type="submit" value="입력" id="search">
						</span>
						</div>

						<div class="box">
							<div id="map_canvas"></div>
						</div>
						<p/>
						<div class='modal-footer'>
        					<button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
						</div>
				</div>
			</div>
		</div>
	</div>
	<!-- searchUserlist modal -->
	<div class="modal fade" id="searchUserModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<form>
						<table class="table table-hover" id="searchUserTable">
								<tr>
								</tr>
						</table>	
					</form>
				</div>
			</div>
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