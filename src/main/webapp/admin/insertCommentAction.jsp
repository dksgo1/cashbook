<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	//1) C
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 관리자만 들어올 수 있게
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// null이나 공백이면 돌려보내기
	if(request.getParameter("commentMemo") == null ||
		request.getParameter("commentMemo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
			return;
	}
	String memberId = request.getParameter("memberId");
	String commentMemo = request.getParameter("commentMemo"); 
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	Comment comment = new Comment();
	comment.setCommentMemo(commentMemo);
	comment.setHelpNo(helpNo);
	comment.setMemberId(memberId);
	
	
	// 2 Model호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.insertComment(comment);
	
	if(row == 1) {
		System.out.println("답변성공");
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
		return;
	} else {
		System.out.println("답변실패");
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