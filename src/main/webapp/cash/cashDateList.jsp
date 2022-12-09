<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// C
	if(session.getAttribute("loginMember") == null) { // 로그인 상태 아닐시 로그인 폼으로 보냄
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// M
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
	// View

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
<title>Insert title here</title>
</head>
<body>
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<div class="col-xl-10 d-flex grid-margin stretch-card">
			<div class="card">
				<div class="card-body">
       				<h4 class="card-link">수입이나 지출을 입력하세요.</h4>
					<div class="row">
						<div class="col-lg-10">		
							<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
							<input type="hidden" name="year" value="<%=year%>">
							<input type="hidden" name="month" value="<%=month%>">
							<input type="hidden" name="date" value="<%=date%>">
							<table class="table table-striped">
								<tr>
									<td>categoryNo</td>
									<td>
										<select name = "categoryNo">
										<%
											for(Category c : categoryList) {
										%>
												<option value="<%=c.getCategoryNo()%>">
													<%=c.getCategoryKind()%> <%=c.getCategoryName()%>
												</option> 
										<%
											}
										%>
										</select>
									</td>
								</tr>
								<tr>
									<td>cashDate</td>
									<td>
									<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
									</td>
								</tr>
								<tr>
									<td>cashPrice</td>
									<td>
									<input type="number" name="cashPrice" value="">
									</td>
								</tr>
								<tr>
									<td>cashMemo</td>
									<td>
										<textarea rows="3" cols="50" name="cashMemo"></textarea>
									</td>
								</tr>
							</table>
							<button class="btn btn-secondary btn-rounded btn-fw" type="submit">입력</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- cash 목록 출력 -->
	<table class ="table table-striped table-header-bg">
		<tr>
			<th>categoryKind</th>
			<th>categoryName</th>
			<th>cashPirce</th>
			<th>cashMemo</th>
			<th>수정</th><!-- request.getContextPath()/cash/updateCash.jsp?cashNo= -->
			<th>삭제</th><!-- request.getContextPath()/cash/deleteCashForm.jsp?cashNo=  -->
		</tr>
		<%
			for(HashMap<String, Object> m : list) { 
		%>
				<tr>
					<td><%=(String)m.get("categoryKind")%></td>
					<td><%=(String)m.get("categoryName")%></td>
					<td><%=(Long)m.get("cashPrice")%>원</td>
					<td><%=(String)m.get("cashMemo")%></td> 
					<%
						int cashNo = (Integer)m.get("cashNo");
					%>
					<td><a class="btn btn-secondary btn-rounded btn-fw" href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month-1%>&date=<%=date%>">수정</a></td>
					<td><a class="btn btn-secondary btn-rounded btn-fw" href="<%=request.getContextPath()%>/cash/deleteCash.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>	
</body>
</html>