package com.kh.food.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.food.model.service.FoodService;

/**
 * Servlet implementation class FoodTogetherCheck
 */
@WebServlet("/togetherCheck.bo")
public class FoodTogetherCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodTogetherCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		userNo : <%=((BMember)request.getSession().getAttribute("loginUser")).getUserNo()%>, // 참여자 번호
//		bno : <%=map.get("boardNo") %>, // 해당 글번호
//		writerId : <%= map.get("userId")%> // 작성자 아이디 (uniqe)
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		int bno =  Integer.parseInt(request.getParameter("bno"));
		String writerId = request.getParameter("writerId");
		int person = Integer.parseInt(request.getParameter("person"));
		
		
		
		Gson gson = new Gson();
		response.setContentType("json/application; charset=UTF-8");
		// tocheck 테이블에 정보가 있는 지 확인 있다면 체크 못하게 해야됨.
		int check = new FoodService().toCheck(userNo);
		if(check > 0) { // 이미 참여 이력이 있다면  1이 반환
			int deletetocheck = new FoodService().deletetocheck(userNo); // 삭제 되면 색은 검은색이여야 한다
			if(deletetocheck > 0){				
					gson.toJson("0",response.getWriter());
			}else {
				gson.toJson("err",response.getWriter());
			}
		}else {
			int incheck = new FoodService().toCheckIn(userNo, bno, writerId, person); // 제대로 입력 됬다면 1이상
			if(incheck > 0) {
				gson.toJson("1",response.getWriter());
			}else {
				gson.toJson("0",response.getWriter());
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
