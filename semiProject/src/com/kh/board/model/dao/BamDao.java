package com.kh.board.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.BamCategory;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.board.model.vo.Reply;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;

public class BamDao {
	Properties prop = new Properties();
	
	public BamDao() {
		String filePath = BamDao.class.getResource("/sql/bam/bam-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//대나무숲 게시글 총 갯수 세는 메소드
	public int selectListCount(Connection conn) {
		int count = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectListCount");
		
		try {
			stmt = conn.createStatement();
			
			rset=stmt.executeQuery(sql);
			
			if(rset.next()) {
				count = rset.getInt("COUNT");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}

		return count;
	}

	//현재 페이지 게시글들 조회
	public ArrayList<Board> selectList(Connection conn, PageInfo pi) {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectList");
		
		try {
			//현재페이지 조회해야할 게시글 번호 변수
			//현재 페이지에서 가장 낮은 게시글번호
			int startRow = (pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
			//현재 페이지에서 가장 높은 게시글 번호
			int endRow = (startRow+pi.getBoardLimit()) - 1;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO")
								,rset.getString("USERNO")
								,rset.getString("BAM_CATEGORY_NO")
								,rset.getString("BOARD_TITLE")
								,rset.getString("BOARD_CONTENT")
								,rset.getDate("CREATE_DATE")
								,rset.getInt("GOOD")
								,rset.getInt("REPORT")
								,rset.getInt("COUNT")));
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		
		
		return list;
	}
	//공지사항 리스트 가져오기
	public ArrayList<Board> selectNoticeList(Connection conn) {
		ArrayList<Board> nlist = new ArrayList<>();
		Statement stmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectNoticeList");
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				nlist.add(new Board(rset.getInt("BOARD_NO")
									,rset.getString("USERNO")
									,"공지"
									,rset.getString("BOARD_TITLE")
									,rset.getString("BOARD_CONTENT")
									,rset.getDate("CREATE_DATE")
									,rset.getInt("GOOD")
									,rset.getInt("REPORT")
									,rset.getInt("COUNT")));
			}
			
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return nlist;
	}

	//대나무숲 게시글 작성할때 게시글 제목,내용
	public int insertBam(Connection conn, Board b) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertBam");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b.getBoardWriter());
			pstmt.setString(2, b.getBoardTitle());
			pstmt.setString(3, b.getBoardContent());
			pstmt.setString(4, b.getBoardType()); //
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	//공지사항 작성(인서트)
	public int insertNoticeBam(Connection conn, Board b) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertNoticeBam");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b.getBoardWriter());
			pstmt.setString(2, b.getBoardTitle());
			pstmt.setString(3, b.getBoardContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//대나무숲 게시글 작성할때 첨부파일
	public int insertAttachment(Connection conn, Attachment at) {
		int result2 =0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, at.getOriginName());
			pstmt.setString(2, at.getChangeName());
			pstmt.setString(3, at.getFilePath());
		
			result2 = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return result2;
	}
	//조회수 증가 메소드
		public int increaseCount(Connection conn, int boardNo) {
			int result = 0;
			PreparedStatement pstmt = null;
			
			String sql = prop.getProperty("increaseCount");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, boardNo);
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return result;
		}

		//대나무숲 게시글 조회 메소드
		public Board selectBam(Connection conn,int boardNo) {
			Board b = null;
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			
			String sql = prop.getProperty("selectBam");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, boardNo);
				
				rset = pstmt.executeQuery();
				
				if(rset.next()) {
					b=new Board(rset.getInt("BOARD_NO")
								,rset.getString("USERNO")
								,rset.getString("BAM_CATEGORY_NO")
								,rset.getString("BOARD_TITLE")
								,rset.getString("BOARD_CONTENT")
								,rset.getDate("CREATE_DATE")
								,rset.getDate("MODIFY_DATE")
								,rset.getInt("GOOD")
								,rset.getInt("COUNT"));
				}
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
			}
					
			
			
