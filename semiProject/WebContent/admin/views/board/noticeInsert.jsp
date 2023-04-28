<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#wrapper{
		text-align: center;
	}
	#bb{
		text-align: left;
	}
	select{
		margin-left: 190px;
		margin-top: 30px;
		width: 100px;
		height: 30px;
		text-align: center;
	}
	textarea, input[type=text]{
        width: 100%;
        height: 100%;
		font-size: medium;
        
    }
    textarea{
    	vertical-align: middle;
    }
    th{
        width: 20%;
        text-align: center;
    }
    td{
        width: 60%;
        background-color : white;
    }
    #btnbtn{
    	margin-top:40px;
        text-align: center;
    }
	h2{
		margin-bottom: 10px;
	}
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<h2> 공지사항 작성 </h2>
	<form action="<%=contextPath %>/insert.abo " method="post">
		<div id="wrapper">
			<div id="bb">
				<input type="hidden" name="bType" value="4"> 
				<select name="boardtype" id="boardtype">
					<option value="bam">대나무숲</option>
					<option value="food">맛집</option>
				</select>
			</div>
			<table style="width: 60%; height: 50%; margin-top: 10px;">
				<tr>
					<th style="height: 40px;">제목 </th>
					<td><input type="text" name="insertTitle" id="insertTitle" ></td>
				</tr>
				<tr>
					<th>내용 </th>
					<td><textarea name="content" id="content" cols="50" rows="15" style="resize: none;"></textarea></td>
				</tr>
			</table>
			<div id="btnbtn">
				<button type="submit" class="custom-btn btn-10">등록</button>
				<button type="button" onclick="history.back();" class="custom-btn btn-10">취소</button>
			</div>
		</div>
	</form>
</body>
</html>