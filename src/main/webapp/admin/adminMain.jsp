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
	<!-- Required meta tags --> 
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Regal Admin</title>
	<!-- base:css -->
	<link rel="stylesheet" href="../regal/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="../regal/vendors/feather/feather.css">
	<link rel="stylesheet" href="../regal/vendors/base/vendor.bundle.base.css">
	<!-- endinject -->
	<!-- plugin css for this page -->
	<link rel="stylesheet" href="../regal/vendors/flag-icon-css/css/flag-icon.min.css"/>
	<link rel="stylesheet" href="../regal/vendors/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="../regal/vendors/jquery-bar-rating/fontawesome-stars-o.css">
	<link rel="stylesheet" href="../regal/vendors/jquery-bar-rating/fontawesome-stars.css">
	<!-- End plugin css for this page -->
	<!-- inject:css -->
	<link rel="stylesheet" href="../regal/css/style.css">
	<!-- endinject -->
	<link rel="shortcut icon" href="../regal/images/favicon.png" />
<title>Insert title here</title>
</head>
<body>
<body>
	<div>
		<jsp:include page="/inc/header2.jsp"></jsp:include>		        		
	</div>
	<div class="container-fluid page-body-wrapper">	
		<jsp:include page="/inc/main.jsp"></jsp:include>
    		<div class="main-panel">
       			<div class="content-wrapper">
         			<div class="row">
           				<div class="col-sm-12 mb-4 mb-xl-0">
             				<h4 class="font-weight-bold text-dark">관리자 페이지</h4>
           					<p class="font-weight-normal mb-2 text-muted"></p>
           				</div>
         			</div>
         			<div class="row mt-3">
           				<div class="col-xl-6 flex-column d-flex grid-margin stretch-card">
             				<div class="row flex-grow">
               					<div class="col-sm-11 grid-margin stretch-card">
                   					<div class="card">
                     					<div class="card-body">
                       						<h4>최근 공지</h4>
											<table class="table">
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
												<a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="btn btn-inverse-info for inverse buttons btn-sm btn-block btn-outline-dark">공지관리</a>
											</table>
                         					<canvas id="customers"></canvas>
                     					</div>
                   					</div>
               					</div>
               					<div class="col-sm-11 stretch-card">
                   					<div class="card">
                     					<div class="card-body">
                         					<h4>최근 가입 회원</h4>
											<table class="table">
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
												<a href="<%=request.getContextPath()%>/admin/memberList.jsp" class="btn btn-inverse-info for inverse buttons btn-sm btn-block btn-outline-dark">멤버관리(목록, 레벨수정, 강제탈퇴)</a>
											</table>	
                         					<canvas id="orders"></canvas>
                     					</div>
                   					</div>
              					</div>
             				</div>
	 					</div>
						<div class="col-xl-6 d-flex grid-margin stretch-card">
               				<div class="card">
                 				<div class="card-body">
                     				<h4 class="card-title">고객센터</h4>		
                   					<div class="row">
                       					<div class="col-lg-7">
										<!-- 최근 문의 -->
										<h4>최근 문의사항</h4>
										<table class="table">
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
											<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="btn btn-inverse-info for inverse buttons btn-sm btn-block btn-outline-dark">(관리자)고객센터</a>
										</table>											 						
									</div>
								</div>
							</div>
      					</div>
						<div class="row">
         				</div>
         			</div>
       			</div>
        		<!-- content-wrapper ends -->
        		<!-- partial:partials/_footer.html -->
        		<footer class="footer">
   					<div class="d-sm-flex justify-content-center justify-content-sm-between">
          				<span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © bootstrapdash.com 2020</span>
            			<span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center"> Free <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap dashboard templates</a> from Bootstrapdash.com</span>
        			</div>
         			<span class="text-muted d-block text-center text-sm-left d-sm-inline-block mt-2">Distributed By: <a href="https://www.themewagon.com/" target="_blank">ThemeWagon</a></span> 
       			</footer>
       			</div>
       		</div>	
	</div>	
</body>
</html>