<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin | Language</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/stylesheet.css">
<link href="css/bootstrap.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="css/jquery.min.js"></script>
<script type="text/javascript" src="css/bootstrap.min.js"></script>
<script type="text/javascript">
function subs() {
	var lang=document.getElementById('input-lan').value;
	if(lang=='')
		{
		alert('Please Enter Language');
		return false;
		}
	else
		{
		document.forms[0].action="AddLanguage.jsp";
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
		else if(!session.getAttribute("type").equals("A"))
		{
			response.sendRedirect("index.jsp");
		}
		if(request.getParameter("lang")!=null)
		{
			int row=Admin.addLanguage(request.getParameter("lang"));
			if(row>0)
			{
				response.sendRedirect("LanguageDisplay.jsp");
			}
			else
			{
				response.sendRedirect("AddLanguage.jsp");
			}
		}
%>
	<%@page import="jsp.Admin"%>
	<div id="container">
	<jsp:include page="AdminHeader.jsp"></jsp:include>
		<div id="content " >
			<div class="page-header">
			
				<div class="container-fluid ">
				  
					<h2 class="col-md-11 col-md-push-1 col-sm-12">Language</h2>
				</div>
			</div>
			<div class="container-fluid col-md-9 col-md-push-1 col-sm-12">
		
				<div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"> Add Language</h3>
                    </div>
                    <div class="panel-body ">
                         <form action="" method="post"  class="form-horizontal">
					                <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-lan">Language Name</label>
                                        <div class="col-sm-8">
                                        <input type="text" name="lang" value="" placeholder="Language" id="input-lan" class="form-control" required="required">
                                        
                                        </div>
                                    </div>
                                    <div class="form-group">
                                    <label class="col-sm-2 " ></label>
                                        <div class="col-sm-2">
                                        <input type="submit"  value="Submit" class="form-control btn btn-primary" onclick="subs()">
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