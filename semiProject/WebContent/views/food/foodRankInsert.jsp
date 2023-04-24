<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.6.4.js"integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script> 
		<script type="text/javascript"src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f91f4c1499628ccd44bb5d41070cb9a1&libraries=services"></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	</head>
	<body>

		<body>
			<form action="<%=request.getContextPath()%>/rankInsert.bo" method="post">
				<table>
					<tr>
						<th>제목</th>
						<td><input type="text" name="Btitle" required></td>
					</tr>
					<tr>
						<th>음식 카테고리</th>
						<td>
							<select name="foodselect" id="foodselect" onchange="hiddenselect()">
								<!-- 나중에 생각하기.... -->
								<option value="1">떡볶이</option>
								<option value="2">김밥</option>
								<option value="3">치킨</option>
								<option value="4">피자</option>
								<option value="5">파스타</option>
								<option value="0">기타</option>
							</select>
							<input type="text" id="hiddeninput" name="newfood" style="display:none;">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="10" cols="30" name="content" style="resize: none" required></textarea></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><input type="text" id="mainAddress" name="address" required>
							<input type="hidden" name="saveAddress" id="saveAddress">
						</td>
					</tr>
					<tr>
						<th>상세 주소</th>
						<td><input type="text" name="addressDetail" id="iiii"></td>
					</tr>
					<tr>
						<div id="map" style="width: 500px; height: 350px;" tabindex="0" align="center"></div>
					</tr>
				</table>
				
				<button type="submit">등록하기</button>
			</form>
		</body>
		<script>
			$(function () {
				if ($("mainAddress").val() != 0) {
					$("input[name=addressDetail]").attr("required", true);
				}
			})
	
			function hiddenselect() {
				if ($("#foodselect option:selected").val() == 0) {
					$("#hiddeninput").css("display", "block");
				} else {
					$("#hiddeninput").css("display", "none");
				}
			}		
			
			window.onload = function () {
				document.getElementById("mainAddress").addEventListener("click",function () { 
							// 지도 오픈
							new daum.Postcode(
								{	oncomplete: function (data) { // 주소 선택시 자동으로 입력
									var dongaddress = ""; // 모두 지번으로 받을꺼다.
									if(data.autoJibunAddress == ""){
										dongaddress = data.jibunAddress;
									}else{
										dongaddress = data.autoJibunAddress;
									}
									console.log(dongaddress);
									console.log(data);
													document.getElementById("mainAddress").value = data.address; // 주소 넣기
													document.getElementById("saveAddress").value = dongaddress;
													
													document.querySelector("input[name=addressDetail]").focus(); //상세입력 포커싱
			 									}
								}).open();
						})
				// 이벤트 2개 걸기 (tab키로 작성시)
				document.getElementById("mainAddress").addEventListener("keyup", function () { 
							// 지도 오픈
							new daum.Postcode(
								{	oncomplete: function (data) { //선택시 입력값 세팅
									var dongaddress = ""; // 모두 지번으로 받을꺼다.
									if(data.autoJibunAddress == ""){
										dongaddress = data.jibunAddress;
									}else{
										dongaddress = data.autoJibunAddress;
													document.getElementById("mainAddress").value = data.address;
													document.getElementById("saveAddress").value = dongaddress;
													document.querySelector("input[name=addressDetail]").focus(); 
												}
								}}).open(), { once: true } // 한번만 실행할꺼다.
			});

			$("#iiii").on("focusin", function () {
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					level: 3 // 지도의 확대 레벨
				};
				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption);
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
				// 주소로 좌표를 검색합니다
				var pickAddress = $("#mainAddress").val() + " " + $("#iiii").val();
				geocoder.addressSearch(pickAddress, function (result, status) {
					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						// 결과값으로 받은 위치를 마커로 표시합니다
						var marker = new kakao.maps.Marker({
							map: map,
							position: coords
						});
						// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						map.setCenter(coords);
					}
				});
			});
			}
		</script>
	</body>

	</html>