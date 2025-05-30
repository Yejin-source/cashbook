package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Admin;

public class AdminDao {
	
	/*
		[반환 타입]
		int: 영향을 받은 행의 수 등을 반환할 때 사용
		DTO 객체(Admin): 데이터베이스에서 조회된 정보를 반환할 때 사용
		void: 반환 값이 필요하지 않고, 작업만 수행할 때 사용
		
		[매개변수]
		DTO 객체 or HashMap: 여러 개의 관련된 데이터를 묶어서 전달할 때 사용
		단일 데이터만 필요한 경우: 해당 데이터를 직접 매개변수로 전달 (ex. String id, String pw)
	*/
	
	// 로그인 메서드
	public Admin loginAdminPw(String id, String pw) throws ClassNotFoundException, SQLException {
		Admin admin = new Admin(); // admin 객체가 미리 생성되게 수정
		
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 로그인 쿼리 작성
		String sql = "SELECT admin_id adminId, admin_pw adminPw FROM admin WHERE admin_id = ? AND admin_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		System.out.println("AdminDao.java loginAdminPw_stmt: " + stmt); // 쿼리 디버깅
		rs = stmt.executeQuery(); // 쿼리 실행
		
		// 로그인 성공 시 Admin 객체 생성
		if(rs.next()) {
			admin.setId(rs.getString("adminId")); // adminId 값을 Admin 객체에 저장
			admin.setPw(rs.getString("adminPw")); // adminPw 값을 Admin 객체에 저장
			System.out.println("로그인 성공");
		} else {
			System.out.println("로그인 실패");
		}
		
		conn.close(); // 연결 해제
		return admin; // 로그인 성공 시 admin 객체 반환
	}
	
	
	// 비밀번호 수정 메서드
	public int updateAdminPw(String id, String pw, String newPw) throws ClassNotFoundException, SQLException {			
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		// 로그인 쿼리 작성
		String sql = "UPDATE admin SET admin_pw = ? WHERE admin_id = ? AND admin_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, id);
		stmt.setString(3, pw);
		System.out.println("AdminDao.java updateAdminPw_stmt: " + stmt); // 쿼리 디버깅
		
		int row = stmt.executeUpdate(); // 쿼리 실행
		if(row == 1) {
			System.out.println("비밀번호 변경 성공");
		} else {
			System.out.println("비밀번호 변경 실패");
		}
		conn.close(); // 연결 해제
		return row;
	}
	
}
