<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement" %>
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
<style>
.res
{
display:none;
}
#success{
	color:green;
}
#suc,#fac{
  width: 320px;
  height: auto;
}
#failed{
color:red;
}

</style>
<title>transact</title>
</head>
<body>
<div class="res" id="success">
   <center><h3 id="t">Transaction Successful</h3>
   <img src="Successful Transaction.gif" id="suc" style={width:80px;height:30px;}/></center>
   </div>
<div" class="res" id="failed">
<center><h3 >Transaction Failed, Insufficient Balance</h3>
<img src="failed.png" id="fac" /></center>
</div>
<% String sender = request.getParameter("sender"); %>
<% String recv = request.getParameter("recv"); %>
<% String amnt = request.getParameter("amount"); %>
<% int amt=Integer.parseInt(amnt); %>
<%
try{
	
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root","Nive@2104");
Statement statement=connection.createStatement();
String sql ="select *from users where email=?";
PreparedStatement ps=connection.prepareStatement(sql);
PreparedStatement qs=connection.prepareStatement(sql);
ps.setString(1,sender);
qs.setString(1,recv);
ResultSet rs=qs.executeQuery();
rs.next();
int rbal=rs.getInt("balance");
ResultSet resultSet = ps.executeQuery();
resultSet.next();
int bal=resultSet.getInt("balance");
if(bal<amt)
{
%>
	<script>
		var h=document.getElementById("failed");
		h.style.display="block";
	</script>
<%}
else
{
    PreparedStatement p=connection.prepareStatement("update users set balance=? where email=?");
    PreparedStatement q=connection.prepareStatement("update users set balance=? where email=?");
    p.setInt(1,bal-amt);
    q.setInt(1,rbal+amt);
    p.setString(2,sender);
    q.setString(2,recv);
    p.executeUpdate();
    q.executeUpdate();
    PreparedStatement x=connection.prepareStatement("insert into history values (?, ?,?)");
    x.setString(1,sender);
    x.setString(2,recv);
    x.setInt(3,amt);
    x.execute();
   %>
 
		<script>
		var h=document.getElementById("success");
		h.style.display="block";
	</script>
	  <% 
}
connection.close();
}
catch (Exception e) {
e.printStackTrace();
}
%>
</body>
</html>