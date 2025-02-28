<%@page import="jsp.ConnectionDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%=request.getParameter("type") %>
<%
         try {
        	 	String u=null,p=null,t=null;
				if(request.getParameter("uname") != null && request.getParameter("psw") != null && request.getParameter("type") != null)
     			{
     				u = request.getParameter("uname");
     			
     				p = request.getParameter("psw");
     				
     				t=request.getParameter("type");
     			}
			Connection con = ConnectionDb.connect();
			String query="select * from tbl_user_master where UserEmailId=? and Password=md5(?) and UserType=?";
 			PreparedStatement pstmt =con.prepareStatement(query);
 			pstmt.setString(1, u);
 			pstmt.setString(2, p);
 			pstmt.setString(3, t);
 			ResultSet rs=pstmt.executeQuery();
 			if(rs!=null)
 			{
	 			if(rs.next())
	 			{	
	 				String email=rs.getString("UserEmailId");
	 				String type=rs.getString("UserType");
	 				String status=rs.getString("UserStatus");
	 				session.setAttribute("userid", rs.getInt("UserId"));
	 				session.setAttribute("email",email);
					session.setAttribute("type", type);
					if(status.equals("A"))
					{
						if(type.equals("A"))//A used for Admin
		 				{	
		 					response.sendRedirect("AdminDashboard.jsp");
		 				}
		 				else if(type.equals("C"))//C used for Company
		 				{
		 					response.sendRedirect("CompanyDashboard.jsp");
		 				}
		 				else if(type.equals("S"))//S used for Student
		 				{
		 					response.sendRedirect("StudentDashboard.jsp");
		 				}	
					}
					else if(status.equals("P") && type.equals("C"))
					{
						session.setAttribute("msg", "Company under verification...!");
		 				response.sendRedirect("index.jsp");	
					}
					else if(status.equals("R"))
					{
						session.setAttribute("msg", "User no longer available...!");
		 				response.sendRedirect("index.jsp");	
					}
	 						
	 			}
	 			else
	 			{
	 				session.setAttribute("msg", "Username Or Password Are Wrong...!");
	 				response.sendRedirect("index.jsp");
	 				
	 			}
 			}
 			else
 			{
 				session.setAttribute("msg", "Something Are Wrong...!");
 				response.sendRedirect("index.jsp");
 			}
         }
         catch (Exception e) {
           out.println("An exception occurred: " + e);
         }
 %>

</body>
</html>