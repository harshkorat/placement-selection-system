<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin | Document</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/stylesheet.css">
<link href="css/bootstrap.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="css/jquery.min.js"></script>
<script type="text/javascript" src="css/bootstrap.min.js"></script>
<script type="text/javascript">
function sub() {
	var title=document.getElementById('input-title').value;
	var file=document.getElementById('input-file').value;
	if(title=='')
		{
		alert('Please Enter Title');
		return false;
		}
	if(file=='')
		{
		alert('Please Enter File');
		return false;
		}
	else
		{
		
		var ext=file.substring(file.lastIndexOf('.')+1);
		if(ext=="pdf")
			{
			localStorage.setItem("t",title);
			}
		else
			{
			alert('Enter pdf file only');
			return false;
			}
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
		
%>
	<%@page import="jsp.Admin"%>
	<div id="container">
	<jsp:include page="AdminHeader.jsp"></jsp:include>
		<div id="content " >
			<div class="page-header">
			
				<div class="container-fluid ">
				  
					<h2 class="col-md-11 col-md-push-1 col-sm-12">Document</h2>
				</div>
			</div>
			<div class="container-fluid col-md-9 col-md-push-1 col-sm-12">
		
				<div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"> Add Document</h3>
                    </div>
                    <div class="panel-body ">
                         <form action="UploadDocument.jsp" method="post" enctype="multipart/form-data"  class="form-horizontal">
					                <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-title">Document Title</label>
                                        <div class="col-sm-8">
                                        <input type="text" name="title" value="" placeholder="Title" id="input-title" class="form-control" required="required">
                                        
                                             
                                        
                                        </div>
                                    </div>
                                    <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-file">File</label>
                                        <div class="col-sm-8">
                                        <input type="file" name="file" accept="application/pdf" size="50" id="input-file" class="form-control" required="required">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                    <label class="col-sm-2 " ></label>
                                        <div class="col-sm-2">
                                        <input type="submit"  value="Submit" class="form-control btn btn-primary" onclick="sub()">
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