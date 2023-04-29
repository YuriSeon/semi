<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.4.js"integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script> 
<script type="text/javascript"src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f91f4c1499628ccd44bb5d41070cb9a1&libraries=services"></script>
    <style>
        #topdiv{
            width: 850px;
            height: 800px;
            box-sizing: border-box;
            margin: auto;
        }
        #topdiv *{
            float: left;
        }
        #foodboarddiv, #foodImgdiv{
            width: 47.5%;
            height: 40%;
            box-sizing: border-box;
        }
        #titleDiv{
            width: 100%;
            height: 10%;
            box-sizing: border-box;
        }
        #contentDiv{
            width: 100%;
            height: 40%;
            box-sizing: border-box;
        }
        #endTimediv{
            width: 100%;
            height: 22%;
            box-sizing: border-box;
        }
        #persondiv{
            width: 100%;
            height: 22%;
            box-sizing: border-box;
        }
        #nonediv1{
            width: 100%;
            height: 2%;
            box-sizing: border-box;
        }
        #nonediv{
            width: 5%;
            height: 40%;
            box-sizing: border-box;
        }
        #botImg{
            width: 100%;
            height: 35%;
            background-color: black;
            box-sizing: border-box;
        }
        #addDiv{
            width: 100%;
            height: 5%;
            box-sizing: border-box;
        } 
        #button3{
            width: 100%;
            height: 7%;
            box-sizing: border-box;
        }
        #etcbtns{
            width: 100%;
            height: 7%;
            box-sizing: border-box;
        }

        
    </style>

</head>
<body>
<%@ include file="../common/menubar.jsp" %>
	<%
		HashMap<String, String> map = (HashMap<String, String>)request.getAttribute("map");
	%>
	
	
	
	 <div id="topdiv">
            <div id="foodImgdiv">
            <img id="miriImg" src='<%=map.get("filePath")  + "/"+ map.get("changeName")%>' style="width:100%; height:100%">
            </div>
            <div id="nonediv"></div>
            <div id="foodboarddiv">
                <div id="titleDiv" style="font-weight: 1000; font-size:20px">
                    <%=map.get("title") %>
                </div>
                <div id="nonediv1"></div>
                <div id="contentDiv">
                    내용 : <%=map.get("content") %>
                </div>
                <div id="nonediv1"></div>
                <div id="endTimediv">
                종료시간 : <%=map.get("endTime") %>
                </div>
                <div id="nonediv1"></div>
                <div id="persondiv">
                	인원제한 : <%=map.get("person") %>명
                </div>
            </div>
            <div id="nonediv1"></div>
            <div id="botImg">
            <div id="map" style="width: 100%; height: 100%;" align="center"></div>
            </div>
            <div id="nonediv1"></div>
            <div id="addDiv">
            <%=map.get("mainAddress") %> <%=(map.get("subAddress")==null)?"":map.get("subAddress") %>
            </div>
            <div id="nonediv1"></div>
            <div id="button3" style="text-align: center;">
            <%if(map.get("userId").equals(((BMember)request.getSession().getAttribute("loginUser")).getUserId())){ %>
        	    		<button type="submit"> 수정하기 </button>
            			<button type="button" onclick="location.href='<%=contextPath %>/deleteTogether.bo?bno=<%=request.getParameter("bno")%>'">삭제하기</button>
            		<%} else { %>
            			<button type="button" id="nadu">참여하기</button>
            		<%} %>
            		<button type="button" onclick="history.back();">돌아가기</button>
            </div>
            <div id="etcbtns"></div>
        </div>
        
        
        
	    <form action="<%=contextPath %>/foodTogetherUpdate.bo" method="get">
        <table align="center">
        	<tr>
        		<th>작성자</th>
        		<td><%=map.get("userId") %></td>
        	</tr>
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
            	<td><input type="hidden" name="filePath" value="<%=map.get("filePath") %>"></td>
            	<td><input type="hidden" name="bno" value="<%=map.get("boardNo") %>"></td>
            	<td><input type="hidden" name="originName" value="<%=map.get("originName") %>"></td>            	
            </tr>
            <tr>
	            <td>
    	        	<%if(map.get("userId").equals(((BMember)request.getSession().getAttribute("loginUser")).getUserId())){ %>
        	    		<button type="submit"> 수정하기 </button>
            			<button type="button" onclick="location.href='<%=contextPath %>/deleteTogether.bo?bno=<%=request.getParameter("bno")%>'">삭제하기</button>
            		<%} else { %>
            			<button type="button" id="nadu">참여하기</button>
            		<%} %>
            		<button type="button" onclick="history.back();">돌아가기</button>
            	</td>
            </tr>
        </table>
    </form>
    
    <script>
    
	window.onpopstate = function(event) {
	    history.pushState(null, null, '<%=request.getHeader("Referer")%>');
	    location.reload();
	}
	history.pushState(null, null, null);
	
	
    $(function(){
    	
    	if(("<%=(int)request.getAttribute("check")%>") > 0){
    		console.log("???"  + "<%=(int)request.getAttribute("check")%>");
    		if("<%=(int)request.getAttribute("check")%>" == "<%=Integer.parseInt(map.get("boardNo")) %>"){
	    		$("#nadu").css("color", "red");    			
    		}
    	}
    	
    	
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
		
		
		$("#nadu").on("click", function nadu(){
			$.ajax({
				url : "togetherCheck.bo",
				data : {
					userNo : "<%=((BMember)request.getSession().getAttribute("loginUser")).getUserNo()%>", // 참여자 번호
					bno : "<%=map.get("boardNo") %>", // 해당 글번호
					writerId : "<%=map.get("userId")%>", // 작성자 아이디 (uniqe)
					person : "<%=map.get("person") %>"
				},
				type : "get",
				success : function(data){
					if(data == "iii"){
						alert("글 작성자는 다른 글에 참여 할 수 없습니다.");
					}
					if(data == "err"){
						this.error(data);
					}
					if(data == 1){
						console.log("참여 이력이 없고 참여 되었다.");
						$("#nadu").css("color", "red");
					}else{
						alert("이전 참여 이력이 사라집니다.");
						$("#nadu").css("color", "black");
					}
				},
				error : function(data){
					console.log("ajax error");
				}
			})
		})
		
    });
    </script>
</body>
</html>