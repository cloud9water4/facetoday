<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.httpclient.HttpClient"%>
<%@ page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@ page import="org.apache.commons.httpclient.HttpStatus"%>
<%
	String key = "54d3f6e2290138f417d6be1fde0dab76";
	String target = request.getParameter("target"); // 검색 대상 
	String query = request.getParameter("query"); // 검색어
	String url = "http://openapi.naver.com/search?query=" + query
			+ "&target=" + target + "&key=" + key; // API 호출 URL 
	request.setCharacterEncoding("utf-8");

	HttpClient client = new HttpClient();
	GetMethod method = new GetMethod(url);
	try {
		int statusCode = client.executeMethod(method);
		out.clearBuffer();
		response.reset();
		response.setStatus(statusCode);
		if (statusCode == HttpStatus.SC_OK) {
			String result = method.getResponseBodyAsString();
			response.setContentType("text/xml; charset=utf-8");
			out.println(result);
		}
	} catch (Exception e) {
		out.println(e.toString());
	} finally {
		if (method != null)
			method.releaseConnection();
	}
%>