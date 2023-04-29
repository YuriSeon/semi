<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="com.kh.bMember.model.vo.BMember"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지_정보 수정</title>
</head>
<style>
    
    @font-face {
        font-family: 'GmarketSansMedium';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }

        body{
            color: #262626;
            box-sizing: border-box;
            font-family: 'GmarketSansMedium';
        }

        .wrapper{
            position: absolute;
            left: 50%;
            width: 1000px;
            height: 1000px;
            margin-left: -500px;
            margin-top : -70px;
            font-family: 'GmarketSansMedium';
        }

        #head{
            text-align: center;
            font-size: 25px;
            font-weight: bold;
            margin-top: 100px;
            margin-bottom: 20px;
        }

        #button-area{
            display: flex;
            flex-direction : row;
            margin-top: 30px;
            margin-left: 50px;
            margin-right: 50px;
            justify-content: space-between;
            flex-wrap: wrap;            
        }

        .btnmenu{
            width: 140px;
            height: 40px;
            margin-top: 20px;
            background-color: deepskyblue;
            color: white;
            border-radius: 5px;
            border-style: none;
            cursor: pointer;
            font-size: 17px;
            font-family: 'GmarketSansMedium';          
        }

        .btnmenu:hover{
            background-color:#fff;
            color:deepskyblue;
            border: 1px solid deepskyblue;
        }
    
    	#p2{
            margin-top: -5%;
            margin-bottom: 10%;
            font-size: 15px;
            color: deepskyblue;
        }

        #join_form{
            width: 500px;
            margin: auto;
        }

        .condition{
            color:dimgrey;
            font-size: 10px;
            margin-top: -2px;
        }

        .login_text{
            float: right;
            width: 300px;
            margin-bottom: 10px;          
        }

      .submit1 input{
            width: 200px;
            height: 30px;          
            background-color: deepskyblue;
            color: white;
            border-radius: 5px;
            border-style: none;
            cursor: pointer;
            font-size: 17px;
            margin-left: 30px;
            font-family: 'GmarketSansMedium';
            
        }
        
        .edit:hover{
        	background-color:#fff;
            color:deepskyblue;
            border: 1px solid deepskyblue;
        }
        .dlt:hover{
        	background-color:red;
        	color:white;
        }
       
        .form-group button{
            width: 80px;
            height: 25px;
            background-color: deepskyblue;
            color: white;
            border-radius: 5px;
            border-style: none;
            cursor: pointer;
            font-family: 'GmarketSansMedium';
            
        }

        .school button{           
            height: 25px;
            background-color: deepskyblue;
            color: white;
            border-radius: 5px;
            border-style: none;
            cursor: pointer;
            font-family: 'GmarketSansMedium';
        }

        .info_area{
            margin-top: 30px;
        }
        

        
