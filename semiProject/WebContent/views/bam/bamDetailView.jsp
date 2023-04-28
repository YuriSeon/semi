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
	#reply-area td{
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
                    <td id="goodCount"><%=b.getGood() %></td>
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
                        <%}else if(at.getOriginName().substring(at.getOriginName().lastIndexOf(".")+1).equals("jpg")){ %>
                            <!-- 사진이 있을 경우 -->
                            <img src="<%=contextPath+at.getFilePath()+"/"+at.getChangeName()%>" width="150" height="120">
                    	<%}else{ %>
                    		<!-- 첨부파일이 있을 경우 -->
                    		<a href="<%=contextPath + at.getFilePath()+"/"+at.getChangeName()%>" download="<%=at.getChangeName()%>"><%=at.getOriginName() %></a>
                		<%} %>
                    </td>
                    
                </tr>
            </tbody>
               
         </table>
         <br>
        <br>
        	<div align="center">
	        	<button id="good" onclick="boardGood();">추천</button>
        	</div>
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
            	$(function(){ //페이지 열자마자 댓글 불러오기
            		btncheck();
            		selectReply();
            	});
            
                function replyInsert(){//댓글 작성
                    $.ajax({
                        url : "bamreply.bo",
                        type:"post",
                        data:{
                            con:$("#recon").val(), //댓글 내용
                            bno:<%=b.getBoardNo()%> //게시글 번호
                        },
                        success :function(result){
                            if(result>0){ //작성 성공
                            	
                            	selectReply();
                            	$("#recon").val("");
                            }else{ //작성 실패
	                        	alert("작성오류");
                            }
                        },
                        error :function(){ //통신 실패
                            alert("오류")
                        }
                    });
                }
                
                function selectReply(){ //댓글 불러오기
                	$.ajax({
                		url : "bamreply.bo",
                		data :{ bno:<%=b.getBoardNo()%>},  //게시글 번호
                		success : function(rlist){ //불러오기 성공
                			var boardWriter = <%=b.getBoardWriter()%>; //게시글 작성자 판별하기 위한 게시글 작성자번호
                			var result = ""; 	//댓글 출력위해 빈문자열
                			var replyWriter;	//댓글 작성자 '익명' 담기위한 변수
                			var count = 1;		//익명뒤에 붙일 숫자 (아마 지울예정)
                			for(var i=0; i<rlist.length; i++){ //댓글 작성자 익명 붙이기
                				replyWriter = "익명";
                				if(rlist[i].replyWriter==boardWriter){ //댓글작성자 = 게시글 작성자
                					replyWriter +="(작성자)";
                				}else{ //게시글 작성자가 아닌 댓글 작성자한테 번호 붙이기
                					replyWriter +=count;
                					count++;
                				}
                				
                				result+="<tr>"
                                		+"<td style="+"text-align: center;"+">"+rlist[i].createDate+"</td>"
                                		+"<td style="+"text-align: center;"+">"+replyWriter+"</td>"
                                		+"<td colspan="+1+" rowspan="+1+" width="+400+">"+rlist[i].replyContent+"</td>"
                                		+"<td rowspan="+1+"><button onclick='"+"deleteReply(this);'"+"value='"+rlist[i].replyNo+"'id='deleteRe'>삭제</button></td>"
                            			+"</tr>";
                			}
                			
                			$("#reply-area ").html(result);
                		},
                		error : function(){
                			alert("실패")
                		}
                	});
                };
                
                function deleteReply(d){ //댓글삭제하기
                	//location.href="<--%=contextPath%>/deletereply.bo?replyNo="+$(d).attr("value")+"&bno="+<--%=b.getBoardNo()%>;
                	$.ajax({
                		url: "deletereply.bo",
                		data:{
                			replyNo:$(d).attr("value"),
                			bno:<%=b.getBoardNo()%>,
                			userNo:<%=loginUser.getUserNo()%>
                		},
                		success:function(result){
                				if(result>0){//댓글 삭제 성공
                					alert("댓글 삭제 완료");
                					selectReply();
                				}else{//댓글 삭제 실패
                					alert("자신이 쓴 댓글만 지울수 있습니다.");
                				}
                		},
                		error: function(){
                			console.log("통신실패");
                		}
                	})
                }
                function boardGood(){//게시글 추천하기
                	$.ajax({
                		url:"boardGood.bo",
                		data : {
                			bno:<%=b.getBoardNo()%>,
                			userNo:<%=loginUser.getUserNo()%>
                		},
                		type : "post",
                		success: function(result){
                			if(result>0){//추천 or 추천취소 성공
                				btncheck();
                			}else{//추천 실패?
                				alert("알수없는 오류");
                				console.log("설마");
                			}
                		},
                		error: function(){
                			console.log("추천실패");
                		}
                	})
                }
                function btncheck(){//추천 눌렀엇는지 버튼이벤트+추천수 변경
                	$.ajax({
                		url:"boardGood.bo",
                		data :{
                			bno:<%=b.getBoardNo()%>,
                			userNo:<%=loginUser.getUserNo()%>
                		},
                		success : function(arr){
                			$("#goodCount").html(arr[1]);
                			if(arr[0]>0){
                				$("#good").css("border-color","red");
                			}else{
                				$("#good").css("border-color","black");
                			}
                		},
                		error : function (){
                			console.log("실패");
                		}
                	})
                }
            </script>
      	
</body>
</html>