package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dto.Receit;

public class ReceitDao {
	
		// 영수증 선택 메서드
		public Receit selectReceitOne(int cashNo) throws Exception {
			Receit receit = new Receit();
			
			// MySQL JDBC 드라이버 로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			// DB 연결을 위한 객체 선언
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			// DB 연결
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
					
			// 쿼리 작성
			String sql = "SELECT cash_no cashNo, filename, createdate FROM receit WHERE cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				receit.setCashNo(rs.getInt("cashNo"));
				receit.setFilename(rs.getString("filename"));
			}
			conn.close();
			return receit;
		}
		
		
		// 영수증 추가 메서드
		public void insertReceit(Receit receit) throws Exception {
			int row = 0;
			
			// MySQL JDBC 드라이버 로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			// DB 연결을 위한 객체 선언
			Connection conn = null;
			PreparedStatement stmt = null;
			// DB 연결
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			
			// 쿼리 작성
			String sql = "INSERT INTO receit(cash_no, filename) VALUES(?,?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, receit.getCashNo());
			stmt.setString(2, receit.getFilename());
			row = stmt.executeUpdate();
			
			if(row == 1) {
				System.out.println("영수증 추가 완료");
			} else {
				System.out.println("영수증 추가 실패");
			}
			
			conn.close();
		}
		
		
		// 영수증 삭제 메서드
		public void deleteReceit(int cashNo) throws Exception {
			int row = 0;
			
			// MySQL JDBC 드라이버 로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			// DB 연결을 위한 객체 선언
			Connection conn = null;
			PreparedStatement stmt = null;
			// DB 연결
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			
			// 쿼리 작성
			String sql = "DELETE FROM receit WHERE cash_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			row = stmt.executeUpdate();
			
			if(row == 1) {
				System.out.println("영수증 삭제 완료");
			} else {
				System.out.println("영수증 삭제 실패");
			}

			conn.close();
		}
}
