package com.kh.admin.userManage.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.admin.userManage.model.dao.UserManageDao;
import com.kh.admin.userManage.model.vo.BlackList;
import com.kh.admin.userManage.model.vo.User;
import com.kh.admin.userManage.model.vo.UserCondition;
import com.kh.admin.userManage.model.vo.UserManage;
import com.kh.bMember.model.vo.BMember;
import com.kh.common.model.vo.JDBCTemplate;
import com.kh.common.model.vo.PageInfo;

public class UserManageService {

	public int listCount(String status) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new UserManageDao().listCount(conn, status);
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	public ArrayList<BlackList> selectAllBlackList(PageInfo pi) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<BlackList> list = new UserManageDao().selectAllBlackList(conn, pi);

		JDBCTemplate.close(conn);
		
		return list;
	}

	public ArrayList<BlackList> selectList(String input, String option, PageInfo pi) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<BlackList> list = new UserManageDao().selectList(conn, pi, input, option);
		
		JDBCTemplate.close(conn);
		
		return list;
	
	}

	public ArrayList<User> selectUserList(PageInfo pi, String select) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<User> list = new UserManageDao().selectUserList(conn, pi, select);
		
		JDBCTemplate.close(conn);
		
		return list;
		
	}


		public ArrayList<BMember> checkListRecent(PageInfo pi, int option) {
			
			Connection conn = JDBCTemplate.getConnection();
			
			ArrayList<BMember> list = new UserManageDao().checkList(conn, pi, option);
			
			JDBCTemplate.close(conn);
			
			return list;
		}


		public int ckCount(int select, String search) {
			
			Connection conn = JDBCTemplate.getConnection();
			
			int result = new UserManageDao().ckCount(conn, select, search);
			
			JDBCTemplate.close(conn);
			
			return result;
		}
		
		public ArrayList<BMember> checkSelectList(PageInfo pi, int select, String search) {
			
			Connection conn = JDBCTemplate.getConnection();
			
			ArrayList<BMember> list = new UserManageDao().checkSelectList(conn, pi, select, search);
			
			JDBCTemplate.close(conn);
			
			return list;
			
		}

		public int importantCount() {
			
			Connection conn = JDBCTemplate.getConnection();
			
			int result = new UserManageDao().importantCount(conn);
			
			JDBCTemplate.close(conn);
			
			return result;
			
		}

		public ArrayList<User> importantList(PageInfo pi) {
			
			Connection conn = JDBCTemplate.getConnection();
			
			ArrayList<User> list = new UserManageDao().importantList(conn, pi);
			
			JDBCTemplate.close(conn);
			
			return list;
		}

		public int yellowCard(int userNo) {
			
			Connection conn = JDBCTemplate.getConnection();
			
			int result = new UserManageDao().yellowCard(conn, userNo);
			
			JDBCTemplate.close(conn);
			
			return result;
		}

		public User UserCount(String[] sArr) {
			
			Connection conn = JDBCTemplate.getConnection();
			
			User u = new UserManageDao().UserCount(conn, sArr);
			
			JDBCTemplate.close(conn);
			
			return u;
		}

		public int[] checkCount() {
			
			Connection conn = JDBCTemplate.getConnection();
			
			int[] result = new UserManageDao().checkCount(conn);
			
			JDBCTemplate.close(conn);
			
			return result;
		}

		public ArrayList<User> detailInfo(int userNo) {
			
			Connection conn = JDBCTemplate.getConnection();
			
			ArrayList<User> list = new UserManageDao().detailInfo(conn, userNo);
			
			JDBCTemplate.close(conn);
			
			return list;
		}

		public ArrayList<BMember> mainSearchUser(String search) {
			
			Connection conn = JDBCTemplate.getConnection();
			
			ArrayList<BMember> list = new UserManageDao().mainSearchUser(conn, search);
			
			JDBCTemplate.close(conn);
			
			return list;
		}

		public ArrayList<User> userUpdate(UserCondition uc, BMember b, UserManage um) {
			
			Connection conn = JDBCTemplate.getConnection();
			
			ArrayList<User> list = new ArrayList<>();
			
			int result = 0;
			result += new UserManageDao().updateUC(conn, uc);
			result += new UserManageDao().updateM(conn, b);
			result += new UserManageDao().updateUM(conn, um);
			
			if(result==3) {
				JDBCTemplate.commit(conn);
				
				// 업데이트 성공시 업데이트 된 정보 가져가서 뿌려주기위해 조회
				list = new UserManageDao().detailInfo(conn, b.getUserNo());
			} else {
				
				JDBCTemplate.rollback(conn);
			}
			JDBCTemplate.close(conn);

			return list;
		}

		public int deleteUser(int userNo) {
			
			Connection conn = JDBCTemplate.getConnection();
			
			int result = new UserManageDao().deleteUser(conn, userNo);
			
			if(result>0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
			
			JDBCTemplate.close(conn);
			
			return result;
		}

}
