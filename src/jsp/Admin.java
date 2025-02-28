package jsp;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Part;

public class Admin {
	public static String countStudent(){
		String query="select count(*) as countStudent from tbl_user_master where UserType='S' and UserStatus='A'";
		String count=null;
		
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				count=rs.getString("countStudent");
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return count;
	}
	
	public static String countActiveCompany(){
		String query="select count(*) as countCompany from tbl_user_master where UserType='C' and UserStatus='A'";
		String count=null;
		
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				count=rs.getString("countCompany");
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return count;
	}
	
	public static String countPendingCompany(){
		String query="select count(*) as countCompany from tbl_user_master where UserType='C' and UserStatus='P'";
		String count=null;
		
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				count=rs.getString("countCompany");
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return count;
	}
	
	public static String countRejectedCompany(){
		String query="select count(*) as countCompany from tbl_user_master where UserType='C' and UserStatus='R'";
		String count=null;
		
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				count=rs.getString("countCompany");
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return count;
	}
	
	
	public static List<List<String>> getstudentRecords(int start,int total){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"select * from tbl_user_master,tbl_student where tbl_user_master.UserId=tbl_student.UserId and tbl_user_master.UserType='S' and tbl_user_master.UserStatus='A'   limit "+(start)+","+total);
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			 
			while (rs.next()) {              
				List<String> lis = new ArrayList<String>(columnCount);
				
			   lis.add(rs.getString("StudentName"));
			   lis.add(rs.getString("StudentAddress"));
			   lis.add(rs.getString("StudentCity"));
			   lis.add(rs.getString("StudentState"));
			   lis.add(rs.getString("UserEmailId"));
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
	public static List<List<String>> studentfoundRow(){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT count(*) as cnt from tbl_user_master,tbl_student where tbl_user_master.UserId=tbl_student.UserId and tbl_user_master.UserType='S' and tbl_user_master.UserStatus='A' ");
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
	public static List<List<String>> getcompanyRecords(String type,int start,int total){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"select * from tbl_user_master,tbl_company where tbl_user_master.UserId=tbl_company.UserId and tbl_user_master.UserType='C' and tbl_user_master.UserStatus='"+type+"'   limit "+(start)+","+total);
			ResultSet rs=ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData(); 
			int columnCount = rsmd.getColumnCount();

			 
			while (rs.next()) {              
				List<String> lis = new ArrayList<String>(columnCount);
				
			   lis.add(rs.getString("CompanyName"));
			   lis.add(rs.getString("CompanyAddress"));
			   lis.add(rs.getString("City"));
			   lis.add(rs.getString("State"));
			   lis.add(rs.getString("UserEmailId"));
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
	public static List<List<String>> companyfoundRow(String type){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT count(*) as cnt from tbl_user_master,tbl_company where tbl_user_master.UserId=tbl_company.UserId and tbl_user_master.UserType='C' and tbl_user_master.UserStatus='"+type+"' ");
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

            

            // sends the statement to the database server
            

        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
	
	public static int uploadFile(String title, String file) {
        int row = 0;
        

        try (Connection con=ConnectionDb.connect();
            // Step 2:Create a statement using connection object
            PreparedStatement preparedStatement = con
            .prepareStatement("INSERT INTO tbl_document (DocumentTitle,DocumentFile) values (?, ?)")) {
            
            preparedStatement.setString(1, title);
            preparedStatement.setString(2, file);

            // sends the statement to the database server
            row = preparedStatement.executeUpdate();

        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
	public static int deleteFile(String id) {
        int row = 0;
        

        try (Connection con=ConnectionDb.connect();
            // Step 2:Create a statement using connection object
            PreparedStatement preparedStatement = con
            .prepareStatement("update tbl_document set DocumentStatus='D' where DocumentId=?")) {

            preparedStatement.setInt(1,Integer.parseInt(id) );

            // sends the statement to the database server
            row = preparedStatement.executeUpdate();

        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
	public static int companyStatus(String stutus,String id) {
        int row = 0;
        

        try (Connection con=ConnectionDb.connect();
            // Step 2:Create a statement using connection object
            PreparedStatement preparedStatement = con
            .prepareStatement("update tbl_user_master set UserStatus=? where UserId=?")) {
        	preparedStatement.setString(1,stutus);
            preparedStatement.setInt(2,Integer.parseInt(id) );

            // sends the statement to the database server
            row = preparedStatement.executeUpdate();

        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
	
	public static int deleteLanguage(String id) {
        int row = 0;
        

        try (Connection con=ConnectionDb.connect();
            // Step 2:Create a statement using connection object
            PreparedStatement preparedStatement = con
            .prepareStatement("update tbl_language set LanguageStatus='D' where LanguageId=?")) {

            preparedStatement.setInt(1,Integer.parseInt(id) );

            // sends the statement to the database server
            row = preparedStatement.executeUpdate();

        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
	
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
	
	public static List<List<String>> getLanguageRecords(int start,int total){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"select * from tbl_language where LanguageStatus='A'  order by LanguageName limit "+(start)+","+total);
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
	
	public static List<List<String>> getAllLanguageRecords(){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement(  
					"select * from tbl_language where LanguageStatus='A'  order by LanguageName ");
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
	public static List<List<String>> foundLanguageRow(){
		List<List<String>> ResultList=new ArrayList<List<String>>();
		try{
			Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT count(*) as cnt from tbl_language where LanguageStatus='A' order by LanguageName");
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
	public static int addLanguage(String name) {
        int row = 0;
        

        try (Connection con=ConnectionDb.connect();
            // Step 2:Create a statement using connection object
            PreparedStatement preparedStatement = con
            .prepareStatement("INSERT INTO tbl_language (LanguageName) values (?)")) {

            preparedStatement.setString(1, name);

            // sends the statement to the database server
            row = preparedStatement.executeUpdate();

        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
	public static int getUserId(String email,String password,String type) {
		int id=0;
		try{Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT UserId from tbl_user_master where UserType=? and UserEmailId=? and Password=md5(?) and UserStatus='A'");
			ps.setString(1, type);
			ps.setString(2, email);
            ps.setString(3, password);
			ResultSet rs=ps.executeQuery();
			 
			if (rs.next()) {
				 id=(rs.getInt("UserId"));
				
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return id;
	}
	public static int getCompantUserId(String email,String password,String type) {
		int id=0;
		try{Connection con=ConnectionDb.connect();
			PreparedStatement ps=con.prepareStatement("SELECT UserId from tbl_user_master where UserType=? and UserEmailId=? and Password=md5(?) and UserStatus='P'");
			ps.setString(1, type);
			ps.setString(2, email);
            ps.setString(3, password);
			ResultSet rs=ps.executeQuery();
			 
			if (rs.next()) {
				 id=(rs.getInt("UserId"));
				
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return id;
	}
	public static int addUser(String email,String password,String type) {
		int row=0;
		try (Connection con=ConnectionDb.connect();
	            PreparedStatement preparedStatement = con
	            .prepareStatement("INSERT INTO tbl_user_master(UserEmailId,Password,UserType) values (?,md5(?),?)")) {

	            preparedStatement.setString(1, email);
	            preparedStatement.setString(2, password);
	            preparedStatement.setString(3, type);
	            row = preparedStatement.executeUpdate();
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return row;
	}
	public static int addCompanyUser(String email,String password,String type) {
		int row=0;
		try (Connection con=ConnectionDb.connect();
	            PreparedStatement preparedStatement = con
	            .prepareStatement("INSERT INTO tbl_user_master(UserEmailId,Password,UserType,UserStatus) values (?,md5(?),?,?)")) {

	            preparedStatement.setString(1, email);
	            preparedStatement.setString(2, password);
	            preparedStatement.setString(3, type);
	            preparedStatement.setString(4, "P");
	            row = preparedStatement.executeUpdate();
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return row;
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
	public static int addStudent(String name,String address,String city,String state,String email,String contect,String degree,float cgpa,String password,String skill,int id) {
        int row = 0;
        

        try (Connection con=ConnectionDb.connect();
					PreparedStatement pst=con.prepareStatement("INSERT INTO tbl_student(UserId,StudentName,StudentAddress,StudentCity,StudentState,StudentContect,StudentDegree,StudentCgpa,StudentSkill) values (?,?,?,?,?,?,?,?,?)")) {

		            pst.setInt(1, id);
		            pst.setString(2, name);
		            pst.setString(3, address);
		            pst.setString(4, city);
		            pst.setString(5, state);
		            pst.setString(6, contect);
		            pst.setString(7, degree);
		            pst.setFloat(8, cgpa);
		            pst.setString(9, skill);
		            
		            row = pst.executeUpdate();
		        
        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
	
	public static int addCompany(String name,String address,String city,String state,String email,String contect,String des,int size,String password,String skill,int id) {
        int row = 0;
        

        try (Connection con=ConnectionDb.connect();
					PreparedStatement pst=con.prepareStatement("INSERT INTO tbl_company(UserId,CompanyName,CompanyAddress,City,State,CompanyDescription,CompanyContectNo,CompanySize,Skills) values (?,?,?,?,?,?,?,?,?)")) {

		            pst.setInt(1, id);
		            pst.setString(2, name);
		            pst.setString(3, address);
		            pst.setString(4, city);
		            pst.setString(5, state);
		            pst.setString(6, des);
		            pst.setString(7, contect);
		            pst.setInt(8, size);
		            pst.setString(9, skill);
		            
		            row = pst.executeUpdate();
		        
        } catch (Exception e) {
            // process sql exception
            System.out.print(e);
        }
        return row;
    }
}
