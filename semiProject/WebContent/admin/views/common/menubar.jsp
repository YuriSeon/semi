<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<style>
*{
  margin: 0;
  padding: 0;
  text-decoration: none;
}
:root {
  --accent-color: #fff;
  --gradient-color: #FBFBFB;
}
body{
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
   width: 100vw;
  height: 100vh;
  background-image: linear-gradient(-45deg, #e3eefe 0%, #efddfb 100%);
}

.sidebar{
  position: fixed;
  width: 240px;
  left: -240px;
  height: 100%;
  background-color: #fff;
  transition: all .5s ease;
}
.sidebar header{
  font-size: 28px;
  color: #353535;
  line-height: 70px;
  text-align: center;
  background-color: #fff;
  user-select: none;
  font-family: 'Lato', sans-serif;
}
.sidebar a{
  display: block;
  height: 65px;
  width: 100%;
  color: #353535;
  line-height: 65px;
  padding-left: 30px;
  box-sizing: border-box;
  border-left: 5px solid transparent;
  font-family: 'Lato', sans-serif;
  transition: all .5s ease;
}
a.active,a:hover{
  border-left: 5px solid var(--accent-color);
  color: #fff;
   background: linear-gradient(to left, var(--accent-color), var(--gradient-color));
}
.sidebar a i{
  font-size: 23px;
  margin-right: 16px;
}
.sidebar a span{
  letter-spacing: 1px;
  text-transform: uppercase;
}
#check{
  display: none;
}
label #btn,label #cancel{
  position: absolute;
  left: 5px;
  cursor: pointer;
  color: #d6adff;
  border-radius: 5px;
  margin: 15px 30px;
  font-size: 29px;
  background-color: #e8d1ff;
  box-shadow:inset 2px 2px 2px 0px rgba(255,255,255,.5),
    inset -7px -7px 10px 0px rgba(0,0,0,.1),
   3.5px 3.5px 20px 0px rgba(0,0,0,.1),
   2px 2px 5px 0px rgba(0,0,0,.1);
  height: 45px;
  width: 45px;
  text-align: center;
  text-shadow: 2px 2px 3px rgba(255,255,255,0.5);
  line-height: 45px;
  transition: all .5s ease;
}
label #cancel{
  opacity: 0;
  visibility: hidden;
}
#check:checked ~ .sidebar{
  left: 0;
}
#check:checked ~ label #btn{
  margin-left: 245px;
  opacity: 0;
  visibility: hidden;
}
#check:checked ~ label #cancel{
  margin-left: 245px;
  opacity: 1;
  visibility: visible;
}
@media(max-width : 860px){
  .sidebar{
    height: auto;
    width: 70px;
    left: 0;
    margin: 100px 0;
  }
  header,#btn,#cancel{
    display: none;
  }
  span{
    position: absolute;
    margin-left: 23px;
    opacity: 0;
    visibility: hidden;
  }
  .sidebar a{
    height: 60px;
  }
  .sidebar a i{
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
  --gradient-color: #c1b1f7;
}
.sidebar a.active,.sidebar > a:hover:nth-child(odd) {
  --accent-color: #c1b1f7;
  --gradient-color: #A890FE;
}


.frame {
  width: 50%;
  height: 30%;
  margin: auto;
  text-align: center;
}

h2 {
  position: relative;
  text-align: center;
  color: #353535;
  font-size: 60px;
  font-family: 'Lato', sans-serif;
  margin: 0;
  color: #a759f5;
}

p {
  font-family: 'Lato', sans-serif;
  font-weight: 300;
  text-align: center;
  font-size: 30px;
  color: #d6adff;
  margin: 0;
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
  font-family: Nunito;
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
    background-color: #a1c2ff;
    border-radius: 20px;
    box-shadow: 0 10px 40px #a5b7ff, 0 0 0 20px #ffffffeb;
    transform: scale(0.6);
    border: 10px green;
}

#head form {
    height: 96px;
}

#head input[type="text"] {
  width: 100%;
  height: 55px;
  font-size: 35px;
  line-height: 1;
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
	/* border: 2px solid red; */
  right: 0px;
  width: 33px;
  background-color: #fff;
}
</style>


<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css"
	rel="stylesheet">

</head>
<body>
	<input type="checkbox" id="check">
	<label for="check"> <i class="fas fa-bars" id="btn"></i> <i
		class="fas fa-times" id="cancel"></i>
	</label>
	<div class="sidebar">
		<header>Menu</header>
		<a class="active"> <i class="fas fa-rocket"></i></a> 
	<a href="<%=contextPath %>/main.bo?currentPage=1&typeNo=1"> <i class="fas fa-list"></i> <span>Board</span>
	</a> <a href="<%=contextPath %>/main.re"> <i class="fas fa-film"></i> <span>Reels</span>
	</a> <a href="<%=contextPath %>/main.um?currentPage=1&status=Y"> <i class="fas fa-user"></i><span>User_Manage</span>
	</a> <a href="<%=contextPath %>/main.ck"> <i class="fas fa-star"></i> <span>CheckList</span>
	</a> <a href="<%=contextPath %>/main.bl?currentPage=1&status=K"> <i class="fas fa-poo"></i> <span>BlackList</span>
	</a> <a href="<%=contextPath %>/main"> <i class="fas fa-heart"></i> <span>Go community</span> <!-- 매핑주소 확인 -->
	</a><a href="<%=contextPath %>/logout.me"> <i class="fas fa-rocket"></i> <span>Go Home</span> 
		</a>
	</div>
	<div id="head">
		<!-- <div id="logo">
			<img src="../../../resources/로고_투명배경.png" alt="커뮤니티 로고">
		</div> -->
		<form action="<%=contextPath %>/mainSearch.menu" method="get">
			<div id="cover" >
				<form method="get" action="<%=contextPath %>"/mainSearch.menu"">
					<div class="tb">
						<div class="td"><input type="text" placeholder="Search" required></div>
						<div class="td" id="s-cover">
							<button type="submit">
								<div id="s-circle"></div>
								<span></span>
							</button>
						</div>
					</div>
				</form>
			</div>
		</form>
	</div>
	
</body>

</html>