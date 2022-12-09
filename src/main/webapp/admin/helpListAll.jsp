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
<title>helpListAll</title>
</head>
<body>
	<div class="container-scroller">
		<!-- partial:partials/_navbar.html -->
   		<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
   			<div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
       			<a class="navbar-brand brand-logo" href="<%=request.getContextPath()%>/cash/cashList.jsp"><img src="images/logo.svg" alt="logo"/></a>
       				<a class="navbar-brand brand-logo-mini" href="index.html"><img src="../regal/regal/images/logo-mini.svg" alt="logo"/></a>
   			</div>
     		<div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
       			<button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
         			<span class="icon-menu"></span>
       			</button>
       			<ul class="navbar-nav mr-lg-2">
         			<li class="nav-item nav-search d-none d-lg-block">
           				<div class="input-group">
             				<div class="input-group-prepend">
               					<span class="input-group-text" id="search">
                 					<i class="icon-search"></i>
               					</span>
             				</div>
             				<input type="text" class="form-control" placeholder="Search Projects.." aria-label="search" aria-describedby="search">
           				</div>
         			</li>
   				</ul>
       			<ul class="navbar-nav navbar-nav-right">
           			<li class="nav-item dropdown d-lg-flex d-none">
               			<button type="button" class="btn btn-info font-weight-bold">+ Create New</button>
           			</li>
	         		<li class="nav-item dropdown d-flex">
	           			<a class="nav-link count-indicator dropdown-toggle d-flex justify-content-center align-items-center" id="messageDropdown" href="#" data-toggle="dropdown">
	           				<i class="icon-air-play mx-0"></i>
	           			</a>
	           			<div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="messageDropdown">
	             			<p class="mb-0 font-weight-normal float-left dropdown-header">Messages</p>
	             			<a class="dropdown-item preview-item">
	               				<div class="preview-thumbnail">
	                   			<img src="images/faces/face4.jpg" alt="image" class="profile-pic">
	               				</div>
	               				<div class="preview-item-content flex-grow">
	                 				<h6 class="preview-subject ellipsis font-weight-normal">David Grey
	                 				</h6>
	                 				<p class="font-weight-light small-text text-muted mb-0">
	               		  				The meeting is cancelled
	                 				</p>
	               				</div>
	             			</a>
	             			<a class="dropdown-item preview-item">
	               				<div class="preview-thumbnail">
	                   				<img src="images/faces/face2.jpg" alt="image" class="profile-pic">
	               				</div>
	               				<div class="preview-item-content flex-grow">
	                 				<h6 class="preview-subject ellipsis font-weight-normal">Tim Cook
	                 				</h6>
	                 				<p class="font-weight-light small-text text-muted mb-0">
	                   					New product launch
	                 				</p>
	               				</div>
	           				</a>
	             			<a class="dropdown-item preview-item">
								<div class="preview-thumbnail">
	                   				<img src="images/faces/face3.jpg" alt="image" class="profile-pic">
	               				</div>
	               				<div class="preview-item-content flex-grow">
	                 				<h6 class="preview-subject ellipsis font-weight-normal"> Johnson
	                 				</h6>
	                 				<p class="font-weight-light small-text text-muted mb-0">
	                   					Upcoming board meeting
	                 				</p>
	               				</div>
	             			</a>
	   					</div>
	  		 		</li>
	         		<li class="nav-item dropdown d-flex mr-4 ">
	           			<a class="nav-link count-indicator dropdown-toggle d-flex align-items-center justify-content-center" id="notificationDropdown" href="#" data-toggle="dropdown">
	             			<i class="icon-cog"></i>
	           			</a>
	           			<div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
	             			<p class="mb-0 font-weight-normal float-left dropdown-header">Settings</p>
	           				<a class="dropdown-item preview-item">               
	                 			<i class="icon-head"></i> Profile
	             			</a>
	             			<a class="dropdown-item preview-item">
	                 			<i class="icon-inbox"></i> Logout
	             			</a>
	           			</div>
	         		</li>
	         		<li class="nav-item dropdown mr-4 d-lg-flex d-none">
	           			<a class="nav-link count-indicatord-flex align-item s-center justify-content-center" href="#">
	             			<i class="icon-grid"></i>
	           			</a>
	         		</li>
      			</ul>
      			<button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
         			<span class="icon-menu"></span>
     			</button>
     		</div>
		</nav>
   		<!-- partial -->
   		<div class="container-fluid page-body-wrapper">
     		<!-- partial:partials/_sidebar.html -->
   			<nav class="sidebar sidebar-offcanvas" id="sidebar">
       			<div class="user-profile">
         			<div class="user-image">
           				<img src="images/faces/face28.png">
         			</div>
	         		<div class="user-name">
	             		<%=loginMember.getMemberName()%>님 반갑습니다
	         		</div>
	         		<div class="user-designation">
						<%
							if(loginMember.getMemberLevel() > 0) {
						%>
								<span>등급: 관리자</span>
						<%
							} else {
						%>
								<span>등급: 일반회원</span>
						<%
							}
						%>		
	         		</div>
       			</div>
       			<ul class="nav">
			        <%
						if(loginMember.getMemberLevel() > 0) {
					%>	
							<li class="nav-item">
					 			<a class="nav-link" data-toggle="collapse" href="<%=request.getContextPath()%>/admin/adminMain.jsp" aria-expanded="false" aria-controls="ui-basic">
									<i class="icon-head menu-icon"></i>
									<span class="menu-title">관리자 페이지</span>
          							<i class="menu-arrow"></i>
         						</a>	
								<div class="collapse" id="ui-basic">
									<ul class="nav flex-column sub-menu">
										<li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">Buttons</a></li>
   										<li class="nav-item"> <a class="nav-link" href="pages/ui-features/typography.html">Typography</a></li>
									</ul>
								</div>	
							</li>
						
					<%
						}
					%>
      				<li class="nav-item">
           				<a class="nav-link" data-toggle="collapse" href="<%=request.getContextPath()%>/cash/cashList.jsp" aria-expanded="false" aria-controls="ui-basic">
             				<i class="icon-disc menu-icon"></i>
             				<span class="menu-title">가계부</span>
             				<i class="menu-arrow"></i>
           				</a>
           				<div class="collapse" id="ui-basic">
             				<ul class="nav flex-column sub-menu">
               					<li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">Buttons</a></li>
               					<li class="nav-item"> <a class="nav-link" href="pages/ui-features/typography.html">Typography</a></li>
             				</ul>
           				</div>
         			</li>
         			<li class="nav-item">
           				<a class="nav-link" href="<%=request.getContextPath()%>/updateMemberForm.jsp">
             				<i class="icon-file menu-icon"></i>
             				<span class="menu-title">개인정보 수정</span>
           				</a>
         			</li>
       				<li class="nav-item">
           				<a class="nav-link" href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">
             				<i class="icon-lock menu-icon"></i>
             				<span class="menu-title">비밀번호 수정</span>
           				</a>
         			</li>
         			<li class="nav-item">
           				<a class="nav-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
             				<i class="icon-command menu-icon"></i>
             				<span class="menu-title">고객센터</span>
           				</a>
         			</li>
					<li class="nav-item">
           				<a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp">
             				<i class="icon-unlock menu-icon"></i>
           					<span class="menu-title">로그아웃</span>
           				</a>
         			</li>
       			</ul>
   			</nav>
   			<!-- partial -->
     		<div class="main-panel">
       			<div class="content-wrapper">
         			<div class="row">
           				<div class="col-sm-12 mb-4 mb-xl-0">
             				<h4 class="font-weight-bold text-dark">고객 문의 관리 페이지</h4>
               					<p class="font-weight-normal mb-2 text-muted"></p>
           				</div>
         			</div>
						<div class="col-xl-9 d-flex grid-margin stretch-card">
               				<div class="card">
                 				<div class="card-body">
                     				<h4 class="card-title">문의 목록</h4>
                   					<div class="row">
                       					<div class="col-lg-12">
											<table class="table">
												<tr>
													<th>문의내용</th>
													<th>회원ID</th>
													<th>문의날짜</th>
													<th>답변내용</th>
													<th>답변날짜</th>
													<th>답변추가 / 수정 / 삭제</th>
												</tr>
												<%
													for(HashMap<String, Object> m : list) {
												%>
														<tr>
															<td><%=m.get("helpMemo")%></td>
															<td><%=m.get("memberId")%></td>
															<td><%=m.get("helpCreatedate")%></td>
															<td>
																<%
																	if(m.get("commentMemo") == null) {
																%>
																		<span>답변전</span>
																<%
																	} else {							
																%>
																		<%=m.get("commentMemo")%>
																<%
																	}
																%>
															</td>	
															<td>
																<%
																	if(m.get("commentCreatedate") == null) {
																%>
																		<span>답변전</span>
																<%
																	} else {							
																%>
																		<%=m.get("commentCreatedate")%>
																<%
																	}
																%>
															</td>
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
        <!-- partial -->
			</div>
      <!-- main-panel ends -->
		</div>
	<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->

	<!-- base:js -->
	<script src="vendors/base/vendor.bundle.base.js"></script>
	<!-- endinject -->
	<!-- Plugin js for this page-->
	<!-- End plugin js for this page-->
	<!-- inject:js -->
	<script src="js/off-canvas.js"></script>
	<script src="js/hoverable-collapse.js"></script>
	<script src="js/template.js"></script>
	<!-- endinject -->
	<!-- plugin js for this page -->
	<script src="vendors/chart.js/Chart.min.js"></script>
	<script src="vendors/jquery-bar-rating/jquery.barrating.min.js"></script>
	<!-- End plugin js for this page -->
	<!-- Custom js for this page-->
	<script src="js/dashboard.js"></script>
	<!-- End custom js for this page-->
</body>
</html>