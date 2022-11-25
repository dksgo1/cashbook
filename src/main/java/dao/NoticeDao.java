package dao;
import java.util.*;

import util.*;
import vo.*;
import java.sql.*;

public class NoticeDao {
	public int deleteNotice(Notice notice) throws Exception {
		String sql = "DELETE FROM notice WHERE noitce_no = ?";
		
		return 0; // 임시값
	}
	
	
	public int updateNotice(Notice notice) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE notice SET notice_memo = ?"
					+" WHERE notice_no = ?";
		PreparedStatement stmt= conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		
		ResultSet rs = stmt.executeQuery();
		
		dbUtil.close(rs, stmt, conn);
		return row; 
	}
	
	public int insertNotice(Notice notice) throws Exception {
		String sql = "INSERT notice(notice_memo, updatedate, createdate)"
					+" VALUES(?, NOW(), NOW())";
		return 0;			
					
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
