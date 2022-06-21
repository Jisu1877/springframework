<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n");%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>guestList.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script type="text/javascript">
    	'use strict'
		function delCheck(idx) {
			let ans = confirm("방명록을 삭제하시겠습니까?");
			if(ans) {
				location.href="${ctp}/guestDelete.gu?idx="+idx;
			}
		}    
    </script>
    <style type="text/css">
    	th {
    	background-color : #ccc;
    	text-align : center;
    	}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
 <jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/><p>
<div class="container">
	<h2 class="text-center m-3">방 명 록 리 스 트</h2>
	<div class="row">
		<div class="col text-right">
			<a href="guestInput" class="btn btn-secondary">글쓰기</a>
		</div>
	</div>
	<div>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<table class="table table-borderless m-0 p-0">
				<tr>
					<td  class="text-left">
						방문번호 : ${curScrStartNo}
					</td>
					<td width="75%"   class="text-right">방문IP : ${vo.hostIp}</td>
				</tr>
			</table>
			<table class="table table-bordered">
				<tr>
					<th width="20%">성명</th>
					<td width="30%">${vo.name}</td>
					<th width="20%">방문일자</th>
					<td width="30%">${vo.VDate}</td>
				</tr>
				<tr>
					<th>전자우편</th>
					<td colspan="3">
						<c:if test="${empty vo.email}">- 없음 -</c:if>	
						<c:if test="${!empty vo.email}">${vo.email}</c:if>	
					</td>
				</tr>
				<tr>
					<th>홈페이지</th>
					<td colspan="3">
						<c:set var="hpLen" value="${fn:length(vo.homepage)}"/>
						<c:if test="${empty vo.homepage || hpLen <= 7}">- 없음 -</c:if>
						<c:if test="${!empty vo.homepage && hpLen > 7}">
							<a href="${vo.homepage}" target="_blank">${vo.homepage}</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>글내용</th>
					<td colspan="3">${fn:replace(vo.content, newLine, "<br/>")}</td>
				</tr>
			</table>
			<br/>
			<c:set var="curScrStartNo" value="${curScrStartNo + 1}"/>
		</c:forEach>
	</div>
	<br>
	<!-- 블록 페이징 처리 시작 -->
	<div class="text-center">
		<ul class="pagination justify-content-center pagination-sm">
		  <c:if test="${pag > 1}">
		  	<li class="page-item"><a class="page-link text-secondary" href="guestList?pag=1">◁◁</a></li>
		  </c:if>
		  <c:if test="${curBlock > 0}">
		  	<li class="page-item"><a class="page-link text-secondary" href="guestList?pag=${(curBlock-1)*blockSize + 1}">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
		    <c:if test="${i <= totPage && i == pag}">
		      <li class="page-item active"><a class="page-link text-light border-secondary bg-secondary" href="guestList?pag=${i}">${i}</a></li>
		    </c:if>
		    <c:if test="${i <= totPage && i != pag}">
		      <li class="page-item"><a class="page-link text-secondary" href='guestList?pag=${i}'>${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${curBlock < lastBlock}">
		     <li class="page-item"><a class="page-link text-secondary" href="guestList?pag=${(curBlock+1)*blockSize + 1}">▶</a></li>
		  </c:if>
		  <c:if test="${pag != totPage}">
			 <li class="page-item"><a class="page-link text-secondary" href="guestList?pag=${totPage}">▷▷</a></li>
		  </c:if>
		 </ul>
	</div>
	<!-- 블록 페이징 처리 끝 -->
</div>
<p><br/><p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>