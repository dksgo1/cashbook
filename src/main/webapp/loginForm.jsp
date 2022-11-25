<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");		
		return;
	}
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	int cnt = noticeDao.selectNoticeCount();
	int lastPage = (int)Math.ceil((double)cnt / (double)rowPerPage);
	
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginFrom</title>
</head>
<body>
	<!-- 공지(5개)목록 페이징 -->
	<div>
		<table border="1">
			<tr>
				<th>공지내용</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
			<%
				}
			%>	
		</table>
		<!-- 페이징 -->
		<div>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>			   
	      	<%
				if(currentPage > 1) {
	      	%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">
            			이전
       				</a>
	      	<%      
	       	  	}    				
	      	%>   
	      		<span><%=currentPage%></span>
 			<%  
				if(currentPage < lastPage) {
			%>
	            	<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">
	             	  다음
	            	</a>
			<%   
				}	
			%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</div>
	
	
	<h1>로그인</h1>
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<div>
			ID:
			<input type="text" name="memberId">
		</div>
		<div>
			PW:
			<input type="password" name="memberPw">
		</div>
		<button type="submit">로그인</button>
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
		<%
			if(request.getParameter("msg") != null) {
		%>
				<div><%=request.getParameter("msg") %></div>
		<%
			}
		%>
	</form>	
</body>
</html>