<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<title>노래 목록</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/offcanvas.css" rel="stylesheet">

<script src="http://www.google.com/jsapi"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<style>
#SideObj{
position: fixed;
right:20%;
top:10%;
margin-left:-640px;
text-align:center;
width:170px;}

#Sidelist{
position: fixed;
right:11%;
top:75%;
margin-left:-640px;
text-align:center;
width:170px;}
</style>

<script type="text/javascript">
$(document).ready(function() {
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
		navigator.geolocation.getCurrentPosition(showPosition);
	} else {
		alert("실시간 위치 정보를 지원하지 않는 브라우저를 사용 중입니다.");
	}
	
	function showPosition(position) {
		lat = position.coords.latitude;
		lon = position.coords.longitude;	
		getWeatherInto(lat,lon);
	}
	
	function getWeatherInto(lat,lon){
		  $.ajax({
			  // 결과를 한글로 받을 수 있다.
			  url : "http://api.wunderground.com/api/2d769320347dd67c/geolookup/conditions/lang:KR/q/"+lat+","+lon+".json",
			  dataType : "jsonp",
			  success : function weather(parsed_json) {
				  var observ = parsed_json.current_observation;			
				  var state=observ.weather;
				$('#weather').attr('value',state);

				}
		  });
	 }
});

 jQuery.fn.alternateRowColors = function() {
   $('tbody tr:odd', this)
     .removeClass('even').addClass('odd');
   $('tbody tr:even', this)
     .removeClass('odd').addClass('even');
   return this;
 };
 
 $(document).ready(function() {
   $('table.sortable').each(function() {
     var $table = $(this);
     $table.alternateRowColors();
     $('th', $table).each(function(column) {
       var $header = $(this);
       
	   var findSortKey;
       if ($header.is('.sort-basic')) {
         findSortKey = function($cell) {
           return $cell.text().toUpperCase();
         };
       }
       else if ($header.is('.sort-ranking')) {
         findSortKey = function($cell) {
           var key = $cell.text();
           key = parseFloat(key);
           return isNaN(key) ? 0 : key;
         };
       }     
           
       if (findSortKey) {
         $header.addClass('clickable').hover(function() {
           $header.addClass('hover');
         }, function() {
           $header.removeClass('hover');
         }).click(function() {
			 
			 var sortDirection = 1;
           if ($header.is('.sorted-asc')) {
             sortDirection = -1;
           }
			 
			 
           var rows = $table.find('tbody > tr').get();
           $.each(rows, function(index, row) {
             var $cell = $(row).children('td').eq(column);
             row.sortKey = findSortKey($cell);
           });
		   
           rows.sort(function(a, b) {
             if (a.sortKey < b.sortKey) return -sortDirection;
             if (a.sortKey > b.sortKey) return sortDirection;
             return 0;
           });
           $.each(rows, function(index, row) {
             $table.children('tbody').append(row);
             row.sortKey = null;
           });
		   
		   $table.find('th').removeClass('sorted-asc')
             .removeClass('sorted-desc');
           if (sortDirection == 1) {
             $header.addClass('sorted-asc');
           }
           else {
             $header.addClass('sorted-desc');
           }
           $table.alternateRowColors();
		   $table.trigger('repaginate');
		
         });
       }
     });
   });
 });



 $(document).ready(function() {
  $('table.paginated').each(function() {
    var currentPage = 0;
    var numPerPage = 20;
    var $table = $(this);


	$table.bind('repaginate', function() {
      $table.find('tbody tr').hide()
        .slice(currentPage * numPerPage,
          (currentPage + 1) * numPerPage)
        .show();
    });
			
    var numRows = $table.find('tbody tr').length;
    var numPages = Math.ceil(numRows / numPerPage);
    var $pager = $('<div class="pager"></div>');
    for (var page = 0; page < numPages; page++) {
      $('<span class="page-number"></span>').text(page + 1)
        .bind('click', {newPage: page}, function(event) {
          currentPage = event.data['newPage'];
          $table.trigger('repaginate');
          $(this).addClass('active')
            .siblings().removeClass('active');
        }).appendTo($pager).addClass('clickable');
    }
    $pager.insertBefore($table)
      .find('span.page-number:first').addClass('active');
  });
});
	
 function checkValid(){
	  	var f=window.document.songForm;
		var length=songForm.check.length;
		var cnt=0;
		var song=null;
	    var ary=new Array();
	    for(var i=0;i<length;i++){
	    	if(songForm.check[i].checked){
	    		cnt++;
	    		
	    		song=songForm.check[i].value;
	    		ary.push(song);
	    	     
	    	}    	
	    }
	    song1=ary.join();
	    
	    if(f.list_name.value==null) {
	    	alert("목록의 이름을 정하지 않으셨습니다.");
	    	return false;
	    }
		if(cnt=="0"){
			alert("하나이상 체크하기!!");
			return false;
		}
		document.songForm.check.value=song1;
		return true;
	}

 function play(num) {
	 var source = $('#'+num).attr("name");
	 $('#preview').attr('src',"//www.youtube.com/embed/"+source+"?feature=player_embedded&autoplay=1");
 }
