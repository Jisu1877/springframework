<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memPwdInput</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script type="text/javascript">
	    function sendCheck() {
			opener.window.document.myForm.mid.focus();
			window.close();
		}
    
		//비밀번호 재생성
		function newPwdInput() {
			let pwd1 = pwdInputForm.pwd1.value;
			let pwd2 = pwdInputForm.pwd2.value;
			
			let regPwd = /(?=.*[a-zA-ZS])(?=.*?[#?!@$%^&*-]).{6,24}/;
			
			if(pwd1 == "") {
				alert("재생성할 비밀번호를 입력하세요.");
				pwdInputForm.pwd1.focus();
				return false;
			}
			else if(pwd2 == "") {
				alert("비밀번호를 재입력하세요.");
				pwdInputForm.pwd2.focus();
				return false;
			}
			else if(pwd1 != pwd2) {
				alert("비밀번호가 일치하지 않습니다.");
				pwdInputForm.pwd1.focus();
				return false;
			}
			else if(!regPwd.test(pwd1)) {
	            alert("비밀번호는 1개이상의 문자와 특수문자 조합의 6~24 자리로 작성해주세요.");
	            pwdInputForm.pwd1.focus();
	            return false;
	        }
			else {
				pwdInputForm.submit();
			}
		}
    </script>
</head>
<body>
<p><br/><p>
<div class="container">
	<br>
	<form name="pwdInputForm" method="post" action="${ctp}/memPwdInputOk.mem">
		<h3 class="text-center"><b><font color="blue">※ 비밀번호 재생성 ※</font></b></h3><br>
			<input type="password" class="form-control" placeholder="새로 생성할 비밀번호를 입력하세요." id="pwd1" name="pwd1" required /><br>
		<div class="input-group mb-3">
			<input type="password" class="form-control" placeholder="비밀번호 재입력" id="pwd2" name="pwd2" required />
			<div class="input-group-append">
				<input type="button" value="입력" onclick="newPwdInput()" class="btn btn-primary"/>
			</div>
		</div>
		<input type="hidden" name="mid" value="${param.mid}"/>
		<div class="text-center"><input type="button" value="창닫기" onclick="sendCheck()" class="btn btn-secondary"/></div>
	</form>
</div>
</body>
</html>