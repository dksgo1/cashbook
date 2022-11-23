package dao;
import vo.*;
import util.DBUtil;
import java.sql.*;


public class MemberDao {
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
		
		String sql = "SELECT member_no memberNo, member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberNo(rs.getInt("memberNo"));
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			System.out.println("rs문 실행여부");
			System.out.println("rs문 GET/"+resultMember.getMemberId());
			System.out.println("rs문 GET2/"+resultMember.getMemberName());
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return resultMember;
	}
	
	// 회원가입
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdjj58", "root", "java1234");
		*/
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?, PASSWORD(?), ?, curdate(), curdate())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		resultRow = stmt.executeUpdate();
		
		conn.close();
		stmt.close();
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
