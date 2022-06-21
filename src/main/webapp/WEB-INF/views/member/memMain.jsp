<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memMain</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/><p>
<div class="container">
	<h2>회 원 전 용 방</h2>
	<hr/>
	<p><font color="blue">${sNickName}</font>님 로그인 중..</p>
	<p>현재 <font color="red"> ${sStrLevel}</font> 이십니다.</p>
	<p>누적 포인트 : <font color="blue">${vo.point} </font>회</p>
	<p>총 방문횟수 : <font color="blue">${vo.visitCnt} </font>회</p>
	<p>오늘 방문횟수 : <font color="blue">${vo.todayCnt} </font>회</p>
	<p>최종 접속일 : <font color="blue">${fn:substring(vo.lastDate,0,19)} </font></p>
	<hr/>
	<h4>활동내역</h4>
	방명록에 올린 글 수 : <font color="blue">${guestCnt}</font><br>
	게시판에 올린 글 수 : <font color="blue"></font><br>
	자료실에 올린 글 수 : <font color="blue"></font><br>
</div>
<p><br/><p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>