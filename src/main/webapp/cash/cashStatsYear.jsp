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
	String memberId = loginMember.getMemberId();
	System.out.println(memberId);
	
	// Model호출
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashStatsByYear(memberId);
%>

<!DOCTYPE html>
<html>
<head>
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
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/header2.jsp"></jsp:include>		        		
	</div>
	<div class="container-fluid page-body-wrapper">	
		<jsp:include page="/inc/main.jsp"></jsp:include>	
		<div class="col-xl-10 d-flex grid-margin stretch-card">	
			<div class="card">
				<div class="card-body">
					<div class="card-title">
						<h2 class="text-center">년도별 수입지출 통계</h2>
					</div>
					<div class="row">
	   					<div class="col-lg-10">
							<table class="table table-header-bg">
								<tr>
									<th>년도</th>
									<th>수입횟수</th>
									<th>총 수입</th>
									<th>평균 수입</th>
									<th>지출횟수</th>
									<th>총 지출</th>
									<th>평균 지출</th>
								</tr>
								<%
									for(HashMap<String, Object> m : list) {
								%>
										<tr>
											<td><%=m.get("year")%></td>
											<td><%=m.get("importCount")%></td>
											<td><%=m.get("importSum")%></td>
											<td><%=m.get("importAvg")%></td>
											<td><%=m.get("exportCount")%></td>
											<td><%=m.get("exportSum")%></td>
											<td><%=m.get("exportAvg")%></td>
										</tr>
								<%
									}							
								%>
							</table>
						</div>
					</div>
				</div>	
			</div>
		</div>	
	</div>
</body>
</html>