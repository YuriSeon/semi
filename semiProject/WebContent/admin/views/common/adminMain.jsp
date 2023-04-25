<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.admin.userManage.model.vo.User"%>
<% 
	String contextPath = request.getContextPath(); 
	int[][] boardArr = (int[][])request.getAttribute("boardArr");
	User u = (User)request.getAttribute("u");
	int[] checkArr = (int[])request.getAttribute("checkArr");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>admin_main</title>
    
</head>
<body>
  <div id="bam">
    <table>
      <tr>
        <td>전체 게시글</td>
        <td><%=boardArr[0][0] %></td>
      </tr>
      <tr>
        <td>최근 업로드</td>
        <td><%=boardArr[0][1] %></td>
      </tr>
      <tr>
        <td>최근 신고된 게시글</td>
        <td><%=boardArr[0][2] %></td>
      </tr>
      <tr>
        <td>블러처리된 게시글</td>
        <td><%=boardArr[0][3] %> &nbsp;<button onclick="">GO</button></td>
      </tr>
    </table>
  </div>
  <div id="food">
	<table>
      <tr>
        <td>전체 게시글</td>
        <td><%=boardArr[1][0] %></td>
      </tr>
      <tr>
        <td>최근 업로드</td>
        <td><%=boardArr[1][1] %></td>
      </tr>
      <tr>
        <td>최근 신고된 게시글</td>
        <td><%=boardArr[1][2] %></td>
      </tr>
      <tr>
        <td>블러처리된 게시글</td>
        <td><%=boardArr[1][3] %> &nbsp;<button onclick="">GO</button></td>
      </tr>
    </table>
  </div>
  <div id="user">
    <table>
      <tr>
        <td>현재 총 회원 수</td>
        <td><%=u.getTotalUser()%></td>
      </tr>
      <tr>
        <td>최근 가입자 수</td>
        <td><%=u.getRecentEnroll()%></td>
      </tr>
      <tr>
        <td>탈퇴 회원 수</td>
        <td><%=u.getWithdraw()%></td>
      </tr>
      <tr>
        <td>강퇴 회원 수</td>
        <td><%=u.getKickOut() %></td>
      </tr>
    </table>
  </div>
  <div id="check">
    <table>
      <tr>
        <td>최근 신고당한 회원 수</td>
        <td><%=checkArr[0] %> &nbsp;<button onclick="">GO</button></td>
      </tr>
      <tr>
        <td>경고 1회</td>
        <td><%=checkArr[1] %></td>
      </tr>
      <tr>
        <td>경고 2회</td>
        <td><%=checkArr[2] %></td>
      </tr>
      <tr>
        <td>경고 3회</td>
        <td><%=checkArr[3] %></td>
      </tr>
      <tr>
        <td>경고 4회</td>
        <td><%=checkArr[4] %></td>
      </tr>
      <tr>
        <td>체크 필요한 회원 수</td>
        <td><%=checkArr[5] %> &nbsp;<button onclick="">GO</button></td>
      </tr>
    </table>
  </div>

</body>
</html>