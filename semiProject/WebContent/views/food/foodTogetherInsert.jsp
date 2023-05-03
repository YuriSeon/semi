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
            width: 25%;
            height: 100%;
            box-sizing: border-box;
            float: left;
        }
        #fit1r, #fit2r, #fit3r, #fit4r, #fit5r{
            width: 75%;
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
        }
        #fit21,#fit22,#fit23,#fit24{
            width: 25%;
            height: 100%;
            float: left;
            box-sizing: border-box;
        }
    </style>
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
	    <div id="fio" style="margin:auto">
        <div id="fit1">
            <div id="fit1l" style="font-size: 18px; font-weight: 1000; text-align: center; line-height: 3;">제목</div>
            <div id="fit1r"><input type="text" name="title" style="width:100%; height:80%" required></div>
        </div>
        <div id="fit2">
            <div id="fit21" style="font-size: 18px; font-weight: 1000;text-align: center; line-height: 3;">모집 인원</div>
            <div id="fit22"><input type="number" name="person"style="width:100%; height:80%"  required></div>
            <div id="fit23" style="font-size: 18px; font-weight: 1000;text-align: center; line-height: 3;">종료 시간</div>
            <div id="fit24"><input type="time" id="timer" style="width:100%; height:80%" name="endTime" required></div>
        </div>
        <div id="fit3">
            <div id="fit3l" style="font-size: 18px; font-weight: 1000;text-align: center; line-height: 3;">내용</div>
            <div id="fit3r"><textarea name="content" cols="30" rows="10" style="resize: none; width:100%; height:80%" required><%if(request.getAttribute("menu")!=null){%>메뉴 : <%=request.getAttribute("menu") %><%} %></textarea></div>
        </div>
        <div id="fit4">
            <div id="fit4l" style="font-size: 18px; font-weight: 1000;text-align: center; line-height: 3;">주소</div>
            <div id="fit4r">
            	<%if(request.getAttribute("address")==null){ %>
                	<div id="fit41"><input type="text" name="mainAddress" id="mainAddress" style="width: 100%; height:80%;" required></div>
                	<div id="fit42"><input type="text" name="subAddress" id="subAddress" style="width: 100%; height:80%;" placeholder="상세 주소를 입력해주세요."></div>
                <%} else { %>
                	<div id="fit41"><input type="text" name="mainAddress" style="width: 100%; height:100%;" id="mainAddress" value="<%=address1 %>"></div>
                	<div id="fit42"><input type="text" name="subAddress" style="width: 100%; height:100%;" id="subAddress" value="<%=address2 %>"></div>
                <%} %>
            </div>
        </div>
        <div id="fit5">
            <div id="fit5l" style="font-size: 18px; font-weight: 1000;text-align: center; line-height: 3;">음식사진</div>
         <%if(request.getAttribute("img") == null){ %>
            <div id="fit5r">
        		<input type="file" id="togetherImg" name="togetherImg" style="width:100%; height:100%" required>
            </div>
        <%} else { %>
        	<div id="fit5r">
        		<input type="file" id="togetherImg" name="togetherImg" style="width:100%; height:100%" value="C:\\fakepath\\<%=((String)request.getAttribute("origin")) %>" required>
            </div>
        <%} %>
        </div>
        <div id="fit6">
            <div id="fit6l">
            <%if(request.getAttribute("img")==null){ %>
            	<img id="miriImg" style="display:block; width:100%; height:100%">
            <%} else {  %>
            	<img id="miriImg" src="<%=((String)request.getAttribute("img"))%>" style="width:100%; height:100%">
            	<input type="hidden" name="originName"  style="width:100%; height:100% value="<%=((String)request.getAttribute("origin")) %>">
            	<input type="hidden" name="fullImg"  style="width:100%; height:100% value="<%=((String)request.getAttribute("img")) %>">
            <%} %>
            </div>
            	<div id="fit6r">
            		<div id="map" style="width: 100%; height: 100%;" align="center" ></div>
            	</div>
        </div>
        <div id="fitbtn" style="text-align: center;">
            <button type="submit" class="btn btn-success">등록하기</button>
            <button type="button" class="btn btn-warning" onclick="location.href='<%=request.getContextPath()%>/foodTogether.bo'">뒤로가기</button>
        </div>
    </div>
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