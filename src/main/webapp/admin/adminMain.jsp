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
	int beginRow = 0;
	int rowPerPage = 5;
	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	HelpDao helpDao = new HelpDao();
	
	// 최근공지 5개, 최근멤버 5명
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage);
	
	
	
	// View
%>
<!DOCTYPE html>
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
	<link rel="shortcut icon" href="../regal/images/favicon.png">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/header2.jsp"></jsp:include>
		<!-- adminMain contents -->
	<!-- 최근 공지 -->
	<div class="d-flex justify-content-between">
		<div>
			<h4>최근 공지</h4>
			<table class="table-secondary">
				<tr>
					<th>공지번호</th>
					<th>공지내용</th>
					<th>공지날짜</th>
				</tr>
				<%
					for(Notice n : noticeList) {
				%>
						<tr>
							<td><%=n.getNoticeNo()%></td>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>	
			<!-- 최근 가입한 회원 -->	
			<div>
				<h4>최근 가입 회원</h4>
				<table class="table-secondary">
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>생성날짜</th>
					</tr>
					<%
						for(Member m : memberList) {
					%>
							<tr>
								<td><%=m.getMemberId()%></td>
								<td><%=m.getMemberName()%></td>
								<td><%=m.getCreatedate()%></td>
							</tr>
					<%
						}
					%>
				</table>
			</div>	
			<!-- 최근 문의 -->
			<div>
				<h4>최근 문의사항</h4>
				<table class="table-secondary">
					<tr>
						<th>문의 내용</th>
						<th>아이디</th>
						<th>문의날짜</th>
					</tr>
					<%
						for(HashMap<String, Object> h : helpList) {
					%>
							<tr>
								<td><%=h.get("helpMemo")%></td>
								<td><%=h.get("memberId")%></td>
								<td><%=h.get("helpCreatedate")%></td>
							</tr>	
					<%
						}
					%>
				</table>
			</div>
		</div>	
	</div>
</body>
</html>