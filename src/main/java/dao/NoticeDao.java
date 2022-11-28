package dao;
import java.util.*;

import util.*;
import vo.*;
import java.sql.*;

public class NoticeDao {
	
	// insertNoticeAction.jsp
	public int insertNotice(String noticeMemo) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO notice (notice_memo, updatedate, createdate) VALUES (?, NOW(), NOW())";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, noticeMemo);
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	
	// deleteNotice.jsp
	public int deleteNotice(int noticeNo) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, noticeNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row; 
	}
	
	// updateNoticeForm.jsp
	public Notice selectNoticeOne(int noticeNo) throws Exception {
		Notice notice = null;
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo FROM notice WHERE notice_no = ?";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeMemo(rs.getString("noticeMemo"));
		}
		dbUtil.close(rs, stmt, conn);
		
		return notice;
	}
	
	// updateNoticeAction.jsp
	public int updateNotice(String noticeMemo, int noticeNo) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE notice SET notice_memo = ?"
					+" WHERE notice_no = ?";
		PreparedStatement stmt= conn.prepareStatement(sql);
		stmt.setString(1, noticeMemo);
		stmt.setInt(2, noticeNo);
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row; 
	}
	
	// 마지막 페이지를 구할려면 전체row수가 필요
	public int selectNoticeCount() throws Exception {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return count;
	}
	
	
	// loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		dbUtil.close(rs, stmt, conn);

		return list;
		
	}
}
