<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
    <%@page import="com.koreait.db.DBconn"%>

<%
String b_idx=request.getParameter("b_idx");
String sql="";
Connection conn=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

int b_like=0;
int b_hit=0;

try{
	conn = DBconn.getConnection();
	if(conn!= null){
		sql= "select b_like from tb_board where b_idx=?";
		pstmt= conn.prepareStatement(sql);
		pstmt.setString(1, b_idx);
		rs= pstmt.executeQuery();
		if(rs.next()){
			b_like=rs.getInt("b_like");
			
		}
		sql= "update tb_board set b_like=? where b_idx=?";
		pstmt= conn.prepareStatement(sql);
		pstmt.setInt(1, (b_like)+1);
		pstmt.setString(2, b_idx);
		pstmt.executeUpdate();
		
		%>
		<script>
			alert('❤❤이글에 좋아요를 눌렀습니다.❤❤')
			location.href="./view.jsp?b_idx=<%=b_idx %>"
		</script>
		
		<%
		
	}
}catch(Exception e){
	e.printStackTrace();
	}

%>
