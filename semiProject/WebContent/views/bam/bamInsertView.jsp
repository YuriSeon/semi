<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대나무숲 게시글작성</title>
</head>
<body>
	<form action="<%=request.getContextPath() %>/baminsert.bo" method="post">
        <div style="width: 500px; background-color: gray; color: white;">

            <select name="bamCa" >
                <option value="n">일반</option>
                <option value="q">질문</option>
                <option value="l">연애</option>
            </select>
            제목 : <input type="text" name="title" id="title">
        </div>
            <textarea name="content" id="content" cols="30" rows="10" style="resize:none; width: 450px; "></textarea>
            <br>
            
            <input type="file" id="upfile">
            
        </form>
    </body>
</body>
</html>