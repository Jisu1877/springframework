<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminInput.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		function fCheck() {
			let name = myForm.name.value;
			let mid = myForm.mid.value;
			let pwd = myForm.pwd.value;
		    
		    let regMid = /^[a-z0-9_]{4,20}$/;
			let regPwd = /(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).{4,8}/;
			let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
			
			if(name == "") {
				alert("성명을 입력하세요");
				myForm.name.focus();
				return false;
			}
			else if(mid == "") {
				alert("아이디를 입력하세요");
				myForm.mid.focus();
				return false;
			}
			else if(pwd == "") {
				alert("비밀번호를 입력하세요");
				myForm.pwd.focus();
				return false;
			}
			else if(!regMid.test(mid)) {
	            alert("아이디는 4~20자의 영문 소문자, 숫자와 특수기호(_)만 사용가능합니다.");
	            myForm.mid.focus();
	            return false;
	        }
			else if(!regPwd.test(pwd)) {
	            alert("비밀번호는 1개이상의 문자와 특수문자 조합의 4~8 자리로 작성해주세요.");
	            myForm.pwd.focus();
	            return false;
	        }
			
			myForm.submit();
		}	
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br></p>
<div class="container">
    <div class="w3-container mt-5" id="contact">
    <h2 class="headerJoin text-center">관리자 등록</h2>
	<div class="w3-row-padding w3-padding-16">
		<div class="w3-third w3-margin-bottom"></div>
		<div class="w3-third w3-margin-bottom">
		    <form name="myForm" method="post" class="was-validated">
		    	<div class="form-group">
		    		<label for="name">성명 : &nbsp; &nbsp;</label>
		      		<div class="input-group mb-3">
		    			<input class="input w3-padding-16 w3-border form-control" id="name" name="name" type="text" placeholder="성명을 입력하세요." required>
		    		</div>
		    	</div>
		    	<div class="form-group">
		    		<label for="mid">아이디 : &nbsp; &nbsp;</label>
		      		<div class="input-group mb-3">
		    			<input class="input w3-padding-16 w3-border form-control" id="mid" name="mid" type="text" placeholder="아이디를 입력하세요." required>
					    <div class="input-group-append">
					      	<input type="button" value="중복체크" class="btn w3-amber" onclick="idCheck()"/>
					    </div>
					    <div class="invalid-feedback">&nbsp; 4~20자의 영문 소문자, 숫자와 특수기호(_)만 사용가능합니다.</div>
		    		</div>
		    	</div>
		    	<div class="form-group">
		    		<label for="pwd">비밀번호 : &nbsp; &nbsp;</label>
		      		<div class="input-group mb-3">
		    			<input class="input w3-padding-16 w3-border form-control" id="pwd" name="pwd" type="password" placeholder="비밀번호를 입력하세요." required>
					    <div class="invalid-feedback">&nbsp; 4~8자 영문 대 소문자, 숫자, 특수문자를 사용하세요.<br>&nbsp; (1개이상의 문자와 특수문자 조합 필수)</div>
		    		</div>
		    	</div>
			  <p><br></p>
		      <p style="text-align: center;">
			      <button class="w3-button w3-amber" type="button" onclick="fCheck()">관리자 등록</button>&nbsp; &nbsp;
			      <a class="w3-button w3-black" type="button" href="${ctp}/">홈으로</a>
		      </p>
		    </form>
	    </div>
	    <div class="w3-third w3-margin-bottom">
	    </div>
    </div>
  </div>
</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>