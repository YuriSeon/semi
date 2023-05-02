<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.kh.board.model.vo.BamCategory,com.kh.bMember.model.vo.BMember"%>
<%
	ArrayList<BamCategory> clist = (ArrayList<BamCategory>)request.getAttribute("clist");
	
	
%>
<!DOCTYPE html>
<html>
  	<!-- 서머노트 쓰기위한 CDN(jQuery, 서머노트cdn) -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <!-- 메뉴바에 있는 jquery와 충돌이 나기 때문에 필요한 js는 $대신 변수를 지정해서 써준다. -->
	<script > var jb = jQuery.noConflict(); </script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<head>
<meta charset="UTF-8">
<title>대나무숲 게시글작성</title>
	<style>
        .insert-form{
        	margin:auto;
        	border:1px solid rgb(243, 241, 241);
        	
        }
        .sun{
        	background-color:rgb(0,255,255);
        	height:5px;
        	border:0;
        	width:70%;
        	
        }
       
	</style>
</head>
<body>
	<%@ include file ="../common/menubar.jsp"%> 
	<div align="center">
		<h3>대나무숲</h3>
		<hr class="sun">
	</div>
	<div class="insert-form" style="width:800px">
	<form action="<%=contextPath%>/baminsert.bo" method="post" enctype="multipart/form-data">
	
        <div style="width: 500px; background-color: white; color: black;">
			<input type="hidden" name="userNo" value="<%=loginUser.getUserNo()%>">
			
            <select name="category">
					<option value="1">일반</option>
					<option value="2">질문</option>
            		<option value="3">연애</option>
            <%if(loginUser !=null&& loginUser.getUserNo()==1){ %>
					<option value="4">공지</option>            		
            <%} %>
			</select>
            제목 : <input type="text" name="title" id="title" maxlength="20" placeholder="최대길이20" size=45>
        </div>
		 <br>
			  <textarea id="summernote" name="content"></textarea>
			  
            <br>
            
            <input type="file" name="upfile">
            <br>
            <br>
            <div align="center">
	            <button type="submit" onclick="badCheck();">작성하기</button>
	            <button type="reset">취소</button>
            </div>
      </form>
	</div>
	<br><br><br>
      <script>
	    // 메인화면 페이지 로드 함수
	   $(document).ready(function() {
			  jb('#summernote').summernote({
			  height:300,
			  minHeight:null,
			  maxheight:null,
			  lang: "ko-KR",//한글 안되면 UTF-8로 해봄
			  placeholder:"사진의 크기는 ?mb까지 최대 3개까지 넣으실 수 있습니다.",
			  toolbar: [
					    // 글꼴 설정
					    ['fontname', ['fontname']],
					    // 글자 크기 설정
					    ['fontsize', ['fontsize']],
					    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
					    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
					    // 글자색
					    ['color', ['forecolor','color']],
					    // 글머리 기호, 번호매기기, 문단정렬
					    ['para', ['ul', 'ol', 'paragraph']],
					    // 줄간격
					    ['height', ['height']]
					    // 그림첨부
					    //['insert',['picture']],
					  ],
			  // 추가한 글꼴
			  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
			  // 추가한 폰트사이즈
			  fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50'],
		  });
		});
</script>

</body>
</html>