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
</head>
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
     
        background-color : white;
    }
    input[type=radio]{
    	margin-left:40px;
    	
    }
    #btnbtn{
    	margin-top:30px;
        text-align: center;
        
    }
    #btnbtn *{
    	width: 85px;
  		height: 25px;
    }
	#tab{
        vertical-align : middle;   
    }
    table *{
        box-sizing: border-box;
    }
    btn-9{
        margin-top:10px;
    }
    img{
    	width:50px;
    }
    .replyContent{
    	width : 400px;
    }
    #tr5{
    	font-size : 13px;
    }
    
</style>
</head>
<body>
<%@include file="../common/menubar.jsp" %>

    <div id="wrapper">
        <div id="bb">
            <br><br><br><br><br>
            <table>
                <tr id="tr1">
                    <th >게시판 종류</th>
                    <td colspan="3"> 
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
                   <td colspan="3">
                       <input type="text" name="title" id="title" value="<%=b.getBoardTitle()%>" readonly>
                   </td>
               </tr>
               <tr id="tr3">
                   <th>내용</th>
                    <td colspan="3">
                        <div><textarea name="content" id="content" cols="30" rows="8" style="resize: none;" readonly><%=b.getBoardContent() %></textarea></div>
                    </td>
                </tr>
                <tr id="tr4">
                    <th>첨부파일</th>
                    <% if(a!=null) { %>
                        <td>
                        파일명 : <%=a.getFilePath()+a.getChangeName() %> 
                        <img src="<%=contextPath+a.getFilePath()%>/<%=a.getChangeName()%>" >
                        </td>
                    <% } else { %> 
                        <td style="background-color:white;" colspan="3"> 첨부된 파일이 없습니다.</td>
                    <% } %>   
                </tr>
               	<tr>
               		<th colspan="4">댓글</th>
               	</tr>
                <% if(rList!=null && !(rList.isEmpty())) {%>
                    <% for(int i=0; i<rList.size(); i++) {%>
		                <tr id="tr5">
		                	<td><%=rList.get(i).getReplyNo() %></td>
	                        <td><%=rList.get(i).getReplyWriter() %></td>
	                        <td class="replyContent"><input type="text" name="replyCount" id="replyCount" value="<%=rList.get(i).getReplyContent() %>" readonly></td>
		                	<td ><%=rList.get(i).getCreateDate() %></td>
		                </tr>
	                <% } %>
                <% } else { %>
                	<tr>
                		<td colspan="2" style="height:150px;">작성된 댓글이 없습니다.</td>
                	</tr>
                <% } %>
            </table>
	       <div id="btnbtn">
	            <button type="button" class="custom-btn btn-9" onclick="history.back();">뒤로가기</button>
	            <button type="button" class="custom-btn btn-10" onclick="boardActive();">활성화</button>
	            <button type="button" class="custom-btn btn-5" onclick="boardDelete();" >삭제</button>
            </div>
        </div>
    </div>
	<script>
	
		// 뒤로가기 버튼 제어하기 -------------------------------------------------------------
		window.onpopstate = function(event) {
		    history.pushState(null, null, '<%=request.getHeader("Referer")%>');
		    location.reload();
		}
		history.pushState(null, null, null);
		// ----------------------------------------------------------------------------
	
		var bno = "<%=b.getBoardNo()%>";

		$(function(){
			$("input[type=radio]").each(function(){
				if($(this).val()=='<%=b.getBoardType()%>') {
					$(this).attr("checked", true);
					console.log(this);
				}
			});
		});
	
		function boardActive(){
			if(confirm("게시물을 활성화시키시겠습니까?")){
				location.href="<%=contextPath%>/active.abo?bno="+bno;
			} else {
				alert("취소하셨습니다.");
			}
		}
		
		function boardDelete(){
			if(confirm("게시물을 삭제하시겠습니까?")){
				location.href="<%=contextPath %>/blurDelete.abo?bno="+bno;
			} else {
				alert("취소하셨습니다.");
			}
		}
	</script>
</body>
</html>