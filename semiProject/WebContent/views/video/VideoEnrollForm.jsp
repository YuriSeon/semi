<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		
</head>
<style>
    .box{
        text-align: center;
    }
    #head{
        position: relative;
    }
    #h12{
        position: absolute;
        
        
    }
    #b3{
        text-align: center;
        font-size: larger;
    }
  
	#enroll-form input,textarea{
		width:100%;
		box-sizing:border-box;
	}
    #file1{
        position: absolute;
    }
</style>


<body>
    <%@include file ="../common/menubar.jsp" %>

  
    <div class="outer">
		<br>
		<h2 align="center">릴스 게시글 작성하기(글쓰기 눌러서 들어왔을 떄)</h2>
		<br>
		
		
		<!-- 이렇게 작성하면 insert.ph라고 매핑 잡은 주소에 post방식으로도 처리할 수 있음 -->
		<form action="<%=contextPath %>/insert.vd" method="post" id="enroll-form" enctype="multipart/form-data">
		<table align="center">
		<tr>
			<th width="100">제목</th>
			<td colspan="3"><input type="text" name="title" required></td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3"><textarea name="content" rows="10" cols="30" required style="resize:none"></textarea></td>
		</tr>
		<tr>
			<th>썸네일</th>
			<td colspan="3" align="center">
				<img width="200" height="200" id="titleImg">
			</td>
		</tr>

	</table>
	<div id="file-area" align="center">
		<input type="file" id="file1" name="file1" onchange="loadImg(this,1);" required>	
	</div>	
	<br><br>

	<div align="center">
		<button type="submit">작성하기</button>
	</div>
</form>
<script>
$(function(){
	$("#file-area").hide();	
	$("#titleImg").click(function(){
		$("#file1").click();
	});
	function loadImg(inputFile,num) {
		if(inputFile.files.length == 1){
			var reader = new FileReader();
			reader.readAsDataURL(inputFile.files[0]);	
			reader.onload = function(e){
				switch(num){
					case 1: $("#titleImg").attr("src",e.target.result); break;
				}
			}
		}else{
			switch(num){
				case 1: $("#titleImg").attr("src",null); break;
			}
		}
	}
}
</script>
		
	<br><br>
	</div>

</body>
</html>