 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
	request.setCharacterEncoding("utf-8");
	int bookid = Integer.parseInt(request.getParameter("bookid"));
	int custid = Integer.parseInt(request.getParameter("custid"));
	String publisher = request.getParameter("bookname");
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String username = "c##madang";
	String password = "madang";
	String sql = "insert into orders values(orders_seq.nextval, ?, ?, ?, sysdate) ";
	
	try{
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, username, password);
	    String getPriceSql = "select price from book where bookid = ?";
	    PreparedStatement pstmt2 = conn.prepareStatement(getPriceSql);
	    pstmt2 = conn.prepareStatement(getPriceSql);
	    pstmt2.setInt(1, bookid);
	    ResultSet rs = pstmt2.executeQuery();

	    int price = 0;
	    if (rs.next()) {
	        price = rs.getInt("price");
	    }
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, custid);
		pstmt.setInt(2, bookid);
		pstmt.setInt(3, price);
		
	    int result = pstmt.executeUpdate();
	    if (result > 0) {
	%>
	       <h2>주문 등록</h2>
	<%
	    } else {
	%>
	        <h2>주문 등록 실패</h2>
	<%
	    }
	}catch(Exception e){
		System.out.println("예외발생: " + e.getMessage());
	}
%>
</body>
</html>