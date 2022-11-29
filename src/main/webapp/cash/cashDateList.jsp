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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/header.jsp"></jsp:include>
	</div>
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="date" value="<%=date%>">
		<table border="1">
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
		<button type="submit">입력</button>
	</form>
	<!-- cash 목록 출력 -->
	<table border="1">
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
					<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month-1%>&date=<%=date%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>	
</body>
</html>