<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*"%>
<%@ page import = "java.util.*"%>
<%
	// Controller
	/* 이거떄문에 진행이 안됨ㅠ 나중에 해결하기..
	Member loginMember = (Member)session.getAttribute("login");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	*/
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	// Model : notice list
	NoticeDao noticeDao =  new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage); //beginRow값과 rowPerPage값 넣어야함
	
	int noticeCount = noticeDao.selectNoticeCount(); // -> lastPage를 구할려면 필요함 
	int lastPage = (int)Math.ceil((double)noticeCount / (double)rowPerPage);
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
	<div>
		<!-- noticeList contents -->
		<table border="1" >
			<tr>
				<th>공지번호</th>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeNo()%>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
						<td><a href="<%=request.getContextPath()%>/admin/noticeUpdateForm.jsp">수정</a></td>
						<td>삭제</td>
					</tr>
			<%
				}
			%>
		</table>
		<!-- 페이징 -->
		<div>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {
			%>		
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
				<span><%=currentPage%></span> <!-- 현재 보고있는 페이지가 몇페이지인지 -->
			<%
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
		
	</div>
</body>
</html>