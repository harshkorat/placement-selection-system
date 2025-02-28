<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

</head>
<body>
<header  id="header" class="navbar navbar-static-top ">

  <div class="container-fluid">
    <ul class="nav navbar-nav ">
    <li ><a href="AdminDashboard.jsp" style="color: black;font-weight: bold;" ><h3><b>Placement Selection</b></h3> </a></li>
      <li ><a href="AdminDashboard.jsp" style="font-weight: bold;">Home</a></li>
      
      <li class="dropdown"><a href="#" class="dropdown-toggle" style="font-weight: bold;" data-toggle="dropdown"> Company <span class="caret"></span></a>
        <ul class="dropdown-menu dropdown-menu-right">
          <li><a href="ActiveCompany.jsp">Active Company</a></li>
          <li><a href="PendingCompany.jsp">Approve Company</a></li>
          <li><a href="RejectCompany.jsp">Rejected Company</a></li>
        </ul>
      </li>
      <li><a href="StudentDisplay.jsp" style="font-weight: bold;">Student</a></li>
      <li><a href="DocumentDisplay.jsp" style="font-weight: bold;">Document</a></li>
      <li><a href="LanguageDisplay.jsp" style="font-weight: bold;">Language</a></li>
    </ul>   
    <a href="#" id="button-menu" class="hidden-md hidden-lg"><span class="fa fa-bars"></span></a>        
    <ul class="nav navbar-nav navbar-right">
      <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="image/profile-45x45.png" alt="admin" title="admin" id="user-profile" class="img-circle" ><%= session.getAttribute("email")  %> <span class="caret"></span></a>
        <ul class="dropdown-menu dropdown-menu-right">
          <li><a href="AdminProfile.jsp"> Your Profile</a></li>
          <li><a href="Logout.jsp"> Logout</a></li>
        </ul>
      </li>
      
    </ul>
  </div>
</header>
<nav></nav>

</body>
</html>