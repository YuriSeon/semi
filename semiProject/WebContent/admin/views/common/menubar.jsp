<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	String alertMsg = (String)request.getSession().getAttribute("alertMsg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<style>
@font-face {
        font-family: 'GmarketSansMedium';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }
* {
	margin: 0;
	padding: 0;
	text-decoration: none;
	font-family: 'GmarketSansMedium';  
}

:root { 
  --accent-color: #fff; 
	--gradient-color: #FBFBFB;
}

body {
  display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 100vw;
	height: 100vh;
	background-image: linear-gradient(-45deg, #e3eefe 0%, #d9edfa 100%);
}

.sidebar {
	position: fixed;
	width: 240px;
	left: -240px;
	height: 100%;
	background-color: #fff;
	transition: all .5s ease;
}

.sidebar header {
	font-size: 28px;
	color: #ffffff;
	line-height: 70px;
	text-align: center;
	background-color: #fff;
	user-select: none;
	font-family: 'Lato', sans-serif;
}

.sidebar a {
	display: block;
	height: 65px;
	width: 100%;
	color: #131529;
	line-height: 65px;
	padding-left: 20px;
	box-sizing: border-box;
	border-left: 5px solid transparent;
	font-family: 'Lato', sans-serif;
	transition: all .5s ease;
}

a.active, a:hover {
	border-left: 5px solid var(--accent-color);
	color: #ffffff;
	background: linear-gradient(to left, var(--accent-color),
		var(--gradient-color));
}

.sidebar a i {
	font-size: 22px;
	margin-right: 17px;
}

.sidebar a span {
	letter-spacing: 0px;
	text-transform: uppercase;
}

#check {
	display: none;
}

label #btn, label #cancel {
	position: absolute;
	left: 5px;
	cursor: pointer;
	color: #71dbf3;
	border-radius: 5px;
	margin: 15px 30px;
	font-size: 29px;
	background-color: #ace7fb;
	box-shadow: inset 2px 2px 2px 0px rgba(255, 255, 255, .5), inset -7px
		-7px 10px 0px rgba(0, 0, 0, .1), 3.5px 3.5px 20px 0px
		rgba(0, 0, 0, .1), 2px 2px 5px 0px rgba(0, 0, 0, .1);
	height: 45px;
	width: 45px;
	text-align: center;
	text-shadow: 2px 2px 3px rgba(255, 255, 255, 0.5);
	line-height: 45px;
	transition: all .5s ease;
}

label #cancel {
	opacity: 0;
	visibility: hidden;
}

#check:checked ~ .sidebar {
	left: 0;
}

#check:checked ~ label #btn {
	margin-left: 245px;
	opacity: 0;
	visibility: hidden;
}

#check:checked ~ label #cancel {
	margin-left: 245px;
	opacity: 1;
	visibility: visible;
}

@media ( max-width : 860px) {
	.sidebar {
		height: auto;
		width: 70px;
		left: 0;
		margin: 100px 0;
	}
	header, #btn, #cancel {
		display: none;
	}
	span {
		position: absolute;
		margin-left: 23px;
		opacity: 0;
		visibility: hidden;
	}
	.sidebar a {
		height: 60px;
	}
	.sidebar a i {
		margin-left: -10px;
	}
	a:hover {
    width: 200px;
    background: inherit;
  }
  .sidebar a:hover span{
    opacity: 1;
    visibility: visible;
  }
}

.sidebar > a.active,.sidebar > a:hover:nth-child(even) {
  --accent-color: #52d6f4;
  --gradient-color: #b1e2f7;
}
.sidebar a.active,.sidebar > a:hover:nth-child(odd) {
  --accent-color: #4ad7f7;
  --gradient-color: #a2e1fb;
}

#head * {
  outline: none;
}
#head {
  margin: 0;
}

.tb {
  display: table;
  width: 100%;
}

.td {
  display: table-cell;
  vertical-align: middle;
}

#head input,
#head button {
  color: #fff;
  font-family: 'Lato', sans-serif;
  padding: 0;
  margin: 0;
  border: 0;
  background-color: transparent;
}

#cover {
    position: absolute;
    top: 12%;
    left: 63%;
    right: 0;
    width: 550px;
    padding: 10px;
    margin: -80px auto 0 auto;
    background-color: #9ce7f7;
    border-radius: 20px;
    box-shadow: 0 10px 40px #a5d5ff, 0 0 0 15px #ffffffeb;
    transform: scale(0.6);
    border: 10px rgb(0, 30, 128);
}

