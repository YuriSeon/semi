<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
	<form action="<%=request.getContextPath()%>/rankInsert.bo"
		method="post">
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="Btitle" required></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="30" name="content"
						style="resize: none" required></textarea></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" id="kakao_address" name="address"
					required></td>
			</tr>
			<tr>
				<th>상세 주소</th>
				<td><input type="text" name="addressDetail"></td>
			</tr>
		</table>
		<button type="submit">등록하기</button>
	</form>
</body>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	window.onload = function() {
		document
				.getElementById("kakao_address")
				.addEventListener(
						"click",
						function() { //주소입력칸을 클릭하면
							//카카오 지도 발생
							new daum.Postcode(
									{
										oncomplete : function(data) { //선택시 입력값 세팅
											document
													.getElementById("kakao_address").value = data.address; // 주소 넣기
											document
													.querySelector(
															"input[name=addressDetail]")
													.focus(); //상세입력 포커싱
										}
									}).open();
						});
	}
</script>
</body>
</html>