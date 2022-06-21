<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminLogin.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script>
		'use strict';
		function fCheck() {
			let mid = document.getElementById("mid").value;
			let pwd = document.getElementById("pwd").value;
			
			if(mid == "") {
				alert("아이디를 입력하세요");
				myForm.mid.focus();
			}
			else if(pwd == "") {
				alert("비밀번호를 입력하세요");
				myForm.pwd.focus();
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
<p><br></p>
<div class="container">
    <div class="container" style="margin-bottom:100px">
		<div class="container p-3">
			<div class="w3-row-padding w3-padding-16">
				<div class="w3-third w3-margin-bottom"></div>
				<div class="w3-third w3-margin-bottom">
				<h2 class="headerJoin text-center">ADMIN LOGIN</h2><p><br></p>
					<form name="myForm" method="post">
						<div class="form-group">
					      <label for="mid">ID :</label>
					      <input type="text" class="form-control" id="mid" value="${mid}" placeholder="아이디를 입력하세요." name="mid" required autofocus>
					    </div>
						<div class="form-group" >
					      <label for="pwd">Password :</label>
					      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required>
					    </div>
					    <div class="form-group text-center">
						<button type="submit" class="w3-btn w3-black" onclick="fCheck()">로그인</button> &nbsp;&nbsp;		
						<a class="w3-btn w3-amber" href="${ctp}/">홈으로</a>
						</div>
					</form>
				</div>
				<div class="w3-third w3-margin-bottom"></div>
			</div>
		</div>
	</div>
</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>