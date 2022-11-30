<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	
	// lastPage
	int count = helpDao.selectHelpCount();
	int lastPage = (int)Math.ceil((double)count / (double)rowPerPage);
	

%><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- base:css -->
	<link rel="stylesheet" href="../regal/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="../regal/vendors/feather/feather.css">
	<link rel="stylesheet" href="../regal/vendors/base/vendor.bundle.base.css">
	<!-- inject:css -->
	<link rel="stylesheet" href="../regal/css/style.css">
<title>helpListAll</title>
</head>
<body>
	<!-- head include -->
	<div>
		<jsp:include page="/inc/adminHeader.jsp"></jsp:include>
	</div>
	<div class="col-lg-5 mx-auto">
		<h1>문의 목록</h1>
		<!-- 고객센터 문의 목록 -->
		<table border="1">
			<tr>
				<th>문의내용</th>
				<th>회원ID</th>
				<th>문의날짜</th>
				<th>답변내용</th>
				<th>답변날짜</th>
				<th>답변추가 / 수정 / 삭제</th>
			</tr>
			<%
				for(HashMap m : list) {
			%>
					<tr>
						<td><%=m.get("helpMemo")%></td>
						<td><%=m.get("memberId")%></td>
						<td><%=m.get("helpCreatedate")%></td>
						<td><%=m.get("commentMemo")%></td>
						<td><%=m.get("commentCreatedate")%></td>
						<td>
							<%
								if(m.get("commentMemo") == null) {
							%>
									<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">
										답변입력
									</a>
							<%
								} else {
							%>
									<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>&commentMemo=<%=m.get("commentMemo")%>">
										답변수정
									</a>
									<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>">
										답변삭제
									</a>
							<%
								}
							%>
						</td>
					</tr>
			<%
				}
			%>
		</table>
		<!-- 페이징 -->
		<div>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/helpList.jsp?currentPage=-1">이전</a>
			<%
				}
			%>
				<span><%=currentPage%></span> <!-- 현재 보고있는 페이지 -->
			<%
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=+1">다음</a>
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
		<!-- footer include -->
	</div>	
</body>
</html>