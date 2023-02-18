package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Cash;
import vo.Member;	
public class CashDao {
	// 사용자별 년도별 수입/지출 sum, avg
	public ArrayList<HashMap<String, Object>> selectCashStatsByYear(String memberId) {
		ArrayList<HashMap<String, Object>> list = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT"
					+ "		YEAR(t2.cashDate) year"
					+ "		, COUNT(t2.importCash) importCount"
					+ "		, IFNULL(SUM(t2.importCash), 0) importSum"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) importAvg"
					+ "		, COUNT(t2.exportCash) exportCount"
					+ "		, IFNULL(SUM(t2.exportCash), 0) exportSum"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) exportAvg"
					+ "	FROM"
					+ "		(SELECT"
					+ "			memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ "		FROM (SELECT cs.cash_no cashNo"
					+ "				, cs.cash_date cashDate"
					+ "				, cs.cash_price cashPrice"
					+ "				, cg.category_kind categoryKind"
					+ "				, cs.member_id memberId"
					+ "			FROM cash cs "
					+ "			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ "	WHERE t2.memberId = ?"
					+ "	GROUP BY YEAR(t2.cashDate)"
					+ " ORDER BY YEAR(t2.cashDate) ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			list = new  ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("year", rs.getInt("year"));
				m.put("importCount", rs.getInt("importCount"));
				m.put("importSum", rs.getInt("importSum"));
				m.put("importAvg", rs.getInt("importAvg"));
				m.put("exportCount", rs.getInt("exportCount"));
				m.put("exportSum", rs.getInt("exportSum"));
				m.put("exportAvg", rs.getInt("exportAvg"));
				list.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 사용자별 월별 
	public HashMap<String, Object> selectCashStatsByMonth(Member member, int year) {
	    HashMap<String, Object> statsList = new HashMap<String, Object>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        DBUtil dbUtil = new DBUtil();
	        conn = dbUtil.getConnection();
	        String sql = "SELECT "
	    			+ " MONTH(t2.cashDate) month, "
	    			+ " COUNT(t2.importCash) importCount, "
	    			+ " IFNULL(SUM(t2.importCash), 0) importSum, "
	    			+ " IFNULL(ROUND(AVG(t2.importCash)), 0) importAvg, "
	    			+ " COUNT(t2.exportCash) exportCount, "
	    			+ " IFNULL(SUM(t2.exportCash), 0) exportSum, "
	    			+ " IFNULL(ROUND(AVG(t2.exportCash)), 0) exportAvg "
	    			+ " FROM (SELECT "
	    			+ " 		memberId, "
	    			+ " 		cashNo, "
	    			+ " 		cashDate, "
	    			+ " 		IF(categoryKind = '수입', cashPrice, null) importCash, "
	    			+ " 		IF(categoryKind = '지출', cashPrice, null) exportCash "
	    			+ " 		FROM (SELECT "
	    			+ " 			cs.cash_no cashNo, "
	    			+ " 			cs.cash_date cashDate, "
	    			+ " 			cs.cash_price cashPrice, "
	    			+ " 			cg.category_kind categoryKind, "
	    			+ " 			cs.member_id memberId "
	    			+ " 			FROM cash cs "
	    			+ " 			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2 "
	    			+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ? "
	    			+ " GROUP BY MONTH(t2.cashDate) "
	    			+ " ORDER BY MONTH(t2.cashDate) ASC";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, member.getMemberId());
	        stmt.setInt(2, year);
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            int month = rs.getInt("month");
	            statsList.put(month + "importCount", rs.getInt("importCount"));
	            statsList.put(month + "importSum", rs.getInt("importSum"));
	            statsList.put(month + "importAvg", rs.getInt("importAvg"));
	            statsList.put(month + "exportCount", rs.getInt("exportCount"));
	            statsList.put(month + "exportSum", rs.getInt("exportSum"));
	            statsList.put(month + "exportAvg", rs.getInt("exportAvg"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (conn != null) conn.close();
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return statsList;
	}
	
	// 최소, 최대년도
	public HashMap<String, Object> selectMaxMinYear() throws Exception {
		HashMap<String, Object> map = null;		

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT"
					+ "	(SELECT MIN(YEAR(cash_date)) FROM cash) minYear"
					+ ", (SELECT MAX(YEAR(cash_date))FROM cash) maxYear"
					+ " FROM DUAL";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			map = new HashMap<String, Object>();
			map.put("minYear", rs.getInt("minYear"));
			map.put("maxYear", rs.getInt("maxYear"));
			
		}
		stmt.close();
		rs.close();
		return map;
	}

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
	public int deleteCash(int cashNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM cash WHERE cash_no =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		row = stmt.executeUpdate();
		
		return row;
	}
	
	
}