package dao;
import java.sql.*;
import java.util.*;
import java.net.*;
import java.util.ArrayList;
import java.util.HashMap;
import util.*;
import vo.*;
import vo.Member;	
public class CashDao {
	
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		/*
		SELECT 
			c.cash_no cashNo
			, c.cash_date cashDate
			, c.cash_price cashPrice
			, c.category_no categoryNo
			, ct.category_kind categoryKind
			, ct.category_name categoryName 
		FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no 
		WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? 
		ORDER BY c.cash_date ASC;
	    */
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC"; // 과제
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
      
		rs.close();
		stmt.close();
		conn.close();
		return list;
		
	}
	
	//cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC"; // 과제
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
	  
		rs.close();
		stmt.close();
		
		conn.close();
		return list;
	}

	// updateCash
	public int updateCash(Member paramMember, Cash paramCash, Category paramCategory) throws Exception {
		int resultRow = 0;
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdjj58", "root", "java1234");
		*/
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql ="UPDATE cash c INNER JOIN category ct ON c.category_no = ct.category_no INNER JOIN member m ON c.member_id = m.member_id SET ct.category_kind=?, ct.category_name=?,  c.cash_price=?, c.cash_memo =? WHERE c.cash_no =? AND m.member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCategory.getCategoryKind());
		stmt.setString(2, paramCategory.getCategoryName());
		stmt.setLong(3, paramCash.getCashPrice());
		stmt.setString(4, paramCash.getCashMemo());
		stmt.setInt(5, paramCash.getCashNo());
		stmt.setString(6, paramMember.getMemberId());
		
		resultRow = stmt.executeUpdate();
		
		if(resultRow == 1) {
			System.out.println("수정성공");
		} else {
			System.out.println("수정실패");
		}
		
		conn.close();
		stmt.close();
		return resultRow;
	}
			
}