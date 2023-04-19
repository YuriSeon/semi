<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>admin_main</title>
    <style>
    html, .wrap {
  background: #f5f7f8;
  font-family: 'Roboto', sans-serif;
  -webkit-font-smoothing: antialiased;
  padding: 20px 0;
}

.band {
  width: 90%;
  max-width: 1240px;
  margin: 0 auto;
  
  display: grid;
  
  grid-template-columns: 1fr;
  grid-template-rows: auto;
  grid-gap: 20px;
  
}

@media only screen and (min-width: 500px) {
  .band {
    grid-template-columns: 1fr 1fr;
  }  
  .item-1 {
  grid-column: 1/ span 2;
  }
  .item-1 h1 {
    font-size: 30px;
  }
}

@media only screen and (min-width: 850px) {
  .band {
    grid-template-columns: 1fr 1fr 1fr 1fr;
  }
}

/* card */

.card {
  min-height: 100%;
  background: white;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
  display: flex;
  flex-direction: column;
  text-decoration: none;
  color: #444;
  position: relative;
  top: 0;
  transition: all .1s ease-in;
}

.card:hover {
  top: -2px;
  box-shadow: 0 4px 5px rgba(0,0,0,0.2);
}

.card article {
  padding: 20px;
  display: flex;
  
  flex: 1;
  justify-content: space-between;
  flex-direction: column;
  
}
.card .thumb {
  padding-bottom: 60%;
  background-size: cover;
  background-position: center center;
}

.card p { 
  flex: 1; /* make p grow to fill available space*/
  line-height: 1.4;
}

/* typography */
h1 {
  font-size: 20px;
  margin: 0;
  color: #333;
}

.card span {
  font-size: 12px;
  font-weight: bold;
  color: #999;
  text-transform: uppercase;
  letter-spacing: .05em;
  margin: 2em 0 0 0;
}
        div{
            /* border: 1px solid black; */
            box-sizing: border-box;
            
        }
        .wrap{
            width: 95vW;
            height: 95vh;
            margin: auto;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
        }
        #header{
            width: 100%;
            height: 15%;
        }
        #logo{
            height: 95%;
            width: 13%;
            margin: auto;
            left: 0;
            right: 0;
            bottom: 0;
        }
        #content1, #content2{
            width: 100%;
            height: 42.5%;
        }
        #content1>div, #content2>div{
            float: left;
        }
        #con1{
            width: 42%;
            height: 100%;
            margin-bottom: 0.2%;
            margin-right: 0.2%;
            background-color:mistyrose;
        }
        #con2{
            width: 37.2%;
            height: 100%;
            margin-bottom: 0.2%;
            margin-right: 0.2%;
            margin-left: 0.2%;
            background-color:antiquewhite;

        }
        #con3{
            width: 20%;
            height: 100%;
            margin-bottom: 0.2%;
            margin-left: 0.2%;
            background-color:beige;
        }#tent1{
            width: 42%;
            height: 100%;
            margin-right: 0.2%;
            background-color:bisque;
        }
        #tent2{
            width: 32%;
            height: 99.8%;
            margin-left: 0.2%;
            margin-right: 0.2%;
            margin-top: 0.2%;
            background-color:cornsilk;
        }
        #tent3{
            width: 13.9%;
            height: 99.8%;
            margin-left: 0.2%;
            margin-right: 0.2%;
            margin-top: 0.2%;
            background-color:ivory;
        }
        #tent4{
            width: 10.9%;
            height: 99.8%;
            margin-left: 0.2%;
            margin-top: 0.2%;
        }
        #tent4>div{
            width: 100%;
            height: 32.8%;
        }
        #play1{
            margin-bottom: 1.5%;
            background-color:palegoldenrod;
            
        }
        #play2{
            margin-top: 1.5%;
            margin-bottom: 1.5%;
            background-color:wheat;
        }
        #play3{
            margin-top: 1.5%;
            background-color:papayawhip;
        }
    </style>
</head>
<body>
    <div class="wrap">
        <div id="header">
            <div id="logo">
                <img src="" alt="community_logo" onclick="<%=contextPath%>">
            </div>
        </div>
        <div id="content1">
            <div id="con1" name class="card thumb"onclick="location.href='<%=contextPath%>/board.bo?currentPage=1&bType=3'"></div><!-- 게시판 메인으로 게시글 조회는 맛집-->
            <div id="con2" class="card thumb"onclick="location.href='<%=contextPath%>/main.re?currentPage=1'"></div><!-- 릴스 게시글 메인으로 -->
            <div id="con3" class="card thumb"onclick="location.href='<%=contextPath%>/main.ck?currentPage=1'"></div><!-- 체크리스트 메인으로 -->
        </div>
        <div id="content2">
            <div id="tent1" class="card thumb"onclick="location.href='<%=contextPath%>/board.bo?currentPage=1&bType=2'"></div><!-- 게시판 메인으로 게시글 조회는 대나무숲 -->
            <div id="tent2" class="card thumb"onclick="location.href='<%=contextPath%>/main.um?currentPage=1&status=Y'"></div><!-- user관리페이지로 -->
            <div id="tent3"class="card thumb"></div>
            <div id="tent4">
                <div id="play1"class="card thumb"onclick="location.href='<%=contextPath%>/main.bl?currentPage=1&status=K'"></div><!-- blacklist로 이동 -->
                <div id="play2"class="card thumb"onclick="location.href='<%=contextPath%>/'"></div><!-- 커뮤니티로 이동하는 매핑주소 -->
                <div id="play3"class="card thumb"onclick="location.href='<%=contextPath%>/logout.me'"></div> <!-- 로그아웃 매핑주소 -->
            </div>
        </div>
    </div>
</body>
</html>