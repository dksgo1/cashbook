<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %> 
<%@ page import = "java.net.*"%>
<%
	// Controller
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 로그인상태 아니거나 관리자 레벨이 아니면 돌려보내기
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("categoryNo") == null ||
		request.getParameter("categoryNo").equals("") ||
		request.getParameter("categoryName") == null ||
		request.getParameter("categoryName").equals("") ||
		request.getParameter("categoryKind") == null ||
		request.getParameter("categoryKind").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
			return;
	}
		
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	// 2) Model 호출
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.updateCategoryName(categoryKind, categoryName, categoryNo);
	
	if(row == 1) {
		System.out.println("수정성공");
	} else {
		System.out.println("수정실패");
	}

	response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>