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
	<%@ include file="../common/menubar.jsp" %>
    <form action="<%=contextPath %>/foodTogetherInsert.bo" method="post" enctype="multipart/form-data">
        <table align="center">
            <tr>
                <th style="width:200px;">제목</th>
                <td><input type="text" name="title" required></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" cols="30" rows="10" style="resize: none;" required></textarea></td>
            </tr>
            <tr>
                <th>뭐먹을지 사진</th>
                <td><input type="file" id="togetherImg" name="togetherImg" required></td>
        
            </tr>
            <tr>
            	<td></td>
            	<td align="center"><img id="miriImg" style="display:none;"></td>
            </tr>
            
            <tr>
                <th>주소</th>
                <td><input type="text" name="mainAddress" id="mainAddress" required> <input type="text" name="subAddress" id="subAddress" style="width: 50px;"></td>
            </tr>
		
            <tr id="maptr" style="display: none;" align="center">
            
            	<td >
                    <div id="map" style="width: 100px; height: 100px;" align="center" ></div>
                </td>
                
            </tr>
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
                <td><button type="submit">등록하기</button></td>
                <td><button type="button" onclick="history.back();">돌아가기</button></td>
            </tr>
        </table>
    </form>
</body>
</html>