<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %> 
<%@ page import = "java.net.*"%>
<%
	//Controller
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 로그인상태 아니거나 관리자 레벨이 아니면 돌려보내기
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// null값이나 공백있으면 돌려보내기
	if(request.getParameter("commentNo") == null ||
		request.getParameter("commentNo").equals("") ||
		request.getParameter("commentMemo") == null ||
		request.getParameter("commentMemo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/helpList.jsp");
			return;
	}

	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String commentMemo = request.getParameter("commentMemo");
	
	// 2) Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.updateComment(commentMemo, commentNo);
	
	if(row == 1) {
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
		return;
	} else {
		System.out.println("수정실패");
	}
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