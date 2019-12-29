<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1, width=device-width"/> 
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	a, a:hover {
		color : #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand">관리자 로그인 상태</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="memberList.jsp">회원 관리</a></li>
			</ul>
		
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
		
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">ID</th>
						<th style="background-color: #eeeeee; text-align: center;">이름</th>
						<th style="background-color: #eeeeee; text-align: center;">성별</th>
						<th style="background-color: #eeeeee; text-align: center;">이메일</th>
						<th style="background-color: #eeeeee; text-align: center;">탈퇴</th>
					</tr>
				</thead>
				<tbody>
					<%
						UserDAO userDAO = new UserDAO();
						ArrayList<User> list = userDAO.getList();
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getUserName()%></td>
						<td><%=list.get(i).getUserGender()%></td>
						<td><%=list.get(i).getUserEmail()%></td>
						<td><a class="btn btn-primary" onClick="return confirm('정말로 <%=list.get(i).getUserID()%> 사용자를 탈퇴시키겠습니까?')" href="userDeleteAction.jsp?userID=<%=list.get(i).getUserID()%>">X</a></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<!-- 
	<script src="https://jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	-->
</body>
</html>