<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.net.*" %>
<%@ page import = "java.sql.*" %>
<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);

	NoticeDao noticeDao = new NoticeDao();
	noticeDao.updateNotice(notice);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>공지 수정</h1>
	<form action="<%=request.getContextPath()%>/admin/noticeUpdateAction.jsp" method="post">
		<table>
			<tr>
				<td>공지 내용</td>
				<td><textarea row="5" cols="100" name="noticeMemo"><%=notice.getNoticeMemo()%></textarea></td>
			</tr>
		</table>
	</form>
</body>
</html>