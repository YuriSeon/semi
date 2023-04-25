package com.kh.admin.main.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.admin.board.model.service.BoardService;
import com.kh.admin.userManage.model.service.UserManageService;
import com.kh.admin.userManage.model.vo.User;

/**
 * Servlet implementation class AdminMainController
 */
@WebServlet("/main.admin")
public class AdminMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminMainController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 게시판 영역에 들어갈 내용 조회
		int[][] boardArr = new BoardService().totalBoardCount(); 
		
		// 회원관리 영역에 들어갈 내용 조회
		String[] sArr = {"Y", "Y", "N", "K"}; // 회원 상태값 배열로 회원 수 조회
		
		User u = new UserManageService().UserCount(sArr);
		
		// 관리필요한 회원 리스트 영역에 들어갈 내용 조회
		int[] checkArr = new UserManageService().checkCount();
		
		request.setAttribute("boardArr", boardArr);
		
		request.setAttribute("u", u);
		
		request.setAttribute("checkArr", checkArr);
		
		request.getRequestDispatcher("admin/views/common/adminMain.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
