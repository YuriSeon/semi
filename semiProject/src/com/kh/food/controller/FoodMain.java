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

import com.kh.bMember.model.vo.BMember;
import com.kh.food.model.service.FoodService;
import com.kh.food.model.vo.FoodTogether;
import com.kh.message.model.service.MessageService;
import com.kh.message.model.vo.Message;

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
		Timer time = new Timer();
		TimerTask task = new TimerTask() {
			
			@Override
			public void run() {
				Date d = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
				String nowStr = sdf.format(d);
				String[] nArr = nowStr.split(":");
				int now = Integer.parseInt(nArr[0])*60 + Integer.parseInt(nArr[1]);
				
				ArrayList<FoodTogether> toTime = new FoodService().selectEndTime();
				// 이거 그냥 시간이랑 보드 넘버, 인원 가져오기
				
				for(int i = 0; i < toTime.size(); i++) {
					String[] times = toTime.get(i).getEndTime().split(":");
					int et = Integer.parseInt(times[0])*60 + Integer.parseInt(times[1]);
					if(et <= now) {
						// 구인 종료
						System.out.println(toTime.get(i).getBoardNo() + "번 게시글의 모집 시간이 끝났습니다.");
						// 쪽지를 보내기 위해선 유저 넘버가 필요하다.
						ArrayList<BMember> list = new FoodService().selectAlluser(toTime.get(i).getBoardNo());
						// 1.boardNo를 통해 참여자 번호들과 전화번호를 가져올것이다.
						String msg = ""; 
						// 2. 보낼 메시지를 저장할 변수 선언
						for(BMember b : list) { // 메시지를 위한 작업
							msg += "닉네임 : " + b.getUserNick() + ", 연락처 : " + b.getPhone() + "<br>";
						}
						for(BMember b : list) {
							Message mg = new Message();
							mg.setUserWriter("1"); // 관리자의 이름으로 쪽지를 전송한다.
							mg.setAcceptUser(String.valueOf(b.getUserNo()));// 쪽지를 받을 사람
							mg.setMsgContent(msg); //쪽지 내용
							
							new MessageService().insertMessage(mg);
						}
						
					}
					System.out.println("+++++ 스레드가 돌아가는걸 보여주기 위한 코드 +++++");
				}
			};
		};
		time.schedule(task, 0, 1000); // 1초에 한번씩 실행하겠다.
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
