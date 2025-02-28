<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student | Dashboard</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/stylesheet.css">
<link href="css/bootstrap.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="css/jquery.min.js"></script>
<script type="text/javascript" src="css/bootstrap.min.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'
	crossorigin='anonymous'></script>

</head>
<body>
	<% 
	
		// Prevent Back Button After Logout

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
		response.setHeader("Pragma", "no-cache");
		
		response.setHeader("Expires", "0");
	
		// Check Session
		
		if(session.getAttribute("email") == null)
		{
			response.sendRedirect("index.jsp");
		}
		else if(!session.getAttribute("type").equals("S"))
		{
			response.sendRedirect("index.jsp");
		}
		int id=(int)session.getAttribute("userid");	
%>
	<%@page import="jsp.Student"%>
	<div id="container">
	<jsp:include page="StudentHeader.jsp"></jsp:include>
		<div id="content " >
			<div class="page-header">
				<div class="container-fluid ">
					<h2 class="col-md-11 col-md-push-1 col-sm-12">Dashboard</h2>
				</div>
			</div>
			<div class="container-fluid col-md-11 col-md-push-1 col-sm-12">
				<div class="row ">
					<div class="col-lg-3 col-md-3 col-sm-6">
						<div class="tile tile-primary">
							<div class="tile-heading">Total Interview Request Sent</div>
							<div class="tile-body">
								<i class="fas fa-podcast" style="margin: 5%;"></i>
								<h2 class="pull-right"><%=Student.countInterviweReqestPending(id)%></h2>
							</div>

						</div>
					</div>



				</div>
			</div>

		</div>
</div>
		
</body>
</html>