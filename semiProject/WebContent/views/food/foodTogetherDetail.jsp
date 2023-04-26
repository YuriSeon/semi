<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.js"integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script> 
<script type="text/javascript"src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f91f4c1499628ccd44bb5d41070cb9a1&libraries=services"></script>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
	<h1>foodTogetherDetail</h1>
	
	<%
		HashMap<String, String> map = (HashMap<String, String>)request.getAttribute("map");
	%>
	
	    <form action="<%=contextPath %>/foodTogetherUpdate.bo %>" method="get">
        <table align="center">
            <tr>
                <th style="width:200px;">제목</th>
                <td><input type="text" name="title" value="<%=map.get("title") %>" readOnly></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" cols="30" rows="10" style="resize: none;" readOnly><%=map.get("content") %></textarea></td>
            </tr>
            <tr>
            	<td></td>
            	<td align="center"><img id="miriImg" src='<%=map.get("filePath")  + "/"+ map.get("changeName")%>' style="width:150px; height:150px"></td>
            </tr>
            
            <tr>
                <th>주소</th>
                <td><input type="text" name="mainAddress" id="mainAddress" value="<%=map.get("mainAddress") %>" readOnly>
                <input type="text" name="subAddress" id="subAddress" value="<%=(map.get("subAddress")==null)?"":map.get("subAddress") %>" style="width: 50px;" readOnly></td>
                
                
            </tr>
		
            <tr id="maptr" align="center" >
            
            	<td >
                    <div id="map" style="width: 200px; height: 200px;" align="center"></div>
                </td>
                
            </tr>
            <tr>
                <th>모집 인원</th>
                <td><input type="text" name="person" value="<%=map.get("person") %>명" readOnly></td>
            </tr>
            <tr>
            	<th>종료시간</th>
            	<td><input type="time" id="timer" name="endTime" value="<%=map.get("endTime") %>" readOnly></td>
            	<td><input type="hidden" id="bno" name="boardNo" value="<%=map.get("boardNo") %>" readOnly></td>
            	<td><input type="hidden" name="changeName" value="<%=map.get("changeName") %>"></td>
            </tr>
            <tr>
	            <td>
            
    	        	<%if(true){ %>
        	    		<button type="submit"> 수정하기 </button>
            			<button type="button" onclick="location.href='<%=contextPath %>/deleteTogether.bo'"> 삭제하기</button>
            		<%} else { %>
            			<button type="button" onclick="go();">참여하기</button>
            		<%} %>
            		<button type="button" onclick="history.back();">돌아가기</button>
            	</td>
            </tr>
        </table>
    </form>
    
    <script>
    $(function(){    	
    	var mapContainer = document.getElementById('map'),// 지도를 표시할 div 
    					   mapOption = {center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        								level: 3};// 지도의 확대 레벨
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
    	}});
    })
    </script>
</body>
</html>