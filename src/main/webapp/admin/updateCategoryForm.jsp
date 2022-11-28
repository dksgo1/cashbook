<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@page import="vo.*"%>
<%@page import="java.util.*"%>
<%@page import="dao.*"%>
<%
	//Controller
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 로그인상태 아니거나 관리자 레벨이 아니면 돌려보내기
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	

	// 분리된M(모델)을 호출
	CategoryDao categoryDao = new CategoryDao();
	Category updateCategory = categoryDao.selectCategoryOne(categoryNo);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCategoryForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>categoryKind</td>
				<td>
					<input type="radio" name="categoryKind" value="수입">수입
					<input type="radio" name="categoryKind" value="지출">지출
				</td>
			</tr>	
			<tr>
				<td>이름</td>
				<td><input type="text" name="categoryName" value="<%=updateCategory.getCategoryName()%>"></td>
			</tr>
		</table>
		<input type="hidden" name="categoryNo" value="<%=updateCategory.getCategoryNo()%>">
		<button type="submit">수정</button>
	</form>
</body>
</html>