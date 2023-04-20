<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.kh.board.model.vo.Board,com.kh.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
  		.list-area{
		width:760px;
		margin:auto;
	}
	.thumbnail{
		border:1px solid white;
		width :220px;
		display:inline-block;
		margin:14px;
	}
	.thumbnail:hover{
		cursor:pointer;
		opacity :0.7;
	}
  	
  	
        div{
             border: 1px solid black;
             box-sizing: border-box;
        }
        .wrap{
            height: 800px;
            width: 1000px;
            margin: auto;
        }
        .wrap>div{
            width: 100%;
        }

        #header{
          
            height: 15%;
        }
        #content{
            height: 80%;
            position: relative;
        }
        #footer{
            height: 5%      
          }
        #header>div,#content>div{
            float: left;
            height: 100%;
        }
        #header_1{
            width: 15%;
        }
      
     
        /* 바디 영역 */
      
        #content_2{
            width: 70%;
            text-align: center;
            position:absolute;
            
            right: 14%;
            
        }
        #content_3{
            position: absolute;
            right: 0%;
            width: 14%;
            float: left;
            height: 100%;
            font-weight: 1000;
            font-size: x-large;
            
        }
      
         
        /*-------------푸터 영역------------------*/
      
        #header{
            text-align: center; 
        }
  
    </style>
</head>
<body>
	<%-- <%@include file ="../common/menubar.jsp" %> --%>

    <div class="wrap">
        <div id="header">
            
        </div>
     
        <div id="content">
            <div id="content_1"></div>
            <div id="content_2" >썸넬(게시글제목,조회수,올린시간,작성자,카테고리(일상,게임,,,))
           
            	<div class="list-area">
					<% for(Board b : list) {%>
		   		 <div class="thumbnail" align ="center">
					<input type="hidden" name="bno" value="<%=b.getBoardNo()%>">
						<img src="" width="200px" height ="150px">
							<p>
								No.<%=b.getBoardNo()%><br>
								<%= b.getBoardTitle() %><br>
								조회수 : <%=b.getCount() %>
							</p>
				
		  		 </div>	
				<%} %>
				</div>
					
            </div>
            <div id="content_3">
            	<a href="/insert.vd" class="btn btn-info">글쓰기</a>
            </div>
        </div>
        
        <div id="footer">
            <div id="footer_1"></div>
        </div>
        <div align="center" class="paging-area">
			<%if(pi.getCurrentPage()!= 1){ %>
				<button onclick="location.href='/list.vd?currentPage=<%=pi.getCurrentPage()-1%>'">&lt;</button>
			<%} %>
			
			<%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++ ){ %>
				<!-- 내가 보고있는 페이지 버튼은 비활성화 하기  -->
				<%if(i != pi.getCurrentPage()){ %>
					<button onclick="location.href='/list.vd?currentPage=<%=i%>';"><%=i %></button>
				<%}else{ %> <!-- 내가 보고있는 페이지와 페이징바 버튼의 수가 같다면 i와 currentPage -->
					<button disabled><%=i %></button>
				<%} %>
			<%} %>
			
			<%if(pi.getCurrentPage() != pi.getMaxPage()){ %>
				<button onclick="location.href='/list.vd?currentPage=<%=pi.getCurrentPage()+1%>'">&gt;</button>
			<%} %>
		</div>
        
    
         
   
       
    </div>
</body>
</html>