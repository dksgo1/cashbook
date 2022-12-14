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
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	// 최근공지 5개, 최근멤버 5명
	
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
             				<h4 class="font-weight-bold text-dark">카테고리 관리 페이지</h4>
             				<a href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가</a>
           					<p class="font-weight-normal mb-2 text-muted"></p>
           				</div>
         			</div>
						<div class="col-xl-9 d-flex grid-margin stretch-card">
               				<div class="card">
                 				<div class="card-body">
                     				<h4 class="card-title">카테고리 목록</h4>
                   					<div class="row">
                       					<div class="col-lg-8">
											<table class="table">
												<tr>
													<th>번호</th>
													<th>수입/지출</th>
													<th>이름</th>
													<th>마지막 수정 날짜</th>
													<th>생성날짜</th>
													<th>수정</th>
													<th>삭제</th>
												</tr>
												<!-- 모델데이터 categoryList 출력 -->
												<%
													for(Category c : categoryList) {
												%>
														<tr>
															<td><%=c.getCategoryNo()%></td>
															<td><%=c.getCategoryKind()%></td>
															<td><%=c.getCategoryName()%></td>
															<td><%=c.getUpdatedate()%></td>
															<td><%=c.getCreatedate()%></td>
															<td><a href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
															<td><a href="<%=request.getContextPath()%>/admin/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
														</tr>
												<%
													}
												%>
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
</body>
</html>