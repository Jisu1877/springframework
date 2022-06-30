<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>pdsContent.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
    <script>
	  //다운로드 수 증가처리
	  	function downNumCheck(idx) {
			$.ajax({
				type : "post",
				url : "${ctp}/pds/pdsDownNum",
				data : {idx : idx},
				success : function() {
					location.reload();
				},
				error : function() {
					alert("전송오류.");
				}
			});
		}
    </script>
</head>
<body>
<p><br/><p>
<div class="container">
<div class="modal-dialog">
     <div class="modal-content">
       <!-- Modal Header -->
       <div class="modal-header">
         <h4 class="modal-title">${vo.title} (분류 : ${vo.part})</h4>
         <button type="button" class="close" onclick="window.close();">&times;</button>
       </div>
       
       <!-- Modal body -->
       <div class="modal-body">
		 - <b>올린이</b> : ${vo.nickName}
         <hr>
		 - <b>올린 날짜</b> : ${fn:substring(vo.FDate,0,fn:length(vo.FDate)-2)}<br>
		 - <b>아이디</b> : ${vo.mid}<br>
		 - <b>파일명</b> : ${vo.FName}<br>
		 - <b>파일크기</b> : <fmt:formatNumber value="${vo.FSize /1024}" pattern="#,##0"/>KByte<br>
		 - <b>다운로드수</b> : ${vo.downNum}<br>
		 - <b>자료설명</b> : 
		 <p>${fn:replace(vo.content, newLine, '<br/>')}</p>
		 <hr>
		<c:set var="fNames" value="${fn:split(vo.FName,'/')}"/>
		<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
		<c:forEach var="fSName" items="${fSNames}" varStatus="st">
			<a href="${ctp}/data/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${st.count}. ${fSName}</a> <br>
			<c:set var="fSNameLen" value="${fn:length(fSName)}"/>
			<c:set var="ext" value="${fn:substring(fSName, fSNameLen-3, fSNameLen)}"/>
			<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
			<c:if test="${extUpper == 'JPG' || extUpper == 'GIF' || extUpper == 'PNG' }">
				<img src="${ctp}/data/pds/${fSName}" width="400px"/>
			</c:if>
			<hr>
		</c:forEach>
		
         <hr>
       </div>
       
       <!-- Modal footer -->
       <div class="modal-footer">
         <button type="button" class="btn btn-danger" onclick="window.close();">Close</button>
       </div>
       
     </div>
     </div>
   </div>

</body>
</html>