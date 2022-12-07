<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*" %>
<%
	//1) C
	if(session.getAttribute("loginMember") == null) {
	// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// Controller : session, request
	//session에 지정된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	String memberId = loginMember.getMemberId();
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="../regal/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="../regal/vendors/feather/feather.css">
	<link rel="stylesheet" href="../regal/vendors/base/vendor.bundle.base.css">
	<link rel="stylesheet" href="../regal/css/style.css">
<title>고객센터</title>
</head>
<body>
	<div class="container-scroller">
		<div class="container-fluid page-body-wrapper">
			<div>
				<jsp:include page="/inc/header2.jsp"></jsp:include>
			</div>
			<div class="d-flex justify-content-center">				
				<div class="col-xl-10 d-flex grid-margin stretch-card">
      				<div class="card">
          				<div class="card-body">
							<h4>고객센터</h4>
							<div>
								<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp?memberId=<%=memberId%>" class="btn btn-dark">문의 추가</a>
							</div>
							<table class="table">
								<tr>
									<th>문의내용</th>
									<th>문의날짜</th>
									<th>답변내용</th>
									<th>답변날짜</th>
									<th>수정</th>
									<th>삭제</th>
								</tr>
								<%
									for(HashMap<String, Object> m : list) {
								%>
							            <tr>
							               <td><%=m.get("helpMemo")%></td>
							               <td><%=m.get("helpCreatedate")%></td>
							               <td>
							                  <%
							                     if(m.get("commentMemo") == null) {
							                  %>
							                        답변전
							                  <%      
							                     } else {
							                  %>
							                        <%=m.get("commentMemo")%>
							                  <%   
							                     }
							                  %>   
							               </td>
							               <td>
							                  <%
							                     if(m.get("commentCreatedate") == null) {
							                  %>
							                        답변전   
							                  <%      
							                     } else {
							                  %>
							                        <%=m.get("commentCreatedate")%>
							                  <%   
							                     }
							                  %>   
							               </td>
											<td>
												<%
							                  		if(m.get("commentMemo") == null) {
												%>
							              	 		<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>&helpMemo=<%=m.get("helpMemo")%>">수정</a>   
												<%      
													} else {
												%>
														&nbsp;
												<%   
													}
												%>   
											</td>
											<td>
											   	<%
													if(m.get("commentMemo") == null) {
												%>
													<a href="<%=request.getContextPath()%>/help/deleteHelp.jsp?helpNo=<%=m.get("helpNo")%>">삭제</a>   
												<%      
													} else {
												%>
														&nbsp;
												<%   
													}
												%>
										   </td>
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