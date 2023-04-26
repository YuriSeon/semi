package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.board.model.service.BamService;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.BtnCheck;

/**
 * Servlet implementation class BamGoodController
 */
@WebServlet("/boardGood.bo")
public class BamGoodController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BamGoodController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 추천했었는지 체크+추천수 가져오기
		int boardNo = Integer.parseInt(request.getParameter("bno"));
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		Board b = new BamService().selectBam(boardNo);
		
		BtnCheck bc = new BamService().selectBtnCheck(boardNo, userNo);
		
		if(bc!=null&&bc.getBtncheck().contains("추천")) {//이미 추천을 눌렀음
			
			int[] arr = {1,b.getGood()}; //가져갈 배열{추천했었는지 판별,추천수}
			response.setContentType("json/aplication; charset=UTF-8");
			new Gson().toJson(arr,response.getWriter());
		}else {//아직 추천을 누르지 않았음
			int[] arr = {0,b.getGood()}; //가져갈 배열{추천했었는지 판별,추천수}
			response.setContentType("json/aplication; charset=UTF-8");
			new Gson().toJson(arr,response.getWriter());
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//대나무숲 게시글 추천
		//추천할 게시글 번호
		int boardNo = Integer.parseInt(request.getParameter("bno"));
		//추천한 유저
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		int result = new BamService().goodBtn(boardNo,userNo);
		
		response.getWriter().print(result);
	}

}