</style>
<body>
	<%@ include file ="../common/menubar.jsp"%> 
	<%
	String userId = loginUser.getUserId();
	String userName = loginUser.getUserName();
	String userPwd = loginUser.getUserPwd();
	String phone = loginUser.getPhone();
	String address = loginUser.getAddress();
	String email = loginUser.getEmail();
	String ssn = loginUser.getSsn();
	String userNick = loginUser.getUserNick();
	String schoolNo = loginUser.getSchoolNo();
	String school_st = (loginUser.getSchool_st() == null) ? "" : loginUser.getSchool_st();
	%>


    <div class="wrapper">
        <div id="head">마이 페이지</div>
        <hr>
        <div id="button-area">
            <button class="btnmenu" onclick="location.href='<%=contextPath %>/list.me?currentPage=1'" id="message">내 쪽지함</button>
            <button class="btnmenu" onclick="location.href='<%=contextPath %>/myPage2.me'" id="myinfo">프로필 수정</button>
            <button class="btnmenu" onclick="location.href='<%=contextPath %>/myPage3.me'" id="like">포인트</button>
        </div>


        <div class="info_area">
            <form action="<%=contextPath %>/update.me" id="join_form" method="post">
                <div class="form-group">
                    <label for="userId">아이디 *</label><input type="text" id="userId" value="<%=userId%>"  name="userId" class="login_text" readonly>
                    <p class="condition"  id="con1" style="color: white;">내용</p>
                </div>

                <div class="form-group">
                    <label for="userName">이름 *</label> <input type="text" id="userName" value="<%=userName%>" name="userName" class="login_text" required> <br>
                    <p class="condition" id="con4" style="color: white;">내용</p>
                </div>
                
                <div class="form-group">
                    <label for="phone">휴대전화 *</label> <input type="text" id="phone" value="<%=phone%>" name="phone" class="login_text" required> <br>
                    <p class="condition" id="con5" style="color: white;">내용</p>                
                </div>
                
                <div class="form-group">
                    <label for="address">주소 *</label> <input type="address" id="address" value="<%=address%>" name="address" class="login_text" style="width: 180px; float: none; margin-left: 150px;" required>
                    <button type="button" id="addressBtn" onclick="openDaumPostcode();" class="" style="width: 110px;">주소 찾기</button><br>
                    <p class="condition" id="con6" style="color: white; margin-top: -10px;">내용</p>
                </div>
                
                <div class="form_group">
                    <label for="email">이메일 *</label> <input type="email" id="email" value="<%=email%>" name="email" class="login_text" required> <br>
                    <p class="condition" id="con7">'@'포함하여 입력</p>
                </div>
            
                <div class="form-group">
                    <label for="ssn">주민등록번호 *</label> <input type="text" id="ssn" value="<%=ssn%>" name="ssn" class="login_text" required> <br>
                    <p class="condition" id="con8">'-'포함하여 입력</p>
                </div>
                
                <div class="form-group">
                    <label for="userNick">닉네임 *</label> <input type="text" id="userNick" value="<%=userNick%>" name="userNick" class="login_text" required> <br>
                    <p class="condition" id="con9" style="color: white;">내용</p>
                </div>
                
                <br>
                <hr>
                <br>
                추가 정보(선택 가능)
                <br><br>
                <div class="school">
                    학교 이름
                    <select name="schoolNo" id="sName" class="login_text" value="<%=schoolNo%>" style="text-align: center; font-family: 'GmarketSansMedium';">
                        <option value="0">선택안함</option>
                        <option value="1">서울대학교</option>
                        <option value="2">고려대학교</option>
                        <option value="3">연세대학교</option>
                        <option value="4">서강대학교</option>
                        <option value="5">성균관대학교</option>
                        <option value="6">한양대학교</option>
                        <option value="7">이화여자대학교</option>
                        <option value="8">건국대학교</option>
                        <option value="9">중앙대학교</option>
                        <option value="10">동국대학교</option>
                    </select>   
                    <p class="condition" id="con10">학교 이름 전체 입력</p>
                </div>
                <div class="school">
                    학교 이메일 <input type="email" id="sEmail" class="login_text" style="width: 180px; float: none; margin-left: 112px;" > 
                    <button type="button" id="verifyButton" class="validate-btn" style="width: 105px;">학교 인증</button>  
                    <p class="condition" id="con11" style="margin-top: -10px; color: white;">내용</p>
                </div>

                <br><br>
                <div class="submit1">
                    <input type="submit" class="edit" value="정보 수정" onclick="validate();">
                    <input type="button" class="dlt" value="회원 탈퇴" style="background-color: grey;" onclick="deleteMem();">
                </div>

        
            </form>

        </div>
  
    </div>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    
    $("#verifyButton").on("click", function(){//학생 인증 버튼
		var condition11 = document.getElementById("con11");
		var flag = sval();
		
		if(flag){
			sendEmail(event);
          	condition11.innerHTML = "학교 인증 완료";
            condition11.style.color = "deepskyblue";
		}
	});
    
    
    function sval(){//학교 인증 시작
 	    var inputSname = document.getElementById("sName");
 	    var inputSemail = document.getElementById("sEmail");
 	    var condition10 = document.getElementById("con10");
 	    var condition11 = document.getElementById("con11");
 	    var inputSsn = document.getElementById("ssn");
 	    var validateBtn = document.querySelector(".validate-btn");
 	    var ageLimit = 35;
 	    var birthYear = '19'+inputSsn.value.substring(0,2);
 	    var currentYear = '20'+new Date().getFullYear()% 100;
 	    var age = currentYear - birthYear +1;

 	    inputSname.addEventListener('blur',()=>{
 	      if(inputSname.value = ''){
 	        condition10.innerHTML = "올바르지 않은 학교 이름입니다.";
 	        condition10.style.color = "red"
 	        inputSname.focus();
 	      }else{
 	        condition10.innerHTML = "✔";
 	        condition10.style.color = "deepskyblue";                    
 	      }
 	    });

 	    inputSemail.addEventListener('blur', () => {
 	      if (inputSemail.value != '') {
 	        var regExp10 = /@naver\.com$/;
 	        if (!regExp10.test(inputSemail.value)) {
 	          condition11.innerHTML = "올바르지 않은 메일 형식입니다.";
 	          condition11.style.color = "red"
 	          inputSemail.focus();
 	        } else {

 	        }
 	      }
 	    });

 	    if (age >= ageLimit) {
 	      alert("정말로 학생이신가요..? "+ageLimit+"세 까지만 인증 가능합니다.."+age);
 	      document.getElementById("sName").value="0";
 	      document.getElementById("sEmail").value="";
 	      return false;
 	    }

 	    return true;
 	  }//학교 인증 끝
    
    
        
        function validate(){//유효성 검사

                var inputName = document.getElementById("userName");
                var inputPhone = document.getElementById("phone");
                var inputAddress = document.getElementById("address");
                var inputEmail = document.getElementById("email");
                var inputSsn = document.getElementById("ssn");
                var inputNick = document.getElementById("userNick");
                

                var condition4 = document.getElementById("con4")
                var condition5 = document.getElementById("con5");
                var condition6 = document.getElementById("con6");
                var condition7 = document.getElementById("con7");
                var condition8 = document.getElementById("con8");
                var condition9 = document.getElementById("con9");

                inputName.addEventListener('blur',()=>{
                    var regExp3 = /^[가-힣]{2,}$/;
                    

                    if(!regExp3.test(inputName.value)){
                        condition4.innerHTML = "2글자 이상 한글로만 작성해주세요";
                        condition4.style.color = "red";
                        inputName.focus();
                    }else{
                        condition4.innerHTML = "멋진 이름이네요!";
                        condition4.style.color = "deepskyblue";
                    }

                });


                inputPhone.addEventListener('blur',()=>{
                    var regExp4 = /^\d{3}\d{3,4}\d{4}$/;
                    

                    if(!regExp4.test(inputPhone.value)){
                        condition5.innerHTML = "숫자로만 입력해주세요";
                        condition5.style.color = "red";
                        inputPhone.focus();
                    }else{
                        condition5.innerHTML = "✔";
                        condition5.style.color = "deepskyblue";
                    }

                });

                inputAddress.addEventListener('blur',()=>{
                    var regExp5 = /^[a-zA-Z0-9가-힣/\s/g ]{2,}$/;
                    

                    if(!regExp5.test(inputAddress.value)){
                        condition6.innerHTML = "전체 주소를 입력해주세요";
                        condition6.style.color = "red";
                        inputAddress.focus();
                        // return false;
                    }else{
                        condition6.innerHTML = "✔";
                        condition6.style.color = "deepskyblue";
                    }

                });

                inputEmail.addEventListener('blur',()=>{
                    var regExp6 = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
                    

                    if(!regExp6.test(inputEmail.value)){
                        condition7.innerHTML = "'@'' 포함하여 입력해주세요";
                        condition7.style.color = "red";
                        inputEmail.focus();
                        // return false;
                    }else{
                        condition7.innerHTML = "✔";
                        condition7.style.color = "deepskyblue";
                    }

                });

                inputSsn.addEventListener('blur',()=>{
                    var regExp7 = /^\d{6}-\d{7}$/;
                    

                    if(!regExp7.test(inputSsn.value)){
                        condition8.innerHTML = "'-' 포함하여 입력해주세요";
                        condition8.style.color = "red";
                        inputSsn.focus();
                        // return false;
                    }else{
                        condition8.innerHTML = "✔";
                        condition8.style.color = "deepskyblue";
                    }

                });

                inputNick.addEventListener('blur',()=>{
                    var regExp8 = /^[a-zA-Z0-9가-힣]{1,}$/;
                    

                    if(!regExp8.test(inputNick.value)){
                        condition9.innerHTML = "입력을 하셔야 합니다!";
                        condition9.style.color = "red";
                        inputNick.focus();
                        // return false;
                    }else{
                        condition9.innerHTML = "✔";
                        condition9.style.color = "deepskyblue";
                    }

                });
              
            }
            validate();//전체 검사 끝
            
        	function sendEmail(event){//학생 메일 보내기
            	  event.preventDefault();
            	  var inputSemail = document.getElementById("sEmail");
            	  var email = inputSemail.value;
            	  var xhttp = new XMLHttpRequest();
            	  xhttp.onreadystatechange = function() {
            	    if (this.readyState == 4 && this.status == 200) {
            	      alert(this.responseText);
            	    }
            	  };
            	  xhttp.open("POST", "sendEmail.me", true);
            	  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            	  xhttp.send("email=" + email);
            	}//학생 메일 끝
            


    function openDaumPostcode(){

        new daum.Postcode({
            oncomplete: function(data) {

                var fullAddress = "";

                if (data.userSelectedType === 'R') {
                    fullAddress = data.roadAddress;
                } else {
                    fullAddress = data.jibunAddress;
                }


                if(data.userSelectedType === 'R'){

                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        fullAddress += " "+data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        fullAddress += ' ' + data.buildingName;
                    }
                }

                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("address").value = fullAddress;
                
                }

                
        }).open();
        }
       
    	function deleteMem(){
    		var confirmDelete = confirm("정말로 탈퇴하시겠습니까?");
    		
    		if(confirmDelete){
    			location.href ="<%=contextPath%>/deleteMem.me"      	
    		}    		
    	}
          
    </script>


</body>
</html>