package com.kh.bMember.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.service.BMemberService;
import com.kh.bMember.model.vo.BMember;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/login.me")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		
		BMember loginUser = new BMemberService().loginMember(userId,userPwd);
		
		if(loginUser != null) {
			
			if(loginUser.getPower().equals(("A"))) {//관리자페이지 이동
				request.getSession().setAttribute("loginUser", loginUser);
				request.getSession().setAttribute("alertMsg", "관리자 페이지로 이동합니다.");
				response.sendRedirect(request.getContextPath()+"/views/common/admin.jsp");
			}else {//메인페이지 이동
				request.getSession().setAttribute("loginUser", loginUser);
				request.getSession().setAttribute("alertMsg", "로그인 성공");
				response.sendRedirect(request.getContextPath()+"/mainPage.jsp");
			}
		}else {
			request.setAttribute("errorMsg", "로그인 실패하였습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);

		}
	}

}
