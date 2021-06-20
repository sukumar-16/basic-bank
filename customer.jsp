<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
<title>Customer</title>
<link href="${pageContext.request.contextPath}/custStyle.css" rel="stylesheet" type="text/css" >
</head>
<body>
<div style="height:100px;background-color:black;color:white;text-align:center;font-size:30px;font-family:Helvetica;">
<a href="index.jsp"><img src="home2.png" style="height: 100px;float:left; margin-right:0px;"/></a>
<p style="padding-top:30px;">Customer Details</p></div> 
<button id="btn" style="margin-left:45%; padding-bottom:30px;font-size: 20px;border: 2px groove black;margin-top:30px;padding-left:10px;color:white;background-color:#278e97;width:220px;
 box-shadow: 2px 2px 9px black;font-family:calibri;height:30px;">
 Send Money</button>
<div class="table-wrapper">
<table class="fl-table" border="1">
<thead>
<th>Sno</th>
<th>Name</th>
<th>Email</th>
<th>Balance</th>
</thead>
<%
try{
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","Nive@2104");
Statement statement=connection.createStatement();
String sql ="select *from users";
ResultSet resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("sNo") %></td>
<td><%=resultSet.getString("Customer_Name") %></td>
<td><%=resultSet.getString("email") %></td>
<td><%=resultSet.getString("balance") %></td>
</tr>
<%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
</div>
<script>
var btn=document.getElementById("btn");
btn.addEventListener('click',function(){
	window.open('sendMoney.jsp','Testing','width=500,height=300,toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no');
})
</script>
</body>
</html>