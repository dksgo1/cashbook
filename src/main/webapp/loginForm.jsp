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
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- base:css -->
	<link rel="stylesheet" href="regal/regal/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="regal/regal/vendors/feather/feather.css">
	<link rel="stylesheet" href="regal/regal/vendors/base/vendor.bundle.base.css">
	<!-- endinject -->
	<!-- plugin css for this page -->
	<link rel="stylesheet" href="regal/regal/vendors/flag-icon-css/css/flag-icon.min.css"/>
	<link rel="stylesheet" href="regal/regal/vendors/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="regal/regal/vendors/jquery-bar-rating/fontawesome-stars-o.css">
	<link rel="stylesheet" href="regal/regal/vendors/jquery-bar-rating/fontawesome-stars.css">
	<!-- End plugin css for this page -->
	<!-- inject:css -->
	<link rel="stylesheet" href="regal/regal/css/style.css">
	<!-- endinject -->
	<link rel="shortcut icon" href="regal/regal/images/favicon.png">
<title>loginFrom</title>

</head>

<body>
	<div class="row w-25 mx-auto"> 
		<table class="table">
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
	</div>	
		<!-- 페이징 -->
		<div class="text-center">
			<a class="btn btn-outline-dark btn-rounded btn-fw btn-sm" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>			   
	      	<%
				if(currentPage > 1) {
	      	%>
					<a class="btn btn-outline-dark btn-rounded btn-fw btn-sm" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">
            			이전
       				</a>
	      	<%      
	       	  	}    				
	      	%>   
	      		<span><%=currentPage%></span>
 			<%  
				if(currentPage < lastPage) {
			%>
	            	<a class="btn btn-outline-dark btn-rounded btn-fw btn-sm" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">
	             	  다음
	            	</a>
			<%   
				}	
			%>
			<a class="btn btn-outline-dark btn-rounded btn-fw btn-sm" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>	
	<!-- 로그인 폼 -->
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<div class="container-scroller">
			<div class="container-fluid page-body-wrapper full-page-wrapper">
	    		<div class="content-wrapper d-flex align-items-center auth px-0">
	    			<div class="row w-100 h-100 mx-0">
	    				<div class="col-lg-4 mx-auto">
							<div class="auth-form-light text-left py-5 px-4 px-sm-5">
								<h4>안녕하세요</h4>
								<h6 class="font-weight-light">계속 진행하시려면 로그인을 해주세요</h6>
	              				<form class="pt-3">
									<div class="form-group">
										<input type="text" class="form-control form-control-lg" id="exampleInputEmail1" placeholder="Member Id" name="memberId">
									</div>
									<div class="form-group">
										<input type="password" class="form-control form-control-lg" id="exampleInputPassword1" placeholder="Password" name="memberPw">
									</div>
									<div class="mt-3">
										<button type="submit" class="btn btn-block btn-info btn-lg font-weight-medium auth-form-btn">로그인</button>
									</div>
									<div class="text-center mt-4 font-weight-light">
										아이디가 없으신가요? <a href="<%=request.getContextPath()%>/insertMemberForm.jsp" class="text-primary">회원가입</a>
	                				</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>  
		</div>
	</form>
</body>
</html>