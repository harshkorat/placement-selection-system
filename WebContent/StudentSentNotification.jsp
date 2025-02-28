<%@page import="jsp.Student"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student | Send Notification</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/stylesheet.css">
<link href="css/bootstrap.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="css/jquery.min.js"></script>
<script type="text/javascript" src="css/bootstrap.min.js"></script>
<script type="text/javascript">
function subs() {
	var des=document.getElementById('input-des').value;
	if(des=='')
		{
		alert('Please Enter Description');
		return false;
		}
	else
		{
		document.forms[0].action="StudentSentNotification.jsp";
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
		else if(!session.getAttribute("type").equals("S"))
		{
			response.sendRedirect("index.jsp");
		}
		if(request.getParameter("des")!=null)
		{
			int row=0;
			int id=(int)(session.getAttribute("userid"));
			if(request.getParameter("n")!=null)
			{
				row=Student.notification(id, Integer.parseInt(request.getParameter("cid")),request.getParameter("des"));
				if(row>0)
				{
					response.sendRedirect("StudentDashboard.jsp");
				}
				else
				{
					response.sendRedirect("StudentSentNotification.jsp");
				}	
			}
			
			
		}
%>
	
	<div id="container">
	<jsp:include page="StudentHeader.jsp"></jsp:include>
		<div id="content " >
			<div class="page-header">
			
				<div class="container-fluid ">
				  
					<h2 class="col-md-11 col-md-push-1 col-sm-12">Notification</h2>
				</div>
			</div>
			<div class="container-fluid col-md-9 col-md-push-1 col-sm-12">
		
				<div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Send Notification</h3>
                    </div>
                    <div class="panel-body ">
                         <form action="" method="post"  class="form-horizontal">
					                <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-n">Send To</label>
                                        <div class="col-sm-8">
                                        <input type="text" name="n" value="<%=Student.getNotificationSenderName(Integer.parseInt(request.getParameter("cid"))) %>"  id="input-n" class="form-control" readonly="readonly" required="required">
                                        <input type="hidden" name="cid" value="<%=request.getParameter("cid")%>">
                                        </div>
                                    </div>
                                    <div class="form-group  ">
                                        <label class="col-sm-2 control-label" for="input-des">Description</label>
                                        <div class="col-sm-8">
                                        <input type="text" name="des" value="" placeholder="Write messages..." id="input-des" class="form-control" required="required"/>
                                        
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