<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %> 
<%@ page import = "java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("utf-8"); // 인코딩
	if(session.getAttribute("loginMember") == null) { // 로그인 안했을 경우 로그인 폼으로 돌려보냄
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	

	// 2)
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String cashDate = request.getParameter("cashDate");
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	
	CashDao cashDao = new CashDao();
	int row = cashDao.updateCash(cashNo, categoryNo, cashDate, cashPrice, cashMemo);
	
	if(row == 1) {
		System.out.println("UPDATE COMPLETE");
	} else {
		System.out.println("UPDATE FALSE");
	}
	
	response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");


	
	
%>
