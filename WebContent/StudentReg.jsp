<%@page import="jsp.Admin"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student | Registration</title>
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
	var email=document.getElementById('input-email').value;
	var contect=document.getElementById('input-contect').value;
	var degree=document.getElementById('input-degree').value;
	var cgpa=document.getElementById('input-cgpa').value;
	var pass=document.getElementById('input-pass').value;
	
	
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
	else  if(email=='')
	{
	alert('Please Enter Email');
	return false;
	}
	else  if(contect=='')
	{
	alert('Please Enter Contect');
	return false;
	}
	else  if(degree=='')
	{
	alert('Please Enter Degree');
	return false;
	}
	else  if(cgpa=='')
	{
	alert('Please Enter CGPA');
	return false;
	}
	else  if(pass=='')
	{
	alert('Please Enter Password');
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
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

response.setHeader("Pragma", "no-cache");

response.setHeader("Expires", "0");
List<List<String>> rs1=Admin.getAllLanguageRecords();;
%>
	
	<div id="container">
		<div id="content " >
			<div class="page-header">
			
				<div class="container-fluid ">
				  
					<h2 class="col-md-11 col-md-push-1 col-sm-12">Placement Selection Portal</h2>
					<a href="index.jsp"><h2 class="btn btn-primary" >Login</h2></a>
				</div>
			</div>
			<div class="container-fluid col-md-9 col-md-push-1 col-sm-12">
		
				<div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"> Student Registration</h3>
                    </div>
                    <div class="panel-body ">
                         <form action="AddStudent.jsp" method="post"  class="form-horizontal">
					                <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-name">Name</label>
                                        <div class="col-sm-10">
                                        <input type="text" name="name" value="" placeholder="Firstname  Lastname" id="input-name" class="form-control" required="required">
                                        </div>
                                    </div>
                                    <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-add">Address</label>
                                        <div class="col-sm-10">
                                        <input type="text" name="add" value="" placeholder="Address" id="input-add" class="form-control" required="required">
                                        </div>
                                    </div >
                                    <div class="row form-group required">
                                    	<div>
	                                        <label class="col-sm-2 control-label" for="input-city">City</label>
	                                        <div class="col-sm-4">
	                                        <input type="text" name="city" value="" placeholder="City" id="input-city" class="form-control" required="required">
	                                        </div>
	                                    </div>
	                                    <div >
	                                        <label class="col-sm-2 control-label" for="input-state">State</label>
	                                        <div class="col-sm-4">
	                                        <input type="text" name="state" value="" placeholder="State" id="input-state" class="form-control" required="required">
	                                        </div>
	                                    </div>
                                    </div>
                                    <div class="row form-group required">
                                    	<div>
		                                    <label class="col-sm-2 control-label" for="input-email">Email</label>
	                                        <div class="col-sm-4">
	                                        <input type="email" name="email" value="" placeholder="Email" id="input-email" class="form-control" required="required">
	                                        </div>
	                                    </div >
	                                    <div >
	                                        <label class="col-sm-2 control-label" for="input-contect">Contect</label>
	                                        <div class="col-sm-4">
	                                        <input type="text" name="contect" pattern="^[6-9]{1}[0-9]{9}$" value="" placeholder="Contect" id="input-contect" class="form-control" required="required">
	                                        </div>
	                                    </div >
                                    </div>
                                    <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-degree">Degree</label>
                                        <div class="col-sm-10">
                                        <input type="text" name="degree" value="" placeholder="Degree" id="input-degree" class="form-control" required="required">
                                        </div>
                                    </div >
                                    <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-cgpa">CGPA</label>
                                        <div class="col-sm-10">
                                        <input type="number" max="10" min="1" step="0.01" name="cgpa" value="" placeholder="CGPA" id="input-cgpa" class="form-control" required="required">
                                        </div>
                                    </div >
                                    <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-pass">Password</label>
                                        <div class="col-sm-10">
                                        <input type="password" name="pass" value="" placeholder="Password" id="input-pass" class="form-control" required="required">
                                        </div>
                                    </div >
                                    <div class="form-group required ">
                                        <label class="col-sm-2 control-label" for="input-skill">Development Skills</label>
                                        <div class="col-sm-10">
                                                        <%
            for(List<String> a:rs1)
            {
            		%>
            		<label class="checkbox-inline">
				      <input type="checkbox"  name="skill" value="<%= a.get(0) %>"  id="input-skill" class="form-control " ><%= a.get(1) %>
				    </label>
            		<%
            }
                %>
                                        
                                        
                                        </div>
                                    </div >
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