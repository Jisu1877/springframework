<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminInputCheck.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br></p>
<div class="container">
    <form method="post">
    	<div class="text-center">
    		<h2>관리자 등록을 위한 비밀번호를 입력하세요.</h2><br>
    	</div>
		<table class="table table-bordered" style="font-size: 20px;">
   			<tr>
   				<th class="text-center">비밀번호</th>
   				<td><input type="password" name="pwd" id="pwd" class="form-control"></td>
   			</tr>
   			<tr>
   				<td colspan="2" class="text-center">
	    			<input type="submit" value="입력" class="btn btn-dark"> &nbsp;
	    			<input type="reset" class="btn btn-outline-primary" value="다시입력"> &nbsp;
   				</td>
   			</tr>
  		</table>
	</form>
</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>