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

String b_userid="";
String b_title="";
String b_content="";
String b_regdate="";
String r_content="";
int r_boardidx=0;
String r_userid="";
String r_regdate="";
int r_tot=0;
int b_like=0;
int b_hit=0;

try{
	conn = DBconn.getConnection();
	if(conn!= null){
		sql= "update tb_board set b_hit=b_hit+1 where b_idx=?;";
		pstmt= conn.prepareStatement(sql);
		pstmt.setString(1, b_idx);
		pstmt.executeUpdate();
		
		sql= "select b_idx, b_userid, b_title, b_content, b_regdate, b_like, b_hit from tb_board where b_idx=?";
		pstmt= conn.prepareStatement(sql);
		pstmt.setString(1, b_idx);
		rs= pstmt.executeQuery();
		if(rs.next()){
			b_userid=rs.getString("b_userid");
			b_title=rs.getString("b_title");
			b_content=rs.getString("b_content");
			b_regdate=rs.getString("b_regdate");
			b_like=rs.getInt("b_like");
			b_hit=rs.getInt("b_hit");
		}
		
		%>
		

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 리스트</title>

<script>
	function like(){
		const xhr= new XMLHttpRequest();
		xhr.onreadystatechange= function(){
			if(xhr.readystate == XMLHttpRequest.DONE && xhr.status ==200){
				
				document.getElementById('like').innerHTML = xhr.responseText;
			}

		}
		xhr.open('GET', './like_ok.jsp?b_idx=<%=b_idx%>', true);
		xhr.send();
	}

</script>
</head>
<body>

<h2>커뮤니티 리스트</h2>
<table border="1" width="800">
<tr>
	<td>제목</td><td><%=b_title %></td>
</tr>
<tr>
	<td>날짜</td><td><%=b_regdate %></td>
</tr>
<tr>
	<td>작성자</td><td><%=b_userid %></td>
</tr>
<tr>
	<td>조회수</td><td><%=b_hit %></td>
</tr>
<tr>
	<td>좋아요</td><td><span id="like"><%=b_like %></span></td>
</tr>
<tr>
	<td>내용</td><td><%=b_content%> </td>
</tr>
<tr>
	<td colspan="2">

				<%
		if(b_userid.equals((String)session.getAttribute("userid"))){
			
		%>

		<input type="button" value="수정" onclick="location.href='./edit.jsp?b_idx=<%=b_idx %>'">
		<input type="button" value="삭제" onclick="location.href='./delete.jsp?b_idx=<%=b_idx %>'">
		
		<%
					}		
		%>
		<input type="button" value="좋아요" onclick="like()">
		<input type="button" value="리스트" onclick="location.href='list.jsp'">
	</td>
</tr>
</table>

<hr/>
<form method="post" action="reply_ok.jsp">
	<input type="hidden" name="b_idx" value="<%=b_idx %>">
	<p><%=session.getAttribute("userid") %> : <input type="text" size="40" name="r_content"><input type="submit" value="확인"></p>
</form>
<hr/>

<%
	sql = "select r_boardidx, r_idx, r_userid, r_content, r_regdate from tb_reply where r_boardidx=? order by r_idx desc";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, b_idx);
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		r_boardidx=rs.getInt("r_boardidx");
		int r_idx = rs.getInt("r_idx");
		r_userid = rs.getString("r_userid");
		r_content = rs.getString("r_content");
		r_regdate = rs.getString("r_regdate");
		
%>
	<p><%=r_userid%> : <%=r_content%> (<%=r_regdate %>)
	<%
	if(r_userid.equals((String)session.getAttribute("userid"))){
		%>
		<input type="button" value="삭제" onclick="location.href='./r_delete.jsp?r_idx=<%=r_idx %>&r_boardidx=<%=r_boardidx%>'">
		
		<%
	}
	
	%>
	
	</p>
<%
	}
		}
}catch(Exception e){
	e.printStackTrace();
	}

%>
</body>
</html>