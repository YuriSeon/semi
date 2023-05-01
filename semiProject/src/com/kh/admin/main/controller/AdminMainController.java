package com.kh.admin.main.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.admin.board.model.service.BoardService;
import com.kh.admin.userManage.model.service.UserManageService;
import com.kh.admin.userManage.model.vo.User;
import com.kh.bMember.model.vo.BMember;

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
		
		HttpSession session = request.getSession();
		
		String power = null;
		
		if((BMember)session.getAttribute("loginUser")!=null) {
			power = ((BMember)session.getAttribute("loginUser")).getPower();
		}else {
			power = request.getParameter("power");
		}
		
		
		// 로그인 페이지에서 관리자여부 확인 후 관리자 페이지로 넘어왔지만 메인페이지 시작 전 2중체크
		if(power.equals("A")) {
			
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
			
		} else {// 관리자가 아니라면 커뮤니티 메인화면으로 다시 보내기
			session.setAttribute("alertMsg", "관리자가 아니시네요 나가세요");
			
			response.sendRedirect(request.getContextPath()+"/login.me");
		}
		// 게시판 영역에 들어갈 내용 조회
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
