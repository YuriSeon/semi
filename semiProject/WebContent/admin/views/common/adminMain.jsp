<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.admin.userManage.model.vo.User"%>
<% 
	String contextPath = request.getContextPath(); 
	String alertMsg = (String)request.getSession().getAttribute("alertMsg");
	int[][] boardArr = (int[][])request.getAttribute("boardArr");
	User u = (User)request.getAttribute("u");
	int[] checkArr = (int[])request.getAttribute("checkArr");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>admin_main</title>
    <style>
     @font-face {
        font-family: 'GmarketSansMedium';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }
      :root{
--background-dark: #7ad7ff;
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
font-family: 'GmarketSansMedium';
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
background-image: linear-gradient(15deg, #45b8ff 0%, #acf4ff 150%);
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

.card:before{
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
left: 1px;
padding: var(--spacing-l);
position: absolute;
top: 0;
}
.card__heading{
color: var(--text-lighter);
font-size: 1.9rem;
text-shadow: 2px 2px 20px rgba(0,0,0,0.2);
line-height: 1.5;
word-spacing: 100vw;
}
td{
padding:2px;

}

  </style>
</head>
<body>
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">

<section class="hero-section">
<div class="card-grid">
  <a class="card" href="<%=contextPath %>/typeList.abo?bType=2&currentPage=1">
    <div class="card__background" style="background-image: url()"></div>
    <div class="card__content">
   	<br><br>
      <h3 class="card__heading">대나무숲 게시판</h3>
      <br>
      <table>
          <tr>
            <td>전체 게시글</td>
            <td>&nbsp;<%=boardArr[0][0] %></td>
          </tr>
          <tr>
            <td>최근 업로드</td>
            <td>&nbsp;<%=boardArr[0][1] %></td>
          </tr>
          <tr>
            <td>최근 신고된 게시글</td>
            <td>&nbsp;<%=boardArr[0][2] %></td>
          </tr>
          <tr>
            <td>블러처리된 게시글</td>
            <td>&nbsp;<%=boardArr[0][3] %></td>
          </tr>
        </table>
    </div>
  </a>
  <a class="card" href="<%=contextPath %>/typeList.abo?bType=3&currentPage=1">
    <div class="card__background"  style="background-image: url()"></div>
    <div class="card__content">
      <br><br>
      <h3 class="card__heading">맛집 게시판</h3>
      <br>
      <table>
          <tr>
            <td>전체 게시글</td>
            <td>&nbsp;<%=boardArr[1][0] %></td>
          </tr>
          <tr>
            <td>최근 업로드</td>
            <td>&nbsp;<%=boardArr[1][1] %></td>
          </tr>
          <tr>
            <td>최근 신고된 게시글</td>
            <td>&nbsp;<%=boardArr[1][2] %></td>
          </tr>
          <tr>
            <td>블러처리 된 게시글</td>
            <td>&nbsp;<%=boardArr[1][3] %></td>
          </tr>
        </table>
    </div>
  </a>
  <a class="card" href="<%=contextPath %>/main.um?currentPage=1&status=Y" >
    <div class="card__background" style="background-image: url(<%=contextPath %>/resources/admin/사람들.png)"></div>
    <div class="card__content">
      <br><br>
      <h3 class="card__heading">회원 정보</h3>
      <br>
      <table>
          <tr>
            <td>현재 총 회원 수</td>
            <td><%=u.getTotalUser()%></td>
          </tr>
          <tr>
            <td>최근 가입자 수</td>
            <td><%=u.getRecentEnroll()%></td>
          </tr>
          <tr>
            <td>탈퇴 회원 수</td>
            <td><%=u.getWithdraw()%></td>
          </tr>
          <tr>
            <td>강퇴 회원 수</td>
            <td><%=u.getKickOut() %></td>
          </tr>
        </table>
    </div>
  </li>
  <a class="card" href="<%=contextPath %>/main.ck?option=1&currentPage=1">
    <div class="card__background"  style="background-image: url()"></div>
    <div class="card__content">
      <br><br>
      <h3 class="card__heading">체크 리스트</h3>
      <br>
      <table>
          <tr>
            <td>최근 신고 당한 회원 수</td>
            <td>&nbsp;<%=checkArr[0] %></td>
            <!-- 뭐지 이거 -->
          </tr>
          <tr>
            <td>경고 1회</td>
            <td>&nbsp;<%=checkArr[1] %></td>
          </tr>
          <tr>
            <td>경고 2회</td>
            <td>&nbsp;<%=checkArr[2] %></td>
          </tr>
          <tr>
            <td>경고 3회</td>
            <td>&nbsp;<%=checkArr[3] %></td>
          </tr>
          <tr>
            <td>경고 4회</td>
            <td>&nbsp;<%=checkArr[4] %></td>
          </tr>
          <tr>
            <td>체크 필요한 회원 수</td>
            <td>&nbsp;<%=checkArr[5] %> </td>
          </tr>
        </table>
    </div>
  </a>
<div>
</section>
<script>
		var msg = "<%=alertMsg%>";
		
		if(msg != "null") {
			alert(msg);
			<%session.removeAttribute("alertMsg");%>
		}
	</script>
</body>
</html>