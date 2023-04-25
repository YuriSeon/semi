<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.*"%>
<%
	Board b = (Board)request.getAttribute("b");
	Attachment at = (Attachment)request.getAttribute("at");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 디테일</title>
<style>
	#detail-area>thead th,td{
		border:1px solid black;
	}
	#detail-area>tbody th{
		border:1px solid black;
	}
</style>
</head>
<body>	
	<%@ include file ="../common/menubar.jsp"%> 
          <table id="detail-area" align="center" border="1">
            <thead>
                <tr>
                
	                <td width="20"><%=b.getBoardType() %></td>
                    <td>익명(사진)</td>
                    
                    <th width="350"><%=b.getBoardTitle() %></th>
                    
                    <td><%=b.getCount() %></td>
                    <td><%=b.getGood() %></td>
                    <td><%=b.getCreateDate() %></td>
                </tr>
            </thead>
            
            <tbody>

                <tr>
                    <th>내용</th>
                    <td colspan="3">
                        <p style="height:200px;"><%=b.getBoardContent() %></p>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                        <!-- 첨부파일이 없을 경우 : 첨부파일이 없습니다. -->
                    	<%if(at == null) {%>
                    		첨부파일이 없습니다.
                        <%}else{ %>
                                <!-- 첨부파일이 있을 경우 -->
                                <img src="<%=contextPath+at.getFilePath()+"/"+at.getChangeName()%>" width="150" height="120">
                    	<%} %>
                    </td>
                    
                </tr>
            </tbody>
               
         </table>
         <br>
        <br>
        	<button onclick="">추천하기</button>
        <%if(loginUser != null && loginUser.getUserNo()==Integer.parseInt(b.getBoardWriter())||loginUser.getUserNo()==1){ %>
	        <div align="center">
	        	<button onclick="location.href='<%=contextPath%>/bamupdate.bo?bno=<%=b.getBoardNo()%>'" class="btn">수정하기</button>
	        	<button onclick="location.href='<%=contextPath%>/bamdelete.bo?bno=<%=b.getBoardNo()%>'" class="btn">삭제하기</button>
	        </div>
        <%} %> 
      	<div align="center">
            <button onclick="location.href='<%=contextPath%>/bamlist.bo?currentPage=1'" class="btn">글목록으로</button>
            <button onclick="location.href='<%=contextPath%>/bamreport.bo?bno=<%=b.getBoardNo()%>&userNo=<%=loginUser.getUserNo()%>'" class="btn">신고하기</button>
      	</div>
      	
      	
      	<table border="1" style="width: 600px;" align="center">
                <thead>
                    <tr>
                        <td><textarea id="recon" cols="60" rows="3" style="resize: none;"></textarea></td>
                        <td><button onclick="replyInsert();">댓글 작성</button></td>
                        <td><button type="reset">취소</button></td>
                    </tr>
                </thead>
            </table>
            <table id="reply-area" border="1" align="center" style="width: 600px;">
                	
                	<!--  댓글 예시
                    <tr>
                        <td style="text-align: center;">익명</td>
                        <td colspan="2" rowspan="2" width="400" height="">강아지가 귀엽네요</td>
                        <td rowspan="2"><button onclick="deleteReply();">삭제</button></td>
                    </tr>
                    <tr>
                        <td style="text-align: center;">2023-04-20 10:30</td>
                    </tr>
                	 -->
                	
            </table>
            <br><br><br>
            
            <script>
            	$(function(){
            		selectReply();
            	});
            
                function replyInsert(){
                    $.ajax({
                        url : "bamreply.bo",
                        type:"post",
                        data:{
                            con:$("#recon").val(),
                            bno:<%=b.getBoardNo()%>
                        },
                        success :function(result){
                            if(result>0){
                            	
                            	selectReply();
                            	$("#recon").val("");
                            }else{
	                        	alert("작성오류");
                            }
                        },
                        error :function(){
                            alert("오류")
                        }
                    });
                }
                
                function selectReply(){
                	$.ajax({
                		url : "bamreply.bo",
                		data :{ bno:<%=b.getBoardNo()%>},
                		success : function(rlist){
                			var boardWriter = <%=b.getBoardWriter()%>
                			var result = "";
                			var replyWriter;
                			var count = 1;
                			for(var i=0; i<rlist.length; i++){
                				replyWriter = "익명";
                				if(rlist[i].replyWriter==boardWriter){
                					replyWriter +="(작성자)";
                				}else{
                					replyWriter +=count;
                					count++;
                				}
                				
                				result+="<tr>"
                                		+"<td style="+"text-align: center;"+">"+replyWriter+"</td>"
                                		+"<td colspan="+2+" rowspan="+2+" width="+400+">"+rlist[i].replyContent+"</td>"
                            			+"</tr>"
                            			+"<tr>"
                                		+"<td style="+"text-align: center;"+">"+rlist[i].createDate+"</td>"
                                		//+"<"+"%if(loginUser != null && loginUser.getUserNo()==Integer.parseInt("+rlist[i].replyWriter+")||loginUser.getUserNo()==1){ %>"
                                		+"<td rowspan="+2+"><button onclick='"+"deleteReply(this);'"+"value='"+rlist[i].replyNo+"'id='deleteRe'>삭제</button></td>"
                                		//+"<"+"%}%>"
                            			+"</tr>";
                			}
                			
                			$("#reply-area ").html(result);
                		},
                		error : function(){
                			alert("실패")
                		}
                	});
                };
                function deleteReply(d){
                	location.href="<%=contextPath%>/deletereply.bo?replyNo="+$(d).attr("value")+"&bno="+<%=b.getBoardNo()%>;
                	
                }
            </script>
      	
</body>
</html>