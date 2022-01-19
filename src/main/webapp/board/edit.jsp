
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
		
		request.setCharacterEncoding("UTF-8");
		String b_idx=request.getParameter("b_idx");
		
		String sql="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
	
		String b_title="";
		String b_content="";
		
		


try{
	conn = DBconn.getConnection();
	if(conn!= null){

		sql= "select b_title, b_content from tb_board where b_idx=?";
		pstmt= conn.prepareStatement(sql);
		pstmt.setString(1, b_idx);
		rs= pstmt.executeQuery();
		if(rs.next()){
			b_title=rs.getString("b_title");
			b_content=rs.getString("b_content");
		}
			%>
			
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Community - write</title>
</head>
<body>
<h2>글수정</h2>
<form action='edit_ok.jsp' method="post">
	<input type="hidden" name="b_idx" value="<%=b_idx %>">
	<p>작성자: <input name="b_name" id="b_name" type="text" value="<%=session.getAttribute("userid") %>"></p>
	<p>제목: <input name="b_title" id="b_title" type="text" value="<%=b_title %>"></p>
	<p>내용: <textarea rows="5" cols="40" name="b_content" id="b_content"><%=b_content %></textarea></p>
	<p><input type="submit" value="수정완료">
	<input type="reset" value="다시작성">
	<input type="button" value="리스트" onclick="location.href='list.jsp'">
	</p>
	
</form>
</body>
</html>
<%

	
	}
}catch(Exception e){
	e.printStackTrace();
	}
	}
%>