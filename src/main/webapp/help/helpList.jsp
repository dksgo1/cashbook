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
	<link rel="stylesheet" href="../regal/regal/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="../regal/regal/vendors/feather/feather.css">
	<link rel="stylesheet" href="../regal/regal/vendors/base/vendor.bundle.base.css">
	<link rel="stylesheet" href="../regal/regal/vendors/flag-icon-css/css/flag-icon.min.css"/>
	<link rel="stylesheet" href="../regal/regal/vendors/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="../regal/regal/vendors/jquery-bar-rating/fontawesome-stars-o.css">
	<link rel="stylesheet" href="../regal/regal/vendors/jquery-bar-rating/fontawesome-stars.css">
	<link rel="stylesheet" href="../regal/regal/css/style.css">
	<link rel="shortcut icon" href="../regal/regal/images/favicon.png" />
<title>고객센터</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/header2.jsp"></jsp:include>		        		
	</div>
	<div class="container-fluid page-body-wrapper">	
		<jsp:include page="/inc/main.jsp"></jsp:include>
			<div class="main-panel">
       			<div class="content-wrapper">
         			<div class="row">
           				<div class="col-sm-12 mb-4 mb-xl-0">
             				<h4 class="font-weight-bold text-dark">무엇이든 문의를 주세요</h4>
           					<p class="font-weight-normal mb-2 text-muted"></p>
           				</div>
         			</div>
         			<div class="row mt-3">
           				<div class="col-xl-3 flex-column d-flex grid-margin stretch-card">
             				<div class="row flex-grow">
               					<div class="col-sm-12 grid-margin stretch-card">
                   					<div class="card">
                     					<div class="card-body">
                         		
                       						<h3 class="text-dark font-weight-bold">가장 자주 묻는 질문</h3>
                         					<h5 class="text-dark mb-4">계정 삭제는 어떻게 하나요?</h5>
                         					<h5 class="text-dark mb-2">비밀번호를 변경하고 싶어요</h5>
                         					<canvas id="customers"></canvas>
                     					</div>
                   					</div>
               					</div>
               					<div class="col-sm-12 stretch-card">
                   					<div class="card">
                     					<div class="card-body">
                        					
                         					<h3 class="text-dark font-weight-bold">혹시 이런것이 궁금하시나요?</h3>
                         					<h5 class="text-dark mb-2">가계부 작성방법</h5>
                         					<canvas id="orders"></canvas>
                     					</div>
                   					</div>
              					</div>
             				</div>
	 					</div>
						<div class="col-xl-9 d-flex grid-margin stretch-card">
               				<div class="card">
                 				<div class="card-body">
                     				<h4 class="card-title">고객센터</h4>
                     				<div>
										<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp?memberId=<%=memberId%>" class="btn btn-dark">문의 추가</a>
									</div>
                   					<div class="row">
                       					<div class="col-lg-7">
											<table class="table table-header-bg">
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
						<div class="row">
         				</div>
         			</div>
       			</div>
        		<!-- content-wrapper ends -->
        		<!-- partial:partials/_footer.html -->
        		<footer class="footer">
   					<div class="d-sm-flex justify-content-center justify-content-sm-between">
          				<span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © bootstrapdash.com 2020</span>
            			<span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center"> Free <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap dashboard templates</a> from Bootstrapdash.com</span>
        			</div>
         			<span class="text-muted d-block text-center text-sm-left d-sm-inline-block mt-2">Distributed By: <a href="https://www.themewagon.com/" target="_blank">ThemeWagon</a></span> 
       			</footer>
				</div>
			</div>	
	</div>	
</body>
</html>