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
			String query="select * from tbl_user_master where UserEmailId=? and UserType=?";
 			PreparedStatement pstmt =con.prepareStatement(query);
 			pstmt.setString(1, u);
 			pstmt.setString(2, t);
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

	 				query="update tbl_user_master set Password=md5(?) where UserEmailId=? and UserType=?";
	 				PreparedStatement pstmts =con.prepareStatement(query);
	 	 			pstmts.setString(1, p);
	 	 			pstmts.setString(2, u);
	 	 			pstmts.setString(3, t);
	 	 			int row=pstmts.executeUpdate();
	 	 			if(row>0)
	 		 		{
	 	 				response.sendRedirect("index.jsp");
	 		 		}
	 	 			else
	 	 			{
	 	 				session.setAttribute("msg", "Something want wrong...!");
		 				response.sendRedirect("forgot.jsp");
	 	 			}
	 			}
	 			else
	 			{
	 				session.setAttribute("msg", "Invalid Username or Type...!");
	 				response.sendRedirect("forgot.jsp");
	 				
	 			}
 			}
 			else
 			{
 				session.setAttribute("msg", "Invalid Username or Type...!");
 				response.sendRedirect("forgot.jsp");
 			}
         }
         catch (Exception e) {
           out.println("An exception occurred: " + e);
         }
 %>

</body>
</html>