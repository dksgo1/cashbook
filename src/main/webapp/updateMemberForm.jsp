<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%

	if(session.getAttribute("loginMember") == null) {
	// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// Controller : session, request
	//session에 지정된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	String memberId = loginMember.getMemberId();
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- base:css -->
	<link rel="stylesheet" href="regal/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="regal/vendors/feather/feather.css">
	<link rel="stylesheet" href="regal/vendors/base/vendor.bundle.base.css">
	<!-- endinject -->
	<!-- plugin css for this page -->
	<link rel="stylesheet" href="regal/vendors/flag-icon-css/css/flag-icon.min.css"/>
	<link rel="stylesheet" href="regal/vendors/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="regal/vendors/jquery-bar-rating/fontawesome-stars-o.css">
	<link rel="stylesheet" href="regal/vendors/jquery-bar-rating/fontawesome-stars.css">
	<!-- End plugin css for this page -->
	<!-- inject:css -->
	<link rel="stylesheet" href="regal/css/style.css">
	<!-- endinject -->
	<link rel="shortcut icon" href="regal/images/favicon.png">
<title>updateMemberForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post" id="updateForm">
		<div class="container-scroller">
   			<div class="container-fluid page-body-wrapper full-page-wrapper">
   				<div class="content-wrapper d-flex align-items-stretch auth auth-img-bg">
					<div class="row flex-grow">
						<div class="col-lg-6 d-flex align-items-center justify-content-center">
							<div class="auth-form-transparent text-left p-3">
								<div class="brand-logo">
									<img src="regal/images/logo-dark.svg" alt="logo">
								</div>
									<h4>개인정보 수정</h4>
	      							<div class="form-group">
	                 					<label for="exampleInputEmail">아이디</label>
	                 				<div class="input-group">
	                					<div class="input-group-prepend bg-transparent">
	                     					<span class="input-group-text bg-transparent border-right-0">
	                       						<i class="mdi mdi-account-outline text-primary"></i>
	                     					</span>
	              						</div>
	                   					<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly" class="form-control form-control-lg border-left-0"  placeholder="아이디">
	               					</div>
	           					</div>
								<div class="form-group">
									<label for="exampleInputPassword">비밀번호</label>
									<div class="input-group">
										<div class="input-group-prepend bg-transparent">
											<span class="input-group-text bg-transparent border-right-0">
												<i class="mdi mdi-lock-outline text-primary"></i>
											</span>
										</div>
										<input type="password" name="memberPw" class="form-control form-control-lg border-left-0" id="pw" placeholder="비밀번호">                        
									</div>
	           					</div>
	           					<div class="form-group">
									<label for="exampleInputPassword">변경할 이름</label>
									<div class="input-group">
										<div class="input-group-prepend bg-transparent">
											<span class="input-group-text bg-transparent border-right-0">
												<i class="mdi mdi-lock-outline text-primary"></i>
											</span>
										</div>
										<input type="text" name="memberName" class="form-control form-control-lg border-left-0" id="exampleInputPassword" placeholder="변경할 이름">                        
									</div>
	           					</div>
	               				<div class="my-3">
	                 				<button type="button" id="updateBtn" class="btn btn-block btn-info btn-lg font-weight-medium auth-form-btn">개인정보 수정</button>
	               				</div>
	               				 <div>
									<%
										if(request.getParameter("msg2") != null) {
									%>
										<div class="alert alert-danger">
											<%=request.getParameter("msg2") %>
										</div>
									<%
										}
									%>
	               				</div>
	       					</div>
	       				</div>
						<div class="col-lg-6 login-half-bg d-flex flex-row">
							<p class="text-white font-weight-medium text-center flex-grow align-self-end">Copyright &copy; 2020  All rights reserved.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<br>
	<script>
	let updateBtn = document.querySelector('#updateBtn');
	
	updateBtn.addEventListener('click', function() {
		// 디버깅
		console.log('updateBtn click!');
		
	 	// PW 폼 유효성 검사
        let pw = document.querySelector('#pw');
        if(pw.value == '') {
           alert('pw를 확인하세요');
           pw.focus();
           return;
        }
		
		
		let updateForm = document.querySelector('#updateForm');
		updateForm.submit(); // action="./signinAction.jsp"
	});
	
	</script>
</body>
</html>