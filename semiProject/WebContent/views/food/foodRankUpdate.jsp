<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.js"
	integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f91f4c1499628ccd44bb5d41070cb9a1&libraries=services"></script>
<title>BreakTime[Update View]</title>

</head>
<body>
	<form
		action="<%=request.getContextPath()%>/foodRankUpdate.bo?bno=<%=request.getParameter("bno")%>"
		method="get">
		<h1>수정하기</h1>
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="Btitle"
					value="<%=(String) request.getAttribute("title")%>" required></td>
			</tr>
			<tr>
				<th>음식 카테고리</th>
				<td>
					<%
						String food = (String) request.getAttribute("foodName");
					%> <select name="foodselect" id="foodselect"
					onchange="hiddenselect()">
						<!-- 나중에 생각하기.... -->
						<option value="1">떡볶이</option>
						<option value="2">김밥</option>
						<option value="3">치킨</option>
						<option value="4">피자</option>
						<option value="5">파스타</option>
						<option id="etc" value="0">기타</option>
				</select> <input type="text" id="hiddeninput" name="newfood"
					style="display: none;"> <script>
						
						$("#foodselect option").each(function(){
							if(this.text == "<%=food%>"){
								$(this).prop("selected", true);
							}else{
								$("#etc").prop("selected", true);
								$("#hiddeninput").css("display", "block").val("<%=food%>");
							}
						});
					</script>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="30" name="content"
						style="resize: none" required><%=(String) request.getAttribute("content")%></textarea></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" id="kakao_address" name="address"
					value="<%=(String) request.getAttribute("address1")%>" required></td>
			</tr>
			<tr class="detailaddress" style="display: none">
				<th>상세 주소</th>
				<td><input id="iiii" type="text" name="addressDetail"></td>
			</tr>
		</table>
		<div id="map" style="align: center; width: 500px; height: 350px;"></div>
		<button type="submit">수정 등록하기</button>
	</form>
</body>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	
	window.onload = function() {
		document
				.getElementById("kakao_address")
				.addEventListener(
						"click",
						function() { //주소입력칸을 클릭하면
							//카카오 지도 발생
							new daum.Postcode(
									{
										oncomplete : function(data) { //선택시 입력값 세팅
											document
													.getElementById("kakao_address").value = data.address; // 주소 넣기
											$(".detailaddress").css("display", "table-row");
											document
											.querySelector(
													"input[name=addressDetail]")
											.focus(); //상세입력 포커싱
										}
									}).open();
						});
		

	};
</script>
<script>

// 주소로 좌표를 검색합니다
<%-- geocoder.addressSearch('<%=request.getAttribute("address1")%> <%=request.getAttribute("address2")%>', function(result, status)  --%>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};  

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

//주소로 좌표를 검색합니다
<%-- geocoder.addressSearch('<%=request.getAttribute("address1")%> <%=request.getAttribute("address2")%>', function(result, status) { --%>
var pickAddress = $("#kakao_address").val();
console.log(pickAddress);
geocoder.addressSearch(pickAddress, function(result, status) {

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






$("#iiii").on("focusin", function() {
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
<%-- geocoder.addressSearch('<%=request.getAttribute("address1")%> <%=request.getAttribute("address2")%>', function(result, status) { --%>
var pickAddress = $("#kakao_address").val() + " " + $("#iiii").val();
geocoder.addressSearch(pickAddress, function(result, status) {

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




</script>
</body>
</html>