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
	<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f91f4c1499628ccd44bb5d41070cb9a1&libraries=services"></script>
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

        #allFood{
            width: 800px;
            height: 510px;
        }
        #nonepo{
            width: 100%;
            height: 5%;
        }
        #allFoodExit{
            width: 100%;
            height: 5%;
            box-sizing: border-box;
        }
        #ssx{
            width: 100%;
            height: 90%;
            box-sizing: border-box;
            
        }
        #allFoodLeft, #allFoodRight{
            width: 10%;
            height: 100%;
            box-sizing: border-box;
            float: left;
            line-height: 8;
            font-size:50px;
            font-weight: 10000;
        }
        #allFoodPackage{
            width: 80%;
            height: 100%;
            box-sizing: border-box;
            float: left;
        } 
        
        		#locactionFood{
			width: 800px;
			height: 600px;
			box-sizing: border-box;
		}
		#ol, #or{
			width: 20%;
			height: 100%;
			box-sizing: border-box;
			float: left;
			line-height: 40;
		}
		#om{
			width: 60%;
			height: 100%;
			box-sizing: border-box;
			float: left;
		}
		#oo1{
			width: 100%;
			height: 5%;
			box-sizing: border-box;
		}
		#foodSlide{
			width: 100%;
			height: 65%;
			box-sizing: border-box;
		}
		#oo3{
			width: 100%;
			height: 10%;
			box-sizing: border-box;
		}
		#fra{
			width: 100%;
			height: 10%;
			box-sizing: border-box;
			line-height: 4;
			font-size: 15px;
		}
		#oo5{
			width: 100%;
			height: 10%;
			box-sizing: border-box;
			line-height: 5;
		}
		#frm, #frg{
			width: 50%;
			height: 100%;
			box-sizing: border-box;
			float: left;
			line-height: 3;
			font-size: 18px;
			font-weight: 1000;
		}
		
</style>
</head>
<%@include file="../common/menubar.jsp" %>

<body style="text-align:center;">
	<div class="wrap">
		<div class="search">
			<button type="submit" class="searchButton" id="locationFoodBtn">
				밥
			</button>
			<input id="userCurrLo" type="text" class="searchTerm" name="userCurrLo" readOnly>
		</div>
	</div>
	<br><br>
	<div id="locactionFood" style="display:none; text-align:center; margin:auto;">

	<div id="ol">
	<button id="prebtn"  class="btn btn-danger"> &lt </button>
	</div>
		<div id="om">
			<div id="oo1">
			<button type="button" id="returnMain" >종료하기</button>
			</div>
			<div id="foodSlide">
			
			</div>
			<div id="oo3">
				<div id="frm"></div>
				<div id="frg"></div>
			</div>
			<div id="fra"></div>
			<div id="oo5">
			<button id="togeterbtn" class="btn btn-warning">같이 먹을 사람 찾으러 가기</button>
			<input type='hidden' name='locationbno'>
			</div>
		</div>
		<div id="or">
		<button id="nextbtn"  class="btn btn-danger"> &gt </button>
		</div>
	</div>
	
	<div id="allFood" style="display:none; text-align:center;  margin:auto;">
        <div id="nonepo"></div>
        <div id="allFoodExit"><button id="allfoodEbtn" class="btn btn-primary">종료하기</button></div>
        <div id="ssx">
            <div id="allFoodLeft">&lt</div>
            <div id="allFoodPackage" style="margin-top:30px;">
            	    <div id="imgarea"></div>
            	    <div id="iframarea"></div>
            </div>
            <div id="allFoodRight">&gt</div>
        </div>
    </div>
		
				
	<div id="UserShowPage">
<!-- 		<div id ="topmargin"></div> -->
		<div id="left">
			<div id="foodrankbtn" style="background-image: url(https://ceoimg.cdn.baemin.com/ceoimg-ym4g/i/2023/4/12/01gxscxbnb37gspcrt41cva8cr.jpg); background-size:100% 100%;" onclick="location.href='<%=request.getContextPath()%>/foodRanking.bo'">
			</div>
			<div id="nonediv"></div>
			<div id="foodtogetherbtn" style="background-image: url(https://ceoimg.cdn.baemin.com/ceoimg-ym4g/i/2023/4/5/01gx7jpdc4zcsrm1gj63f98phv.jpeg); background-size: 100%, 100%;" onclick="location.href='<%=request.getContextPath()%>/foodTogether.bo'">
			</div>
		</div>
		<div id="bottomshow">
			<div class="noneb1"></div>
			<div id="ads" style="background-image: url(https://img.woowahan.com/www/common/baemin.jpg); background-size:826px 193.188px;" onclick="location.href='https://www.baemin.com/'">
			</div>
			<div class="noneb1"></div>
