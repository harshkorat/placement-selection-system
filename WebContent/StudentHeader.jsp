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
    <li ><a href="StudentDashboard.jsp" style="color: black;font-weight: bold;" ><h3><b>Placement Selection</b></h3> </a></li>
      <li ><a href="StudentDashboard.jsp" style="font-weight: bold;">Home</a></li>
      <li><a href="Company.jsp" style="font-weight: bold;">Company</a></li>
      <li><a href="PendingInterview.jsp" style="font-weight: bold;">Pending Interview</a></li>
      <li><a href="StudentDocumentDisplay.jsp" style="font-weight: bold;">Document</a></li>
      <li><a href="StudentNotification.jsp" style="font-weight: bold;">Notifications</a></li>
    </ul>   
    <a href="#" id="button-menu" class="hidden-md hidden-lg"><span class="fa fa-bars"></span></a>        
    <ul class="nav navbar-nav navbar-right">
      <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="image/profile-45x45.png" alt="admin" title="admin" id="user-profile" class="img-circle" ><%= session.getAttribute("email")  %> <span class="caret"></span></a>
        <ul class="dropdown-menu dropdown-menu-right">
          <li><a href="StudentProfile.jsp"> Your Profile</a></li>
          <li><a href="StudentAuth.jsp">Change Password</a></li>
          <li><a href="Logout.jsp"> Logout</a></li>
        </ul>
      </li>
      
    </ul>
  </div>
</header>
<nav></nav>

</body>
</html>