<%@page import="facetoday.spring.service.SongServiceImpl"%>
<%@page import="facetoday.spring.service.SongService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<OL TYPE="1">
<c:forEach items="${songs}" var="list">
<LI>${list}<p>
</c:forEach>

</OL>
</body>
</html>