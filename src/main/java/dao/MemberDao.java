package dao;
import vo.*;
import util.DBUtil;
import java.sql.*;
import java.util.ArrayList;


public class MemberDao {
	
	// 멤버레벨수정 form
	public Member selectMember(String memberId) throws Exception {
		Member member = null;
		
		String sql = "SELECT member_id memberId, member_level memberLevel FROM member WHERE member_id = ?";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, memberId);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			member = new Member();
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
		}
		dbUtil.close(rs, stmt, conn);
		
		return member;
	}
	
	//관리자 : 멤버레벨수정 action
	public int updateMemberLevel(int memberLevel, String memberId) throws Exception {
		int row = 0;
		
		String sql = "UPDATE member SET member_level = ?, updatedate = CURDATE() WHERE member_id = ?";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, memberLevel);
		stmt.setString(2, memberId);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	// 관리자 : 멤버수
	public int selectMemberCount() throws Exception {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) cnt FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			count = rs.getInt("cnt");
		}
		dbUtil.close(rs, stmt, conn);
		
		return count;
	}
	
	// 관리자 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Member> list = new ArrayList<Member>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		
		while(rs.next()) {
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			m.setMemberLevel(rs.getInt("memberLevel"));
			m.setMemberName(rs.getString("memberName"));
			m.setUpdatedate(rs.getString("updatedate"));
			m.setCreatedate(rs.getString("createdate"));
			list.add(m);
		}
			
		dbUtil.close(rs, stmt, conn);	
		
		return list;	
	}
	// 관리자 멤버 강퇴
	public int deleteMemberByactin(String memberId) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM member WHERE member_id = ?";
		
		DBUtil dbUtil =  new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, memberId);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	// 회원탈퇴
	public int deleteMember(Member member) {
		return 0;
	}
	
	// 로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = new Member();
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdjj58", "root", "java1234");
		--> DB를 연결하는 코드(명령물)가 Dao 메서드를 거의 공통으로 중복된다.
		--> 중복되는 코드를 하나의 이름(메서드)으로 만들자
		--> 입력값과 반환값 결정해야 한다
		--> 입력값X, 반환값은 Connection타입의 결과값이 남아야 한다.
		*/
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberNo(rs.getInt("memberNo"));
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
			System.out.println("rs문 실행여부");
			System.out.println("rs문 GET/"+resultMember.getMemberId());
			System.out.println("rs문 GET2/"+resultMember.getMemberName());
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return resultMember;
	}
	
	// 회원가입 1) id중복확인 2) 회원가입
	
	// 반환 t: 이미존재, f: 사용가능
	public boolean selectMemberIdCk(String memberId) throws Exception {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			result = true;
		}
		dbUtil.close(rs, stmt, conn);
		return result;
	}
	
	
	
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdjj58", "root", "java1234");
		*/
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		resultRow = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return resultRow;
	}
	
	// 회원정보 수정
	public int updateMember(Member paramMember) throws Exception {
		int resultRow = 0;
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdjj58", "root", "java1234");
		*/
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member set member_name=? WHERE member_id=? AND member_pw =PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberName());
		stmt.setString(2, paramMember.getMemberId());
		stmt.setString(3, paramMember.getMemberPw());
		resultRow = stmt.executeUpdate();
		
		conn.close();
		stmt.close();
		return resultRow;
	}

	
	
	
	
	// 비밀번호 수정
	public int updateMemberPw(Member paramMember, String newMemberPw) throws Exception {
		int resultRow = 0;	
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdjj58", "root", "java1234");
		*/
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_no memberNo, member_id memberId, member_pw memberPw FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			sql ="UPDATE MEMBER SET member_pw = PASSWORD(?) WHERE member_id=?";
			PreparedStatement updateStmt = conn.prepareStatement(sql);
			updateStmt.setString(1, newMemberPw);
			updateStmt.setString(2, paramMember.getMemberId());
			
			
			resultRow = updateStmt.executeUpdate();
			
			if(resultRow == 0) {
				System.out.println("수정실패");
			} else {
				System.out.println("수정성공");		
			}
			updateStmt.close();
		} else {
			System.out.println("현재 비밀번호가 틀립니다");
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return resultRow;
	}
}
