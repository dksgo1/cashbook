<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//Controller
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		}
	//session에 지정된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	int row = helpDao.deleteHelp(helpNo);
	
	if(row == 1) {
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
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