<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*"%>
<%@ page import = "java.util.*"%>
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
             				<h4 class="font-weight-bold text-dark">공지관리 페이지</h4>
             				<a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지 추가 </a>
           					<p class="font-weight-normal mb-2 text-muted"></p>
           				</div>
         			</div>
						<div class="col-xl-9 d-flex grid-margin stretch-card">
               				<div class="card">
                 				<div class="card-body">
                     				<h4 class="card-title">공지목록</h4>
                   					<div class="row">
                       					<div class="col-lg-7">
											<table class="table">
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
															<td><%=n.getNoticeNo()%></td>
															<td><%=n.getNoticeMemo()%></td>
															<td><%=n.getCreatedate()%></td>
															<td><a href="<%=request.getContextPath()%>/admin/noticeUpdateForm.jsp?noticeNo=<%=n.getNoticeNo()%>">수정</a></td>
															<td><a href="<%=request.getContextPath()%>/admin/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
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