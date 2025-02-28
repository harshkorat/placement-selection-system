package jsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;

public class Company {
	public static String countInterviweReqestPending(int id){
		String query="select count(*) as countReq from tbl_interviwe where RequestStatus='P'  and CompanyId='"+id+"'";
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
	public static String countInterviweReqestAccepted(int id){
		String query="select count(*) as countReq from tbl_interviwe where RequestStatus='A' and CompanyId='"+id+"'";
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
	public static List<List<String>> getStudentAcceptedRecords(int id,int start,int total){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"SELECT tbl_interviwe.InterviweId,tbl_interviwe.StudentId,tbl_interviwe.RequestDate,tbl_student.StudentName,tbl_student.StudentAddress,tbl_student.StudentCity,tbl_student.StudentState,tbl_student.StudentContect,tbl_student.StudentDegree,tbl_student.StudentCgpa,tbl_student.StudentSkill,tbl_user_master.UserEmailId FROM tbl_interviwe,tbl_student,tbl_user_master WHERE tbl_interviwe.StudentId=tbl_student.UserId AND tbl_interviwe.StudentId=tbl_user_master.UserId AND tbl_interviwe.RequestStatus='A' and tbl_interviwe.CompanyId=? limit "+(start)+","+total);
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			 
			while (rs.next()) {              
						List<String> lis = new ArrayList<String>(columnCount);
						lis.add(String.valueOf(rs.getInt("StudentId")));
					   lis.add(rs.getString("StudentName"));
					   lis.add(rs.getString("StudentAddress"));
					   lis.add(rs.getString("StudentCity"));
					   lis.add(rs.getString("StudentState"));
					   lis.add(rs.getString("StudentDegree"));
					   lis.add(rs.getString("StudentContect"));
					   lis.add(rs.getString("UserEmailId"));
					   lis.add(String.valueOf(rs.getFloat("StudentCgpa")));
					   lis.add(rs.getString("StudentSkill"));
					   lis.add(String.valueOf(rs.getDate("RequestDate")));
					   lis.add(String.valueOf(rs.getInt("InterviweId")));
					   
					   ResultList.add(lis);
	    	}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static List<List<String>> getCompanyRecords(int id){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"select * from tbl_company where UserId=?");
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			while (rs.next()) {              
				List<String> lis = new ArrayList<String>(columnCount);
				
			   lis.add(rs.getString("CompanyName"));
			   lis.add(rs.getString("CompanyAddress"));
			   lis.add(rs.getString("City"));
			   lis.add(rs.getString("State"));
			   lis.add(rs.getString("CompanyContectNo"));
			   lis.add(rs.getString("CompanyDescription"));
			   lis.add(String.valueOf(Integer.parseInt(rs.getString("CompanySize"))));
			   lis.add(rs.getString("Skills"));
			   lis.add(String.valueOf(rs.getInt("CompanyId")));
				lis.add(String.valueOf(rs.getInt("UserId")));
			   
			   
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
	
	public static int profileCompany(String name,String address,String city,String state,String contect,String des,int size,String skill,int id)
	{
		int row = 0;
    	try (Connection con=ConnectionDb.connect();
				PreparedStatement pst=con.prepareStatement("update tbl_company set CompanyName=?,CompanyAddress=?,City=?,State=?,CompanyContectNo=?,CompanyDescription=?,CompanySize=?,Skills=? where UserId=?")) {

	            
	            pst.setString(1, name);
	            pst.setString(2, address);
	            pst.setString(3, city);
	            pst.setString(4, state);
	            pst.setString(5, contect);
	            pst.setString(6, des);
	            pst.setInt(7, size);
	            pst.setString(8, skill);
	            pst.setInt(9, id);
	            row = pst.executeUpdate();
	        
    } catch (Exception e) {
        // process sql exception
        System.out.print(e);
    }
    return row;    }

	public static List<List<String>> foundStudentAcceptedRow(int id){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT count(*) as cnt FROM tbl_interviwe,tbl_student,tbl_user_master WHERE tbl_interviwe.StudentId=tbl_student.UserId AND tbl_interviwe.StudentId=tbl_user_master.UserId AND tbl_interviwe.RequestStatus='A' and tbl_interviwe.CompanyId=?");
			ps.setInt(1, id);
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
	public static int updateInterview(String status,int id) {
        int row = 0;
        

        try (Connection con=ConnectionDb.connect();
            // Step 2:Create a statement using connection object
            PreparedStatement preparedStatement = con
            .prepareStatement("update tbl_interviwe set RequestStatus=? where InterviweId=?")) {
        	preparedStatement.setString(1,status);
            preparedStatement.setInt(2,id);

            // sends the statement to the database server
            row = preparedStatement.executeUpdate();

        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
	
	public static List<List<String>> getStudentPendingRecords(int id,int start,int total){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"SELECT tbl_interviwe.InterviweId,tbl_interviwe.StudentId,tbl_interviwe.RequestDate,tbl_student.StudentName,tbl_student.StudentAddress,tbl_student.StudentCity,tbl_student.StudentState,tbl_student.StudentContect,tbl_student.StudentDegree,tbl_student.StudentCgpa,tbl_student.StudentSkill,tbl_user_master.UserEmailId FROM tbl_interviwe,tbl_student,tbl_user_master WHERE tbl_interviwe.StudentId=tbl_student.UserId AND tbl_interviwe.StudentId=tbl_user_master.UserId AND tbl_interviwe.RequestStatus='P' and tbl_interviwe.CompanyId=? limit "+(start)+","+total);
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			 
			while (rs.next()) {              
						List<String> lis = new ArrayList<String>(columnCount);
						lis.add(String.valueOf(rs.getInt("StudentId")));
					   lis.add(rs.getString("StudentName"));
					   lis.add(rs.getString("StudentAddress"));
					   lis.add(rs.getString("StudentCity"));
					   lis.add(rs.getString("StudentState"));
					   lis.add(rs.getString("StudentDegree"));
					   lis.add(rs.getString("StudentContect"));
					   lis.add(rs.getString("UserEmailId"));
					   lis.add(String.valueOf(rs.getFloat("StudentCgpa")));
					   lis.add(rs.getString("StudentSkill"));
					   lis.add(String.valueOf(rs.getDate("RequestDate")));
					   lis.add(String.valueOf(rs.getInt("InterviweId")));
					   
					   ResultList.add(lis);
	    	}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return ResultList;
		
		
	}
	public static List<List<String>> foundStudentPendingRow(int id){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT count(*) as cnt FROM tbl_interviwe,tbl_student,tbl_user_master WHERE tbl_interviwe.StudentId=tbl_student.UserId AND tbl_interviwe.StudentId=tbl_user_master.UserId AND tbl_interviwe.RequestStatus='P' and tbl_interviwe.CompanyId=?");
			ps.setInt(1, id);
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
}
