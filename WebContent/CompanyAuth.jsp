<%@page import="jsp.Company"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Company | Profile</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/stylesheet.css">
<link href="css/bootstrap.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="css/jquery.min.js"></script>
<script type="text/javascript" src="css/bootstrap.min.js"></script>
<script type="text/javascript">
function subs() {
	var email=document.getElementById('input-email').value;
	if(email=='')
		{
		alert('Please Enter Email');
		return false;
		}
	else
		{
		document.forms[0].action="CompanyAuth.jsp";
		document.forms[0].submit();
		}
}
</script>

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
		else if(!session.getAttribute("type").equals("C"))
		{
			response.sendRedirect("index.jsp");
		}
		if(request.getParameter("email")!=null)
		{
			int row=0;
			int id=(int)(session.getAttribute("userid"));
			if(request.getParameter("pass").equals(""))
			{
				row=Company.profile(request.getParameter("email"),"A",id);
			}
			else
			{

				row=Company.profile(request.getParameter("email"),request.getParameter("pass"),id);	
			}
			
			if(row>0)
			{
				response.sendRedirect("Logout.jsp");
			}
			else
			{
				response.sendRedirect("CompanyAuth.jsp");
			}
		}
%>
	
	<div id="container">
	<jsp:include page="CompanyHeader.jsp"></jsp:include>
		<div id="content " >
			<div class="page-header">
			
				<div class="container-fluid ">
				  
					<h2 class="col-md-11 col-md-push-1 col-sm-12">Change Password</h2>
				</div>
			</div>
			<div class="container-fluid col-md-9 col-md-push-1 col-sm-12">
		
				<div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Authentication Details</h3>
                    </div>
                    <div class="panel-body ">
                         <form action="" method="post"  class="form-horizontal">
					                <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-email">Email</label>
                                        <div class="col-sm-8">
                                        <input type="email" name="email" value="<%=session.getAttribute("email") %>" placeholder="Email" id="input-email" class="form-control" required="required">
                                        
                                        </div>
                                    </div>
                                    <div class="form-group  ">
                                        <label class="col-sm-2 control-label" for="input-pass">Password</label>
                                        <div class="col-sm-8">
                                        <input type="password" name="pass" value="" placeholder="Password" id="input-pass" class="form-control" >
                                        
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                    <label class="col-sm-2 " ></label>
                                        <div class="col-sm-2">
                                        <input type="submit"  value="Save" class="form-control btn btn-primary" onclick="subs()">
                                        </div>
                                    </div>

                            </form>
                            
                            

                    </div>
                </div>
			</div>

		</div>
</div>
		
</body>
</html>