package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class StatsDao {
	
	// 전체 수입/지출 총액
	public ArrayList<HashMap<String, Object>> totalStatsByKind() throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
				
		// 쿼리 작성
		String sql = "SELECT kind, COUNT(*) cnt, SUM(amount) sum FROM category ct INNER JOIN cash cs"
				+ " ON ct.category_no = cs.category_no GROUP BY ct.kind";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("kind", rs.getString("kind"));
			map.put("cnt", rs.getInt("cnt"));
			map.put("sum", rs.getInt("sum"));
			list.add(map);
		}
		conn.close();
		return list;
	}
	
	
	// 연도별 수입/지출 총액
	public ArrayList<HashMap<String, Object>> yearStatsByKind(int year) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 쿼리 작성
		String sql = "SELECT YEAR(cash_date) year, kind, COUNT(*) cnt, SUM(amount) sum"
				+ " FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no"
				+ " WHERE YEAR(cash_date) = ? GROUP BY YEAR(cash_date), ct.kind ORDER BY YEAR(cash_date)";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("year", rs.getString("year"));
			map.put("kind", rs.getString("kind"));
			map.put("cnt", rs.getInt("cnt"));
			map.put("sum", rs.getInt("sum"));
			list.add(map);
		}
		conn.close();
		return list;
	}
	
	
	// 월별 수입/지출 총액
	public ArrayList<HashMap<String, Object>> monthStatsByKind(int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 쿼리 작성
		String sql = "SELECT MONTH(cash_date) month, kind, COUNT(*) cnt, SUM(amount) sum FROM category ct"
				+ " INNER JOIN cash cs ON ct.category_no = cs.category_no WHERE MONTH(cash_date) = ?"
				+ " GROUP BY MONTH(cash_date), ct.kind ORDER BY MONTH(cash_date)";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, month);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("month", rs.getString("month"));
			map.put("kind", rs.getString("kind"));
			map.put("cnt", rs.getInt("cnt"));
			map.put("sum", rs.getInt("sum"));
			list.add(map);
		}
		conn.close();
		return list;
	}
	
	
	// 특정년도의 월별 수입/지출 총액
	public ArrayList<HashMap<String, Object>> targetYearStatsByKind(int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 쿼리 작성
		String sql = "SELECT MONTH(cash_date) month, kind, COUNT(*) cnt, SUM(amount) sum"
				+ " FROM category ct INNER JOIN cash cs ON ct.category_no = cs.category_no"
				+ " WHERE YEAR(cash_date) = ? AND MONTH(cash_date) = ?"
				+ " GROUP BY MONTH(cash_date), ct.kind ORDER BY MONTH(cash_date)";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("month", rs.getString("month"));
			map.put("kind", rs.getString("kind"));
			map.put("cnt", rs.getInt("cnt"));
			map.put("sum", rs.getInt("sum"));
			list.add(map);
		}
		conn.close();
		return list;
	}
}
