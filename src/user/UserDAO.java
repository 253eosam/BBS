package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;

public class UserDAO {

		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;
		
		public UserDAO() {
			try {
				String dbURL = "jdbc:mysql://121.151.244.47:3306/BBS";
				String dbID = "dddLs";
				String dbPassword = "1234";
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		public int login(String userID, String userPassword) {
			String SQL = "SELECT userPassword FROM USER WHERE userID=?";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,userID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					if(rs.getString(1).equals(userPassword)) {
						if(userID.equals("admin"))
							return 2;	//관리자 로그인
						return 1;	//로그인 성공
					}
					else
						return 0;	//비밀번호 불일치
				}
				return -1;	//아이디가 없음
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -2;	//데이터베이스 오류
		}
		
		public int join(User user) {
			String SQL = "INSERT INTO USER VALUES (?,?,?,?,?)";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user.getUserID());
				pstmt.setString(2, user.getUserPassword());
				pstmt.setString(3, user.getUserName());
				pstmt.setString(4, user.getUserGender());
				pstmt.setString(5, user.getUserEmail());
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		public ArrayList<User> getList(){
			String SQL = "SELECT userID, userName, userGender, userEmail FROM USER";
			ArrayList<User> list = new ArrayList<User>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					User user = new User();
					user.setUserID(rs.getString(1));
					user.setUserPassword("***********************");
					user.setUserName(rs.getString(2));
					user.setUserGender(rs.getString(3));
					user.setUserEmail(rs.getString(4));
					list.add(user);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list;
		}
		
		public int delete(String userID) {
			String SQL = "DELETE FROM USER WHERE userID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				return pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
}
