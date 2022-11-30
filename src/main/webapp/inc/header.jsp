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
<title>Insert title here</title>
</head>
<body>
	<div>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="btn btn-outline-info">가계부</a>
		<a href="<%=request.getContextPath()%>/updateMemberForm.jsp" class="btn btn-outline-info">개인정보수정</a>
		<a href="<%=request.getContextPath()%>/updateMemberPwForm.jsp" class="btn btn-outline-info">비밀번호수정</a>
		<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-outline-info">로그아웃</a>
	</div>
</body>
</html>