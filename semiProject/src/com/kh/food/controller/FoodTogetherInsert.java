package com.kh.food.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.bMember.model.vo.BMember;
import com.kh.board.model.BamFileRenamePolicy;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.food.model.service.FoodService;
import com.kh.food.model.vo.FoodTogether;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class FoodTogetherInsert
 */
@WebServlet("/foodTogetherInsert.bo")
public class FoodTogetherInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodTogetherInsert() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("views/food/foodTogetherInsert.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = 0;
		// insert post & multiple
		request.setCharacterEncoding("UTF-8");
		String savePath = request.getSession().getServletContext().getRealPath("/resources/food_files/");
		int maxSize = 10 * 1024 * 1024;
		MultipartRequest multiRequest = new MultipartRequest(request, savePath,maxSize,"UTF-8",new BamFileRenamePolicy());
		
		// 요소 추출
		int userNo = ((BMember)request.getSession().getAttribute("loginUser")).getUserNo();
		String title = multiRequest.getParameter("title");
		String content = multiRequest.getParameter("content");
		String mainAddress = multiRequest.getParameter("mainAddress");
		String subAddress = multiRequest.getParameter("subAddress");
		if(subAddress == null) {
			subAddress = "";
		}
		int person = Integer.parseInt(multiRequest.getParameter("person").substring(0,(multiRequest.getParameter("person").length() - 1)));
//		Date endTime = null;
//		String endTimeString = multiRequest.getParameter("endTime");
//		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
//		try {
//			endTime = sdf.parse(endTimeString);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
		String endTime = multiRequest.getParameter("endTime");
		
		// 객체 저장 (Board)
		Board b = new Board();
		b.setUn(userNo);
		b.setBoardTitle(title);
		b.setBoardContent(content);
		// 객체 저장 (FoodTogether)
		FoodTogether ft = new FoodTogether();
		ft.setMainAdress(mainAddress);
		ft.setSubAddress(subAddress);
		ft.setPerson(person);
		ft.setEndTime(endTime);

		// Service()로 전달
		Attachment att = null;
		if(multiRequest.getOriginalFileName("togetherImg") != null) {
			att = new Attachment();
			att.setOriginName(multiRequest.getOriginalFileName("togetherImg"));
			att.setChangeName(multiRequest.getFilesystemName("togetherImg"));
			att.setFilePath("/resources/food_files");
			result = new FoodService().foodToInsert(b, ft, att);
		}
		
		if(result > 0) {
			response.sendRedirect(request.getContextPath() + "/foodTogether.bo");
		}else {
			request.getRequestDispatcher("views/common/error.jap").forward(request, response);
		}
		
	}

}