#head form {
    height: 96px;
}

#head input[type="text"] {
  width: 100%;
  height: 55px;
  font-size: 30px;
  line-height: 1;
  margin-left: 20px;
}

#head input[type="text"]::placeholder {
	color: #fefbff;
}

#s-cover {
	width: 1px;
	padding-left: 35px;
}

#head button {
	position: relative;
	display: block;
	width: 60px;
	height: 50px;
	cursor: pointer;
}

#s-circle {
	position: relative;
	top: -8px;
	left: 0;
	width: 25px;
	height: 28px;
	margin-top: 0;
	border-width: 10px;
	border: 10px solid #fff;
	background-color: transparent;
	border-radius: 50%;
	transition: 0.5s ease all;
}

#head button span {
	position: absolute;
	top: 36px;
	left: 26px;
	display: block;
	width: 38px;
	height: 10px;
	background-color: transparent;
	border-radius: 10px;
	transform: rotateZ(52deg);
	transition: 0.5s ease all;
}

#head button span:before,
#head button span:after {
	content: "";
	position: absolute;
	bottom: 0;
	right: 0;
	width: 38px;
	height: 12px;
	background-color: #fff;
	border-radius: 10px;
	transform: rotateZ(0);
	transition: 0.5s ease all;
}

#s-cover:hover #s-circle {
	top: -5px;
	width: 65px;
	height: 14px;
	border-width: 0;
	background-color: #fff;
	border-radius: 20px;
}

#s-cover:hover span {
	top: 50%;
	left: 55px;
	width: 22px;
	margin-top: -9px;
	transform: rotateZ(0);
}

#s-cover:hover button span:before {
	bottom: 11px;
	transform: rotateZ(52deg);
}

#s-cover:hover button span:after {
	bottom: -11px;
	transform: rotateZ(-52deg);
}
#s-cover:hover button span:before,
#s-cover:hover button span:after {
  right: 0px;
  width: 33px;
  background-color: #fff;
}

