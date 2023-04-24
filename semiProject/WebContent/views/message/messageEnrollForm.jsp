<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.bMember.model.vo.BMember"%>
<%
	//로그인 유저 정보
	BMember loginUser = (BMember)session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">    
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>    
<script src="https://code.jquery.com/jquery-3.6.4.js"integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>닉네임 눌러서 메시지 보내기</title>
</head>
<body>
    <table id="table">
        <tbody>
            <tr>
            	<!-- data-id="닉네임" 넣고 메시지 보내기에 보냄-->
                <td><a href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#myModal" data-id="닉네임" id="userNick">닉네임</a></td>
            </tr>
        </tbody>
    </table>
    <div class="modal fade" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <table border="1" id="nickname-layer">
                        <tr>
                            <td><button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">메시지 보내기</button></td>
                        </tr>
                        <tr>
                            <td><button type="button" onclick="location.href='<%=contextPath%>/bamreport.bo?userNo=유저번호'" class="btn" >메시지 차단하기</button></td>
                        </tr>
                        <tr>
                            <td><button type="button" onclick="location.href='<%=contextPath%>/bamreport.bo?userNo=유저번호'" class="btn" >신고하기</button></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">New message</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                        <div class="mb-3">
                            <label for="recipient-name" class="col-form-label">닉네임:</label>
                            <input type="text" class="form-control" id="recipient-name" readonly>
                        </div>
                         <div class="mb-3">
                            <label for="message-text" class="col-form-label">내용:</label>
                            <textarea class="form-control" id="message-text"></textarea>
                </div>
             </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="msgEnroll();">Send message</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
     <script >
	     $("#userNick").click(function(){
	    	 var data = $(this).data("id")
	    	 $("#recipient-name").val(data);
	     });
     	function msgEnroll(){
     		
     		$.ajax({
     			url:"insertMsg.dm",
     			data:{
     				//받는회원 닉네임
     				acceptNick:$("#recipient-name").val(),
     				//메시지 내용
     				msgContent:$("#message-text").val()
     			},
     			type:"post",
     			success:function(result){
     				if(result>0){//인서트(작성) 성공
     					alert("메시지를 보냈습니다.")
     					
     				}else{//인서트 실패
     					alert("메시지 전송 실패")
     				}
     			},
     			error:function(){
     				console.log("통신실패")
     			}
     		});
     	}
     </script>
    
</body>
</html>