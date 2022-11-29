<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@page import="vo.*"%>
<%@page import="java.util.*"%>
<%@page import="dao.*"%>
<%
	// Controller
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 로그인상태 아니거나 관리자 레벨이 아니면 돌려보내기
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	
	// Model 호출
	CommentDao commentDao = new CommentDao();
	Comment updateComment = commentDao.selectCommentOne(commentNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCommentForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>commentNo</td>
				<td><input type="number" name="helpNo" value="<%=commentNo%>" readonly="readonly"></td>
			</tr>		
			<tr>
				<td>commentMemo</td>
				<td><textarea rows="5" cols="100" name="commentMemo"></textarea></td>
			</tr>
		</table>
		<input type="hidden" name="commentNo" value="<%=updateComment.getCommentNo()%>">
		<button type="submit">수정</button>
	</form>
</body>
</html>