<%@page import="javax.servlet.annotation.MultipartConfig"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

</head>

<body>

<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
	<%@ page import="javax.servlet.http.*"%>
	<%@ page import="org.apache.commons.fileupload.*"%>
	<%@ page import="org.apache.commons.fileupload.disk.*"%>
	<%@ page import="org.apache.commons.fileupload.servlet.*"%>
	<%@ page import="org.apache.commons.io.output.*"%>
	
	<%
String fs=null;	
File file ;
int maxFileSize = 5000 * 1024;
int maxMemSize = 5000 * 1024;
String filePath = "E:\\Placement\\documents";
String contentType = request.getContentType();
if ((contentType.indexOf("multipart/form-data") >= 0)) 
{
DiskFileItemFactory factory = new DiskFileItemFactory();
factory.setSizeThreshold(maxMemSize);
factory.setRepository(new File("E:\\Placement\\documents"));
ServletFileUpload upload = new ServletFileUpload(factory);
upload.setSizeMax( maxFileSize );
	try{
	List fileItems = upload.parseRequest(request);
	Iterator i = fileItems.iterator();
	while ( i.hasNext () )
	{
	FileItem fi = (FileItem)i.next();
	if ( !fi.isFormField () ) {
	String fieldName = fi.getFieldName();
	String fileName = fi.getName();
	boolean isInMemory = fi.isInMemory();
	long sizeInBytes = fi.getSize();
	file = new File( filePath + fileName ) ;
	fi.write( file ) ;
	
	fs=fileName;
	}
	}
	}catch(Exception ex) {
	System.out.println(ex);
	}
	
}else{
out.println("Error in file upload.");
}
%>

<form  action="" method="post" >
	<input type="hidden" id="n" name="n" value="">
	<input type="hidden" id="f" name="f" value="<%=fs %>">
	 
	</form>
</body>
</html>
<script type="text/javascript">
var a=localStorage.getItem("t");

document.getElementById("n").value = localStorage.getItem("t"); 
document.forms[0].action="DocumentDB.jsp";
document.forms[0].submit();
</script>