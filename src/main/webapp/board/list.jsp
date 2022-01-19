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
		int totalCount=0;
		String sql="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try{
			String url = "jdbc:mysql://localhost:3306/aiclass";
			   String uid = "root";
			   String upw = "1234";
			   Class.forName("com.mysql.cj.jdbc.Driver");
			   conn = DriverManager.getConnection(url, uid, upw);
			   if(conn != null){
	            sql = "select count(b_idx) as total from tb_board";
	            pstmt = conn.prepareStatement(sql);
	            rs = pstmt.executeQuery();
	            if(rs.next()){
	               totalCount = rs.getInt("total");
	            }

				
	            sql= "select b_idx, b_userid, b_title, b_regdate, b_hit, b_like, b_content from tb_board order by b_idx desc";
	            pstmt = conn.prepareStatement(sql);
	            rs = pstmt.executeQuery();
	            
	            
	         

				%>
				
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community - List</title>
</head>
<body>
<h2>커뮤니티 - 리스트</h2>
<p>게시글: <%= totalCount %>개</p>
<table border="1" width="800">
<tr>
	<th width="50">번호</th>
	<th width="300">제목</th>
	<th width="100">글쓴이</th>
	<th width="75">조회수</th>
	<th width="200">날짜</th>
	<th width="75">좋아요</th>
</tr>

<% 
while(rs.next()){
    String b_idx = rs.getString("b_idx");
    String b_userid = rs.getString("b_userid");
    String b_title = rs.getString("b_title");
    String b_content = rs.getString("b_content");
    String b_regdate = rs.getString("b_regdate").substring(0,10);
    int b_hit = rs.getInt("b_hit");
    String b_like = rs.getString("b_like");


%>
      <tr>
         <td><%=b_idx %></td>
         <td><a href="./view.jsp?b_idx=<%=b_idx %>"><%=b_title %>
       
         <%
         ResultSet rs1=null;
         int totalre=0;
         sql="select count(r_idx) as total from tb_reply where r_boardidx=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, b_idx);
         rs1 = pstmt.executeQuery();
         if(rs1.next()){
            totalre=rs1.getInt("total");
            %>
            [<%=totalre %>]
            <%
         }
         %>
         
         
         </a></td>
         <td><%=b_userid %></td>
         <td><%=b_hit %></td>
         <td><%=b_regdate %></td>
         <td><%=b_like %></td>
      </tr>


<%

}

%>

</table>

<p><input type="button" value="글쓰기" onclick="location.href='write.jsp'">
<input type="button" value="메인으로" onclick="location.href='../login.jsp'"></p>
</body>
</html>

<%
			   }
	      }catch(Exception e){
	         e.printStackTrace();
	      }
		}
		%>

