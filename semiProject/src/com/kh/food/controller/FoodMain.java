package com.kh.food.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.food.model.service.FoodService;
import com.kh.food.model.vo.FoodTogether;

/**
 * Servlet implementation class FoodMain
 */
@WebServlet("/foodmain.bo")
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
//		Timer time = new Timer();
//		TimerTask task = new TimerTask() {
//			
//			@Override
//			public void run() {
//				Date d = new Date();
//				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
//				String nowStr = sdf.format(d);
//				String[] nArr = nowStr.split(":");
//				int now = Integer.parseInt(nArr[0])*60 + Integer.parseInt(nArr[1]);
//				
//				ArrayList<FoodTogether> toTime = new FoodService().selectEndTime();
//				// 이거 그냥 시간이랑 보드 넘버, 인원 가져오기
//				
//				for(int i = 0; i < toTime.size(); i++) {
//					String[] times = toTime.get(i).getEndTime().split(":");
//					int et = Integer.parseInt(times[0])*60 + Integer.parseInt(times[1]);
//					if(et <= now) {
//						// 구인 시간 완료 => se
//					}else {
//						// 구인 시간 남음 => 현재 로그인된 사용자의 번호가 together에 참여되어있는지 확인하고, 있다면 현재 참여자 현황을 보여준다. ex) 2/5명
//						// 만약 참여 한게 없다면 그냥 pass
//					}
//				}
//				/*
//				 * 1. Select해서 밥같이 먹을거 시간을 다 가져온다.
//				 * 2. endTime이랑 now랑 같은지 비교한다.
//				 * 3. if(true) >> select해서 해당 BoardNo에 참여한 사람들 닉네임, 전화번호 조회해오기.
//				 * 4. 쪽지로 "모임장 : xxx 전화번호 : 010-xxxx-xxxx"
//				 *        "참여자 : xxx 전화번호 : 010-xxxx-xxxx" 이런식으로 보내기.
//				 * */
//			};
//		};
//		
//		time.schedule(task, 0, 1000);
//		
		request.getRequestDispatcher("views/food/foodMain.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
