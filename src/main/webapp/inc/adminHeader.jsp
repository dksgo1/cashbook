<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
	<a href="<%=request.getContextPath()%>/cash/cashList.jsp">가계부</a>
	<a href="<%=request.getContextPath()%>/updateMemberForm.jsp">개인정보수정</a>
	<a href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">비밀번호수정</a>
	<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">고객센터</a></li>
	</ul>
</div>