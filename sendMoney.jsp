<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
try {
Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/sendMoney.css" rel="stylesheet" type="text/css" >
</head>
<meta charset="ISO-8859-1">
<title>Transact</title>
</head>
<body>
<%! String driverName = "com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/bank";%>
<%!String user = "root";%>
<%!String psw = "Nive@2104";%>
<div id="formm" ><form action="transact.jsp" method="POST">
<%
Connection con = null;
PreparedStatement s = null;
try
{
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
String sql = "SELECT * FROM users";
s = con.prepareStatement(sql);
ResultSet rs = s.executeQuery(); 
%>
<p class="labe">Select Sender :</p>
<select name="sender">
<%
while(rs.next())
{
String fname = rs.getString("email"); 
%>
<option value="<%=fname %>"><%=fname %></option>
<%
}
%>
</select>
<p class="labe"> Select Receiver:</p>
<select name="recv">
<%
rs = s.executeQuery(); 
while(rs.next())
{
String fname = rs.getString("email"); 
%>
<option value="<%=fname %>"><%=fname %></option>
<%
}
%>
</select>
<%
}
catch(Exception e)
{ 
out.println(e);
}
%>
</p>
<input type="number" id="amt" name= "amount" placeholder="Enter amount"/><br><br>
<button id="sub" type="submit">Submit</button>
</form></div>
</body>
</html>