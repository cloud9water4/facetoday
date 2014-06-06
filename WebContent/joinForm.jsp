<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="../../assets/ico/favicon.ico">

<title>회원 가입하기</title>
<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<!-- 회원 가입 modal-->
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<form method="post" enctype="multipart/form-data" action="join.do" id="joinMember">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3 id="myModalLabel">회원가입-디자인 추후 수정</h3>
					</div>
					<div class="form-group">
						<!-- Username -->
						<label class="control-label" for="name">이름</label>
						<div class="form-group">
							<input type="text" id="name" name="name" placeholder="이름,닉네임"
								class="form-control" required autofocus="autofocus">
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
							<input type="password" name="passwd" placeholder="비밀번호"
								class="form-control" required>
							<p class="help-block">비밀번호는 최소한 4 글자 이상으로 해주세요.</p>
						</div>
					</div>

					<div class="form-group">
						<!-- Password -->
						<label class="control-label" for="password_confirm">비밀번호(재입력)</label>
						<div class="form-group">
							<input type="password" name="passwd_confirm"
								placeholder="비밀번호(재입력)" class="form-control" required>
							<p class="help-block">비밀번호를 다시 입력해주세요.</p>
						</div>
					</div>

					<div class="form-group">
						<!-- Password-->
						<label class="control-label" for="birth">생년월일</label>
						<div class="form-group">
							<input type="date" id="birth" name="birth" class="form-control"
								required>
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
	
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="resource/js/bootstrap.min.js"></script>
	
</body>
</html>