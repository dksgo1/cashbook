<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>
<%@ page import="vo.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
	// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	
	// Controller : session, request
	//session에 지정된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	
	// request 년 + 월 넘어와야 함
	int year = 0;
	int month = 0;
	
	if(request.getParameter("year") == null || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);	
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer. parseInt(request.getParameter("month"));
		// month -> -1, month -> 12 일경우
		if(month == -1) {
			month = 11;
			year -= 1;
		}
		if(month == 12) {
			month = 0;
			year += 1;
		}
	}
	// 출력하고자 하는 년,월과 월의1일의 요일(일요일 1, 월요일 2, 화요일 3, ..........토요일 7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); 
	
	// begin blank 개수는 firstDay - 1
	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay -1;
	int endBlank = 0; // beginBlank + lastDate + endBlank --> 7로 나누어 떨어진다
	if((beginBlank +lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank +lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank;
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	
	
	// view : 달력출력 + 일별 cash 목록 출력
%>
<!DOCTYPE html>
<html>

<head>
	<!-- Required meta tags --> 
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
	<link rel="shortcut icon" href="../regal/regal/images/favicon.png" />
</head>
<body>
	<div class="container-scroller">
		<!-- partial:partials/_navbar.html -->
   		<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
   			<div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
       			<a class="navbar-brand brand-logo" href="<%=request.getContextPath()%>/cash/cashList.jsp"><img src="images/logo.svg" alt="logo"/></a>
       				<a class="navbar-brand brand-logo-mini" href="index.html"><img src="images/logo-mini.svg" alt="logo"/></a>
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
	                   				<img src="../regal/regal/images/faces/face4.jpg" alt="image" class="profile-pic">
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
           				<img src="../regal/regal/images/faces/face28.png">
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
							<li class="nav-item dropdown">
					 			<a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
									<i class="icon-head menu-icon"></i>
									<span class="menu-title">관리자 페이지</span>
          							<i class="menu-arrow"></i>
         						</a>	
								<div class="collapse" id="#ui-basic">
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
             				<i class="icon-pie-graph menu-icon"></i>
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
             				<i class="icon-help menu-icon"></i>
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
             				<h4 class="font-weight-bold text-dark">Hi, welcome back!</h4>
           					<p class="font-weight-normal mb-2 text-muted"></p>
           				</div>
         			</div>
         			<div class="row mt-3">
           				<div class="col-xl-3 flex-column d-flex grid-margin stretch-card">
             				<div class="row flex-grow">
               					<div class="col-sm-12 grid-margin stretch-card">
                   					<div class="card">
                     					<div class="card-body">
                         					<h2><%=year%>년<%=month+1%>월</h2>
                       						<p class="card-title">이번달 총 수입</p>
                         					<h4 class="text-dark font-weight-bold mb-2">43,981</h4>
                       						<img src="../regal/regal/images/faces/smiley.jpg">
                         					<canvas id="customers"></canvas>
                     					</div>
                   					</div>
               					</div>
               					<div class="col-sm-12 stretch-card">
                   					<div class="card">
                     					<div class="card-body">
                        					<h2><%=year%>년<%=month+1%>월</h2>
                         					<p class="card-title">이번달 총 지출</p>
                         					<h4 class="text-dark font-weight-bold mb-2">55,543</h4>
                         					<img src="../regal/regal/images/faces/sad.png">
                         					<canvas id="orders"></canvas>
                     					</div>
                   					</div>
              					</div>
             				</div>
	 					</div>
						<div class="col-xl-9 d-flex grid-margin stretch-card">
               				<div class="card">
                 				<div class="card-body">
                     				<h4 class="card-title">수입지출 목록</h4>
                     				<h3><%=year%>년<%=month+1%>월</h3>
                   					<div class="row">
                       					<div class="col-lg-5">
                         					<p>월 수입과 지출을 확인해보세요</p>
											<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>" class="btn btn-outline-secondary btn-sm">&#8701;이전달</a>
											<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>" class="btn btn-outline-secondary btn-sm">다음달&#8702;</a>
                       					</div>
				                  		<table class="table table-header-bg table-bordered">
												<tr>
													<th>일</th>
													<th>월</th>
													<th>화</th>
													<th>수</th>
													<th>목</th>
													<th>금</th>
													<th>토</th>
												</tr>
												<tr>
													<%
														for(int i=1; i<=totalTd; i++) {
													%>
															<td>
													<%
																int date = i-beginBlank;
																if(date > 0 && date <= lastDate) {			
													%>
																	<div>
																		<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
																			<%=date%>
																		</a>
																	</div>
																	<div>
																		<%
																			for(HashMap<String, Object> m : list ) {
																				String cashDate = (String)(m.get("cashDate"));
																				if(Integer.parseInt(cashDate.substring(8)) == date) {
																		%>	
																						
																					[<%=(String)(m.get("categoryKind"))%>]
																					<%=(String)(m.get("categoryName"))%>
																					&nbsp;
																					<%=(Long)(m.get("cashPrice"))%>원
																					<br>		
																		<%
																		
																				}
																			}
																		%>
																	</div>
													<%
																}
													%>		
															</td>
													<%
															if(i%7 == 0 && i != totalTd) {
													%>
																</tr><tr> <!-- td7개 만들고 테이블 줄바꿈 -->
													<%
															}
														}
													%>		
												</tr>		
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

