<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.koreait.db.DBconn"%>
<%
	// 로그인 하지 않았을 경우 login.jsp 로 이동
	if(session.getAttribute("userid")== null){
%>
		<script>
		alert('로그인 후 이용하세요');
		location.href='../login.jsp'
		</script>
<%
	}else{
	// 데이터를 받음
request.setCharacterEncoding("UTF-8");
String b_idx=request.getParameter("b_idx");
String b_title=request.getParameter("b_title");
String b_content=request.getParameter("b_content");

String sql="";
Connection conn=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

try{
	conn = DBconn.getConnection();
	if(conn!= null){
		sql= "update tb_board set b_title=?, b_content=? where b_idx=?";
		pstmt= conn.prepareStatement(sql);
		pstmt.setString(1, b_title);
		pstmt.setString(2, b_content);
		pstmt.setString(3, b_idx);
		pstmt.executeUpdate();
	}
	}catch(Exception e){
		 e.printStackTrace();
	}
	
%>
<script>
alert("업데이트 되었습니다.");
location.href="./view.jsp?b_idx=<%=b_idx%>";
</script>
<% } %>