<!-- 			<div id="whatfood" style="background-image: url(https://yt3.googleusercontent.com/ytc/AGIKgqPNJ64rrMhG_Wl00qzE8ugDRZFO3UnX6eTaMZQAGg=s900-c-k-c0x00ffffff-no-rj); background-size:100% 100%;"> -->
			<div id="whatfood" style="background-image: url(https://ceoimg.cdn.baemin.com/ceoimg-ym4g/i/2023/4/25/01gyv2k0103b0yy80034trm3qd.jpg); background-size:952px 193.188px;">

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

     var foodImgc = 0;
     var Imglistt;

    $("#whatfood").on("click", function(){
    	$("#iframarea").css("display", "none");
    	$("#imgarea").css("display", "block");
    	$.ajax({
    		url : "chfood.bo",
    		type : "get",
    		success : function(Imglist){
    			Imglistt = Imglist;
    			$("#locationFoodBtn").attr("disabled", true);
    			$("#UserShowPage").css("display", "none");
    			$("#allFood").css("display", "block");
    			if(Imglist?.length){
    				let str = "<img style='width:100%; height:100%;' id='" + Imglist[0].originName + "'src=" + "<%=request.getContextPath() %>" + Imglist[0].filePath + "/" + Imglist[0].changeName + ">";
    				$("#imgarea").html(str);
    			}else{
    				$("#imgarea").html("<img style='width:100%; height:100%;'" + "src=" + "'https://m.jejedeco.com/web/product/big/202110/a5f04036c5ca1501d1f459e4a7e3023e.jpg'>");   
    				
    			}
    		},
    		error : function(){
    			console.log("ajax error");
    		}
    	})

    });
    
    $("#allFoodRight").on("click", function(){
    	foodImgc = foodImgc + 1;
    	try{    		
    		var str = "<img style='width:100%; height:100%;' id='" + Imglistt[foodImgc].originName + "' src=" + "<%=request.getContextPath() %>" + Imglistt[foodImgc].filePath + "/" + Imglistt[foodImgc].changeName + ">";
    	}catch(err){
    		foodImgc = 0;
    		var str = "<img style='width:100%; height:100%;' id='" + Imglistt[0].originName + "' src=" + "<%=request.getContextPath() %>" + Imglistt[0].filePath + "/" + Imglistt[0].changeName + ">";    		
    	}
    	if($("#iframarea").css("display") == "block"){
    		$("#allFoodPackage #iframarea").css("display","none");
    		$("#allFoodPackage #imgarea").css("display", "block");
    	}
		$("#imgarea").html(str);
    });
    
    
    
    $("#allFoodLeft").on("click", function(){
    	foodImgc = foodImgc - 1;
    	
    	
    	
    	try{    		
    		var str = "<img style='width:100%; height:100%;' id='" + Imglistt[foodImgc].originName +  "'src=" + "<%=request.getContextPath() %>" + Imglistt[foodImgc].filePath + "/" + Imglistt[foodImgc].changeName + ">";
    	}catch(err){
    		foodImgc = Object.keys(Imglistt).length-1;
    		var str = "<img style='width:100%; height:100%;' id='" + Imglistt[Object.keys(Imglistt).length-1].originName + "'src=" + "<%=request.getContextPath() %>" + Imglistt[Object.keys(Imglistt).length-1].filePath + "/" + Imglistt[Object.keys(Imglistt).length-1].changeName + ">";    		
    	}
    	if($("#iframarea").css("display") == "block"){
    		$("#allFoodPackage #iframarea").css("display","none");
    		$("#allFoodPackage #imgarea").css("display", "block");
    	}
		$("#imgarea").html(str);
    });
    
    
    
    $("#allfoodEbtn").on("click", function(){
    	$("#locationFoodBtn").attr("disabled", false);
    	$("#UserShowPage").css("display", "block");
		$("#allFood").css("display", "none");
		$("#allFoodMap").css("display", "none");
		$("#allFoodPackage").css("display", "block");
    });
    
    $("#allFoodPackage").on("click", function(){
    	if($("#imgarea").css("display") == "block"){
	    	$("#imgarea").css("display", "none");
	    	$("#iframarea").css("display", "block");  
	    	let str = "<iframe id='inlineFrameExample' style='width:640px; height:520px;' src='<%=request.getContextPath() %>/views/food/iframFood.jsp'></ifram>";
	  		$("#iframarea").html(str);    	
    	}else{
	    	$("#imgarea").css("display", "block");
	    	let str = "<iframe id='inlineFrameExample' style='width:640px; height:520px;' src='<%=request.getContextPath() %>/views/food/iframFood.jsp'></ifram>";
	  		$("#iframarea").css("display", "none");    		    		
    	}
    });     

    	
    	


     
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
                    $("#foodSlide").html("<img style='width:100%; height:100%;'" + "src=" + "'https://m.jejedeco.com/web/product/big/202110/a5f04036c5ca1501d1f459e4a7e3023e.jpg'>");
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

                    imgAddress = "<%=contextPath %>" + data[1][number].filePath + "/" + data[1][number].changeName;

                    $("#frm").text(menu);
                    $("#fra").html(data[0][number].abbress);
                    $("#frg").html("추천수 : " + data[0][number].good);
//                     var img = "<img alt='대표이미지' src='" + imgadd + "' style='width:100%; height:100%'>";
//                     foodStart += "메뉴 : " + data[0][number].foodName + "<br>주소 : " + ata[0][number].abbress + "<br>추천수 : " + data[0][number].good;
                    foodStart += "<input id='justbno' just type='hidden' value='"+ data[0][number].boardNo +"'>";
                    foodStart += "<img alt='대표이미지' src='" + imgAddress + "' style='width:100%; height:100%;'>";
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