<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <%@include file="../common/menubar.jsp" %>
    <div>
		<div id="head">
			<form action="<%=contextPath %>/mainSearch.menu" method="get">
				<div>
					<input type="search" name="main-search" id="main-search" placeholder="검색어를 입력하세요.">
				</div>
				<div>
					<button type="submit">검색</button>
				</div>
			</form>
		</div>
		<div id="content">
			<div id="con1">
				<form action="<%=contextPath%>/selectBoard.bo" method="get">
				<select name="board-category" id="board-category">
					<option name="b-category" value="notice">공지사항</option>
					<option name="b-category" value="bam">대나무숲</option>
				</select>
				<div><input type="search" name="search-content" id=""></div>
				<div><button type="submit">검색</button></div>
			</form>
			<button type="button" onclick="location.href='<%=contextPath %>/delete.bo'">삭제하기</button>	
			</div>

            <!-- 게시물 조회해와서 출력할 부분 -->
		</div>
	</div>
</body>
</html>