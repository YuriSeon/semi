<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.kh.board.model.vo.Board, com.kh.bMember.model.vo.BMember"%>
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
 %>
 	<h1>상세보기</h1>
 	<form action="<%=request.getContextPath() %>/foodRankUpdate.bo?bno=<%=request.getParameter("bno")%>" method="post">
	<table id = "table-area">
		<%if(m.getUserId() != b.getBoardWriter()){ %>
		<tr>
			<th>작성자 : </th>
			<td><%=b.getBoardWriter() %> </td>
		</tr>
		<%} else { %>
		<tr>
			<th>작성자 : </th>
			<td>본인</td>
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
		<%if(!b.getAbbress().equals("")){ %>
		<tr>
			<th>주소</th>
			<td><input type="text" id="address" name="address1" value="<%=b.getAbbress() %>" readOnly></td>
		</tr>
		<% } else { %>
		<tr>
			<th>주소</th>
			<td><input type="text" id="address" name="addresss1" value="입력된 주소가 없습니다." readOnly></td>
		</tr>
		<%} %>		
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
			$(function(){
				$("#button3").children().click(function(){
					var btnName = this.id;
					$.ajax({
						url : this.id,
						data : {
							bno : "<%=request.getParameter("bno")%>"
						},
						success : function (data){
							switch(btnName){
							case "goodbtn":
								$("#goodbtn").html("추천" + data);
								break;
							case "badbtn" :
								$("#badbtn").html("비추천" + data);
								break;
							case "reportbtn" :
								$("#reportbtn").html("신고" + data);
								break;
							}
						},
						error : function(){
							console.log(this.id + " error ");
						}
					});
				});
			});
			
	</script>
	
	
	
	
	<%if(m != null && m.getUserNo() == b.getUn()){ %>
	<button type="submit">수정하기</button>
	<button type="button" onclick="location.href='<%=request.getContextPath()%>/foodRankDelete.bo?bno=<%=request.getParameter("bno")%>'">삭제하기</button>
	<%} %>
	<button type="button" onclick="location.href=<%=request.getContextPath() %>/foodRanking.bo">목록보기</button>
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
geocoder.addressSearch("<%=b.getAbbress()%>", function(result, status) {

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