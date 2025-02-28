<%@page import="jsp.Company"%>
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

	if(request.getParameter("skill")!=null && request.getParameter("des")!=null)
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
		String des=request.getParameter("des");
		int size=Integer.parseInt(request.getParameter("size"));
		String password=request.getParameter("pass");
		int rows=Admin.addCompanyUser(email,password,"C");
		if(rows>0)
		{
			int id=Admin.getCompantUserId(email, password, "C");
			if(id>0)
			{
				int row=Admin.addCompany(name, address, city, state, email, contect, des, size, password, skill,id);
				if(row>0)
				{
					int notification=Admin.notification(1, id, "Thank you for joining with us...!!!");
					if(notification>0)
					{
						response.sendRedirect("index.jsp");			
					}
					else
					{
						response.sendRedirect("CompanyReg.jsp");
					}		
				}
						
			}
		}
		
			
	}
	else
	{
		response.sendRedirect("CompanyReg.jsp");
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
		String contect=request.getParameter("contect");
		String des=request.getParameter("des");
		int size=Integer.parseInt(request.getParameter("size"));
		int id=(int)session.getAttribute("userid");
		int row=Company.profileCompany(name, address, city, state, contect, des, size, skill,id);
		if(row>0)
		{
				response.sendRedirect("CompanyDashboard.jsp");			
		}
		else
		{
			response.sendRedirect("CompanyProfile.jsp");
		}			
	}
	else
	{
		response.sendRedirect("CompanyProfile.jsp");
	}
}
%>
</body>
</html>