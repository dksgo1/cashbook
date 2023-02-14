<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- base:css -->
	<link rel="stylesheet" href="../regal/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="../regal/vendors/feather/feather.css">
	<link rel="stylesheet" href="../regal/vendors/base/vendor.bundle.base.css">
	<!-- inject:css -->
	<link rel="stylesheet" href="../regal/css/style.css">
	<link rel="shortcut icon" href="../regal/images/favicon.png">
<title>Insert title here</title>
</head>
<body>
	<div class="col-lg-3 mx-auto">
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="btn btn-outline-info">가계부</a>
		<a href="<%=request.getContextPath()%>/updateMemberForm.jsp" class="btn btn-outline-info">개인정보수정</a>
		<a href="<%=request.getContextPath()%>/updateMemberPwForm.jsp" class="btn btn-outline-info">비밀번호수정</a>
		<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-outline-info">로그아웃</a>
	</div>
	<div class="col-md-4 grid-margin stretch-card col-lg-3 mx-auto">
		<div class="card">
			<div class="card-body">
				<div class="template-demo">
					<ul>
						<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="btn btn-inverse-info for inverse buttons btn-sm btn-block btn-outline-dark">공지관리</a></li>
						<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp" class="btn btn-inverse-info for inverse buttons btn-sm btn-block btn-outline-dark">카테고리관리</a></li>
						<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp" class="btn btn-inverse-info for inverse buttons btn-sm btn-block btn-outline-dark">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
						<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="btn btn-inverse-info for inverse buttons btn-sm btn-block btn-outline-dark">(관리자)고객센터</a></li>
					</ul>
				</div>	
			</div>
		</div>
	</div>
</body>
</html>