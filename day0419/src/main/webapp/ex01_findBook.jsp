<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style type="text/css">
	body {
		background-color: #f8f9fa;
		padding: 30px;
		text-align: center;
	}
	h3 {
		margin-bottom: 20px;
	}
	form {
		margin-bottom: 30px;
	}

	input[type="text"] {
		padding: 5px 10px;
		width: 200px;
		border: 1px solid #ccc;
		border-radius: 4px;
	}

	.container {
		width: 60%;
		margin: 0 auto;
	}

	table {
		width: 100%;
		border-collapse: collapse;
	}

	th, td {
		padding: 10px;
		border: 1px solid #dee2e6;
		text-align: center;
	}

	th {
		background-color: #343a40;
		color: white;
	}
	td{
		color : #1b291f;
	}

	tr:nth-child(even) {
		background-color: #f2f2f2;
	}
</style>
</head>
<body>
<form method = "post">
	<h3>오늘날 판매된 도서의 정보</h3>
	출판사 : <input type = "text" name = "publisher">
	<button class = "btn btn-primary">조회</button>
</form>
<%
	request.setCharacterEncoding("utf-8");
	String publisher = request.getParameter("publisher");

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String username = "c##madang";
	String password = "madang";
	String sql = "select b.bookname, b.price from book b "
				+ "join orders o on "
				+ "o.bookid = b.bookid "
				+ "where publisher = ? "
				+ "and to_char(sysdate, 'yy/mm/dd') = to_char(orderdate, 'yy/mm/dd')";
	try {
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, username, password);
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, publisher);

		ResultSet rs = pstmt.executeQuery();
%>	<div class = "container">
		<table class="table table-dark table-striped">
			<tr>
				<th>도서명</th>
				<th>가격</th>
			</tr>
			<%
			while(rs.next()) {
			%>
			<tr>
				<td><%= rs.getString("bookname") %></td>
				<td><%= rs.getInt("price") %></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
<%
		rs.close();
		pstmt.close();
		conn.close();
	} catch(Exception e) {
		System.out.println("예외발생: " + e.getMessage());
	}
%>
</body>
</html>
