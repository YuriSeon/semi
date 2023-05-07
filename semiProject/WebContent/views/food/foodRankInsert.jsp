<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.6.4.js"integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script> 
		<script type="text/javascript"src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f91f4c1499628ccd44bb5d41070cb9a1&libraries=services"></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>

<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	
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
        #fit6l, #map{
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
	<body>

		<body>
		<%@ include file="../common/menubar.jsp" %>
		
<form action="<%=request.getContextPath()%>/rankInsert.bo" method="post" enctype="multipart/form-data" >
	<div id="fio" style="margin:auto">
        <div id="fit1">
            <div id="fit1l">제목</div>
            <div id="fit1r"><input type="text" name="Btitle" style="width:100%; height:80%" required></div>
        </div>
        <div id="fit2">
            <div id="fit2l">음식 카테고리</div>
            <div id="fit2r">
            	<select name="foodselect" id="foodselect" onchange="hiddenselect()" style="width:98%; height:40%">
								<!-- 나중에 생각하기.... -->
								<option value="1">떡볶이</option>
								<option value="2">김밥</option>
								<option value="3">치킨</option>
								<option value="4">피자</option>
								<option value="5">파스타</option>
								<option value="0">기타</option>
				</select>
				<input type="text" id="hiddeninput" name="newfood" style="display:none; width:100%; height:40%; margin-top:5px;"placeholder="음식 이름을 입력해주세요.">
            </div>
        </div>
        <div id="fit3">
            <div id="fit3l">내용</div>
            <div id="fit3r">
            <textarea rows="10" cols="30" name="content" style="resize: none; width:100%; height:90%" required></textarea>
            </div>
        </div>
        <div id="fit4">
            <div id="fit4l">주소</div>
            <div id="fit4r">
                <div id="fit41"><input type="text" style="width:100%; height:80%" id="mainAddress" name="address" placeholder="주소를 입력해주세요." required></div>
                <div id="fit42"><input type="text" style="width:100%; height:80%" name="addressDetail" id="iiii"></div>
                <input type="hidden" name="saveAddress" id="saveAddress">
            </div>
        </div>
        <div id="fit5">
            <div id="fit5l">음식사진</div>
            <div id="fit5r"><input type="file" id="insertImg" name="firstImg" style="width:100%; height:100%;" required ></div>
        </div>
        <div id="fit6">
            <div id="fit6l"><img id="miri" style="display:none; width:100%; height:100%;"></div>
            <div id="map" tabindex="0" align="center"></div>
        </div>
        <div id="fibtn" style="text-align: center; line-height: 3;">
		    <button type="submit" class="btn btn-success">등록하기</button>
		    <button type="button" class="btn btn-warning" onclick="location.href='<%=request.getContextPath()%>/foodRanking.bo'">뒤로가기</button>
        </div>
    </div>
</form>
		
		
		</body>
		<script>
		
		$("#insertImg").on("change", (e)=>{readImg(e.target)});
		
		function readImg(input){
			const reader = new FileReader();
			
			reader.onload = e =>{
				$("#miri").css("display", "block");
				$("#miri").attr("src", e.target.result);
				$("#miri").css("width", "100%").css("height", "100%");
			}
			try{				
				reader.readAsDataURL(input.files[0])
			}catch(err){
				alert("현재 파일이 없습니다.");
			}
		}
		
		
		
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
							new daum.Postcode(
								{	oncomplete: function (data) { 
									var dongaddress = ""; // 도로명과 지번 중 어느것이 나올지 모르기 때문에 모든 지번으로 통일하기 위해 수정
									if(data.autoJibunAddress == ""){
										dongaddress = data.jibunAddress;
									}else{
										dongaddress = data.autoJibunAddress;
									}
													document.getElementById("mainAddress").value = data.address; // 주소 넣기
													document.getElementById("saveAddress").value = dongaddress;
													document.querySelector("input[name=addressDetail]").focus(); 
			 									}
								}).open();
						});
				// 같은 곳에 이벤트를 2개 걸어서 각각 상황에 맞는 이벤트가 실행되게 수정
// 				document.getElementById("mainAddress").addEventListener("onfocus", function () { 
// 							new daum.Postcode(
// 								{	oncomplete: function (data) { 
// 									var dongaddress = ""; // 도로명과 지번 중 어느것이 나올지 모르기 때문에 모든 지번으로 통일하기 위해 수정
// 									if(data.autoJibunAddress == ""){
// 										dongaddress = data.jibunAddress;
// 									}else{
// 										dongaddress = data.autoJibunAddress;}
// 													document.getElementById("mainAddress").value = data.address;
// 													document.getElementById("saveAddress").value = dongaddress;
// 													document.querySelector("input[name=addressDetail]").focus(); 
												
// 								}}.open()) // tab키로 이동시에도 똑같이 실행되게 만들었다.
// 			});
				$("#mainAddress").on("keyup",()=>{
    	new daum.Postcode(
                {
                    oncomplete: (data) => { //선택시 입력값 세팅
                        var dongaddress = ""; // 모두 지번으로 받을꺼다.
                        if (data.autoJibunAddress == "") {
                            dongaddress = data.jibunAddress;
                        } else {
                            dongaddress = data.autoJibunAddress;
                        }
                        $("#mainAddress").val(data.address);
                        $("#maptr").css("display", "block");
                        $("input[name=subAddress]").focus();
                    }
                }).open()
    })

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
				var pickAddress = $("#mainAddress").val();
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