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
		String userid=(String)session.getAttribute("userid");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		//DB 연결
		
		String sql="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try{
			conn=DBconn.getConnection();
			if(conn!=null){
				sql="insert into tb_board (b_userid, b_title, b_content) values (?,?,?)";
				pstmt= conn.prepareStatement(sql);
			    pstmt.setString(1, userid);
			    pstmt.setString(2, title);
			    pstmt.setString(3, content);
			    pstmt.executeUpdate();
			}
			
		}catch(Exception e){
			 e.printStackTrace();
		}
		
	%>
	<script>
	alert("업데이트 되었습니다.");
	location.href="./list.jsp";
	</script>
	<%
	
	}
%>