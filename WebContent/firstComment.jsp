<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="modal-dialog">
			<div class="modal-content">
			<div class="modal-header">
			이 주의 노래에 대한 평가를 남겨주세요! EXO-K_중독(Overdose)
			</div>
				<div class="modal-body">
					<div class="table">
					</div>
					<form id="CommentViewForm" action="writeComment.do" method="post" enctype="multipart/form-data">
						<table class="table table-hover" id="CommentTable">
								<tr>
								</tr>
						</table>					
						<div class="input-group">
							<input type="text" class="form-control" placeholder="평가를 남겨주세요." name="content">
						<span class="input-group-btn">
							<input class="btn btn-primary" type="submit" value="입력">
						</span>
						</div>
					</form>
				</div>
			</div>
		</div>
</body>
</html>