<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Break Time[Food_Main]</title>
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	
	<h1>맛집 메인 페이지 입니다.</h1>
	현재 위치 :
	<input type="text" id="userCurrLo" size="100">
	<p>
		현재 위치를 기반으로 "뭐먹지"를 클릭하면 맛집 순위에서 현재위치와 일치하는 곳을 추천합니다. (slide로 하나씩 넘겨볼 수
		있다.) <br> 없다면 "맛집이 없습니다." 라는 것으로 대체
	</p>
	<a href="<%=request.getContextPath()%>/foodRanking.bo">맛집 순위</a>
	<a href="<%=request.getContextPath()%>/foodTogether.bo">같이 먹을 사람</a>
	<a href="<%=request.getContextPath()%>">뭐 먹지?</a>
	<script>
	$(function(){
		try{			
			function success(pos) {
				var crd = pos.coords;
				lat = crd.latitude; // 위도
				lon = crd.longitude; // 경도
			};

			function error(err) {
				$("#userCurrLo").attr("placeholder","현재 위치를 찾기 못했습니다.")
			};
		navigator.geolocation.getCurrentPosition(success, error);
		// 위도 경도 받는데 생각보다 시간이 딜레이된다.
		// settimeout으로 우선 해결..
		var time = 100;
		try{
			lon			
		}catch(err){
			time = time * 10;			
			$("#userCurrLo").attr("placeholder","위치 추적중");
		}
		setTimeout(() => {
	        $.ajax({
	            url: 'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=' + lon + '&y=' + lat,
	            type: 'GET',
	            headers: {
	                'Authorization': 'KakaoAK 443a788ac3404e8299a0b6615292d7b9'
	            },
	            success: function (data) {
	            	if(data.documents[0].road_address == null){
		                $("#userCurrLo").val(data.documents[0].address.address_name);            		
	            	}else{
		                $("#userCurrLo").val(data.documents[0].road_address.address_name);            				            		
	            	}
	            },
	            
	            error : function (e) {
	                console.log("error");
	            }
	        });
		}, time);
		
		// 이렇게 얻은 위치 정보로 맛집 게시판에 올라온 주소와 비교해서 맛집이 있다면 보여준다.
		}catch(err){
			$("#userCurrLo").attr("placeholder","위치 추척에 실패ㅠㅠ 주소를 직접 입력해주세요.");
				document
						.getElementById("kakao_address")
						.addEventListener(
								"click",
								function() { 
									new daum.Postcode(
											{
												oncomplete : function(data) {
													document
															.getElementById("kakao_address").value = data.address; 
												}
											}).open();
								});
			}
	});
    </script>

</body>
</html>