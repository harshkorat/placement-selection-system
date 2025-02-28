<%@page import="jsp.Student"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student | Notification</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/stylesheet.css">
<link href="css/bootstrap.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="css/jquery.min.js"></script>
<script type="text/javascript" src="css/bootstrap.min.js"></script>
</head>
<body>
<%
int id=(int)session.getAttribute("userid");
List<List<String>> rs1=Student.getStudNotifications(id);
 
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
			
%>
	
	<div id="container">
	<jsp:include page="StudentHeader.jsp"></jsp:include>
		<div id="content " >
			<div class="page-header">
			
				<div class="container-fluid ">
				  
					<h2 class="col-md-11 col-md-push-1 col-sm-12">Notifications</h2>
				</div>
			</div>
			<div class="container-fluid col-md-11 col-md-push-1 col-sm-12">
			
				<div class="row ">
					<div class="col-md-10 col-md-2 col-sm-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Notification List</h3>
              </div>
              <div class="panel-body">
                <form action="" method="post" enctype="multipart/form-data" >
                  <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                      <tbody>
                            <%
                            
            for(List<String> a:rs1)
            {
            	String name=Student.getNotificationSenderName(Integer.parseInt(a.get(0)));
            		%>
            		
            		<div class="alert alert-success alert-dismissible">
            		<b>Name : <%=name %></b><br>
            		<b>Date : <%=a.get(2) %></b><br>
            		<b><%=a.get(1) %></b><br>
          			</div>        
	                <%
                    
            	
            }

                %>
                        
                      </tbody>
                    </table>

                    
                  </div>
                </form>
                     </div>
            </div>
          </div>
				</div>
			</div>

		</div>
</div>
		
</body>
</html>