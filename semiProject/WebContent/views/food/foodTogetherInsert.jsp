<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BreakTime[Together]</title>
<script src="https://code.jquery.com/jquery-3.6.4.js"integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script> 
<script type="text/javascript"src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f91f4c1499628ccd44bb5d41070cb9a1&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath() %>/resources/food_js/foodTogeterInsert.js"></script>
<!-- 깔끔하게 진행하기 위해 자바스크립트 코드는 별도로 관리한다. -->
</head>

<body>
<%

	String addresss = ((String)request.getAttribute("address"));
	String address1 = "";
	String address2 = "";
	
	if(addresss != null){		
		address1 = ((String)request.getAttribute("address")).substring(0, addresss.lastIndexOf(" "));
		address2 = addresss.substring(addresss.lastIndexOf(" "));
	}

%>
	<%@ include file="../common/menubar.jsp" %>
    <form id="form" action="<%=contextPath %>/foodTogetherInsert.bo" method="post" enctype="multipart/form-data">
        <table align="center">
            <tr>
                <th style="width:200px;">제목</th>
                <td><input type="text" name="title" required></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" cols="30" rows="10" style="resize: none;" required><%if(request.getAttribute("menu")!=null){%>메뉴 : <%=request.getAttribute("menu") %><%} %></textarea></td>
            </tr>
            <%if(request.getAttribute("img") == null){ %>
            <tr>
                <th>뭐먹을지 사진</th>
                <td><input type="file" id="togetherImg" name="togetherImg" required></td>
            </tr>
            <%} %>
            <tr>
            	<td></td>
            	<%if(request.getAttribute("img")==null){ %>
            	<td align="center"><img id="miriImg" style="display:none;"></td>
            	<%} else { %>
            	<td align="center"><img id="miriImg" src="<%=((String)request.getAttribute("img"))%>" style="width:200px; height:200px"></td>
            	<td><input type="hidden" name="originName" value="<%=((String)request.getAttribute("origin")) %>"></td>
            	<td><input type="hidden" name="fullImg" value="<%=((String)request.getAttribute("img")) %>"></td>
            	<%} %>
            </tr>
            
            <tr>
                <th>주소</th>
                <%if(request.getAttribute("address")==null){ %>
                	<td><input type="text" name="mainAddress" id="mainAddress" required> <input type="text" name="subAddress" id="subAddress" style="width: 50px;"></td>
                <%} else { %>
                	<td><input type="text" name="mainAddress" id="mainAddress" value="<%=address1 %>">
                	<input type="text" name="subAddress" id="subAddress" value="<%=address2 %>" style="width: 50px;"></td>
                <%} %>
            </tr>
			
			<%if(request.getAttribute("address")==null) {%>
            <tr id="maptr" style="display: none;" align="center">
            	<td >
                    <div id="map" style="width: 100px; height: 100px;" align="center" ></div>
                </td>
            </tr>
            <%} else { %>
            <tr id="maptr" align="center">
            	<td >
                    <div id="map" style="width: 100px; height: 100px;" align="center" ></div>
                </td>
            </tr>
            <%} %>
            <tr>
                <th>모집 인원</th>
                <td><input type="number" name="person" required></td>
            </tr>
            <tr>
            	<th>종료시간</th>
            	<td><input type="time" id="timer" name="endTime" required></td>
            </tr>
            <tr>
                <th>등록하기</th>
                <td><button type="button" id="goo">등록하기</button></td>
                <td><button type="button" onclick="history.back();">돌아가기</button></td>
            </tr>
        </table>
    </form>
    <script>
   $(function(){
 	   $("#goo").on("click",function(){
		   if($("#mainAddress").attr("disabled") == "disabled"){			   
			   $("#mainAddress").attr("disabled", false);
			   $("#subAddress").attr("disabled", false);
		   }
		   $("#form").submit();
		   return false;

	   });
	   
	   if(<%=request.getAttribute("address") != null%>){
		   $("#mainAddress").attr("disabled", true);
		   $("#subAddress").attr("disabled", true);
	   }
	   
	   
	   if($("#mainAddress").val() != ""){
		   $("#mainAddress").off("click");
	   }
	   
	   if($("#map").css("display") == "block"){
    	var mapContainer = document.getElementById('map'),// 지도를 표시할 div 
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
   }
   });
    </script>
</body>
</html>