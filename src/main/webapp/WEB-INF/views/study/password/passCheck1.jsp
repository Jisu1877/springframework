<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>passCheck1.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script>
    	'use strict';
    	function fCheck(flag) {
			let pwd = document.getElementById("pwd").value;
			if(pwd.trim() == "") {
				alert("비밀번호를 입력하세요");
				document.getElementById("pwd").focus();
				return false;
			}
			else if(pwd.length > 10) {
				alert("비밀번호 길이는 10자 이하로 작성해주세요.");
				document.getElementById("pwd").focus();
				return false;
			}
			else {
				if(flag == 1) {
					myForm.action = "${ctp}/study/password/passCheck1";
					
				}
				else {
					myForm.action = "${ctp}/study/password/passCheck2";
				}
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
		<form name="myForm" method="post">
			<h2>비밀번호 암호화 연습</h2>
			<hr>
			<div>
				<strong>비밀번호 : </strong> &nbsp;
				<input type="password" name="pwd" id="pwd" autofocus/> &nbsp;
				<input type="button" value="암호화(숫자만입력)" onclick="fCheck(1)" class="w3-button w3-yellow w3-hover-yellow w3-small" /> &nbsp;
				<input type="button" value="암호화(혼합)" onclick="fCheck(2)" class="w3-button w3-yellow w3-hover-yellow w3-small" />
			</div>
			<hr>
			<div>
				<strong>※ 암호화 결과 ※</strong><br>
				원본 👉 ${pwd}<br>
				암호화 👉 ${encPwd}<br>
				복호화 👉 ${decPwd}
			</div>
	    </form>
    </div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>