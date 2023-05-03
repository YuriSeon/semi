<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.*,java.util.Arrays"%>
<%
	Board b = (Board)request.getAttribute("b");
	Attachment at = (Attachment)request.getAttribute("at");
	String[] arr = (String[])request.getAttribute("arr");
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
            margin-top: 50px;
            margin-bottom: 20px;
        }

        .detail{
            //margin-top: 50px;
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
            word-break:break-all;
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
            margin-left: -35px;
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
        .retop{
            border-top: 1px solid rgb(180, 175, 175); 
        }
        .check{
        	width:25px;
        }
        hr{
        	width:100%;
        	text-align: center;
        }

    </style>
</head>
<body>	
	<%@ include file ="../common/menubar.jsp"%> 
    <div class="bam_head" align="center">대나무 숲</div>
    <div class="layout">
    <hr>
        <div class="detail">
            <div class="title">
            	<%if(b.getTypeNo()!=1){//일반게시글이라면 %>
                <div class="info">
                      <img src="resources/bam_files/팬더.png" class="img" alt="">
                      <p class="p1">팬더</p>
                      <p class="p2"><%=b.getCreateDate() %></p>                    
                </div>                    
             	<div class="btitle">
                      (<%=b.getBoardType() %>)<%=b.getBoardTitle() %>
                 </div>
				<%}else{//공지사항이라면 %> 
				<div class="info">
                      <i class="fa-solid fa-user-secret fa-3x"></i>
                      <p class="p1">관리자</p>
                      <p class="p2"><%=b.getCreateDate() %></p>                    
                </div>                    
             	<div class="btitle">
                      <img style="width:25px" src="resources/bam_files/메가폰.png"><%=b.getBoardTitle() %>
                 </div>
				<%} %>
                <div class="bcount">
                    	조회수:<%=b.getCount() %>  <span id="goodCount">추천수:<%=b.getGood() %></span>
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
                
					<%=b.getBoardContent() %>
                
                <%if(at==null){//첨부파일이 없다면 %>
                	<br>
                <%}else if(Arrays.asList(arr).contains(at.getOriginName().substring(at.getOriginName().lastIndexOf(".")+1).toUpperCase())){ %>
                <!-- 첨부파일에서 확장자명을 뽑아 이미지인지 확인해서 이미지라면 true -->
                	<img src="<%=contextPath+at.getFilePath()+"/"+at.getChangeName()%>">
                <%}else{ %>
                <!-- 이미지가 아니라면 다운로드 할 수 있게 -->
	                <br>
	                <br>
	                <a href="<%=contextPath + at.getFilePath()+"/"+at.getChangeName()%>" download="<%=at.getChangeName()%>"><%=at.getOriginName() %></a>
                <%} %>
                
                
                	</div>
            <br>
            <div class="good">
                <button class="goodbtn" onclick="boardGood();">추천</button>
            </div>
            <br><br>
        </div>

		

		<button onclick="location.href='<%=contextPath%>/bamreport.bo?bno=<%=b.getBoardNo()%>&userNo=<%=loginUser.getUserNo()%>'" class="btn" style="float: right; width:130px">작성자신고</button>
        <div class="reply-area">
            <p>댓글</p>
            <hr>
            <table class="inputTable" style="width: 600px;" align="center">
                <thead>
                    <tr>
                        <td><textarea id="recon" cols="60" rows="3" style="resize: none;"></textarea></td>
                        <td><button onclick="replyInsert();" class="repleBtn">댓글 작성</button></td>
                    </tr>
                </thead>
            </table>
            <br><br>
			<table align="center" id="reply-con">
                <tbody >
    			</tbody>
        	</table>

​
        </div>
    </div>
            <br><br><br>
            
            <script>
            	$(function(){ //페이지 열자마자 실행
            		btncheck(); //추천했는지 판별
            		selectReply(); //댓글 불러오기
            	});
            
                function replyInsert(){//댓글 작성
                	console.log($("#recon").val());
                	console.log(<%=b.getBoardNo()%>);
                    $.ajax({
                        url : "bamreply.bo",
                        type:"post",
                        data:{
                            con:$("#recon").val(), //댓글 내용
                            bno:<%=b.getBoardNo()%>, //게시글 번호
                            btype:<%=b.getTypeNo()%> //공지사항인지
                        },
                        success :function(result){
                            if(result>0){ //작성 성공
                            	console.log("성공")
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
                				replyWriter = "팬더";
                				if(rlist[i].replyWriter==boardWriter){ //댓글작성자 = 게시글 작성자
                					replyWriter +="(작성자)";
                				}
                				
                				result+="<tr class=retop>"
                                +'<td rowspan="1"><img src="resources/bam_files/팬더.png" class="img"></td>'
                                +'<td style="text-align: center;" class="p1">'+replyWriter+'<br>'+rlist[i].createDate+'</td>'
                                +'<td colspan="2" rowspan="1" width="500">'+rlist[i].replyContent+'</td>'
                                +'<td rowspan="1"><button onclick="deleteReply(this);"value="'+rlist[i].replyNo+'"class="btn btn-danger">삭제</button></td>'
                            	+'</tr>';
                			}
                			
                			$("#reply-con tbody").html(result);
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
                			$("#goodCount").html("추천수:"+arr[1]);
                			if(arr[0]>0){
                				$(".goodbtn").html("<img class='check' src='resources/bam_files/체크표시.png'>");
                			}else{
                				$(".goodbtn").html("추천");
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