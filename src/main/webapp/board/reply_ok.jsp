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
String r_boardidx=request.getParameter("b_idx");
String r_userid=(String)session.getAttribute("userid");
String r_content=request.getParameter("r_content");

String sql="";
Connection conn=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

try{
	conn = DBconn.getConnection();
	if(conn!= null){
		sql= "insert into tb_reply (r_userid, r_content, r_boardidx) values (?,?,?)";
		pstmt= conn.prepareStatement(sql);
		pstmt.setString(1, r_userid);
		pstmt.setString(2, r_content);
		pstmt.setString(3, r_boardidx);
		pstmt.executeUpdate();
	}
	}catch(Exception e){
		 e.printStackTrace();
	}
	
%>
<script>
alert("댓글이 달렸습니다.");
location.href="./view.jsp?b_idx=<%=r_boardidx%>";
</script>
<% } %>