#wrapper{
		width: 85vw;
		height: 71vh;
		vertical-align: middle;
		background-color: white;
		box-shadow: 6px 8px 8px 0px #e7e8ea;
		border-radius: 1%;
	}
	table{
		width: 95%;
		margin: auto;
		right: 0;
		left: 0;
	}
	thead>tr{
		background-color: rgb(172, 231, 254);
		text-align: center;
	}
	tbody>tr{
		background-color: rgb(238, 251, 255);
	}
	table *{
		border: 1px solid white;
		text-align: center;
		box-shadow: 1px 3px 3px 0px #e7e8ea;
		border-radius: 1%;
	}
	
	#bb{
		margin-left: 5%;
	}
	#bb form *{
		float: left;
		margin: 5px;
		margin-top: 0;
		margin-left:0;
	}
	#checkL{
		float: right;
		margin-right: 5%;
	}
	#tab>thead th{
		height: 45px;
		font-size: 14px;
		font-weight: 900;
	}
	#tab>tbody td{
		height: 30px;
		font-size: 12px;
	}
	.custom-btn {
  width: 105px;
  height: 40px;
  color: #fff;
  border-radius: 5px;
  padding: 5px 10px;
  font-family: 'Lato', sans-serif;
  font-weight: 500;
  background: transparent;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  display: inline-block;
   box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
   7px 7px 20px 0px rgba(0,0,0,.1),
   4px 4px 5px 0px rgba(0,0,0,.1);
  outline: none;
}
/* 3 */
.btn-3 {
  background: rgb(0,172,238);
background: linear-gradient(0deg, rgba(0,172,238,1) 0%, rgba(2,126,251,1) 100%);
  width: 85px;
  height: 25px;
  line-height: 30px;
  padding: 0;
  border: none;
  
}
.btn-3 span {
  position: relative;
  display: block;
  width: 100%;
  height: 100%;
}
.btn-3:before,
.btn-3:after {
  position: absolute;
  content: "";
  right: 0;
  top: 0;
   background: rgba(2,126,251,1);
  transition: all 0.3s ease;
}
.btn-3:before {
  height: 0%;
  width: 2px;
}
.btn-3:after {
  width: 0%;
  height: 2px;
}
.btn-3:hover{
   background: transparent;
  box-shadow: none;
}
.btn-3:hover:before {
  height: 100%;
}
.btn-3:hover:after {
  width: 100%;
}
.btn-3 span:hover{
   color: rgba(2,126,251,1);
}
.btn-3 span:before,
.btn-3 span:after {
  position: absolute;
  content: "";
  left: 0;
  bottom: 0;
   background: rgba(2,126,251,1);
  transition: all 0.3s ease;
}
.btn-3 span:before {
  width: 2px;
  height: 0%;
}
.btn-3 span:after {
  width: 0%;
  height: 2px;
}
.btn-3 span:hover:before {
  height: 100%;
}
.btn-3 span:hover:after {
  width: 100%;
}
/* 5 */
.btn-5 {
  width: 85px;
  height: 26px;
  line-height: 25px;
  padding: 0;
   margin: 0;
  border: none;
  background: rgb(255,27,0);
background: linear-gradient(0deg, rgba(255,27,0,1) 0%, rgba(251,75,2,1) 100%);
}
.btn-5:hover {
  color: #f0094a;
  background: transparent;
   box-shadow:none;
}
.btn-5:before,
.btn-5:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #f0094a;
  box-shadow:
   -1px -1px 5px 0px #fff,
   7px 7px 20px 0px #0003,
   4px 4px 5px 0px #0002;
  transition:400ms ease all;
}
.btn-5:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
.btn-5:hover:before,
.btn-5:hover:after{
  width:100%;
  transition:800ms ease all;
}
/* 8 */
.btn-8 {
  background-color: #f0ecfc;
background-image: linear-gradient(315deg, #f0ecfc 0%, #c797eb 74%);
  line-height: 42px;
  padding: 0;
  border: none;
}
.btn-8 span {
  position: relative;
  display: block;
  width: 100%;
  height: 100%;
}
.btn-8:before,
.btn-8:after {
  position: absolute;
  content: "";
  right: 0;
  bottom: 0;
  background: #c797eb;
  /*box-shadow:  4px 4px 6px 0 rgba(255,255,255,.5),
  -4px -4px 6px 0 rgba(116, 125, 136, .2), 
  inset -4px -4px 6px 0 rgba(255,255,255,.5),
  inset 4px 4px 6px 0 rgba(116, 125, 136, .3);*/
  transition: all 0.3s ease;
}
.btn-8:before{
  height: 0%;
  width: 2px;
}
.btn-8:after {
  width: 0%;
  height: 2px;
}
.btn-8:hover:before {
  height: 100%;
}
.btn-8:hover:after {
  width: 100%;
}
.btn-8:hover{
  background: transparent;
  color:rgb(207, 56, 207);
}
.btn-8 span:hover{
  color: #c797eb;
}
.btn-8 span:before,
.btn-8 span:after {
  position: absolute;
  content: "";
  left: 0;
  top: 0;
  background: #c797eb;
  /*box-shadow:  4px 4px 6px 0 rgba(255,255,255,.5),
  -4px -4px 6px 0 rgba(116, 125, 136, .2), 
  inset -4px -4px 6px 0 rgba(255,255,255,.5),
  inset 4px 4px 6px 0 rgba(116, 125, 136, .3);*/
  transition: all 0.3s ease;
}
.btn-8 span:before {
  width: 2px;
  height: 0%;
}
.btn-8 span:after {
  height: 2px;
  width: 0%;
}
.btn-8 span:hover:before {
  height: 100%;
}
.btn-8 span:hover:after {
  width: 100%;
}
  
/* 9 */
.btn-9 {
  width: 85px;
  height: 25px;
  border: none;
  transition: all 0.3s ease;
  overflow: hidden;
  color: #ffffff;
  background-color: rgb(147, 237, 253);
}
.btn-9:after {
  position: absolute;
  content: " ";
  z-index: -1;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
   background-color: #1fd1f9;
background-image: linear-gradient(315deg, #1fd1f9 0%, #b621fe 74%);
  transition: all 0.3s ease;
}
.btn-9:hover {
  background: transparent;
  box-shadow:  4px 4px 6px 0 rgba(255,255,255,.5),
              -4px -4px 6px 0 rgba(116, 125, 136, .2), 
    inset -4px -4px 6px 0 rgba(255,255,255,.5),
    inset 4px 4px 6px 0 rgba(116, 125, 136, .3);
  color: #777777;
}
.btn-9:hover:after {
  -webkit-transform: scale(2) rotate(180deg);
  transform: scale(2) rotate(180deg);
  box-shadow:  4px 4px 6px 0 rgba(255,255,255,.5),
              -4px -4px 6px 0 rgba(116, 125, 136, .2), 
    inset -4px -4px 6px 0 rgba(255,255,255,.5),
    inset 4px 4px 6px 0 rgba(116, 125, 136, .3);
}
/* 10 */
.btn-10 {
	width: 85px;
  height: 30px;
  background: rgb(45, 140, 255);
background: linear-gradient(0deg, rgb(106, 181, 245) 0%, rgb(90, 154, 251) 100%);
  color: #fff;
  border: none;
  transition: all 0.3s ease;
  overflow: hidden;
}
.btn-10:after {
  position: absolute;
  content: " ";
  top: 0;
  left: 0;
  z-index: -1;
  width: 100%;
  height: 100%;
  transition: all 0.3s ease;
  -webkit-transform: scale(.1);
  transform: scale(.1);
}
.btn-10:hover {
  color: #fff;
  border: none;
  background: rgb(118, 202, 245);
}
.btn-10:hover:after {
  background: rgb(112, 203, 249);
background: linear-gradient(0deg, rgb(136, 203, 255) 0%,  rgb(87, 179, 254)100%);
  -webkit-transform: scale(1);
  transform: scale(1);
}

/* 11 */
.btn-11 {
  border: none;
  background: rgb(251,33,117);
    background: linear-gradient(0deg, rgba(251,33,117,1) 0%, rgba(234,76,137,1) 100%);
    color: #fff;
    overflow: hidden;
}
.btn-11:hover {
    text-decoration: none;
    color: #fff;
}
.btn-11:before {
    position: absolute;
    content: '';
    display: inline-block;
    top: -180px;
    left: 0;
    width: 30px;
    height: 100%;
    background-color: #fff;
    animation: shiny-btn1 3s ease-in-out infinite;
}
.btn-11:hover{
  opacity: .7;
}
.btn-11:active{
  box-shadow:  4px 4px 6px 0 rgba(255,255,255,.3),
              -4px -4px 6px 0 rgba(116, 125, 136, .2), 
    inset -4px -4px 6px 0 rgba(255,255,255,.2),
    inset 4px 4px 6px 0 rgba(0, 0, 0, .2);
}


@-webkit-keyframes shiny-btn1 {
    0% { -webkit-transform: scale(0) rotate(45deg); opacity: 0; }
    80% { -webkit-transform: scale(0) rotate(45deg); opacity: 0.5; }
    81% { -webkit-transform: scale(4) rotate(45deg); opacity: 1; }
    100% { -webkit-transform: scale(50) rotate(45deg); opacity: 0; }
}


/* 12 */
.btn-12{
  position: relative;
  right: 20px;
  bottom: 20px;
  border:none;
  box-shadow: none;
  width: 130px;
  height: 30px;
  line-height: 35px;
  -webkit-perspective: 230px;
  perspective: 230px;
}
.btn-12 span {
  background: rgb(0,172,238);
background: linear-gradient(0deg, rgba(0,172,238,1) 0%, rgba(2,126,251,1) 100%);
  display: block;
  position: absolute;
  width: 130px;
  height: 40px;
  box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
   7px 7px 20px 0px rgba(0,0,0,.1),
   4px 4px 5px 0px rgba(0,0,0,.1);
  border-radius: 5px;
  margin:0;
  text-align: center;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-transition: all .3s;
  transition: all .3s;
}
.btn-12 span:nth-child(1) {
  box-shadow:
   -7px -7px 20px 0px #fff9,
   -4px -4px 5px 0px #fff9,
   7px 7px 20px 0px #0002,
   4px 4px 5px 0px #0001;
  -webkit-transform: rotateX(90deg);
  -moz-transform: rotateX(90deg);
  transform: rotateX(90deg);
  -webkit-transform-origin: 50% 50% -20px;
  -moz-transform-origin: 50% 50% -20px;
  transform-origin: 50% 50% -20px;
}
.btn-12 span:nth-child(2) {
  -webkit-transform: rotateX(0deg);
  -moz-transform: rotateX(0deg);
  transform: rotateX(0deg);
  -webkit-transform-origin: 50% 50% -20px;
  -moz-transform-origin: 50% 50% -20px;
  transform-origin: 50% 50% -20px;
}
.btn-12:hover span:nth-child(1) {
  box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
   7px 7px 20px 0px rgba(0,0,0,.1),
   4px 4px 5px 0px rgba(0,0,0,.1);
  -webkit-transform: rotateX(0deg);
  -moz-transform: rotateX(0deg);
  transform: rotateX(0deg);
}
.btn-12:hover span:nth-child(2) {
  box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
   7px 7px 20px 0px rgba(0,0,0,.1),
   4px 4px 5px 0px rgba(0,0,0,.1);
 color: transparent;
  -webkit-transform: rotateX(-90deg);
  -moz-transform: rotateX(-90deg);
  transform: rotateX(-90deg);
}


/* 14 */
.btn-14 {
  width: 50px;
  height: 30px;
  background: rgb(255,151,0);
  border: none;
  z-index: 1;
  margin: 0;
  padding: 0;
}
.btn-14:after {
  position: absolute;
  content: "";
  width: 100%;
  height: 0;
  top: 0;
  left: 0;
  z-index: -1;
  border-radius: 5px;
  background-color: #eaf818;
  background-image: linear-gradient(315deg, #eaf818 0%, #f6fc9c 74%);
   box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5);
   7px 7px 20px 0px rgba(0,0,0,.1),
   4px 4px 5px 0px rgba(0,0,0,.1);
  transition: all 0.3s ease;
}
.btn-14:hover {
  color: #000;
}
.btn-14:hover:after {
  top: auto;
  bottom: 0;
  height: 100%;
}
.btn-14:active {
  top: 2px;
}

/* 16 */
.btn-16 {
  border: none;
  color: #000;
}
.btn-16:after {
  position: absolute;
  content: "";
  width: 0;
  height: 100%;
  top: 0;
  left: 0;
  direction: rtl;
  z-index: -1;
  box-shadow:
   -7px -7px 20px 0px #fff9,
   -4px -4px 5px 0px #fff9,
   7px 7px 20px 0px #0002,
   4px 4px 5px 0px #0001;
  transition: all 0.3s ease;
}
.btn-16:hover {
  color: #000;
}
.btn-16:hover:after {
  left: auto;
  right: 0;
  width: 100%;
}
.btn-16:active {
  top: 2px;
}

</style>

<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
</head>

<body>
	<input type="checkbox" id="check">
	<label for="check"> <i class="fas fa-bars" id="btn"></i> 
	<i class="fas fa-times" id="cancel"></i>
	</label>
	<div class="sidebar">
		<header>안보이지메롱 언제다하냐</header>
		<a class="active"> 
			<i class=""></i><span style="font-size: 28px; text-align: center; font-weight: 800;">&nbsp;&nbsp;&nbsp;Menu</span></a>
	<a href="<%=contextPath %>/main.abo?currentPage=1"> <i class="fas fa-list"></i> <span>Board</span>
	</a> <a href="<%=contextPath %>/main.um?currentPage=1"> <i class="fas fa-user"></i><span>User_Manage</span>
	</a> <a href="<%=contextPath %>/main.ck?option=1&currentPage=1"> <i class="fas fa-star"></i> <span>CheckList</span>
	</a> <a href="<%=contextPath %>/main.bl?currentPage=1&status=K"> <i class="fas fa-poo"></i> <span>BlackList</span>
	</a> <a href="<%=contextPath %>/Main.co"> <i class="fas fa-heart"></i> <span>Go community</span>
	</a><a href="<%=contextPath %>/logout.me"> <i class="fas fa-rocket"></i> <span>Go Home</span>
		</a>
	</div>
	<div id="head">
		<form action="<%=contextPath %>/mainSearch.menu" method="get">
			<div id="cover">
				<form method="get" action="<%=contextPath %>/mainSearch.menu">
					<div class="tb">
						<div class="td"><input type="text" name="search" placeholder="검색어를 입력하세요." required></div>
						<div class="td" id="s-cover">
							<button type="submit">
								<div id="s-circle"></div>
				<!-- <div id="logo">
			<a hr -->				<span></span>
							</button>
						</div>
					</div>
				</form>
			</div>
		</form>
	</div>
	<script>
		var msg = "<%=alertMsg%>";
		
		if(msg != "null") {
			// 알람메세지가 있을 때 한 번만 나올 수 있도록 세션에서 삭제하기. 
			// 메뉴바 항상 include해서 사용할거라 여기만 작성하면 됨.
			alert(msg);
			<%session.removeAttribute("alertMsg");%>
		}
	</script>
</body>

</html>