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
	public int updateCash(int cashNo, int categoryNo, String cashDate, long cashPrice, String cashMemo) throws Exception {
		int resultRow = 0;
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdjj58", "root", "java1234");
		*/
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql ="UPDATE cash SET category_no =?, cash_date =?, cash_price =?, cash_memo =?, updatedate = CURDATE() WHERE cash_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		stmt.setString(2, cashDate);
		stmt.setLong(3, cashPrice);
		stmt.setString(4, cashMemo);
		stmt.setInt(5, cashNo);
		
		
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
	
	public Cash selectUpdateCashData(int cashNo) throws Exception {
		Cash cash = new Cash();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT cash_no cashNo, category_no categoryNo, cash_date cashDate, cash_price cashPrice, cash_memo cashMemo, updatedate FROM cash Where cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			cash.setCashNo(rs.getInt("cashNo"));
			cash.setCategroyNo(rs.getInt("categoryNo"));
			cash.setCashDate(rs.getString("cashDate"));
			cash.setCashPrice(rs.getLong("cashPrice"));
			cash.setCashMemo(rs.getString("cashMemo"));
			cash.setUpdatedate(rs.getString("updatedate"));
		}
		
		return cash;
	}

	
	
	// insertCashAction
	public int insertCash(Cash cash) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql ="INSERT INTO cash (category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES(?,?,?,?,?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategroyNo());
		stmt.setString(2, cash.getMemberId());
		stmt.setString(3, cash.getCashDate());
		stmt.setLong(4, cash.getCashPrice());
		stmt.setString(5, cash.getCashMemo());
		
		row = stmt.executeUpdate();
				
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// deleteCashAction
	public int deleteCash(int cashNo, String memberId) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM cash WHERE cash_no =? AND MemberId =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		stmt.setString(2, memberId);
		
		row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("삭제성공");
		} else {
			System.out.println("삭제실패");
		}
		
		return row;
	}
	
	
}