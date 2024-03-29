<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ajaxMenu.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br></p>
<div class="container">
    <h2>AJax 연습</h2>
    <hr>
    <div class="mb-3">
    	기본(String) :
    	<a href="${ctp}/study/ajax/ajaxTest1" class="w3-button w3-blue w3-hover-blue w3-small">시(도)/구(동)(String배열)</a> &nbsp;
    	<a href="${ctp}/study/ajax/ajaxTest2" class="w3-button w3-blue w3-hover-blue w3-small">시(도)/구(동)(ArrayList의 String배열)</a> &nbsp;
    	<a href="${ctp}/study/ajax/ajaxTest3" class="w3-button w3-blue w3-hover-blue w3-small">시(도)/구(동)(HashMap형식으로 전달)</a> &nbsp;
    </div>
    <div>
    	응용(vo) :
    	<a href="${ctp}/study/ajax/ajaxTest4" class="w3-button w3-pale-red w3-hover-pale-red w3-small">회원아이디검색(VO/VOS)</a> &nbsp;
    </div>
</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>