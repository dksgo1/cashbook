<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// 1) C
	request.setCharacterEncoding("UTF-8"); // 인코딩
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));

	// 2) Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.deleteComment(commentNo);
	
	if(row == 1) {
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
		return;
	} else {
		System.out.println("삭제실패");
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