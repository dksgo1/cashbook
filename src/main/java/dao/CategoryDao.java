package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
	
	// 수정 : 수정폼(select)과 수정액션(update)으로 구성
	// admin ->updateCategoryAction.jsp
	public int updateCategoryName(String categoryKind, String categoryName, int categoryNo) throws Exception {
		int row = 0;
		
		String sql ="UPDATE category SET category_kind = ?, category_name = ?, updatedate = CURDATE() WHERE category_no = ?";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, categoryKind);
		stmt.setString(2, categoryName);
		stmt.setInt(3, categoryNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// admin -> updateCategoryform.jsp
	public Category selectCategoryOne(int categoryNo) throws Exception {
		Category category = null;
		String sql = "SELECT category_no categoryNo, category_name categoryName FROM category WHERE category_no = ?";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryName(rs.getString("categoryName"));
		}
		dbUtil.close(rs, stmt, conn);
		
		return category;
	}
	
	// admin -> deleteCategory.jsp
	public int deleteCategory(int categoryNo) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM category WHERE category_no = ?";
	
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, categoryNo);
		row = stmt.executeUpdate();

		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	// admin -> insetCategoryAction.jsp
	public int insertCategory(String categoryKind, String categoryName) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO category (category_kind, category_name, updatedate, createdate) VALUES (?, ?, CURDATE(), CURDATE())";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryKind);
		stmt.setString(2, categoryName);
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
	
		return row;
	}
	
	
	
	
	// admin -> 카테고리 관리 -> 카테고리 목록
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
		ArrayList<Category> list = null; // 참조타입은 null로 초기화 시켜주는게 좋음
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
				
		list = new ArrayList<Category>(); 
		conn = dbUtil.getConnection();
		
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1); 1 - 셀렉트 절의 순서
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate"));
			c.setCreatedate(rs.getString("createdate"));
			list.add(c);
		}
		//db지원 (jdbc api지원) 반납
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	
	
	
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// ORDER BY category_kind
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNO"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
			categoryList.add(category);
		}
		return categoryList;
	}
}
