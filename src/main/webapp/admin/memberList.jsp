<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import ="dao.*" %>
<%@ page import ="java.util.*" %>
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
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	int memberCount = memberDao.selectMemberCount(); // lastPage
	int lastPage = (int)Math.ceil((double)memberCount / (double)rowPerPage);

	
	// View
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- base:css -->
	<link rel="stylesheet" href="../regal/regal/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="../regal/regal/vendors/feather/feather.css">
	<link rel="stylesheet" href="../regal/regal/vendors/base/vendor.bundle.base.css">
	<!-- endinject -->
	<!-- plugin css for this page -->
	<link rel="stylesheet" href="../regal/regal/vendors/flag-icon-css/css/flag-icon.min.css"/>
	<link rel="stylesheet" href="../regal/regal/vendors/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="../regal/regal/vendors/jquery-bar-rating/fontawesome-stars-o.css">
	<link rel="stylesheet" href="../regal/regal/vendors/jquery-bar-rating/fontawesome-stars.css">
	<!-- End plugin css for this page -->
	<!-- inject:css -->
	<link rel="stylesheet" href="../regal/regal/css/style.css">
	<!-- endinject -->
	<link rel="shortcut icon" href="../regal/regal/images/favicon.png">
<title>Insert title here</title>
</head>
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
             				<h4 class="font-weight-bold text-dark">회원 관리 페이지</h4>
           					<p class="font-weight-normal mb-2 text-muted"></p>
           				</div>
         			</div>
						<div class="col-xl-9 d-flex grid-margin stretch-card">
               				<div class="card">
                 				<div class="card-body">
                     				<h4 class="card-title">회원목록</h4>
                   					<div class="row">
                       					<div class="col-lg-9">
											<table class="table">
												<tr>
													<th>멤버번호</th>
													<th>아이디</th>
													<th>레벨</th>
													<th>이름</th>
													<th>마지막수정날짜</th>
													<th>생성일자</th>
													<th>레벨수정</th>
													<th>강제탈퇴</th>
												</tr>
												<%
													for(Member m : list) {
												%>
														<tr>
															<td><%=m.getMemberNo()%></td>
															<td><%=m.getMemberId()%></td>
															<td><%=m.getMemberLevel()%></td>
															<td><%=m.getMemberName()%></td>
															<td><%=m.getUpdatedate()%></td>
															<td><%=m.getCreatedate()%></td>
															<td><a href="<%=request.getContextPath()%>/admin/updateMemberLevelForm.jsp?memberId=<%=m.getMemberId()%>">레벨수정</a></td>
															<td><a href="<%=request.getContextPath()%>/admin/deleteMember.jsp?memberId=<%=m.getMemberId()%>">강제탈퇴</a></td>
														</tr>
												<%
													}
												%>
											</table>
											<!-- 페이징 -->
											<div>
												<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
												<%
													if(currentPage > 1) {
												%>
														<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
												<%
													}
												%>
													<span><%=currentPage%></span> <!-- 지금 보고있는 페이지가 몇페이지 인지 -->
												<%
													if(currentPage < lastPage) {
												%>
														<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
												<%
													}
												%>
												<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막</a>
											</div>   						
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
</body>
</html>