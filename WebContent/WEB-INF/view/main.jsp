<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="description" content="least.js 2 - Random and Responsive HiDPI jQuery Gallery based on HTML5 and CSS3">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="shortcut icon" href="../../assets/ico/favicon.ico">

<title>Test Web Page</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/donggu.css" rel="stylesheet">
<link href="css/offcanvas.css" rel="stylesheet">

<!-- Responsive viewport for smartphone devices -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<!-- least.js 2 CSS file -->
<link href="css/least.min.css" rel="stylesheet" />

</head>

<script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=false"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="http://www.google.com/jsapi"></script>
<script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=4679e9c92b6f93a47f0bf47d24df517a"></script>


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

img.bg {
	min-height: 100%;
	min-width: 1024px;
	width: 100%;
	height: auto; /* auto */
	position: fixed;
	top: 0;
	left: 0;
	z-index: -100;
}
</style>

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
		
		$('.least-gallery').least();
		
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
				url:"emotion.do",
				type:"post",
				data:$("#userInfo").serialize(),
				dataType:"json",
				success:function(data) {
					var table="";
					
				    $("#EmotionTable tr:gt(0)").remove();
					$(data.Emotionlist).each(function(index,item){
						
						table+="<tr>";
						table+="<td>"+item.write_date+"</td>";
						table+="<td>"+item.keyword+"</td>";
						table+="<td>"+item.state+"</td>";
						table+="</tr>";
					});
					
				    $("#EmotionTable tr:eq(0)").after(table);
				},
				error : function(err){
					alert("데이터를 가져오는 중 오류가 발생했습니다.");
				}
			});
			$.ajax({
				url:"selectAllMe.do",
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
				    	table+="<td><th><input class='btn btn-danger' type='button' value='삭제' id='del' name='"+item.board_num+"'><p/><input class='btn' type='button' value='수정' data-toggle='modal' data-target='#myModal' id='upd' name='"+item.board_num+"'></th>";
				    	table+="</td>";
						table+="</tr>";
						table+="<tr align='right'>";
						table+="<td colspan='5' style='border-top:0px;'>";
						table+="<span class='glyphicon glyphicon-heart'>&nbsp</span>";
						table+="<span class='glyphicon glyphicon-comment' onclick='writeComment("+item.board_num+")'></span>";
						table+="<button class='btn btn-link' onclick='viewComment("+item.board_num+")'><h6>댓글"+item.c_num+"개</h6></button></td>";
						table+="</tr>";
						
						return index<2;	
					});
					
				    $("#listTable tr:eq(0)").after(table);
				},
				error : function(err){
					alert("데이터를 가져오는 중 오류가 발생했습니다.");
				}
			});
			
		}
		$(document).on("click","#allMe", function(){ 
			alert("게시글을 모두 보여줍니다.");
			$.ajax({
				url:"selectAllMe.do",
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
							table+="<td id='contentTable"+item.board_num+"'><h4>"+item.name+"</h4>"+item.content+"<button class='btn btn-link' onclick='positionTable("+item.lat+","+item.lon+","+item.board_num+")'>위치 보기</button>"+item.board_num+"</span></td>";
						} else {
							table+="<td><h4>"+item.name+"</h4>"+item.content+"<span class='hidden'><span class='hidden'>"+item.board_num+"</span><span class='label label-info'>"+item.tag+"</span></td>";
						} 
						table+="<td><h6>"+item.write_date+"</h6></td>";
				    	table+="<td><th><input class='btn btn-danger' type='button' value='삭제' id='del' name='"+item.board_num+"'><p/><input class='btn' type='button' value='수정' data-toggle='modal' data-target='#myModal' id='upd' name='"+item.board_num+"'></th></td>";
						table+="</tr>";
						
						table+="<tr align='right'>";
						table+="<td colspan='5' style='border-top:0px;'>";
						table+="<span class='glyphicon glyphicon-heart'>&nbsp</span>";
						table+="<span class='glyphicon glyphicon-comment' onclick='writeComment("+item.board_num+")'></span>";
						table+="<button class='btn btn-link' onclick=''><h6>댓글"+item.c_num+"개</h6></button></td>";
						table+="</tr>";
					});
					
				    $("#listTable tr:eq(0)").after(table);
				},
				error : function(err){
					alert("데이터를 가져오는 중 오류가 발생했습니다.");
				}
			});
		});
		
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
					.lat(), result[0].geometry.location.lng());
			
			//$("<input type='hidden' class='form-control' name='location' value='"+result[0].geometry.location.lat()+"'><button class='btn btn-link' onclick='positionTable("+item.lat+","+item.lon+","+item.board_num+")'>위치 보기</button>").appendTo("#latHidden");
			//$("<input type='hidden' class='form-control' name='location' value='"+result[0].geometry.location.lng()+"'><button class='btn btn-link' onclick='positionTable("+item.lat+","+item.lon+","+item.board_num+")'>위치 보기</button>").appendTo("#lonHidden");
			
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
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> 
					<span class="icon-bar"></span> <span class="icon-bar"></span> 
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="javascript:history.back()"> <span
					class="glyphicon glyphicon-globe"></span> FaceToday
				</a>
			</div>
			
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
					class="glyphicon glyphicon-bell"></span>&nbsp<span class="badge pull-right">0</span></a>
					<ul class="dropdown-menu">
						<li ><a href="#">알림이 없습니다.</a></li>
						<li class="divider"></li>
						<li><a href="#">알림 설정</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><span
					class="glyphicon glyphicon-cog"></span><b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#">프로필 편집</a></li>
						<li><a href="#">음악 설정</a></li>
						<li><a href="#">Something else here</a></li>
						<li class="divider"></li>
						<li><a href="index.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
		</div>
	</div>
	
	
	<!-- Least Gallery -->
        <section id="least">
        <form action="imageInit.do" method="post">
        	<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
			<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
			<span class="glyphicon glyphicon-th-large"><button type="submit">Go to Gallery</button></span>	
        </form>
            <!-- Least Gallery: Thumbnails -->
            <ul class="least-gallery">
                <c:forEach items="${imageList}" var="list">
                	<li>
                    <a href="http://localhost:9000/projectSpring/facetodayDB/${list.image}" title="${list.tagString}" data-caption="<strong>${list.write_date}</strong> ${list.content}" >
                        <img src="http://localhost:9000/projectSpring/facetodayDB/${list.image}"/>
                    </a>
                	</li>
                </c:forEach>
            </ul>
            
            <!-- Least Gallery: Fullscreen Preview -->
            <div class="least-preview"></div>
        </section>
        <!-- Least Gallery end -->
	
	<div class="container">
		<div class="row">
		
			<div class="col-md-6">          		
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
							<p class="text-center">내 담벼락
							<button class="btn-link" id="allMe"><h6>내 글 전체 보기</h6></button>
						</td>
					</tr>
				</table>
				<p />
				
				<div class="panel panel-info">
					<!-- Default panel contents -->
					<div class="panel-heading text-center"><strong>기분 판단 요소</strong></div>
					<div class="panel-body">
						<p>아래의 목록은 시간에 따라 작성한 회원님의 글을 토대로 분석하여 기분에 영향을 끼친 단어들을 모은 것입니다.
						주요 키워드는 기분에 직접적인 영향을 주었다고 판단된 요소로써, 형태소 단위로 분해되어 입력한 본래의 단어가 반영되지 않을 수 있습니다.</p>
					</div>
					
					<!-- 테이블-->
					<table class="table table-hover" id="EmotionTable">
						<tr>
							<td>시간</td>
							<td>주요 키워드</td>
							<td>예상 수치</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- /.blog-main -->

			<div class="col-md-4">
				
				<!-- 개인 정보 설정 -->
				<div class="media">
					<a class="pull-left" href="#"> 
						<img class="media-object img-rounded" src="testPic/photo-1.jpg">
					</a>
					<div class="media-body">
						<h4 class="media-heading">${sessionScope.userInfo.name}</h4>
						<a href="#"><h6>프로필 편집</h6></a>
					</div>
				</div>
				<p/>
				<div id="myMap"></div>
				<script type="text/javascript">
					var oPoint = new nhn.api.map.LatLng(36.353332, 127.384680); // 지도의 좌표 설정
					nhn.api.map.setDefaultPoint('LatLng'); // 위도 경도 좌표계 사용 (LatLng, TM128, UTMK)
					oMap = new nhn.api.map.Map('myMap', {// 지도 생성 (옵션 설정)
						point : oPoint, // 지도의 중심점 좌표
						zoom : 1, // 지도의 축척레벨
						enableWheelZoom : true, // 마우스 휠 동작으로 지도를 확대/축소할지 여부
						enableDragPan : true, // 마우스로 끌어서 지도를 이동할지 여부
						enableDblClickZoom : true, // 더블클릭으로 지도를 확대할지 여부
						mapMode : 0, // 지도 모드(0 : 일반 지도, 1 : 겹침 지도, 2 : 위성 지도)
						activateTrafficMap : true, // 실시간 교통 홗성화 여부
						activateBicycleMap : false, // 자전거 지도 홗성화 여부
						minMaxLevel : [ 1, 14 ], // 지도의 최소/최대 축척 레벨
						size : new nhn.api.map.Size(350, 500)
					// 지도의 크기
					});
					var mapZoom = new nhn.api.map.ZoomControl();
					mapZoom.setPosition({left:10, top:10}); // - 줌 컨트롤 위치 지정
					oMap.addControl(mapZoom); // - 줌 컨트롤 추가
					mapTypeChangeButton = new nhn.api.map.MapTypeBtn();
					mapTypeChangeButton.setPosition({top:10, left:50}); // 위치
					oMap.addControl(mapTypeChangeButton); // 컨트롤 추가
					
					//지도에 마커 추가
					var oSize = new nhn.api.map.Size(28, 37);
					var oOffset = new nhn.api.map.Size(14, 37);
					var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);
					var oMarker = new nhn.api.map.Marker(oIcon, { title : '마커 : ' + oPoint.toString() });
					oMarker.setPoint(oPoint);
					oMap.addOverlay(oMarker); // 마커 추가
					
					// 마커라벨 표시
	               	// 마커의 기본 표시 설정
 					var infoWindow = new nhn.api.map.InfoWindow(); // - info window 생성
 					var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
 					oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.
 					oMap.addOverlay(infoWindow); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.
 
				</script>
				
				<!-- /.blog-sidebar -->
				<div class="row">
  					<div class="col-xs-6 col-md-3">
    				<a href="#" class="thumbnail">
      					<img data-src="holder.js/100%x180" alt="...">
    				</a>
  					</div>
				</div>
			
			</div>
			
			
			<div class="col-md-2">
			<iframe id="music" width="220" height="180"
					src="//www.youtube.com/embed/?feature=player_embedded&autoplay=0&autohide=1&loop=1&playlist"> </iframe>
			
			
			<h5><span class="glyphicon glyphicon-music"></span>사용자 지정 노래 목록</h5>
			<script type="text/javascript">
			function play(sources) {
				 $('#music').attr('src',"//www.youtube.com/embed/?feature=player_embedded&autoplay=1&autohide=1&loop=1&playlist="+sources);
			}
			
			</script>
			<table class="table table-bordered table-striped">
			<c:forEach items="${requestScope.userlist}" var="userlist">
				<tr>
				<td><h6 onclick="play('${userlist.sources}')">${userlist.list_name}</h6></td>
				<td>
				<form action="deleteUserlist.do" method="post">
					<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
					<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
					<input type="hidden" name="list_num" id="list_num" value="${userlist.list_num}">
					<button class="btn btn-link" type="submit"><span class="glyphicon glyphicon-minus"></span></button>
				</form>
				</td>
				</tr>	
			</c:forEach>
			</table>
			</div>

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
	<!-- end modal define  -->
	
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

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="resource/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/spin.min.js"></script>
	<script src="js/libs/least/least.min.js"></script>
    <script>
        $(document).ready(function(){
            $('.least-gallery').least();
        });
    </script>
    <script>
        /* Google Analytics */
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-16040332-11', 'leastjs.com');
        ga('set', 'anonymizeIp', true);
        ga('send', 'pageview');
    </script>
	</body>
</html>