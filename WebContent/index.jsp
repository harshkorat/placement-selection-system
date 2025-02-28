<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Placement Selection </title>
<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="login.css">
 
</head>

<body>
<div class="main">
    <p class="home" align="center">Placement Selection</p>
    <form class="form1" method="post">
    	<%
    	if(session.getAttribute("msg") != null)
		{
    	%>
			<p class="error" align="center"><%=session.getAttribute("msg") %></p>
		<%
		session.removeAttribute("msg");
		}
    	
    	%>
    	<select class="ty" name="type">
    	<option value="A" >Admin</option>
    	<option value="C">Company</option>
    	<option value="S">Student</option>
    	</select>
      <input class="un " name="uname" type="email" align="center" placeholder="Username" required="required">
      <input class="pass" name="psw" type="password" align="center" placeholder="Password" required="required">
      <input type="submit" class="submit" align="center" value="Log in">
      
      <p class="forgot" align="center"><a href="forgot.jsp">   Forgot Password?</a></p>      
                </form>
                <p class="reg" align="center"><a href="StudentReg.jsp">Student Registration </a></p><p class="reg" align="center"><a href="CompanyReg.jsp">Company Registration</a></p>
    </div>
     
</body>

</html>
<%  
		// Prevent Back Button After Logout
	
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		
		response.setHeader("Pragma", "no-cache");
		
		response.setHeader("Expires", "0");
		
		// Check User
		
		
		if(request.getParameter("uname") != null && request.getParameter("psw") != null && request.getParameter("type") != null)
		{
			String uname = request.getParameter("uname");
 			
			String psw = request.getParameter("psw");
			
			String type =request.getParameter("type");
		%>
			<jsp:forward page="AuthenticationLogin.jsp" >
			<jsp:param name="uname" value="<%=uname%>" />
			<jsp:param name="psw" value="<%=psw%>" />
			<jsp:param name="type" value="<%=type%>" />
			    
			</jsp:forward>	
		<%}
	%>
	