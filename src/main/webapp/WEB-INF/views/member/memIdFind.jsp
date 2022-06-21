<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memIdFind</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    	function sendCheck() {
			opener.window.document.myForm.mid.value = '${mid}';
			opener.window.document.myForm.pwd.focus();
			window.close();
		}
    	
    	//아이디 찾기
    	function idFind() {
    		let email1 = idFindForm.email1.value;
    		let email2 = idFindForm.email2.value;
    		let email = email1 + "@" + email2;
    		idFindForm.email.value = email;
    		
    		if(email1 == "") {
    			alert("이메일을 입력하세요");
    			idFindForm.email1.focus();
    		}
    		else {
    			idFindForm.submit();
    		}
		}
    	
    	window.onload = function() {
    		const flag = '${flag}';
    		if (flag == 'true') {
    			document.getElementById('demo').style.display = "block";
    		}
    	}
    	
    	/*
    	function idFindAjax() {
    		const formData = $("#idFindForm").serialize();
    		const url = $("#idFindForm").attr("action");
    		
    		$.ajax({
                url : url, // 요기에
                type : 'POST',
                data : formData,
    			cache : false,
                success : function(data) {
                	alert(data);
                },
                error : function(xhr, status) {
                    alert(xhr + " : " + status);
                }
    		});
    	}
    	*/
    
    </script>
</head>
<body>
<p><br/><p>
<div class="container">
	<h2><b>아이디 찾기</b></h2>
	<form name="idFindForm" method="post" action="${ctp}/memIdFindOk.mem">
		<div class="form-group">
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
		</div>
		<input type="button" value="아이디 찾기" onclick="idFind()" class="btn btn-secondary"/>
		<input type="hidden" name="email"/>
		<div id="demo" style="display:none">
			<c:set var="Mid" value="${mid}"></c:set>
			<c:choose>
			<c:when test="${empty Mid}">
				<br>
				<p><b><font color="red">※ 아이디 찾기 실패 ※</font><br>입력하신 이메일은 가입이력이 없는 이메일입니다.<br>다시 확인해주세요.</b></p>
			</c:when>
			<c:otherwise>
				<br>
				<p><b>※ 찾은 아이디 : <font color="blue">${Mid}</font></b></p>
				<input type="button" value="창닫기" onclick="sendCheck()" class="btn btn-secondary"/>
			</c:otherwise>
			</c:choose>
		</div>
	</form>
</div>
<p><br/><p>
</body>
</html>