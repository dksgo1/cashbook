<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>
<%@ page import="vo.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
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
	<!-- partial:partials/_navbar.html -->
	<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
		<div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
			<a class="navbar-brand brand-logo" href="index.html"><img src="../regal/images/logo.svg" alt="logo"/></a>
			<a class="navbar-brand brand-logo-mini" href="index.html"><img src="../regal/images/logo-mini.svg" alt="logo"/></a>
		</div>
		<%
			if(loginMember.getMemberLevel() > 0) {
		%>
				<div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
		   			<ul class="navbar-nav mr-lg-2">
		  			<li class="nav-item nav-search d-none d-lg-block">
					</li>
					<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="btn btn-inverse-info for inverse buttons btn-lg btn-block btn-outline-dark">공지관리</a></li>
					<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp" class="btn btn-inverse-info for inverse buttons btn-lg btn-block btn-outline-dark">카테고리관리</a></li>
					<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp" class="btn btn-inverse-info for inverse buttons btn-lg btn-block btn-outline-dark">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
					<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="btn btn-inverse-info for inverse buttons btn-lg btn-block btn-outline-dark">고객센터</a></li>
					</ul>
					<ul class="navbar-nav navbar-nav-right">
					</ul>
				</div>
		<%
			}
		%>
	
		
	</nav>	
	<!-- partial -->
	<nav class="sidebar sidebar-offcanvas" id="sidebar">
		<div class="user-profile">
	 		<div class="user-image">
         			<img src="../regal/images/faces/face28.png">
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
							 <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
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
				<a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">
					<i class="icon-box menu-icon"></i>
					<span class="menu-title">가계부</span>
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" data-toggle="collapse" href="<%=request.getContextPath()%>/updateMemberForm.jsp" aria-expanded="false" aria-controls="ui-basic">
					<i class="icon-head menu-icon"></i>
					<span class="menu-title">개인정보 수정</span>
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">
					<i class="icon-file menu-icon"></i>
					<span class="menu-title">비밀번호 수정</span>
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
					<i class="icon-pie-graph menu-icon"></i>
					<span class="menu-title">고객센터</span>
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp">
					<i class="icon-command menu-icon"></i>
					<span class="menu-title">로그아웃</span>
				</a>
			</li>
		</ul>
	</nav>
</body>
</html>