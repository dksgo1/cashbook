package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Comment;

public class CommentDao {
	// 입력
	public int insertComment(Comment comment) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO comment(comment_memo, help_no, member_id, updatedate, createdate) VALUES (?, ?, ?, NOW(), NOW())";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment.getCommentMemo());
		stmt.setInt(2, comment.getHelpNo());
		stmt.setString(3, comment.getMemberId());
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row;		
	}
	
	// 수정 form
	public Comment selectCommentOne(int commentNo) throws Exception {
		Comment comment = null;
		
		String sql = "SELECT comment_no commentNo, comment_memo commentMemo FROM comment WHERE comment_no = ?";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, commentNo);
		rs = stmt.executeQuery();

		if(rs.next()) {
			comment = new Comment();
			comment.setCommentNo(rs.getInt("commentNo"));
			comment.setCommentMemo(rs.getString("commentMemo"));
		}
		dbUtil.close(rs, stmt, conn);
		
		return comment;
	}
	// 수정 action
	public int updateComment(String commentMemo, String memberId, int commentNo) throws Exception {
		int row = 0;
		
		String sql = "UPDATE comment SET comment_memo = ?, member_id = ?, updatedate = NOW() WHERE comment_no =?";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, commentMemo);
		stmt.setString(2, memberId);
		stmt.setInt(3, commentNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row;	
	}
	
	// 삭제
	public int deleteComment(int commentNo) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM comment WHERE comment_no = ?";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, commentNo);
		row =stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row;	
	}
}
