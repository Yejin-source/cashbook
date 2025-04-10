package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Category;
import dto.Paging;

public class CategoryDao {
	
	// 페이징, 전체 선택 메서드
	public ArrayList<Category> selectCategoryList(Paging p) throws ClassNotFoundException, SQLException {
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 쿼리 작성
		String sql = "SELECT category_no categoryNo, kind, title, createdate FROM category ORDER BY category_no DESC LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		System.out.println("CategoryDao.java selectCategory_stmt: " + stmt); // 쿼리 디버깅
		rs = stmt.executeQuery(); // 쿼리 실행
		
		ArrayList<Category> list = new ArrayList<>();
		
		while(rs.next()) {
			Category c = new Category(); 
			c.setNo(rs.getInt("categoryNo"));
			c.setKind(rs.getString("kind"));
			c.setTitle(rs.getString("title"));
			c.setCreatedate(rs.getString("createdate"));
			list.add(c);
		}
		conn.close(); // 연결 해제
		return list;
	}
	
	
	// 카테고리 목록 전체 개수 구하는 메서드
	public int getTotal() throws ClassNotFoundException, SQLException {		
		int total = 0;
		
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 쿼리 작성
		String sql = "SELECT COUNT(*) cnt FROM category";
		stmt = conn.prepareStatement(sql);
		System.out.println("CategoryDao.java getTotal_stmt: " + stmt); // 쿼리 디버깅
		rs = stmt.executeQuery(); // 쿼리 실행
		rs.next();
		
		total = rs.getInt("cnt");
		
		conn.close(); // 연결 해제
		return total;
	}
	
	
	// 카테고리 값 하나만 가져오는 메서드
	public Category selectCategoryOne(int no) throws ClassNotFoundException, SQLException {
		Category c = new Category();
		
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 쿼리 작성
		String sql = "SELECT category_no categoryNo, kind, title, createdate FROM category WHERE category_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, no);
		System.out.println("CategoryDao.java selectCategoryOne_stmt: " + stmt); // 쿼리 디버깅
		rs = stmt.executeQuery(); // 쿼리 실행
		
		if(rs.next()) {
			c = new Category();
			c.setNo(no);
			c.setKind(rs.getString("kind"));
			c.setTitle(rs.getString("title"));
			c.setCreatedate(rs.getString("createdate"));
		}
		
		conn.close(); // 연결 해제
		return c;
	}
	
	
	// 카테고리 추가 메서드 | 입력 후 자동으로 생성된 키값을 반환값으로 받기
	public int insertCategory(Category category) throws ClassNotFoundException, SQLException {
		int pk = 0;
		
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 쿼리 작성
		String sql = "INSERT INTO category(kind, title) VALUE(?,?)";
		
		// Statement.RETURN_GENERATED_KEYS 옵션: insert 후 select max(pk) from ... 실행
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, category.getKind());
		stmt.setString(2, category.getTitle());
		System.out.println("CategoryDao.java insertCategory_stmt: " + stmt); // 쿼리 디버깅
		
		int row = stmt.executeUpdate(); // insert
		rs = stmt.getGeneratedKeys(); // select max(no) from question
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		
		if(row == 1) {
			System.out.println("카테고리 추가 완료");
		} else {
			System.out.println("카테고리 추가 실패");
		}
		
		conn.close(); // 연결 해제
		return pk;
	}
	
	
	// 카테고리 제목 수정 메서드
	public int updateCategoryTitle(String title, int no) throws ClassNotFoundException, SQLException {
		int row = 0;
		
		// MySQL JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver");
		// DB 연결을 위한 객체 선언
		Connection conn = null;
		PreparedStatement stmt = null;
		// DB 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 쿼리 작성
		String sql = "UPDATE category SET title = ? WHERE category_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, title);
		stmt.setInt(2, no);
		System.out.println("CategoryDao.java updateCategoryTitle_stmt: " + stmt); // 쿼리 디버깅
		
		row = stmt.executeUpdate(); // 쿼리 실행
		if(row == 1) {
			System.out.println("카테고리 제목 수정 완료");
		} else {
			System.out.println("카테고리 제목 수정 실패");
		}
		
		conn.close(); // 연결 해제
		return row;
	}
}

