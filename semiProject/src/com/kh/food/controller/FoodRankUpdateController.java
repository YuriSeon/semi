package com.kh.food.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.BamFileRenamePolicy;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.food.model.service.FoodService;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class FoodRankUpdateController
 */
@WebServlet("/foodRankUpdate.bo")
public class FoodRankUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodRankUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		Attachment att = new FoodService().selectFoodImg(Integer.parseInt(request.getParameter("helloworld")));
		
		request.setAttribute("boardNo", request.getParameter("helloworld"));
		request.setAttribute("foodName", request.getParameter("foodCate"));
		request.setAttribute("title", request.getParameter("Btitle"));
		request.setAttribute("content", request.getParameter("content"));
		request.setAttribute("address1", request.getParameter("address1"));
		request.setAttribute("Attachment", att);
		
		request.getRequestDispatcher("views/food/foodRankUpdate.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String savePath = request.getSession().getServletContext().getRealPath("/resources/food_files/");
		int maxSize = 10 * 1024 * 1024;
		MultipartRequest multiRequest = new MultipartRequest(request, savePath,maxSize,"UTF-8",new BamFileRenamePolicy());
		
		System.out.println("bno = "+request.getParameter("bno"));
		System.out.println("targetBoardNo = "+request.getParameter("targetBoardNo"));
		System.out.println("HelloWolrd = "+request.getParameter("bno"));

		int bno = Integer.parseInt(multiRequest.getParameter("bno"));
		String title = multiRequest.getParameter("Btitle"); // 제목r
		
		
		
		// 인풋이 ""이면 셀렉트 된거가져오고 아니면 인풋값 가져오기
		String newFoodName = multiRequest.getParameter("newfood");
		if(newFoodName == null) {
			System.out.println("nullllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll");
		}
		
		
		String content = multiRequest.getParameter("content"); // 내용
		String address = multiRequest.getParameter("address"); // 도로명 주소
		String address2 = multiRequest.getParameter("addressDetail"); // 상세주소
		String fullAddress = address + (address2.equals("")?"":" "+address2);
		System.out.println("주소 1 " + address );
		System.out.println("주소 2 " + address2 );
		System.out.println("주소는 " + fullAddress);
		Board b = new Board();
		b.setBoardNo(bno);
		b.setBoardTitle(title);
		b.setBoardContent(content);
		b.setAbbress(fullAddress);
		b.setFoodName(newFoodName);
		
		
		
		int result = new FoodService().UpdateFoodBoard(b); // 최종적으로 Dao에서 Board에 수정한 결과 값을 리턴해준다.
		System.out.println(result);
		Attachment att = null;
		if(multiRequest.getOriginalFileName("reupload") != null && result > 0) {
			System.out.println("테스트 입니다.");
			att = new Attachment();
			att.setOriginName(multiRequest.getOriginalFileName("reupload"));
			att.setChangeName(multiRequest.getFilesystemName("reupload"));
			att.setFilePath("/resources/food_files");
			result = new FoodService().foodUpdateImg(bno, att);
		}
		
		
		if(result > 0) {
			response.sendRedirect(request.getContextPath() + "/foodRanking.bo");
		}else {
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

}
