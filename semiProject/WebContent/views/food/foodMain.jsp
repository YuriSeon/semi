<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Break Time[Food_Main]</title>
<script src="https://code.jquery.com/jquery-3.6.4.js"
	integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
	crossorigin="anonymous"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
@import url(https://fonts.googleapis.com/css?family=Open+Sans);

body {
	background: #f2f2f2;
}

.search {
	width: 40%;
	postion: absolute; margin : auto;
	left: 0;
	right: 0;
	display: flex;
	margin: auto;
}

.searchTerm {
	width: 100%;
	border: 3px solid #00B4CC;
	padding: 5px;
	border-radius: 0px 5px 5px 0px;
	outline: none;
	color: #9DBFAF;
}

.searchTerm:focus {
	color: #00B4CC;
}

.searchButton {
	width: 40px;
	height: 40px;
	border: 1px solid #00B4CC;
	background: #00B4CC;
	color: #fff;
	border-radius: 5px 0px 0px 5px;
	cursor: pointer;
	font-size: 20px;
}

/*Resize the wrap to see the search bar change!*/
.wrap {
	width: 100%;
	margin: auto;
	position: relative;
}

#hi {
	height: 20%;
	width: 100%;
}

#UserShowPage{
	width: 50%;
	height: 460px;
	box-sizing: border-box;
	margin: auto;
}
#topmargin{
	height: 10%;
	width: 100%;
	box-sizing: border-box;
}
#left{
	width: 100%;
	height: 30%;
	box-sizing: border-box;
}
#left * {
	float: left;
}
#foodrankbtn, #foodtogetherbtn{
	width: 45%;
	height: 100%;
	border: 1px solid red;
	box-sizing: border-box;
}
#nonediv{
	width: 10%;
	height: 100%;
	box-sizing: border-box;
}
#bottomshow{
	width: 100%;
	height: 60%;
	box-sizing: border-box;
}
.noneb1{
	width: 100%;
	height: 5%;
}
#whatfood, #ads{
	width: 100%;
	height: 70%;
	box-sizing: border-box;
}
</style>
</head>
<%@include file="../common/menubar.jsp" %>
<body>
	<div class="wrap">
		<div class="search">
			<button type="submit" class="searchButton" id="locationFoodBtn">
				밥
			</button>
			<input id="userCurrLo" type="text" class="searchTerm" name="userCurrLo" readOnly>
		</div>
	</div>
	<div id="locactionFood" style="display:none">
		<button type="button" id="returnMain">종료하기</button>
		<button id="prebtn"> &lt </button>
		<div id="foodSlide">
			
		</div>
		<button id="nextbtn"> &gt </button>
		<button id="togeterbtn">같이 먹을 사람 찾으러 가기</button>
		<input type='hidden' name='locationbno'>
	</div>
	<div id="UserShowPage">
		<div id ="topmargin"></div>
		<div id="left">
			<div id="foodrankbtn">
				<a href="<%=request.getContextPath()%>/foodRanking.bo">맛집 순위</a>
			</div>
			<div id="nonediv"></div>
			<div id="foodtogetherbtn" style="background-image: url(https://t1.daumcdn.net/cfile/tistory/997400445ED1FE5D18); background-size: 100%, 100%;">
				<a href="<%=request.getContextPath()%>/foodTogether.bo">같이 먹을 사람</a>
			</div>
		</div>
		<div id="bottomshow">
			<div class="noneb1"></div>
			<div id="ads" style="background-image: url(https://img.woowahan.com/www/common/baemin.jpg); background-size:100% 100%;" onclick="location.href='https://www.baemin.com/'">
			</div>
			<div class="noneb1"></div>
			<div id="whatfood">
				<a href="<%=request.getContextPath()%>">뭐 먹지?</a>
				<!-- 지금 맛집에 있는 것들 -->
			</div>
		</div>
	</div>
	<script>
	$(function(){
		try{			
			function success(pos) {
				var crd = pos.coords;
				lat = crd.latitude; // 위도
				lon = crd.longitude; // 경도
			};

			function error(err) {
				$("#userCurrLo").attr("placeholder","현재 위치를 찾기 못했습니다.")
			};
		navigator.geolocation.getCurrentPosition(success, error);
		// 위도 경도 받는데 생각보다 시간이 딜레이된다.
		// settimeout으로 우선 해결..
		var time = 150;
		try{
			lon			
		}catch(err){
			time = time * 10;			
			$("#userCurrLo").attr("placeholder","위치 추적중");
		}
		setTimeout(() => {
	        $.ajax({
	            url: 'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=' + lon + '&y=' + lat,
	            type: 'GET',
	            headers: {
	                'Authorization': 'KakaoAK 443a788ac3404e8299a0b6615292d7b9'
	            },
	            success: function (data) {
		                $("#userCurrLo").val(data.documents[0].address.address_name);            		
	            }	,
	            
	            error : function (e) {
	                console.log("error");
	            }
	        });
		}, time);
		
		// 이렇게 얻은 위치 정보로 맛집 게시판에 올라온 주소와 비교해서 맛집이 있다면 보여준다.
		}catch(err){
			$("#userCurrLo").attr("placeholder","위치 추척에 실패ㅠㅠ 주소를 직접 입력해주세요.");
				document
						.getElementById("kakao_address")
						.addEventListener(
								"click",
								function() { 
									new daum.Postcode(
											{
												oncomplete : function(data) {
													document
															.getElementById("kakao_address").value = data.address; 
												}
											}).open();
								});
			}
	});
	
     var number = 0; // 전역으로 사용할 내용

    $("#locationFoodBtn").on("click", function(){
        if($("#userCurrLo").val() == ""){
            alert("아직 위치 추적중입니다.");
            
        }else{
            $("#UserShowPage").css("display", "none");
            $("#locactionFood").css("display", "block");
            
            var userLocation = $("#userCurrLo").val();
            showList(userLocation);
        }
    });
    // 넘겨주기 위해 전역 변수로 지정
    var menu = "";
    var address = "";
    var imgAddress = "";
    var originName = "";
    var changeName = "";

    function showList(userLocation){
        $.ajax({
            type : "get",
            url : "locationFood.bo",
            data : {
                location : userLocation
            },
            success : function(data){
                var length = data.length;
                if(data[0].length == 0){
                    $("#foodSlide").html("지금 준비된 음식 이 없습니다.");
                    $("#togeterbtn").attr("disabled", true);
                }else{
                	$("#locactionFood").not("*").css("color","red");
                    if(number > data[0].length-1){
                        number = 0;
                    }else if(number < 0){
                    	number = data[0].length-1;
                    }
                    // 현재 0에는 board list 1에는 attachment list
                    var imgadd = "<%=contextPath %>" + data[1][number].filePath + "/" + data[1][number].changeName;
                    var foodStart = "";
                    menu = data[0][number].foodName;
                    address = data[0][number].abbress;
                    originName = data[1][number].originName;
                    console.log(originName);
                    imgAddress = "<%=contextPath %>" + data[1][number].filePath + "/" + data[1][number].changeName;
                    foodStart += "<h1>" + number +"</h1>"
                    foodStart += "메뉴 : " + data[0][number].foodName + "<br>주소 : " + data[0][number].abbress + "<br>추천수 : " + data[0][number].good;
                    foodStart += "<input id='justbno' just type='hidden' value='"+ data[0][number].boardNo +"'>";
                    foodStart += "<img alt='대표이미지' src='" + imgadd + "' style='width:150px; height:150px;'>";
                    $("#foodSlide").html(foodStart);
                }
            },
            error : function(){
                // 이건 그냥 통신 x
                $("#foodSlide").text("현재 통신에 문제가 있습니다.");
                console.log("Error");
            }
        });
    };
    
    $("#locactionFood").on("click", "button", function(){
    	if(this.id == "nextbtn" || this.id == "prebtn"){
    		let userLocation = $("#userCurrLo").val();
    		if(this.id == "nextbtn"){
    			number = number +1;
    		}else{
    			number = number - 1;
    		}
    		showList(userLocation);
    	}
    });
	
	$("#returnMain").on("click", function(){
		$("#locactionFood").css("display", "none");
		$("#UserShowPage").css("display", "block");
	});
	
	$("#foodSlide").on("click",function(){
		if($("#justbno").val() == null){
			alert("현재 맛집없는데 클릭했어요...");
		}else{			
			location.href = "<%=request.getContextPath() %>/foodRankingDetail.bo?bno=" + $("#justbno").val();
		}
	});
	
	$("#togeterbtn").on("click", function(){
		location.href="<%=request.getContextPath()%>/foodTogetherInsert.bo?menu="+menu+"&address="+address+"&img="+imgAddress+"&origin="+originName;
	})
	
    </script>
</body>
</html>