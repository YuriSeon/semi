<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메시지 입력창</title>
</head>
<body>
	<div style="width:100%; height:200px; overflow:auto " >

        <table width="100%" border="1" cellspacing="0" cellpadding="0">
        
        <tr>
            
            <td style="text-align: right;" >11:00 &nbsp;&nbsp;&nbsp;메세지</td> 
        </tr>
        <tr>
            
            <td>메시지</td>
        </tr> 
        
        <tr>
            <td>메모지</td>
        </tr>
        <tr><td>테스트</td></tr>
        <tr><td style="text-align: right;">테스트</td></tr>
        <tr><td>테스트</td></tr>
        <tr><td style="text-align: right;">테스트</td></tr>
        <tr><td>테스트</td></tr>
        <tr><td style="text-align: right;">테스트</td></tr>
        <tr><td>테스트</td></tr>
        <tr><td style="text-align: right;">테스트</td></tr>
        <tr><td>테스트</td></tr>
        <tr><td style="text-align: right;">테스트</td></tr>
        <tr><td>테스트</td></tr>
        <tr><td style="text-align: right;">테스트</td></tr>
        <tr><td>테스트</td></tr>
        <tr><td style="text-align: right;">테스트</td></tr>

        
        
        </table>
    </div>
    
        <div  style="width:100%; border: 1px solid black;">
            <input type="text" placeholder="메시지 입력" id="con">
            <button onclick="insertMsg();">보내기</button>
        </div>
    
    <script >
    	$(function(){//처음에 메시지 불러오기
        	selectMsgList();
        });
    	function insertmsg(){
    		//메시지 보내기
    		//유저번호 필요
    		$.ajax({
    			url:"insertMsg.dm",
    			type : "post",
    			data : {
    				con:$("#con").val()
    			},
    			success : function(){
    				console.log("성공");
    			},
    			error : function(){
    				console.log("실패");
    			}
    		});
    	}
    	function selectMsgList(){
    		//메시지 불러오기
    		//유저번호 필요
    		$.ajax({
    			url:"selectMsg.dm",
    			
    			
    			
    			
    		});
    
    </script>
    
</body>
</html>