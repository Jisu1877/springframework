<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memPwdCheck.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br></p>
<div class="container">
    <form method="post">
    	<div class="text-center">
    		<h2>비밀번호 확인</h2>
    	</div>
   		<table class="table table-border">
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="pwd" autofocus class="form-control" required/>
				</td>
			</tr>
			<tr class="text-center">
				<td colspan="2">
					<input type="submit" value="확인" class="btn btn-primary"/>
					<input type="reset" value="다시입력" class="btn btn-secondary"/>
					<a href="memMain" class="btn btn-secondary">돌아가기</a>
				</td>
			</tr>    		
   		</table>
    </form>
</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>