<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.kh.board.model.vo.Attachment" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.6.4.js"
			integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f91f4c1499628ccd44bb5d41070cb9a1&libraries=services"></script>
		<title>BreakTime[Update View]</title>
	
	<style>
	 #fio{
            width: 800px;
            height: 700px;
            box-sizing: border-box;
        }
        #fit1,#fit2,#fit5{
            width: 100%;
            height: 10%;
            box-sizing: border-box;
        }
        #fit4{
            width: 100%;
            height: 15%;
            box-sizing: border-box;
        }
        #fit3{
            width: 100%;
            height: 25%;
            box-sizing: border-box;
        }
        #fit6{
            width: 100%;
            height: 25%;
            box-sizing: border-box;
        }
        #fit1l, #fit2l, #fit3l, #fit4l, #fit5l{
            width: 30%;
            height: 100%;
            box-sizing: border-box;
            float: left;
        }
        #fit1r, #fit2r, #fit3r, #fit4r, #fit5r{
            width: 70%;
            height: 100%;
            box-sizing: border-box;
            float: left;
        }
        #fit41, #fit42{
            width: 100%;
            height: 50%;
            box-sizing: border-box;
        }
        #fit6l, #fit6r{
            width: 50%;
            height: 100%;
            box-sizing: border-box;
            float: left;
            border: 1px solid rgb(192, 192, 192);
        }
        #fibtn{
        	width:100%;
        	height:5%;
        	box-sizing: border-box;
        }
	</style>
	</head>

<%
	Attachment att = (Attachment)request.getAttribute("Attachment");
%>
	<body>
	<%@include file="../common/menubar.jsp" %>
	
<form action="<%=request.getContextPath()%>/foodRankUpdate.bo?bno=<%=request.getAttribute("boardNo")%>" method="post" enctype="multipart/form-data">
	<div id="fio" style="margin:auto">
	<input type="hidden" name="targetBoardNo" value="<%=request.getAttribute("boardNo")%>">
        <div id="fit1">
            <div id="fit1l">제목</div>
            <div id="fit1r"><input type="text" style="width:100%; height:80%" name="Btitle" value="<%=(String) request.getAttribute("title")%>" required></div>
        </div>
        <div id="fit2">
            <div id="fit2l">음식 카테고리</div>
            <div id="fit2r">
            	<% String food=(String)request.getAttribute("foodName"); %>
            	<select name="foodselect" id="foodselect" onchange="hiddenselect()" style="width:98%; height:40%">
								<!-- 나중에 생각하기.... -->
								<option value="1">떡볶이</option>
								<option value="2">김밥</option>
								<option value="3">치킨</option>
								<option value="4">피자</option>
								<option value="5">파스타</option>
								<option value="0">기타</option>
				</select>
				<input type="text" id="hiddeninput" name="newfood" style="display:none;" placeholder="음식 이름을 입력해주세요.">
				<script>
								$("#foodselect option").each(function () {
									if(this.text == "<%=food%>") {
										$(this).prop("selected", true);
										
									} else {
										$("#etc").prop("selected", true);
										$("#hiddeninput").css("display", "block").val("<%=food%>");
									}
								});
								
								function hiddenselect() {
									if ($("#foodselect option:selected").val() == 0) {
										$("#hiddeninput").css("display", "block");
									} else {
										$("#hiddeninput").css("display", "none");
										$("#hiddeninput").val($("#foodselect option:selected").text())
									}
								}
							</script>
            </div>
        </div>
        <div id="fit3">
            <div id="fit3l">내용</div>
            <div id="fit3r">
            <textarea rows="10" cols="30" name="content" style="resize: none; width: 100%; height: 80%"
							required><%=(String) request.getAttribute("content")%></textarea>
            </div>
        </div>
        <div id="fit4">
            <div id="fit4l">주소</div>
            <div id="fit4r">
                <div id="fit41"><input type="text" style="width:100%; height:80%;" id="kakao_address" name="address" value="<%=(String) request.getAttribute("address1")%>" required></div>
                <div id="fit42" ><input type="text" style="width:100%; height:80%" name="addressDetail" id="iiii"></div>
            </div>
        </div>
        <div id="fit5">
            <div id="fit5l">음식사진</div>
            <div id="fit5r">
<%--             	<input type="file" id="insertImg" name="firstImg" style="width:100%; height:100%;" value="<%=att.getOriginName() %>" required> --%>
            	<input type="file" id="reupload" name="reupload" style="display:none;">
<!--             	<img alt="??" id="miri" style="display:none"> -->
            </div>
        </div>
        <div id="fit6">
            <div id="fit6l">
            	<img alt="대표이미지" src="<%=contextPath+att.getFilePath()+"/"+att.getChangeName()%>" id="mainImg" name="mainImg" style="width:100%; height:100%;">
