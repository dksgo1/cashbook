<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); // 인코딩
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
	<link rel="stylesheet" href="regal/css/style.css">
<title>insertMemberForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
		<div class="container-scroller">
			<div class="container-fluid page-body-wrapper full-page-wrapper">
				<div class="content-wrapper d-flex align-items-center auth px-0">
					<div class="row w-100 mx-0">
						<div class="col-lg-4 mx-auto">
							<div class="auth-form-light text-left py-5 px-4 px-sm-5">
								<h4>회원탈퇴 페이지</h4>
								<h6 class="font-weight-light">정말 탈퇴 하시겠습니까?</h6>
								<form class="pt-3">
									<div class="form-group">
										<input type="text" class="form-control form-control-lg" id="exampleInputEmail1" placeholder="Member Id" name="memberId">
									</div>
									<div class="form-group">
										<input type="password" class="form-control form-control-lg" id="exampleInputPassword1" placeholder="Password" name="memberPw">
									</div>
									<div class="mt-3">
										<button type="submit" class="btn btn-block btn-info btn-lg font-weight-medium auth-form-btn">탈퇴하기</button>
									</div>
									<div class="text-center mt-4 font-weight-light">
										탈퇴 안할래요 <a href="<%=request.getContextPath()%>/cash/cashList/.jsp" class="text-primary">뒤로가기</a>
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