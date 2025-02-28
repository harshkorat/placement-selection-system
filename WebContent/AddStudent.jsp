<%@page import="jsp.Student"%>
<%@page import="jsp.Admin"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
if(session.getAttribute("email") == null)
{

	if(request.getParameter("skill")!=null)
	{
		String skill="";
		String skills[]=request.getParameterValues("skill");
		for(int i=0;i<skills.length;i++)
		{
			skill+=skills[i]+",";
		}
		StringBuffer sb= new StringBuffer(skill);  
		  
		skill=sb.deleteCharAt(sb.length()-1).toString();  
		
		String name=request.getParameter("name");
		String address=request.getParameter("add");
		String city=request.getParameter("city");
		String state=request.getParameter("state");
		String email=request.getParameter("email");
		String contect=request.getParameter("contect");
		String degree=request.getParameter("degree");
		float cgpa=Float.parseFloat(request.getParameter("cgpa"));
		String password=request.getParameter("pass");
		int rows=Admin.addUser(email,password,"S");
		if(rows>0)
		{
			int id=Admin.getUserId(email, password, "S");
			if(id>0)
			{
				int row=Admin.addStudent(name, address, city, state, email, contect, degree, cgpa, password, skill,id);
				if(row>0)
				{
					int notification=Admin.notification(1, id, "Thank you for joining with us...!!!");
					if(notification>0)
					{
						response.sendRedirect("index.jsp");			
					}
					else
					{
						response.sendRedirect("StudentReg.jsp");
					}		
				}
						
			}
		}
		
			
	}
	else
	{
		response.sendRedirect("StudentReg.jsp");
	}
}
else
{
	if(request.getParameter("skill")!=null)
	{
		String skill="";
		String skills[]=request.getParameterValues("skill");
		for(int i=0;i<skills.length;i++)
		{
			skill+=skills[i]+",";
		}
		StringBuffer sb= new StringBuffer(skill);  
		skill=sb.deleteCharAt(sb.length()-1).toString();  
		String name=request.getParameter("name");
		String address=request.getParameter("add");
		String city=request.getParameter("city");
		String state=request.getParameter("state");
		String email=request.getParameter("email");
		String contect=request.getParameter("contect");
		String degree=request.getParameter("degree");
		float cgpa=Float.parseFloat(request.getParameter("cgpa"));
		String password=request.getParameter("pass");
		int id=(int)session.getAttribute("userid");
		int row=Student.profileStudent(name, address, city, state, contect, degree, cgpa, skill,id);
		if(row>0)
		{
				response.sendRedirect("StudentDashboard.jsp");			
		}
		else
		{
			response.sendRedirect("StudentProfile.jsp");
		}			
	}
	else
	{
		response.sendRedirect("StudentProfile.jsp");
	}
}
%>
</body>
</html>