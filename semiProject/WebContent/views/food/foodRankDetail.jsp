<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.kh.board.model.vo.Board, com.kh.bMember.model.vo.BMember, com.kh.food.model.vo.FoodBtnCheck, com.kh.board.model.vo.Attachment, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Break Time[Detail]</title>
<script src="https://code.jquery.com/jquery-3.6.4.js"
	integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
	crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f91f4c1499628ccd44bb5d41070cb9a1&libraries=services"></script>
</head>
<body>
 <%
 	Board b = (Board)request.getAttribute("FoodRanking");
 	BMember m = ((BMember)request.getSession().getAttribute("loginUser"));
 	FoodBtnCheck fbc = (FoodBtnCheck)request.getAttribute("FoodBtnCheck");
 	Attachment att = (Attachment)request.getAttribute("att");
 %>
 	<%@include file="../common/menubar.jsp" %>
 	<h1>상세보기</h1>
 	<form action="<%=request.getContextPath() %>/foodRankUpdate.bo?bno=<%=request.getParameter("bno")%>" method="get">
 	<input type="hidden" name="helloworld"value="<%=request.getParameter("bno") %>">
 	<input type="hidden" name="imgname"value="<%=att.getChangeName() %>">
	<table id = "table-area">
		<%if(m.getUserId().equals(b.getBoardWriter())){ %>
		<tr>
			<th>작성자 : </th>
			<td>본인</td>
		</tr>
		<%} else { %>
		<tr>
			<th>작성자 : </th>
			<td><%=b.getBoardWriter() %> </td>
		</tr>
		<%} %>
		<tr>
			<th>제목</th>
			<td><input type="text" name="Btitle" value="<%=b.getBoardTitle() %>" readOnly></td>
		</tr>
		<tr>
			<th>메뉴</th>
			<td><input type="text" name="foodCate" value="<%=b.getFoodName()%>" readOnly></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="30" name="content"
					style="resize: none" readOnly><%=b.getBoardContent() %></textarea></td>
		</tr>
		<tr>
			<th>음식 사진 </th>
			<td>
				<img alt="대표이미지" src="<%=contextPath+att.getFilePath()+"/"+att.getChangeName()%>" id="mainImg" name="mainImg" style="width:150px; height:150px;">
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" id="address" name="address1" value="<%=b.getAbbress() %>" readOnly></td>
		</tr>
	
	</table>
	
	<%if(!b.getAbbress().equals("")){ %>
	<div id="map" style="align:center;width:500px;height:350px;"></div>
	<%} %>
	<br><br>
	
	
	<div id="button3">
	<button type="button" id="goodbtn">추천 <%=b.getGood() %></button>
	
	<button type="button" id="badbtn">비추천 <%=b.getBad() %></button>
	<button type="button" id="reportbtn">신고 <%=b.getReport() %></button>
	</div>
	
	<script>
	
	// 뒤로가기 버튼 제어하기 -------------------------------------------------------------
	window.onpopstate = function(event) {
	    history.pushState(null, null, '<%=request.getHeader("Referer")%>');
	    location.reload();
	}
	history.pushState(null, null, null);
	// ----------------------------------------------------------------------------
			$(function(){
				$("#button3").children().click(function(){
					var btnName = this.id;
					$.ajax({
						url : this.id,
						data : {
							bno : "<%=request.getParameter("bno")%>",
							writer : "<%=b.getBoardWriter() %>",
							gestNo : "<%=m.getUserNo()%>"
						},
						success : function (data){
								if(data[0] != null){
									var btn = data[0].btnStyle;
									console.log("button = " + btn);
									if(btn == "GOOD"){
										$("#goodbtn").css("color", "red");
										$("#badbtn").css("color", "black");
										$("#reportbtn").css("color", "black");
									}else if (btn == "BAD"){
										$("#badbtn").css("color", "red");			
										$("#goodbtn").css("color", "black");
										$("#reportbtn").css("color", "black");
									}else{
										$("#reportbtn").css("color", "red");			
										$("#badbtn").css("color", "black");
										$("#goodbtn").css("color", "black");
									}
								}else{
									$("#goodbtn").css("color", "black");
									$("#badbtn").css("color", "black");
									$("#reportbtn").css("color", "black");
								}
								
								$("#goodbtn").html("추천 " + data[1].good);
								$("#badbtn").html("비추천 " + data[1].bad);
								$("#reportbtn").html("신고 " + data[1].report);
							},
						error : function(){
							console.log(this.id + " error ");
						}
					});
				});
			});
		$(function(){
			<% if(fbc != null){%>
				var btn = "<%=fbc.getBtnStyle() %>";
				console.log("button = " + btn);
				if(btn == "GOOD"){
					$("#goodbtn").css("color", "red");
				}else if (btn == "BAD"){
					$("#badbtn").css("color", "red");			
				}else{
					$("#reportbtn").css("color", "red");			
				}
			<%}%>
		})
			
			
	</script>
	
	
	
	
	<%if(m != null && m.getUserNo() == b.getUn()){ %>
	<button type="submit">수정하기</button>
	<button type="button" onclick="location.href='<%=request.getContextPath()%>/foodRankDelete.bo?bno=<%=request.getParameter("bno")%>'">삭제하기</button>
	<%} %>
	
	<!-- <button type="button" onclick="location.href='<%=request.getHeader("Referer")%>'">목록보기</button> -->
	<button type="button" onclick="history.back();">목록보기</button>
	</form>
<script>
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

<%
	String showAddress = "";
	String[] arr = b.getAbbress().split(" ");
	for (int i = 0; i < arr.length - 1; i++){
		showAddress += arr[i] + " ";
	}
%>

geocoder.addressSearch("<%=showAddress%>", function(result, status) {
// 해결 방법 그냥 주소에 메인 주소 / 상세 주소 나눠두면 그냥 더 좋게 할 수 있지만 그러지 않았따...

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
</script>




</body>
</html>