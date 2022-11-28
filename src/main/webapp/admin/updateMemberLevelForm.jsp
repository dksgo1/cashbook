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
			
	String memberId = request.getParameter("memberId");
	System.out.println("memberId");
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	Member m = memberDao.selectMember(memberId);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/updateMemberLevelAction.jsp" method="post">
		<table>
			<tr>
				<td>
					<select name="memberLevel">
						<option value="0">0</option>
						<option value="1">1</option>
					</select>	
				</td>
			</tr>			
		</table>
		<input type="hidden" name="memberId" value="<%=m.getMemberId()%>">
		<button type="submit">레벨 수정</button>
	</form>
</body>
</html>