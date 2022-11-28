<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	//1)
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 0) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	if(request.getParameter("noticeMemo") == null ||
		request.getParameter("noticeMemo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/insertNoticeForm.jsp");
			return;
		}
	
	String noticeMemo = request.getParameter("noticeMemo");
	//System.out.println("noticeMemo");
	
	// 2) Model 호출
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(noticeMemo);
	
	if(row == 1) {
		System.out.println("공지추가 성공");
	} else {
		System.out.println("공지추가 실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
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