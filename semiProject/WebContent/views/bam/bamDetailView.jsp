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
	.menu-bar__menu-1 ul > li > a{
		font-family: 'LotteMartDream';
        font-style: normal;
        font-weight: 700;
        src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamBold.woff2') format('woff2'), url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamBold.woff') format('woff');
        font-size:1.5rem;
        text-align:center;
        padding:20px 0;
        border-radius:10px 10px 0 0;
        color:white;
        }
	@font-face {
            font-family: 'GmarketSansMedium';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
        div{
            box-sizing:border-box;
            font-family: 'GmarketSansMedium';
            color: #262626;
            font-family: 'GmarketSansMedium';
        }
        .layout{
            position: absolute;
            left: 50%;
            width: 1000px;
            height: 1000px;
            margin-left: -500px;
            margin-top: -40px;
        }

        .bam_head{
            text-align: center;
            font-size: 25px;
            font-weight: bold;
            margin-top: 100px;
            margin-bottom: 20px;
        }

        .detail{
            margin-top: 50px;
            display: flex;
            margin-left: 10px;
            flex-direction: column;
            align-items: center;
        }

        .title{           
            display: flex;
            justify-content: space-between;
            background-color:lightgray;
            width: 800px;
            height: 100%;
            text-align: center;
        }
        .img{
            width: 40px;
        }

        .info{
            margin-left: 20px;
            font-size: 10px;
            text-align: center;
            display: flex;
            align-items:center;
        }

        .btitle{
            width: 60%;
            margin-top: 20px;
        }

        .bcount{
            font-size: 12px;
            margin-top: 25px;
            width: 15%;
            margin-right: 10px;
            
        }

        .content{
            width: 800px;
            font-size: 14px;
        }

        .goodbtn{
            width:70px;
            height: 50px;          
            background-color: deepskyblue;
            color: white;
            border-radius: 5px;
            border-style: none;
            cursor: pointer;
            font-size: 17px;
            font-family: 'GmarketSansMedium';
            text-align: center;          
        }

        #writerbtn{            
            width: 800px;
            text-align: right;    
        }

        .inputTable{
            height: 90%;
        }

        #recon{
            vertical-align: middle;
        }


        .repleBtn{
            width: 60px;
            border-style: none;
            border-radius: 5px;
            background-color: deepskyblue;
            color: aliceblue;
            height: 90%;
        }

        .p1{
            font-size: 13px;
            
        }
        .p2{
            margin-left: -25px;
            margin-top: 30px;
            
        }
        .btn{
            width: 90px;
            height: 36px;
            font-size: 16px;
            color: aliceblue;
        }
        .btn-danger{
            background-color: rgb(237, 87, 87);
        }
       

    </style>
</head>
<body>	
	<%@ include file ="../common/menubar.jsp"%> 
          <div class="bam_head" align="center">대나무 숲</div>
    <hr>
    <div class="layout">
        <div class="detail">
            <div class="title">
            	<%if(b.getTypeNo()!=1){//일반게시글이라면 %>
                <div class="info">
                      <img src="resources/css/img/baby-girl.png" class="img" alt="">
                      <p class="p1">익명</p>
                      <p class="p2"><%=b.getCreateDate() %></p>                    
                </div>                    
             	<div class="btitle">
                      (<%=b.getBoardType() %>)<%=b.getBoardTitle() %>
                 </div>
				<%}else{//공지사항이라면 %> 
				<div class="info">
                      <img src="resources/css/img/baby-girl.png" class="img" alt="">
                      <p class="p1">관리자</p>
                      <p class="p2"><%=b.getCreateDate() %></p>                    
                </div>                    
             	<div class="btitle">
                      <img style="width:25px" src="resources/bam_files/메가폰.png"><%=b.getBoardTitle() %>
                 </div>
				<%} %>
                <div class="bcount">
                    	조회수:<%=b.getCount() %> 추천수:<%=b.getGood() %>
                </div>
            </div>
            <%if(loginUser != null && loginUser.getUserNo()==Integer.parseInt(b.getBoardWriter())||loginUser.getUserNo()==1){ %>
            <br>
            <div id="writerbtn">
                <button type="button" onclick="location.href='<%=contextPath%>/bamupdate.bo?bno=<%=b.getBoardNo()%>'" class="btn btn-secondary">수정하기</button>
                <button type="button"  onclick="location.href='<%=contextPath%>/bamdelete.bo?bno=<%=b.getBoardNo()%>'" class="btn btn-danger">삭제하기</button>
            </div>
            <%} %>
            <hr>

            <div class="content">
                <p class="con">
					<%=b.getBoardContent() %>
                </p>
            </div>
            <br>
            <div class="good">
                <button class="goodbtn" onclick="boardGood();">추천</button>
            </div>
            <br><br>
        </div>




        <div class="reply-area">
            <table class="inputTable" style="width: 600px;" align="center">
                <thead>
                    <tr>
                        <td><textarea id="recon" cols="60" rows="3" style="resize: none;"></textarea></td>
                        <td><button onclick="replyInsert();" class="repleBtn">댓글 작성</button></td>
                    </tr>
                </thead>
            </table>
            <br><br>
            <p>댓글 (5)</p>
            <hr>


​
        </div>
    </div>
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
                			for(var i=0; i<rlist.length; i++){ //댓글 작성자 익명 붙이기
                				replyWriter = "익명";
                				if(rlist[i].replyWriter==boardWriter){ //댓글작성자 = 게시글 작성자
                					replyWriter +="(작성자)";
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