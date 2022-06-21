<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<c:set var="name" value="${name}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memPwdFind</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    	function sendCheck() {
			opener.window.document.myForm.mid.value = '${mid}';
			opener.window.document.myForm.pwd.focus();
			window.close();
		}
    	
    	//비밀번호 재쟁성을 위한 정보 확인
    	function pwdFind() {
    		let mid = pwdFindForm.mid.value;
    		let email1 = pwdFindForm.email1.value;
    		let email2 = pwdFindForm.email2.value;
    		let email = email1 + "@" + email2;
    		pwdFindForm.email.value = email;
    		
    		if(email1 == "") {
    			alert("이메일을 입력하세요.");
    			pwdFindForm.email1.focus();
    		}
    		else if(mid == "") {
    			alert("아이디를 입력하세요.");
    			pwdFindForm.mid.focus();
    		}
    		else {
    			pwdFindForm.submit();
    		}
		}
    	
    	
    /* 	window.onload = function() {
    		if ('${name}' != "") {
    			document.getElementById('demo').style.display = "block";
    		}
    	} */
    	
    </script>
</head>
<body>
<p><br/><p>
<div class="container">
	<h2><b>비밀번호 찾기</b></h2>
	<br>
	<form name="pwdFindForm" method="post" action="${ctp}/memPwdFindOk.mem">
		<div class="form-group">
			<label for="email"><h4>아이디 :</h4></label>&nbsp;&nbsp;
			<input type="text" class="form-control" id="mid" value="${mid}" name="mid" placeholder="아이디를 입력하세요." required autofocus/>
		</div>
		<label for="email"><h4>이메일 주소 :</h4></label>
		<div class="input-group mb-3">
		  <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
		  <div class="input-group-append">
		    <select name="email2" class="custom-select">
			    <option value="naver.com" selected>naver.com</option>
			    <option value="hanmail.net">hanmail.net</option>
			    <option value="hotmail.com">hotmail.com</option>
			    <option value="gmail.com">gmail.com</option>
			    <option value="nate.com">nate.com</option>
			    <option value="yahoo.com">yahoo.com</option>
			  </select>
		  </div>
		</div>
		<br>
		<input type="button" value="입력" onclick="pwdFind()" class="btn btn-secondary"/>
		<input type="hidden" name="email"/>
		</form>
</div>
<p><br/><p>
</body>
</html>