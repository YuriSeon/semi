package com.kh.food.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.BamFileRenamePolicy;
import com.kh.board.model.vo.Attachment;
import com.kh.food.model.service.FoodService;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class foodTogetherUpdateController
 */
@WebServlet("/foodTogetherUpdate.bo")
public class foodTogetherUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public foodTogetherUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 수정 버큰 클릭시 이쪽으로 이동 수정 가능한 jsp파일을 보여준다..
		int bno = Integer.parseInt(request.getParameter("bno"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String originName = request.getParameter("originName");
		String changeName = request.getParameter("changeName");
		String filePath = request.getParameter("filePath");
		String mainAddress = request.getParameter("mainAddress");
		String subAddress = request.getParameter("subAddress");
		int person = Integer.parseInt(request.getParameter("person").substring(0, request.getParameter("person").indexOf("명")));
		String timer = request.getParameter("endTime");
		// 모든 정보가 잘 들어온다.
		HashMap<String, String> map = new HashMap<>();
		map.put("bno", String.valueOf(bno));
		map.put("title", title);
		map.put("content", content);
		map.put("originName", originName);
		map.put("changeName", changeName);
		map.put("filePath", filePath);
		map.put("mainAddress", mainAddress);
		map.put("subAddress", subAddress);
		map.put("person", String.valueOf(person));
		map.put("timer", timer);
		request.setAttribute("map", map);
		request.getRequestDispatcher("views/food/foodTogetherUpdate.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String savePath = request.getSession().getServletContext().getRealPath("/resources/food_files/");
		int maxSize = 10 * 1024 * 1024;
		MultipartRequest multiRequest = new MultipartRequest(request, savePath,maxSize,"UTF-8",new BamFileRenamePolicy());
		String bno = multiRequest.getParameter("bno");
		String title = multiRequest.getParameter("title"); // 제목
		String content = multiRequest.getParameter("content"); // 내용
		String mainAddress = multiRequest.getParameter("mainAddress"); // 도로명 주소
		String subAddress = multiRequest.getParameter("subAddress"); // 상세주소
		String person = "";
		try {
			person = multiRequest.getParameter("person").substring(0,multiRequest.getParameter("person").indexOf("명"));			
		}catch(Exception e) {
			// null >> 수정 시 인원을 안바꾸면 숫자로 나와있기 때문에 null 포인트가 뜬다. 이걸 방지
			person = multiRequest.getParameter("person");
		}
		String endTime = multiRequest.getParameter("endTime");
		// 객체가 2개 이상이기 때문에 map으로 한번에 가져가기로 했다.
		HashMap<String, String> map = new HashMap<>();
		map.put("bno",bno); // 조건
		map.put("title",title); // BOARD
		map.put("content",content); // BOARD
		map.put("mainAddress",mainAddress); // FOOD_TOGETHER
		map.put("subAddress",subAddress); // FOOD_TOGETHER
		map.put("person",person); // FOOD_TOGETHER
		map.put("endTime",endTime); // FOOD_TOGETHER
		int result = new FoodService().updateFoodTogether(map);
		Attachment att = null;
		if(multiRequest.getOriginalFileName("togetherImg") != null && result > 0) {
			att = new Attachment();
			att.setOriginName(multiRequest.getOriginalFileName("togetherImg"));
			att.setChangeName(multiRequest.getFilesystemName("togetherImg"));
			att.setFilePath("resources/food_files");
			result = new FoodService().foodUpdateImg(Integer.parseInt(bno), att);
		}
		if(result > 0) {
			response.sendRedirect(request.getContextPath() + "/foodTogether.bo");
		}else {
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

}