<!--             	<input type="file" id="reupload" name="reupload" style="display:none;"> -->
            	<img alt="??" id="miri" style="display:none">
            </div>
            <div id="fit6r">
	            <div id="map" style="width: 100%; height: 100%;"></div>            
            </div>
			<input type="hidden" id="saveAddress">
        </div>
        <div id="fibtn" style="text-align: center; line-height: 3;">
		    <button type="submit" class="btn btn-success">수정 등록하기</button>
		    <button type="button" class="btn btn-warning" onclick="location.href='<%=request.getContextPath()%>/foodRanking.bo'">뒤로가기</button>
        </div>
    </div>
</form>
	
	
	
	
	
	
<%-- 		<form action="<%=request.getContextPath()%>/foodRankUpdate.bo?bno=<%=request.getAttribute("boardNo")%>" method="post" enctype="multipart/form-data"> --%>
<!-- 			<h1>수정하기</h1> -->
<%-- 			<input type="hidden" name="targetBoardNo" value="<%=request.getAttribute("boardNo")%>"> --%>
<!-- 			<table> -->
<!-- 				<tr> -->
<!-- 					<th>제목</th> -->
<%-- 					<td><input type="text" name="Btitle" value="<%=(String) request.getAttribute("title")%>" required> --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>음식 카테고리</th> -->
<!-- 					<td> -->
<%-- <%-- 						<% String food=(String) request.getAttribute("foodName"); %> --%>
<!-- 							<select name="foodselect" id="foodselect" onchange="hiddenselect()"> -->
<!-- 								나중에 생각하기.... -->
<!-- 								<option value="1">떡볶이</option> -->
<!-- 								<option value="2">김밥</option> -->
<!-- 								<option value="3">치킨</option> -->
<!-- 								<option value="4">피자</option> -->
<!-- 								<option value="5">파스타</option> -->
<!-- 								<option id="etc" value="0">기타</option> -->
<!-- 							</select> <input type="text" id="hiddeninput" name="newfood" style="display: none;"> -->
<!-- 							<script> -->

<!-- 							</script> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>내용</th> -->
<!-- 					<td><textarea rows="10" cols="30" name="content" style="resize: none" -->
<%-- 							required><%=(String) request.getAttribute("content")%></textarea></td> --%>
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>음식 사진</th> -->
<!-- 					<td> -->
<%-- 							<img alt="대표이미지" src="<%=contextPath+att.getFilePath()+"/"+att.getChangeName()%>" id="mainImg" name="mainImg" style="width:150px; height:150px;"> --%>
<!-- 							<input type="file" id="reupload" name="reupload" style="display:none;"> -->
<!-- 							<img alt="??" id="miri" style="display:none"> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>주소</th> -->
<%-- 					<td><input type="text" id="kakao_address" name="address" value="<%=(String) request.getAttribute("address1")%>" required></td> --%>
<!-- 				</tr> -->
<!-- 				<tr class="detailaddress" style="display: none"> -->
<!-- 					<th>상세 주소</th> -->
<!-- 					<td><input id="iiii" type="text" name="addressDetail"></td> -->
<!-- 				</tr> -->
<!-- 			</table> -->
<!-- 			<div id="map" style="align: center; width: 500px; height: 350px;"></div> -->
<!-- 			<input type="hidden" id="saveAddress"> -->
<!-- 			<button type="submit">수정 등록하기</button> -->
<!-- 		</form> -->
	</body>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		$("#mainImg").on("click", function(){
			$("#reupload").click();
			
			$("#reupload").on("change", function(e){
				$("#reupload").css("display", "block");
				$("#miri").css("display", "block");
				$("#mainImg").css("display", "none");
				
				readImg(e.target);
			});
		});
		
		function readImg(input){
			const reader = new FileReader();
			
			reader.onload = e =>{

				$("#miri").attr("src", e.target.result);
				$("#miri").css("width", "100%").css("height", "100%");
			}
			try{				
				reader.readAsDataURL(input.files[0])
			}catch(err){
			}
		}


		window.onload = function () {
			document
				.getElementById("kakao_address")
				.addEventListener(
					"click",
					function () { //주소입력칸을 클릭하면
						//카카오 지도 발생
						new daum.Postcode(
							{
								oncomplete: function (data) { //선택시 입력값 세팅
									var dongaddress = ""; // 모두 지번으로 받을꺼다.
									if(data.autoJibunAddress == ""){
										dongaddress = data.jibunAddress;
									}else{
										dongaddress = data.autoJibunAddress;
									}
									document
										.getElementById("kakao_address").value = data.address; // 주소 넣기
									$(".detailaddress").css("display", "table-row");
										$("#saveAddress").val(data.dongaddress);
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


var pickAddress = $("#kakao_address").val();
			console.log(pickAddress);
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

var pickAddress = $("#kakao_address").val() + " " + $("#iiii").val();
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




	</script>
	</body>

	</html>