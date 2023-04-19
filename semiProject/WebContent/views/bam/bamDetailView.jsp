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
</head>
<body>	
          <table id="detail-area" align="center" border="1">
            <thead>
                <tr>
                
                    <td width="20">일반</td>
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
                                <img src="<%=request.getContextPath()+at.getFilePath()+"/"+at.getChangeName()%>" width="150" height="120">
                    	<%} %>
                    </td>
                    
                </tr>
            </tbody>
               
         </table>
         <br>
        <br>
        <!-- if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())){ -->
	        <div align="center">
	        	<button onclick="location.href='<%=request.getContextPath()%>/bamupdate.bo?bno=<%=b.getBoardNo()%>'" class="btn">수정하기</button>
	        	<button onclick="location.href='<%=request.getContextPath()%>/bamdelete.bo?bno=<%=b.getBoardNo()%>'" class="btn">삭제하기</button>
	        </div>
        <!-- } -->
            
</body>
</html>