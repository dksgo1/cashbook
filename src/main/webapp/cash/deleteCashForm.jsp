<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/*
	int boardNo = Integer.parseInt(request.getParameter("cashNo"));
	String msg = request.getParameter("msg"); // 수정실패시 리다이렉트시에는 null값이 아니고 메세지가 있다
	*/
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>가계부 삭제</h1>
	<form action="<%=request.getContextPath()%>/cash/deleteCashAction.jsp" method="post">
		<input type="hidden" name="cashNo" value="">
		삭제할 비밀번호 :
		<input type="password" name="memberPw">
		<button type="submit">삭제</button>
	</form>
</body>
</html>