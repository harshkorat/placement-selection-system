<%@page import="java.util.List"%>
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
	var name=document.getElementById('input-name').value;
	var add=document.getElementById('input-add').value;
	var city=document.getElementById('input-city').value;
	var state=document.getElementById('input-state').value;
	var contect=document.getElementById('input-contect').value;
	var des=document.getElementById('input-des').value;
	var size=document.getElementById('input-size').value;
	
	
	if(name=='')
		{
		alert('Please Enter Name');
		return false;
		}
	else  if(add=='')
		{
		alert('Please Enter Address');
		return false;
		}
	else  if(city=='')
	{
	alert('Please Enter City');
	return false;
	}
	else  if(state=='')
	{
	alert('Please Enter State');
	return false;
	}
	else  if(contect=='')
	{
	alert('Please Enter Contect');
	return false;
	}
	else  if(des=='')
	{
	alert('Please Enter Descriptio');
	return false;
	}
	else  if(size=='')
	{
	alert('Please Enter Company Size');
	return false;
	}
	else if(document.getElementById('input-skill').checked==false) 
	{
		flag=1;
	alert('Please Select At List One Skill');
	return false;
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
		
		int id=(int)session.getAttribute("userid");
		List<List<String>> rs2=Company.getCompanyRecords(id);
		%>
	
	<div id="container">
	<jsp:include page="CompanyHeader.jsp"></jsp:include>
		<div id="content " >
			<div class="page-header">
			
				<div class="container-fluid ">
				  
					<h2 class="col-md-11 col-md-push-1 col-sm-12">Profile</h2>
				</div>
			</div>
			<div class="container-fluid col-md-9 col-md-push-1 col-sm-12">
		
				<div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Your Profile</h3>
                    </div>
                    <div class="panel-body ">
                         <form action="AddCompany.jsp" method="post"  class="form-horizontal">
                                                                   <%
            for(List<String> b:rs2)
            {
            		%>
					                <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-name">Company Name</label>
                                        <div class="col-sm-9">
                                        <input type="text" name="name" value="<%=b.get(0) %>" placeholder="Company" id="input-name" class="form-control" required="required">
                                        </div>
                                    </div>
                                    <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-add">Address</label>
                                        <div class="col-sm-9">
                                        <input type="text" name="add" value="<%=b.get(1) %>" placeholder="Address" id="input-add" class="form-control" required="required">
                                        </div>
                                    </div >
                                    <div class="row form-group required">
                                    	<div>
	                                        <label class="col-sm-2 control-label" for="input-city">City</label>
	                                        <div class="col-sm-4">
	                                        <input type="text" name="city" value="<%=b.get(2) %>" placeholder="City" id="input-city" class="form-control" required="required">
	                                        </div>
	                                    </div>
	                                    <div >
	                                        <label class="col-sm-1 control-label" for="input-state">State</label>
	                                        <div class="col-sm-4">
	                                        <input type="text" name="state" value="<%=b.get(3) %>" placeholder="State" id="input-state" class="form-control" required="required">
	                                        </div>
	                                    </div>
                                    </div>
                                    <div class="row form-group required">
                                    	<div >
	                                        <label class="col-sm-2 control-label" for="input-contect">Contect</label>
	                                        <div class="col-sm-4">
	                                        <input type="text" name="contect" pattern="^[6-9]{1}[0-9]{9}$" value="<%=b.get(4) %>" placeholder="Contect" id="input-contect" class="form-control" required="required">
	                                        </div>
	                                    </div >
                                    </div>
                                    <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-des">Description</label>
                                        <div class="col-sm-9">
                                        
                                        <textarea rows="4" name="des" placeholder="Description" class="form-control" id="input-des" required="required" ><%=b.get(5) %></textarea>
                                        </div>
                                    </div >
                                    <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-size">Company size</label>
                                        <div class="col-sm-9">
                                        <input type="number"  min="1"  name="size" value="<%=b.get(6) %>" placeholder="Company Size" id="input-size" class="form-control" required="required">
                                        </div>
                                    </div >
                                    <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-skill">Development Skills</label>
                                        <div class="col-sm-9">
                                                        <%
                                   String[] sk1 = b.get(7).split(",");
                                        		List<List<String>> rs1=Company.getCheckLanguageRecords(b.get(7).toString());
                         for(List<String> a:rs1)
			            {
			            		%>
			            		<label class="checkbox-inline">
							      <input type="checkbox"  name="skill" value="<%= a.get(0) %>"  id="input-skill" class="form-control " checked="checked"><%= a.get(1)  %>
							    </label>
							    <%
			            }
                 		 rs1=Company.getNotCheckLanguageRecords(b.get(7).toString());
                        for(List<String> a:rs1)
			            {
			            		%>
			            		<label class="checkbox-inline">
							      <input type="checkbox"  name="skill" value="<%= a.get(0) %>"  id="input-skill" class="form-control " ><%= a.get(1)  %>
							    </label>
							    <%
			            }                                
            }
                %>
                                        
                                        
                                        </div>
                                    </div >

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