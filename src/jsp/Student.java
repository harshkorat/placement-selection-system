package jsp;


import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Student {
	public static List<List<String>> getRecords(int start,int total){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"select * from tbl_document where DocumentStatus='A' limit "+(start)+","+total);
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			 
			while (rs.next()) {              
				List<String> lis = new ArrayList<String>(columnCount);
				lis.add(String.valueOf(rs.getInt("DocumentId")));
			   lis.add(rs.getString("DocumentTitle"));
			   lis.add(rs.getString("DocumentFile"));
			   
			   ResultList.add(lis);
			   
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static List<List<String>> foundRow(){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT count(*) as cnt from tbl_document where DocumentStatus='A'");
			ResultSet rs=ps.executeQuery();
			 
			while (rs.next()) {
				List<String> lis = new ArrayList<String>();
			   lis.add(String.valueOf(rs.getInt("cnt")));
			   ResultList.add(lis);
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static int interviewRequest(int sender,int receiver) {
		int row=0;
		try (Connection con=ConnectionDb.connect();
	            PreparedStatement preparedStatement = con
	            .prepareStatement("INSERT INTO tbl_interviwe(StudentId,CompanyId) values (?,?)")) {

	            preparedStatement.setInt(1, sender);
	            preparedStatement.setInt(2, receiver);;
	            row = preparedStatement.executeUpdate();
	        
		}catch(Exception e){
			e.printStackTrace();
		}
		return row;
	}
	public static String countInterviweReqestPending(int id){
		String query="select count(*) as countReq from tbl_interviwe where RequestStatus='P' and StudentId='"+id+"'";
		String count=null;
		
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				count=rs.getString("countReq");
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return count;
	}
	public static String getNotificationSenderName(int id){
		String query="select UserType from tbl_user_master where UserId=?";
		String name=null;
		
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				String type=rs.getString("UserType");
				if(type.equals("C"))
				{
					ps=con.prepareStatement("select CompanyName from tbl_company where UserId=?");
					ps.setInt(1, id);
					rs=ps.executeQuery();
					if(rs.next()){
						name=rs.getString("CompanyName");
					}
				}else if(type.equals("S"))
				{
					ps=con.prepareStatement("select StudentName from tbl_student where UserId=?");
					ps.setInt(1, id);
					rs=ps.executeQuery();
					if(rs.next()){
						name=rs.getString("StudentName");
					}
					
				}else if(type.equals("A"))
				{
					name="Admin";
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return name;
	}
	public static int notification(int sender,int reciver,String des) {
		int row=0;
		try (Connection con=ConnectionDb.connect();
				PreparedStatement preparedStatement=con.prepareStatement("INSERT INTO tbl_notification(Sender,Receiver,Description) values(?,?,?)")){
				preparedStatement.setInt(1,sender);
				preparedStatement.setInt(2, reciver);
				preparedStatement.setString(3, des);
	            row = preparedStatement.executeUpdate();
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return row;
	}
	public static List<List<String>> getCompanyRecords(int id,int start,int total){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		List<List<String>> rs3=getStudentRecords(id);
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"SELECT tbl_company.UserId,tbl_company.CompanyName,tbl_company.CompanyAddress,tbl_company.City,tbl_company.State,tbl_company.CompanyDescription,tbl_company.CompanyContectNo,tbl_company.CompanySize,tbl_company.Skills,tbl_user_master.UserEmailId FROM tbl_company,tbl_user_master WHERE tbl_user_master.UserId=tbl_company.UserId and tbl_user_master.UserStatus='A' and tbl_user_master.UserType='C' limit "+(start)+","+total);
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			 
			while (rs.next()) {              
				String[] sk1=null;
	        	String[] sk2=null;
	        	for(List<String> b:rs3)
	            {
	            	sk1 = b.get(7).split(",");
	            	sk2 = rs.getString("Skills").split(",");
	            }
	        	int row=Student.checkInterviewCompany(id, rs.getInt("UserId"));
	        	if(row==0)
	        	{
		        	row=Student.checkSkill(sk2, sk1);
	            	if(row==1)
	            	{
						List<String> lis = new ArrayList<String>(columnCount);
						lis.add(String.valueOf(rs.getInt("UserId")));
					   lis.add(rs.getString("CompanyName"));
					   lis.add(rs.getString("CompanyAddress"));
					   lis.add(rs.getString("City"));
					   lis.add(rs.getString("State"));
					   lis.add(rs.getString("CompanyDescription"));
					   lis.add(rs.getString("CompanyContectNo"));
					   lis.add(rs.getString("Skills"));
					   lis.add(rs.getString("UserEmailId"));
					   lis.add(String.valueOf(rs.getInt("CompanySize")));
					   
					   ResultList.add(lis);
	            	}
	        	}
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static List<List<String>> foundCompanyRow(int id){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		List<List<String>> rs3=getStudentRecords(id);
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT tbl_company.Skills FROM tbl_company,tbl_user_master WHERE tbl_user_master.UserId=tbl_company.UserId and tbl_user_master.UserStatus='A' and tbl_user_master.UserType='C'");
			ResultSet rs=ps.executeQuery();
			 
			while (rs.next()) {
				String[] sk1=null;
	        	String[] sk2=null;
	        	for(List<String> b:rs3)
	            {
	            	sk1 = b.get(7).split(",");
	            	sk2 = rs.getString("Skills").split(",");
	            }
	        	int row=Student.checkInterviewCompany(id, rs.getInt("UserId"));
	        	if(row==0)
	        	{
		        	row=Student.checkSkill(sk2, sk1);
		        	int count=0;
	            	if(row==1)
	            	{
	            		count++;
	            	}
	            	List<String> lis = new ArrayList<String>();
				   lis.add(String.valueOf(count));
				   ResultList.add(lis);
	        	}
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static List<List<String>> getStudNotifications(int id){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT tbl_notification.Sender,tbl_notification.Description,tbl_notification.NotificationDate FROM tbl_notification WHERE tbl_notification.Receiver=? and tbl_notification.NotificationStatus='A' ORDER BY tbl_notification.NotificationDate DESC");
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			 
			while (rs.next()) {              
						List<String> lis = new ArrayList<String>(columnCount);
						lis.add(String.valueOf(rs.getInt("Sender")));
					   lis.add(rs.getString("Description"));
					   lis.add(String.valueOf(rs.getDate("NotificationDate")));
					   		   ResultList.add(lis);
	    	}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static List<List<String>> getInterviewReqRecords(int id,int start,int total){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"SELECT tbl_company.UserId,tbl_company.CompanyName,tbl_company.CompanyAddress,tbl_company.City,tbl_company.State,tbl_company.CompanyDescription,tbl_company.CompanyContectNo,tbl_company.CompanySize,tbl_company.Skills,tbl_user_master.UserEmailId,tbl_interviwe.RequestDate FROM tbl_company,tbl_user_master,tbl_interviwe WHERE tbl_interviwe.CompanyId=tbl_company.UserId and tbl_user_master.UserId=tbl_company.UserId  and tbl_interviwe.RequestStatus='P' and tbl_interviwe.StudentId='"+id+"' and  tbl_user_master.UserType='C' limit "+(start)+","+total);
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			 
			while (rs.next()) {              
						List<String> lis = new ArrayList<String>(columnCount);
						lis.add(String.valueOf(rs.getInt("UserId")));
					   lis.add(rs.getString("CompanyName"));
					   lis.add(rs.getString("CompanyAddress"));
					   lis.add(rs.getString("City"));
					   lis.add(rs.getString("State"));
					   lis.add(rs.getString("CompanyDescription"));
					   lis.add(rs.getString("CompanyContectNo"));
					   lis.add(rs.getString("Skills"));
					   lis.add(rs.getString("UserEmailId"));
					   lis.add(String.valueOf(rs.getInt("CompanySize")));
					   lis.add(String.valueOf(rs.getDate("RequestDate")));
					   ResultList.add(lis);
	    	}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static List<List<String>> foundInterviewReqRow(int id){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT count(*) as cnt FROM tbl_company,tbl_user_master,tbl_interviwe WHERE tbl_interviwe.CompanyId=tbl_company.UserId and tbl_user_master.UserId=tbl_company.UserId  and tbl_interviwe.RequestStatus='P' and tbl_interviwe.StudentId='"+id+"' and  tbl_user_master.UserType='C'");
			ResultSet rs=ps.executeQuery();
			 
			while (rs.next()) {
				List<String> lis = new ArrayList<String>();
				   lis.add(rs.getString("cnt"));
				   ResultList.add(lis);
	        	
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static int checkSkill(String[] c,String[] s)
	{
		int row=0;
		for(String sskill:s)
		{
			for(String cskill:c)
			{
				if(sskill.equals(cskill))
				{
					row=1;
				}
			}
		}
		return row;
	}
	public static int profile(String email, String pass,int id) {
        int row = 0;
        try {
        	

            if(pass.equals("A"))
            {
            	Connection con=ConnectionDb.connect();
                
                PreparedStatement preparedStatement = con
                .prepareStatement("update tbl_user_master set UserEmailId=? where UserId=?");
                preparedStatement.setString(1, email);
                preparedStatement.setInt(2, id);
                row = preparedStatement.executeUpdate();
            }
            else
            {
            	Connection con=ConnectionDb.connect();
                
                PreparedStatement preparedStatement = con
                .prepareStatement("update tbl_user_master set UserEmailId=?,Password=md5(?) where UserId=?");
                preparedStatement.setString(1, email);
                preparedStatement.setString(2, pass);
                preparedStatement.setInt(3, id);
                row = preparedStatement.executeUpdate();
            }


        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
	public static List<List<String>> getCheckLanguageRecords(String ids){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"select * from tbl_language where LanguageId in ("+ids+")  order by LanguageName ");
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			 
			while (rs.next()) {              
				List<String> lis = new ArrayList<String>(columnCount);
				lis.add(String.valueOf(rs.getInt("LanguageId")));
			   lis.add(rs.getString("LanguageName"));
			   
			   
			   ResultList.add(lis);
			   
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	
	public static List<List<String>> getNotCheckLanguageRecords(String ids){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"select * from tbl_language where LanguageId not in ("+ids+")  order by LanguageName ");
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			 
			while (rs.next()) {              
				List<String> lis = new ArrayList<String>(columnCount);
				lis.add(String.valueOf(rs.getInt("LanguageId")));
			   lis.add(rs.getString("LanguageName"));
			   
			   
			   ResultList.add(lis);
			   
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static int checkInterviewCompany(int id,int cid) {
		int row=0;
		try{Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT InterviweId from tbl_interviwe where StudentId=? and CompanyId=? and RequestStatus!='R'");
			ps.setInt(1, id);
			ps.setInt(2, cid);
            
			ResultSet rs=ps.executeQuery();
			 
			if (rs.next()) {
				 row=(rs.getInt("InterviweId"));
				
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return row;
	}
	public static List<List<String>> getStudentRecords(int id){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"select * from tbl_student where UserId=?");
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			while (rs.next()) {              
				List<String> lis = new ArrayList<String>(columnCount);
				
			   lis.add(rs.getString("StudentName"));
			   lis.add(rs.getString("StudentAddress"));
			   lis.add(rs.getString("StudentCity"));
			   lis.add(rs.getString("StudentState"));
			   lis.add(rs.getString("StudentContect"));
			   lis.add(rs.getString("StudentDegree"));
			   lis.add(String.valueOf(Float.parseFloat(rs.getString("StudentCgpa"))));
			   lis.add(rs.getString("StudentSkill"));
			   lis.add(String.valueOf(rs.getInt("StudentId")));
				lis.add(String.valueOf(rs.getInt("UserId")));
			   
			   
			   ResultList.add(lis);
			   
			}

			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static int profileStudent(String name,String address,String city,String state,String contect,String degree,float cgpa,String skill,int id) {
        int row = 0;
        

        try (Connection con=ConnectionDb.connect();
					PreparedStatement pst=con.prepareStatement("update tbl_student set StudentName=?,StudentAddress=?,StudentCity=?,StudentState=?,StudentContect=?,StudentDegree=?,StudentCgpa=?,StudentSkill=? where UserId=?")) {

		            
		            pst.setString(1, name);
		            pst.setString(2, address);
		            pst.setString(3, city);
		            pst.setString(4, state);
		            pst.setString(5, contect);
		            pst.setString(6, degree);
		            pst.setFloat(7, cgpa);
		            pst.setString(8, skill);
		            pst.setInt(9, id);
		            row = pst.executeUpdate();
		        
        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
}
