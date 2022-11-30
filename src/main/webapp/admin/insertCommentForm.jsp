<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 관리자만 들어올수 있게
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCommentForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>helpNo</td>
				<td><input type="number" name="helpNo" value="<%=helpNo%>" readonly="readonly"></td>
			</tr>	
			<tr>
				<td>commentMemo</td>
				<td><textarea rows="5" cols="100" name="commentMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">답변등록</button>
	</form>
</body>
</html>