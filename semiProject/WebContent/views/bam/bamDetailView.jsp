<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.*,com.kh.bMember.model.vo.BMember"%>
<%
	Board b = (Board)request.getAttribute("b");
	Attachment at = (Attachment)request.getAttribute("at");
	BMember loginUser = (BMember)session.getAttribute("loginUser");
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
                                <img src="<%=request.getContextPath()+at.getFilePath()+"/"+at.getChangeName()%>" width="150" height="120">
                    	<%} %>
                    </td>
                    
                </tr>
            </tbody>
               
         </table>
         <br>
        <br>
        <%if(loginUser != null && loginUser.getUserNo()==Integer.parseInt(b.getBoardWriter())||loginUser.getUserNo()==1){ %>
	        <div align="center">
	        	<button onclick="location.href='<%=request.getContextPath()%>/bamupdate.bo?bno=<%=b.getBoardNo()%>'" class="btn">수정하기</button>
	        	<button onclick="location.href='<%=request.getContextPath()%>/bamdelete.bo?bno=<%=b.getBoardNo()%>'" class="btn">삭제하기</button>
	        </div>
        <%} %> 
            <button onclick="location.href='<%=request.getContextPath()%>/bamlist.bo?currentPage=1'" class="btn">글목록으로</button>
</body>
</html>