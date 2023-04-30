<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.*, java.util.ArrayList"%>
<%
    Board b = (Board)request.getAttribute("b");
	Attachment a = (Attachment)request.getAttribute("a");
	ArrayList<Reply> rList = (ArrayList<Reply>)request.getAttribute("rList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    textarea, input[type=text]{
        width: 100%;
        height: 100%;
        
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
    input[type=radio]{
    	margin-left:40px;
    }
    #btnbtn{
    	margin-top:20px;
        text-align: center;
    }
	#tab{
		border:1px solid black;
	}
    table *{
        box-sizing: border-box;
    }
    btn-9{
        margin-top:10px;
    }
    
</style>
</head>
<body>
<%@include file="../common/menubar.jsp" %>
    <div id="wrapper">
        <div id="bb">
            <br><br>
            <table>
          		<form action="<%=contextPath %>/detail.abo" method="post">
	                <tr id="tr1">
	                    <th>게시판 종류</th>
	                    <td> 
	                        <div>
	                       		<input type="hidden" name="bno" value="<%=b.getBoardNo()%>">
	                            <input type="radio" name="board_type" id="bam" value="대나무숲" disabled>대나무숲
	                            <input type="radio" name="board_type" id="food" value="맛집" disabled>맛집
	                            <input type="radio" name="board_type" id="food" value="공지사항" disabled>공지사항
	                        </div>
	                    </td>
	                </tr>
	                <tr id="tr2">
	                    <th>제목</th>
	                    <td>
	                        <input type="text" name="title" id="title" value="<%=b.getBoardTitle()%>">
	                    </td>
	                </tr>
	                <tr id="tr3">
	                    <th>내용</th>
	                    <td>
	                        <div><textarea name="content" id="content" cols="30" rows="8" style="resize: none;"><%=b.getBoardContent() %></textarea></div>
	                    </td>
	                </tr>
	                <tr id="tr4">
	                    <th>첨부파일</th>
	                    <% if(a!=null) { %>
	                        <td>파일명 : <%=a.getFilePath()+a.getChangeName() %> </td>
	                    <% } else { %> 
	                        <td style="background-color:white;"> 첨부된 파일이 없습니다.</td>
	                    <% } %>   
	                </tr>
	               	<tr>
	               		<th colspan="2">댓글</th>
	               	</tr>
	                <tr id="tr5">
	                <% if(rList!=null && !(rList.isEmpty())) {%>
	                    <% for(int i=0; i<rList.size(); i++) {%>
	                        <td colspan="2">
	                                <td><%=rList.get(i).getReplyWriter() %></td>
	                                <td><input type="text" name="replyCount" id="replyCount" value="<%=rList.get(i).getReplyContent() %>"></td>
	                        </td>
		                <% } %>
	                <% } else { %>
	                	<td colspan="2" style="height:150px;">작성된 댓글이 없습니다.</td>
	                <% } %>
	                </tr>
	            </table>
	            <div id="btnbtn">
	                <button type="button" class="custom-btn btn-9" onclick="history.back();">뒤로가기</button>
	            	<button type="submit" class="custom-btn btn-10">수정하기</button>
	                <button type="button" class="custom-btn btn-5" >삭제</button>
	            </div>
            </form>
        </div>
    </div>
    <script>
	   var bno = <%=b.getBoardNo()%>;
	    // 라디오 객체의 board_type에 맞춰서 체크되도록 설정
	    $(function(){
	    	$("input[name=board_type]").each(function() {
	    		  if($(this).val() == '<%=b.getBoardType()%>') {
	    		    $(this).attr('checked', true);
	    		  } else {
	    			 $(this).attr("disabled", true);
	    		  }
	    	});
	    });
	    
	    $(".btn-5").on("click", function(){
	    	if(confirm("해당 게시물을 삭제하시겠습니까?")){
	    		location.href="<%=contextPath%>/delete.abo?bno="+bno;
	    	} else {
	    		alert("취소하셨습니다.");
	    	}
	    });
	    
    </script>
</body>
</html>