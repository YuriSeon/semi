package com.kh.food.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FoodMain
 */
@WebServlet("/foodm.bo")
public class FoodMain extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodMain() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 데몬 스레드호 밥 같이 먹기 참여자 및 작성자는 남은 시간과 실시간 참여자들 보여주기 및 실시간으로 참여자 늘어나는거 남은 시간 보여주는 기능 구현에 사용할 예정
		Timer time = new Timer();
		TimerTask task = new TimerTask() {
			
			@Override
			public void run() {
				Date d = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("YY/MM/dd HH:mm:ss");
				String time = sdf.format(d);
				System.out.println(time);
			};
		};
		
		time.schedule(task, 0, 10000);
		// 10초마다 실행
		// 매우 잘 실행되는 거 확인
		
		request.getRequestDispatcher("views/food/foodm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
