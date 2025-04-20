<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
</style>
</head>
<body>
	<h2>도서 주문</h2>
	<form action="ex02insertbook.jsp" method="post">
		<select name="custid">
			<%
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:XE";
			String username = "c##madang";
			String password = "madang";
			Connection conn = DriverManager.getConnection(url, username, password);
			
			String custSql = "select custid, name from customer";
			Statement stmt2 = conn.createStatement();
			ResultSet rs2 = stmt2.executeQuery(custSql);

			while (rs2.next()) {
			%>
			<option value="<%=rs2.getInt("custid")%>">
				<%=rs2.getString("name")%>
			</option>
			<%
			}
			rs2.close();
			stmt2.close();
			
			%>
		</select>
		<%
		String bookSql = "select * from book";
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(bookSql);
		%>
		<select name="bookid">
			<%
			while (rs.next()) {
				int id = rs.getInt("bookid");
				String bookname = rs.getString("bookname");
				String publisher = rs.getString("publisher");
			%>
			<option value="<%=id%>"><%=bookname%>(<%=publisher%>)
			</option>
			<%
			}
			rs.close();
			stmt.close();
			conn.close();
			%>
		</select>

		<button>구매</button>
	</form>
</body>
</html>