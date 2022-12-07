<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@page import="vo.*"%>
<%@page import="java.util.*"%>
<%@page import="dao.*"%>
<%
	// Controller
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	if(session.getAttribute("loginMember") == null) {
	// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	//session에 지정된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	
	// 모델 호출
	HelpDao helpDao = new HelpDao();
	Help updateHelp = helpDao.selectHelpOne(helpNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="number" name="helpNo" value="<%=helpNo%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>helpMemo</td>
				<td><textarea rows="5" cols="100" name="helpMemo"><%=helpMemo%></textarea></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>