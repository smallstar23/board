
<%@page import="java.sql.*"%>
<%@page import="com.koreait.db.DBconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
	if(session.getAttribute("userid")== null){
%>
		<script>
		alert('로그인 후 이용하세요');
		location.href='../login.jsp'
		</script>
<%
	}else{
		

		
%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Community - write</title>
</head>
<body>
<h2>커뮤니티 글쓰기</h2>
<form action='write_ok.jsp' method="post">
	<p>작성자: <input name="name" id="name" type="text" value=<%=(String)session.getAttribute("userid") %>></p>
	<p>제목: <input name="title" id="title" type="text"></p>
	<p>내용: <textarea rows="5" cols="40" name="content" id="content"></textarea></p>
	<p><input type="submit" value="완료">
	<input type="reset" value="다시작성">
	<input type="button" value="리스트" onclick="location.href=list.jsp">
	</p>
	
</form>
</body>
</html>
<%
	}
%>