</script>
</head>

<body>
	<!-- 사용자 목록 만들기 -->
	<div class="modal fade" id="userlist" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<form action="check.do" method="post" id="commentView">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="리스트의 이름을 지어주세요." name="list_name">
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
	
	<div class="col-md-8">
	<form action="proposelist.do" method="post">
			<button class="btn btn-link" type="submit"><h6>날씨에 따른 음악 추천</h6></button>
			<input type="hidden" value="" name="weather" id="weather">
	</form>
	<form action="proposelistEmotion.do" method="post">
		<button class="btn btn-link" type="submit"><h6>기분에 따른 음악 추천</h6></button>
		<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
		<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
	</form>
	<form name="songForm" method="post" action="check.do" onSubmit='return checkValid()'>
		
		<table class="table table-bordered table-striped sortable paginated">
			<thead>
				<tr>
					<th></th>
					<th class="sort-basic"><p align="center">가수명</p></th>
					<th class="sort-basic"><p align="center">곡명</p></th>
					<th class="sort-ranking"><p align="center">발매일</p></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${songs}" var="list">
					<tr>
					<td>
						<p align="center">
							<span style="font-size: 9pt;"><input type="checkbox"
								name="check" value="${list.source}"> </span>
						</p>
					</td>

					<td>
						<p align="center">
							<span style="font-size: 9pt;">${list.singer} </span>
						</p>
					</td>
					<td>
						<p align="center">
							<span style="font-size: 9pt;"> 
								<%-- <a href="http://www.youtube.com/watch?v=${list.source}"target="_blank">${list.title}</a> --%>
								<a href="javascript:void(0);" onclick="play(${list.song_num})" target="_blank">${list.title}</a>
								<input type="hidden" id="${list.song_num}" name="${list.source}">
							</span>
						</p>
					</td>
					<td bgcolor="">
						<p align="center">
							<span style="font-size: 9pt;">${list.release} </span>
						</p>
					</td>
					</tr>
				</c:forEach>

			</tbody>

		</table>
		
		<input type="hidden" name="email" id="email" value="${sessionScope.userInfo.email}">
		<input type="hidden" name="social" id="social" value="${sessionScope.userInfo.social}">
		
		<tr>
			<td width="450" height="20" colspan="2" align="center"><b><span
					style="font-size: 9pt;"> <a href="check.do"><input
							type=submit value="듣기"></a> <input type=reset value="다시선택하기"></span></b></td>
		</tr>
		
		<div id="SideObj"> 
			<iframe id="preview" width="410" height="320" src="//www.youtube.com/embed/?feature=player_embedded&autoplay=1&autohide=1&loop=1&playlist="> </iframe>
			<button class="btn btn-info" type="submit" style="width: 410px;">새로운 사용자 음악 목록 만들기</button>
			<input type="text" class="form-control" id="listAdd" name="list_name" placeholder="ex)등굣길 들을 노래" style="width: 410px;"> 
		</div>
	
	</form>

		<div id="Sidelist">
		
			<h6>사용자 노래 리스트</h6>
			<c:forEach items="${requestScope.userlist}" var="userlist">
				<form action="userlistPlay.do" method="post">
				<input type="hidden" value="${userlist.sources}" name="sources">
				<button class="btn btn-link" type="submit">${userlist.list_name}</button>
				</form>
			</c:forEach>
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