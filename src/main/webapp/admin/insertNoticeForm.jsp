<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 로그인상태가 아니거나 관리자 아이디가 아니면 돌려보내기
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>noticeMemo</td>
				<td><textarea rows="5" cols="100" name="noticeMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">공지 추가</button>
	</form>
</body>
</html>