			return b;
		}

		//첨부파일 조회 메소드
		public Attachment selectAttachment(Connection conn, int boardNo) {
			Attachment at = null;
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			
			String sql = prop.getProperty("selectAttachment");
			
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, boardNo);
				
				rset=pstmt.executeQuery();
				
				if(rset.next()) {
					
					at = new Attachment(rset.getInt("FILE_NO")
										,rset.getString("ORIGIN_NAME")
										,rset.getString("CHANGE_NAME")
										,rset.getString("FILE_PATH")
										,rset.getDate("UPLOAD_DATE"));	
				}
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return at;
		}

		//게시글 삭제(상태창변경) 메소드
		public int deleteBam(Connection conn, int boardNo) {
			int result = 0;
			PreparedStatement pstmt = null;
			
			String sql = prop.getProperty("deleteBam");
			
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, boardNo);
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(pstmt);
			}
			
			return result;
		}
		
		//대나무숲 게시글 수정
		public int updateBam(Connection conn, Board b) {
			int result = 0;
			PreparedStatement pstmt = null;
			
			String sql = prop.getProperty("updateBam");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b.getBoardTitle());
				pstmt.setString(2, b.getBoardContent());
				pstmt.setInt(3, b.getBoardNo());
				
				result=pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(pstmt);
			}
			
			return result;
		}

		//대나무숲 게시글 카테고리 수정
		public int updateCategory(Connection conn, Board b) {
			int result = 0;
			PreparedStatement pstmt = null;
			
			String sql = prop.getProperty("updateBamCategory");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(b.getBoardType()));
				pstmt.setInt(2, b.getBoardNo());
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(pstmt);
			}
			
			
			return result;
		}

		//대나무숲 기존첨부 있을때 첨부파일 수정
		public int updateAttachment(Connection conn, Attachment at) {
			int result = 0;
			PreparedStatement pstmt = null;
			
			String sql = prop.getProperty("updateAttachment");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, at.getOriginName());
				pstmt.setString(2, at.getChangeName());
				pstmt.setString(3, at.getFilePath());
				pstmt.setInt(4, at.getFileNo());
				
				result =pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(pstmt);
			}
			
			return result;
		}

		//대나무숲 기존파일 없을때 첨부파일 수정
		public int newInsertAttachment(Connection conn, Attachment at) {
			int result = 0;
			PreparedStatement pstmt = null;
			
			String sql = prop.getProperty("newInsertAttachment");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, at.getBoardNo());
				pstmt.setString(2, at.getOriginName());
				pstmt.setString(3, at.getChangeName());
				pstmt.setString(4, at.getFilePath());
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(pstmt);
			}
			
			
			return result;
		}

		//대나무숲 댓글 작성
		public int insertReply(Connection conn, Reply r) {
			int result =0;
			PreparedStatement pstmt = null;
			
			String sql = prop.getProperty("insertReply");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, r.getBoardNo());
				pstmt.setString(2, r.getReplyContent());
				pstmt.setInt(3, Integer.parseInt(r.getReplyWriter()));
				
				result = pstmt.executeUpdate();
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(pstmt);
			}
			
			return result;
		}

		//대나무숲 댓글 조회
		public ArrayList<Reply> selectReplyList(Connection conn, int bno) {
			ArrayList<Reply> rlist = new ArrayList<>();
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			
			String sql = prop.getProperty("selectReplyList");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bno);
				
				rset = pstmt.executeQuery();
				
				while(rset.next()) {
					rlist.add(new Reply(rset.getInt("REPLY_NO")
										,rset.getInt("BOARD_NO")
										,rset.getString("USERNO")
										,rset.getString("REPLY_CONTENT")
										,rset.getDate("CREATE_DATE")));
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
			}
			
			return rlist;
		}

		//대나무숲 게시글 신고
		public int reportBam(Connection conn, int boardNo) {
			int result = 0;
			PreparedStatement pstmt = null;
			
			String sql = prop.getProperty("reportBam");
			
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, boardNo);
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(pstmt);
			}
			
			return result;
		}

		//댓글 삭제 메소드
		public int deleteReply(Connection conn, int replyNo) {
			int result = 0;
			PreparedStatement pstmt = null;
			
			String sql = prop.getProperty("deleteReply");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, replyNo);
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(pstmt);
			}
			
			return result;
		}

		


		
	
}
