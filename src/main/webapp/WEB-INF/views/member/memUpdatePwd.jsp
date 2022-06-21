<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memUpdatePwd.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script type="text/javascript">
    	function pwdUpdate() {
			let pwd1 = myForm.pwd1.value;
			let pwd2 = myForm.pwd2.value;
			let pwd3 = myForm.pwd3.value;
			
			let regPwd = /(?=.*[a-zA-ZS])(?=.*?[#?!@$%^&*-]).{6,24}/;
			
			if(pwd2 != pwd3) {
				alert("변경할 비밀번호와 비밀번호 재입력 내용이 일치하지 않습니다.");
				myForm.pwd3.focus();
				return false;
			}
			else if(!regPwd.test(pwd2)) {
	            alert("비밀번호는 1개이상의 문자와 특수문자 조합의 6~24 자리로 작성해주세요.");
	            myForm.pwd2.focus();
	            return false;
			}
			else {
				myForm.submit();
			}
			
		}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/><p>
<div class="container">
	<h2 class="text-center">비 밀 번 호 변 경</h2><br>
	<form name="myForm" method="post" action="${ctp}/memUpdatePwdOk.mem" class="was-validated">
		<div class="form-group">
	      <label for="pwd">현재 비밀번호 :</label>
	      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd1" required />
	      <div class="invalid-feedback">필수 입력사항입니다.</div>
	    </div>
		<div class="form-group">
	      <label for="pwd">변경할 비밀번호 :</label>
	      <input type="password" class="form-control" id="pwd" placeholder="변경할 비밀번호를 입력하세요." name="pwd2" required />
	      <div class="invalid-feedback">1개이상의 '문자'와 '특수문자' 조합의 6~24 자리로 작성하세요. </div>
	    </div>
		<div class="form-group">
	      <label for="pwd">변경할 비밀번호 재입력 :</label>
	      <input type="password" class="form-control" id="pwd" placeholder="변경할 비밀번호를 한번 더 입력하세요." name="pwd3" required />
	      <div class="invalid-feedback">필수 입력사항입니다. </div>
	    </div><br>
	    <div class="text-center">
	    	<button type="button" class="btn btn-danger" onclick="pwdUpdate()">변경하기</button>
		    <button type="reset" class="btn btn-secondary">다시작성</button>
		    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/';">돌아가기</button>
	    </div>
	</form>
</div>
<p><br/><p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>