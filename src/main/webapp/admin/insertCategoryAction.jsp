<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	//1)
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 0) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("categoryKind") == null ||
		request.getParameter("categoryKind").equals("") ||
		request.getParameter("categoryName") == null ||
		request.getParameter("categoryName").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp");
			return;
	}
	
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	//System.out.println("categoryKind");
	//System.out.println("categoryName");
	
	
	// 2) Model 호출
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.insertCategory(categoryKind, categoryName);
	
	if(row == 1) {
		System.out.println("추가성공");
	} else {
		System.out.println("추가실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCategoryAction</title>
</head>
<body>

</body>
</html>