<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 1) 
	request.setCharacterEncoding("utf-8"); // 인코딩
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));

	
	
	Cash insertCash = new Cash();
	insertCash.setCategroyNo(Integer.parseInt(request.getParameter("categoryNo")));
	insertCash.setMemberId(request.getParameter("memberId"));
	insertCash.setCashDate(request.getParameter("cashDate"));
	insertCash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
	insertCash.setCashMemo(request.getParameter("cashMemo"));
		
	
	// 2) Model 호출
	CashDao cashDao = new CashDao();
	
	int row = cashDao.insertCash(insertCash);
	System.out.println(row);
	
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
%>