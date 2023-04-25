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
 * Servlet implementation class MemberInsertController
 */
@WebServlet("/insert.me")
public class MemberInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		String userName = request.getParameter("userName");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String ssn = request.getParameter("ssn");
		String userNick = request.getParameter("userNick");
		String schoolNo = null;
		String schoolNoParam = request.getParameter("schoolNo");
		String school_st = "";
		
		if(schoolNoParam != null) {
			schoolNo = schoolNoParam;			
		}
		
		BMember m = new BMember(userId,userPwd,userName,phone,address,email,ssn,userNick,schoolNo,school_st);
		
		int result = new BMemberService().insertMemer(m);
		if(result>0) {
			request.getSession().setAttribute("alertMsg", "환영합니다!");
			response.sendRedirect(request.getContextPath()+"/mainPage.jsp");
		}else {
			request.setAttribute("errorMsg", "가입 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

}
