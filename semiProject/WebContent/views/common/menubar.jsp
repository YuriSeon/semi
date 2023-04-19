<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.bMember.model.vo.BMember"%>
<%
	//로그인 유저 정보
	BMember loginUser = (BMember)session.getAttribute("loginUser");
	//알람 메세지
	String alertMsg = (String)session.getAttribute("alertMsg");
	//패스 변수
	String contextPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html>
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.4.js"integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        /* 폰트 시작 */
        @font-face {
        font-family: 'LotteMartDream';
        font-style: normal;
        font-weight: 400;
        src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamMedium.woff2') format('woff2'), url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamMedium.woff') format('woff');
        }
        @font-face {
        font-family: 'LotteMartDream';
        font-style: normal;
        font-weight: 700;
        src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamBold.woff2') format('woff2'), url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamBold.woff') format('woff');
        }
        @font-face {
        font-family: 'LotteMartDream';
        font-style: normal;
        font-weight: 300;
        src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamLight.woff2') format('woff2'), url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamLight.woff') format('woff');
        }
        header {
        font-family: 'LotteMartDream', sans-serif;
        }

        /* 폰트 끝 */
        /* 노말라이즈 시작 */
        .con-min-width> ul, li {
        margin:0;
        padding:0;
        list-style:none;
        }
        .float-gird a {
        color:inherit;
        text-decoration:none;
        }
        /* 노말라이즈 끝 */
        /* 라이브러리 시작 */
        .con {
        margin-left:auto;
        margin-right:auto;
        }

        .bg-black {
        background-color:black;
        }

        .color-white {
        color:white;
        }

        .text-align-center {
        text-align:center;
        }
        .float-gird::after{
        content:"";
        display:block;
        clear:both;
        }

        .float-gird > *{
        float:left;
        box-sizing:border-box;
        }
        /* 라이브러리 끝 */
        /* 커스텀 시작 */
        .con-min-width {
        min-width:1200px;
        }

        .con {
        width:1200px;
        }
        .block {
        display:block;
        }
        /* 커스텀 끝 */
        /* logo 시작 */
        .logo {
        font-size:3rem;
        display:inline-block;
        padding:20px 0;

        }

        /* logo 끝 */
        /* logo bar 시작 */
        .logo-bar {
        background-color:white;
        color:black;
        height: 200px;
        }

        /* logo bar 끝 */

        /* 메뉴바 시작 */
        .menu-bar {
        background-color:skyblue;
        color:white;
        
        }
        /* 메뉴바 끝 */
        /* 메뉴바 - 메뉴1 시작 */
        .menu-bar__menu-1 ul > li {
        width:25%;
        }

        .menu-bar__menu-1 ul > li > a{
        font-size:1.5rem;
        text-align:center;
        padding:20px 0;
        border-radius:10px 10px 0 0;
        }

        .menu-bar__menu-1 ul > li:hover > a{
        background-color:white;
        color:black;
        }

        /* 메뉴바 - 메뉴1 끝 */

    </style>
</head>
<body>
    <!-- font-awsome load -->
    <script src="https://kit.fontawesome.com/d093edb2d8.js" crossorigin="anonymous"></script>


    <header class="logo-bar con-min-width">
    <div class="com text-align-center">
        <a href="./" class="logo">
        <img src="../../resources/로고_투명배경.png" style="width: 200px;">
        
        </a>
    </div>
    </header>

    <header class="menu-bar con-min-width">
    <div class="con">
        <nav class="menu-bar__menu-1">
        <ul class="float-gird">
            <li>
            <a href="#" class="block">
                <i class="fas fa-user"></i>
                <span>마이페이지</span>
            </a>
            </li>
            <li>
            <a href="<%=contextPath%>/list.vd?currentPage=1" class="block">
                <i class="fa-brands fa-instagram"></i>
                <span>릴스</span>
            </a>
            </li>
            <li>
            <a href="<%=contextPath%>/bamlist.bo?currentPage=1" class="block">
                <i class="fa-solid fa-user-secret"></i>
                <span>대나무숲</span>
            </a>
            
            </li>
            <li>
            <a href="<%=contextPath%>/foodmain.bo" class="block">
                <i class="fa-solid fa-burger"></i>
                <span>맛집</span>
            </a>
            </li>
        </ul>
        </nav>
    </div>
    </header>

</body>
</html>