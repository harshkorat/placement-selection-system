<%@page import="jsp.Company"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Company | Interview Request</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/stylesheet.css">
<link href="css/bootstrap.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="css/jquery.min.js"></script>
<script type="text/javascript" src="css/bootstrap.min.js"></script>
</head>
<body>
<%!
    public int nullIntconvert(String str) {
        int num = 0;
        if (str == null) {
            str = "0";
        } else if ((str.trim()).equals("null")) {
            str = "0";
        } else if (str.equals("")) {
            str = "0";
        }
        try {
            num = Integer.parseInt(str);
        } catch (Exception e) {
        }
        return num;
    }
%>
<%

int showRows = 10;
int totalRecords = 5;
int totalRows = nullIntconvert(request.getParameter("totalRows"));
int totalPages = nullIntconvert(request.getParameter("totalPages"));
int iPageNo = nullIntconvert(request.getParameter("iPageNo"));
int cPageNo = nullIntconvert(request.getParameter("cPageNo"));

int startResult = 0;
int endResult = 0;
int ques = 1;
if (iPageNo == 0) {
    iPageNo = 0;
} else {
    iPageNo = Math.abs((iPageNo - 1) * showRows);
}
int id=(int)session.getAttribute("userid");
List<List<String>> rs1=Company.getStudentPendingRecords(id,iPageNo, showRows);;
 List<List<String>> rs2=Company.foundStudentPendingRow(id);
 
 for(List<String> a:rs2)
 {
	 for(String b:a)
	 {
		 totalRows =Integer.parseInt(b) ;
	 }
 } 
	
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
		if(request.getParameter("apt")!=null)
		{
				int row=Company.updateInterview("A",Integer.parseInt(request.getParameter("apt")));
				if(row>0)
				{
					response.sendRedirect("CompanyDashboard.jsp");	
				}
				else
				{
					response.sendRedirect("CompanyPendingInteriew.jsp");
				}
		}
		if(request.getParameter("rjt")!=null)
		{
				int row=Company.updateInterview("R",Integer.parseInt(request.getParameter("rjt")));
				if(row>0)
				{
					response.sendRedirect("CompanyDashboard.jsp");	
				}
				else
				{
					response.sendRedirect("CompanyPendingInteriew.jsp");
				}
		}
		
%>
	
	<div id="container">
	<jsp:include page="CompanyHeader.jsp"></jsp:include>
		<div id="content " >
			<div class="page-header">
			
				<div class="container-fluid ">
				  
					<h2 class="col-md-11 col-md-push-1 col-sm-12">Interview</h2>
				</div>
			</div>
			<div class="container-fluid col-md-11 col-md-push-1 col-sm-12">
			
				<div class="row ">
					<div class="col-md-10 col-md-2 col-sm-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Pending Interview Request List</h3>
              </div>
              <div class="panel-body">
                <form action="" method="post" enctype="multipart/form-data" >
                  <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                      <tbody>
                            <%
            for(List<String> a:rs1)
            {
            	
            		%>
                    <tr >
                    	<td><b>Request Date</b></td>
	                    	<td><%= a.get(10) %></td>
	                    	<td rowspan="8"  class="text-center">
	                    		<br><br><br><a class="btn btn-primary " href="CompanyPendingInterview.jsp?apt=<%=a.get(11)%>">Accept</a>
	                    		<br><br><a class="btn btn-primary " href="CompanyPendingInterview.jsp?rjt=<%=a.get(11)%>">Reject</a>
	                    		<br><br><a class="btn btn-primary " href="CompanySentNotification.jsp?sid=<%=a.get(0)%>">Send <br>Notification</a>
	                    	</td>
	                    	
	                    	
	                </tr>
	                
                    <tr >
                    	<td><b>Name </b></td>
	                    	<td><%= a.get(1) %> ( <%= a.get(3) %>,<%= a.get(4) %>.)</td>
	                </tr>
	                <tr >
                    	<td><b>Address</b></td>
	                    	<td><%= a.get(2) %></td>
	                </tr>
	                <tr>
                    	<td><b>Email</b></td>
	                    	<td><%= a.get(7) %></td>
	                </tr>
	                <tr>
                    	<td><b>Contect No.</b></td>
	                    	<td><%= a.get(6) %></td>
	                </tr>
	                <tr>
                    	<td><b>Degree</b></td>
	                    	<td><%= a.get(5) %></td>
	                </tr>
	                <tr>
                    	<td><b>CGPA</b></td>
	                    	<td><%= a.get(8) %></td>
	                </tr>
	                <tr>
                    	<td><b>Skills</b></td>
	                    	<td><%
	                        String[] sk1 = a.get(9).split(",");
                    		List<List<String>> rs3=Company.getCheckLanguageRecords(a.get(9).toString());
     for(List<String> b:rs3)
    {
		    out.print(b.get(1)+",");
    }
	                    	
	                    	 %></td>
	                </tr>
	                <tr>
	                <td colspan="3"></td>
	                </tr>
	                <%
                    
            	
            }

                %>
                        
                      </tbody>
                    </table>

                    
                  </div>
                </form>
                    <ul class='pagination'>
                    <% ques++; %>
                    </ul>
                                    	<form class="pagination">
            <input type="hidden" name="iPageNo" value="<%= iPageNo%>">
            <input type="hidden" name="cPageNo" value="<%= cPageNo%>">
            <input type="hidden" name="showRows" value="<%= showRows%>">
            <%
                try {
                    if (totalRows < (iPageNo + showRows)) {
                        endResult = totalRows;
                    } else {
                        endResult = (iPageNo + showRows);
                    }
                    startResult = (iPageNo + 1);
                    totalPages = ((int) (Math.ceil((double) totalRows / showRows)));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                int i = 0;
                int cPage = 0;
                if (totalRows != 0) {
                    cPage = ((int) (Math.ceil((double) endResult / (totalRecords * showRows))));

                    int prePageNo = (cPage * totalRecords) - ((totalRecords - 1) + totalRecords);
                    if ((cPage * totalRecords) - (totalRecords) > 0) {
            %>

             <li class='page-item pagination'><span id="previous"><a href="CompanyPendingInterview.jsp?iPageNo=<%=prePageNo%>&cPageNo=<%=prePageNo%>" class="numbersFont">Previous</a></span></li>
            <%
                }
                for (i = ((cPage * totalRecords) - (totalRecords - 1)); i <= (cPage * totalRecords); i++) {
                    if (i == ((iPageNo / showRows) + 1)) {%>
             <li class='page-item pagination'><span class="numbers"><a href="CompanyPendingInterview.jsp?iPageNo=<%=i%>" class="numbersFont"class="numbersFont"><%=i%></a></span></li>
                <%
                } else if (i <= totalPages) {
                %>
             <li class='page-item pagination'><span class="numbers"><a href="CompanyPendingInterview.jsp?iPageNo=<%=i%>" class="numbersFont" class="numbersFont"><%=i%></a></span></li>
                <%
                        }
                    }
                    if (totalPages > totalRecords && i < totalPages) {
                %>
             <li class='page-item '><span id="next"><a href="CompanyPendingInterview.jsp?iPageNo=<%=i%>&cPageNo=<%=i%>" class="numbersFont">Next</a></span></li>
            <%
                    }
                }

            %>
        </form>
              </div>
            </div>
          </div>
				</div>
			</div>

		</div>
</div>
		
</body>
</html>