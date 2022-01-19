
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
		int r_idx=Integer.parseInt(request.getParameter("r_idx"));
		int r_boardidx=Integer.parseInt(request.getParameter("r_boardidx"));
		
		String sql="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
	


try{
	conn = DBconn.getConnection();
	if(conn!= null){

		sql= "delete from tb_reply where r_idx=?";
		pstmt= conn.prepareStatement(sql);
		pstmt.setInt(1, r_idx);
		pstmt.executeUpdate();
		%>
<script>
alert('댓글이 삭제되었습니다.');
location.href="./view.jsp?b_idx=<%=r_boardidx %>";
</script>
<%
	}
}catch(Exception e){
	e.printStackTrace();
	}
	}
%>

