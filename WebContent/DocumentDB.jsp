<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedInputStream"%>
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
	response.sendRedirect("index.jsp");
}
if(request.getParameter("del")!=null)
{
	int row=Admin.deleteFile(request.getParameter("del"));
	if(row>0)
	{
		response.sendRedirect("DocumentDisplay.jsp");	
	}
	else
	{
		response.sendRedirect("DocumentDisplay.jsp");
	}	
}
else if(request.getParameter("view")!=null)
{
	
	String filepath = "E:\\Placement\\documents"+request.getParameter("view")+".pdf";
	out.print(filepath);
	File file = new File(filepath);
	 
    ServletOutputStream stream = null;
    BufferedInputStream buf = null;
    try {
        stream = response.getOutputStream();
        // set response headers
        response.setContentType("application/pdf");
        response.setDateHeader("Expires", 0);
        response.addHeader("Content-Disposition",
                "inline; filename=dwg.pdf");
        response.setContentLength((int) file.length());
        buf = new BufferedInputStream(new FileInputStream(file));
        int readBytes = 0;
        while ((readBytes = buf.read()) != -1)
            stream.write(readBytes);
    } finally {
        if (stream != null)
            stream.flush();
        stream.close();
        if (buf != null)
            buf.close();
    }

}
else
{
	int row=Admin.uploadFile(request.getParameter("n"), request.getParameter("f"));
	if(row>0)
	{
		response.sendRedirect("DocumentDisplay.jsp");	
	}
	else
	{
		response.sendRedirect("AddDocument.jsp");
	}
}
%>
</body>
</html>