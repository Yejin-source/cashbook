package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Cash;

public class CashDao {
	
	// 날짜별 전체 데이터 가져오는 메서드
	public ArrayList<Cash> selectCashByDate(String cashDate) throws Exception {
		ArrayList<Cash> list = new ArrayList<>();
		
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 쿼리 작성
		String sql = "SELECT cash_no cashNo, category_no categoryNo, cash_date cashDate, amount, memo, color, createdate, updatedate"
						+ " FROM cash WHERE cash_date = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, cashDate);
		System.out.println("CategoryDao.java selectCategoryListByKind_stmt: " + stmt); // 쿼리 디버깅
		rs = stmt.executeQuery(); // 쿼리 실행
		
		while(rs.next()) {
			Cash c = new Cash();
			c.setCashNo(rs.getInt("cashNo"));
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCashDate(rs.getString("cashDate"));
			c.setAmount(rs.getInt("amount"));
			c.setMemo(rs.getString("memo"));
			c.setColor(rs.getString("color"));
			c.setCreatedate(rs.getString("createdate"));
			c.setUpdatedate(rs.getString("updatedate"));
			list.add(c);
		}
		conn.close(); // 연결 해제
		return list;
	}
}
