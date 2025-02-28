<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jsp.Admin"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head lang="en-eg">
<meta charset="ISO-8859-1">
<title>Admin | Reject Company</title>
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
List<List<String>> rs1=Admin.getcompanyRecords("R",iPageNo, showRows);;
 List<List<String>> rs2=Admin.companyfoundRow("R");
 
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
		else if(!session.getAttribute("type").equals("A"))
		{
			response.sendRedirect("index.jsp");
		}
		if(request.getParameter("status")!=null)
		{
				int row=Admin.companyStatus(request.getParameter("status"),request.getParameter("id"));
				if(row>0)
				{
					response.sendRedirect("RejectCompany.jsp");	
				}
				else
				{
					response.sendRedirect("RejectCompany.jsp");
				}
			
		}

%>
	<div id="container">
	<jsp:include page="AdminHeader.jsp"></jsp:include>
		<div id="content " >
			<div class="page-header">
			
				<div class="container-fluid ">
				  
					<h2 class="col-md-11 col-md-push-1 col-sm-12">Rejected Company </h2>
				</div>
			</div>
			<div class="container-fluid col-md-11 col-md-push-1 col-sm-12">
			
				<div class="row ">
					<div class="col-md-11 col-md-1 col-sm-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Company List</h3>
              </div>
              <div class="panel-body">
                <form action="" method="post" enctype="multipart/form-data" >
                  <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                      <thead>
                        <tr>
                          <td class="text-center"> Name </td>
                          <td class="text-center"> Address </td>
                          <td class="text-center"> City </td>
                          <td class="text-center"> State </td>
                          <td class="text-center"> Email </td>
                          <td class="text-center"> Contect </td>
                          <td class="text-center"> Description </td>
                          <td class="text-center"> Size </td>
                          <td class="text-center"> Skill </td>
                          <td class="text-center"> Action </td>
                        </tr>
                      </thead>
                      <tbody>
                            <%
            for(List<String> a:rs1)
            {
            		%>
                    <tr>
                        <td class="text-center"><%= a.get(0) %></td>
                        <td class="text-center"><%= a.get(1) %></td>
                        <td class="text-center"><%= a.get(2) %></td>
                        <td class="text-center"><%= a.get(3) %></td>
                        <td class="text-center"><%= a.get(4) %></td>
                        <td class="text-center"><%= a.get(5) %></td>
                        <td class="text-center"><%= a.get(6) %></td>
                        <td class="text-center"><%= a.get(7) %></td>
                        <td class="text-center">
                        <%
	                        String[] sk1 = a.get(8).split(",");
                    		List<List<String>> rs3=Admin.getCheckLanguageRecords(a.get(8).toString());
     for(List<String> b:rs3)
    {
		    out.print(b.get(1)+",");
    }
	                    	
	                    	 %>
	                    	 </td>
                        <td class="text-center"><a class="btn btn-primary" href="RejectCompany.jsp?status=A&id=<%=a.get(10) %>">Active</a>  <a class="btn btn-primary" href="RejectCompany.jsp?status=P&id=<%=a.get(10) %>">Under Approve</a></td>
                      </tr>
                    <%
                    
            	
            }

                %>
                        
                              
                           
                        <?php 
                        ?>
                      </tbody>
                    </table>

                    
                  </div>
                </form>
                    <ul class='pagination'>
                    <%ques++; %>
                    </ul>
                                    	<form class="pagination">
            <input type="hidden" name="iPageNo" value="<%=iPageNo%>">
            <input type="hidden" name="cPageNo" value="<%=cPageNo%>">
            <input type="hidden" name="showRows" value="<%=showRows%>">
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

             <li class='page-item pagination'><span id="previous"><a href="RejectCompany.jsp?iPageNo=<%=prePageNo%>&cPageNo=<%=prePageNo%>" class="numbersFont">Previous</a></span></li>
            <%
                }
                for (i = ((cPage * totalRecords) - (totalRecords - 1)); i <= (cPage * totalRecords); i++) {
                    if (i == ((iPageNo / showRows) + 1)) {%>
             <li class='page-item pagination'><span class="numbers"><a href="RejectCompany.jsp?iPageNo=<%=i%>" class="numbersFont"class="numbersFont"><%=i%></a></span></li>
                <%
                } else if (i <= totalPages) {
                %>
             <li class='page-item pagination'><span class="numbers"><a href="RejectCompany.jsp?iPageNo=<%=i%>" class="numbersFont" class="numbersFont"><%=i%></a></span></li>
                <%
                        }
                    }
                    if (totalPages > totalRecords && i < totalPages) {
                %>
             <li class='page-item '><span id="next"><a href="RejectCompany.jsp?iPageNo=<%=i%>&cPageNo=<%=i%>" class="numbersFont">Next</a></span></li>
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