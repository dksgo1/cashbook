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
<meta charset="UTF-8">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="../regal/regal/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="../regal/regal/vendors/feather/feather.css">
	<link rel="stylesheet" href="../regal/regal/vendors/base/vendor.bundle.base.css">
	<link rel="stylesheet" href="../regal/regal/vendors/flag-icon-css/css/flag-icon.min.css">
	<link rel="stylesheet" href="../regal/regal/vendors/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="../regal/regal/vendors/jquery-bar-rating/fontawesome-stars-o.css">
	<link rel="stylesheet" href="../regal/regal/vendors/jquery-bar-rating/fontawesome-stars.css">
	<link rel="stylesheet" href="../regal/regal/css/style.css">
	<link rel="shortcut icon" href="../regal/regal/images/favicon.png">
</head>
<body>
   		<!-- partial -->
   	
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
					 			<a class="nav-link" data-toggle="collapse" href="<%=request.getContextPath()%>/admin/adminMain.jsp" aria-controls="ui-basic">
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
           				<a class="nav-link" data-toggle="collapse" href="<%=request.getContextPath()%>/cash/cashStatsYear.jsp" aria-expanded="false" aria-controls="ui-basic">
             				<i class="icon-disc menu-icon"></i>
             				<span class="menu-title">통계</span>
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
					<li class="nav-item">
           				<a class="nav-link" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">
             				<i class="icon-unlock menu-icon"></i>
           					<span class="menu-title">회원탈퇴</span>
           				</a>
         			</li>
       			</ul>
   			</nav>
 
</body>
</html>