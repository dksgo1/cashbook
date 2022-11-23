<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %> 
<%@ page import = "java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("utf-8"); // 인코딩
	
	// 2)
	MemberDao memberDao = new MemberDao();
	
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp");
%>
