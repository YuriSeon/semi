<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
:root{
  --background-dark: #2d3548;
  --text-light: rgba(255,255,255,0.6);
  --text-lighter: rgba(255,255,255,0.9);
  --spacing-s: 8px;
  --spacing-m: 16px;
  --spacing-l: 24px;
  --spacing-xl: 32px;
  --spacing-xxl: 64px;
  --width-container: 1200px;
}

*{
  border: 0;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html{
  height: 100%;
  font-family: 'Montserrat', sans-serif;
  font-size: 14px;
}

body{
  height: 100%;
}

.hero-section{
  align-items: flex-start;
  background-image: linear-gradient(15deg, #0f4667 0%, #2a6973 150%);
  display: flex;
  min-height: 100%;
  justify-content: center;
  padding: var(--spacing-xxl) var(--spacing-l);
}

.card-grid{
  display: grid;
  grid-template-columns: repeat(1, 1fr);
  grid-column-gap: var(--spacing-l);
  grid-row-gap: var(--spacing-l);
  max-width: var(--width-container);
  width: 100%;
}

@media(min-width: 540px){
  .card-grid{
    grid-template-columns: repeat(2, 1fr); 
  }
}

@media(min-width: 960px){
  .card-grid{
    grid-template-columns: repeat(4, 1fr); 
  }
}

.card{
  list-style: none;
  position: relative;
}

.card:before
{
  content: '';
  display: block;
  padding-bottom: 150%;
  width: 100%;
}

.card__background{
  background-size: cover;
  background-position: center;
  border-radius: var(--spacing-l);
  bottom: 0;
  filter: brightness(0.75) saturate(1.2) contrast(0.85);
  left: 0;
  position: absolute;
  right: 0;
  top: 0;
  transform-origin: center;
  trsnsform: scale(1) translateZ(0);
  transition: 
    filter 200ms linear,
    transform 200ms linear;
}

.card:hover .card__background{
  transform: scale(1.05) translateZ(0);
}

.card-grid:hover > .card:not(:hover) .card__background{
  filter: brightness(0.5) saturate(0) contrast(1.2) blur(20px);
}

.card__content{
  left: 0;
  padding: var(--spacing-l);
  position: absolute;
  top: 0;
}

.card__category{
  color: var(--text-light);
  font-size: 0.9rem;
  margin-bottom: var(--spacing-s);
  text-transform: uppercase;
}

.card__heading{
  color: var(--text-lighter);
  font-size: 1.9rem;
  text-shadow: 2px 2px 20px rgba(0,0,0,0.2);
  line-height: 1.4;
  word-spacing: 100vw;
}
</style>
</head>
<body>
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">

<section class="hero-section">
  <div class="card-grid">
    <a class="card" href="<%=request.getContextPath()%>/list.me?currentPage=1">
      <div class="card__background" style="background-image: url(https://images.unsplash.com/photo-1557177324-56c542165309?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80)"></div>
      <div class="card__content">
        <p class="card__category">MyPage</p>
        <h3 class="card__heading">마이페이지</h3>
      </div>
    </a>
    <a class="card" href="#">
      <div class="card__background" style="background-image: url(https://m.zerosafety.co.kr/web/product/big/201712/203_shop1_452500.jpg)"></div>
      <div class="card__content">
        <p class="card__category">영상게시판</p>
        <h3 class="card__heading">릴스 영상</h3>
      </div>
    </a>
    <a class="card" href="<%=request.getContextPath()%>/bamlist.bo?currentPage=1">
      <div class="card__background" style="background-image: url(https://images.unsplash.com/photo-1556680262-9990363a3e6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60)"></div>
      <div class="card__content">
        <p class="card__category">익명게시판</p>
        <h3 class="card__heading">대나무숲</h3>
      </div>
    
    </a>
    <!-- 시간에 따라 메인 페이지 중 음식 사진 변경 -->
    <%
    	Date d = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("HH");
    	int timeNow = Integer.parseInt(sdf.format(d));
    	String[] foodPhoto = {"https://url.kr/6m9wpq", "https://url.kr/ywmcbr", "https://url.kr/biovh4", "https://url.kr/vxqt8b", "https://url.kr/ikb4jc"};
    	String timeFoodPhoto = "";
    	if(timeNow >= 21){ // 저녁 9시부터 새벽 2시까지는 치킨인데 라면으로 변경 
    		timeFoodPhoto = foodPhoto[0];
    	}else if(timeNow >= 18){ // 저녁 6시 이후 삼겹살
    		timeFoodPhoto = foodPhoto[1];
    	}else if(timeNow >= 12){ // 점심시간은 국밥
    		timeFoodPhoto = foodPhoto[2];
    	}else if(timeNow >= 8){ // 아침시간은 토스트
    		timeFoodPhoto = foodPhoto[3];
    	}else if(timeNow <= 2){ // 새벽 2시
    		timeFoodPhoto = foodPhoto[0];
    	} else{ // 그 외 시간은 평온한 음식사진
    		timeFoodPhoto = foodPhoto[4];
    	}
    %>
    <a class="card" href="<%=request.getContextPath() %>/foodmain.bo">
      <div class="card__background" style="background-image: url(<%=timeFoodPhoto%>)"></div>
        <div class="card__content">
        <p class="card__category">맛집 게시판</p>
        <h3 class="card__heading">같이 밥먹자</h3>
      </div>
    </a>
  <div>
</section>
</body>
</html>