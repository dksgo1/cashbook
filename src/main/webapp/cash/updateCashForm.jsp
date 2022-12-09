<%@page import="vo.Cash"%>
<%@page import="vo.Member"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("loginMember") == null) { // 로그인 안했을 경우 로그인 폼으로 돌려보냄
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember"); //session 값 get
	String memberId = loginMember.getMemberId(); // session에서 memberId 값 할당

	
	if(request.getParameter("year") == null ||
		request.getParameter("year").equals("") ||
		request.getParameter("month") == null ||
		request.getParameter("month").equals("") ||
		request.getParameter("date") == null ||
		request.getParameter("date").equals("")) { // 확인하려는 날짜를 알 수 없으므로 cashList 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
	}
	
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	CashDao cashDao = new CashDao();
	Cash cashData = cashDao.selectUpdateCashData(cashNo);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	
	
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
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
			<div class="container-scroller">
				<div class="container-fluid page-body-wrapper full-page-wrapper">
	    			<div class="content-wrapper d-flex align-items-center auth px-0">
	    				<div class="row w-100 h-75 mx-0">
	    					<div class="col-lg-6 mx-auto">
								<div class="auth-form-light text-left py-5 px-4 px-sm-5">
									<h3>수정 하시려면 정보를 다시 입력해주세요</h3>
									<table class="table">
										<tr>
											<td>수입지출</td>
											<td>
												<select name="categoryNo">
													<%
														//category 목록 출력
														for(Category c : categoryList) {
													%>
															<option value="<%=c.getCategoryNo()%>">
																<%=c.getCategoryKind()%>/<%=c.getCategoryName()%>
															</option>
													<%
														}
													%>
												</select>
											</td>
										</tr>
										
										<tr>
											<td>cash_date</td>
											<%
												if(date < 10) {
											%>
													<td><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-0<%=date%>" readonly="readonly"></td>
											<%
												} else {
											%>
													<td><input type="text" name="cashDate" value="<%=year%>-<%=month+1%>-<%=date%>" readonly="readonly"></td>
											<%
												}
											%>
										</tr>
										
										<tr>
											<td>금액</td>
											<td><input type="text" name="cashPrice" value="<%=cashData.getCashPrice()%>"></td>
										</tr>
										
										<tr>
											<td>상세 내용</td>
											<td><textarea name="cashMemo"><%=cashData.getCashMemo() %></textarea></td>
										</tr>
									</table>
									<input type="hidden" name="cashNo" value="<%=cashData.getCashNo()%>">
									<button class="btn btn-secondary btn-rounded btn-fw" type="submit">수정</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>							
		</form>
		<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>">뒤로가기</a>
	</body>
</html>