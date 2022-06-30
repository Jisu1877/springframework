<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n");%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>boContent.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <style type="text/css">
    	th {
    		background-color : coral;
    		text-align : center;
    	}
    </style>
    <script type="text/javascript">
    	'use strict';
    	
    	//전체 댓글 보이기/가리기
    	$(document).ready(function() {
    		$("#reply").show();
			$("#replyViewBtn").hide();
			
			$("#replyViewBtn").click(function() {
				$("#reply").slideDown(500);
				$("#replyViewBtn").hide();
				$("#replyHiddenBtn").show();
			});
			
			$("#replyHiddenBtn").click(function() {
				$("#reply").slideUp(500);
				$("#replyViewBtn").show();
				$("#replyHiddenBtn").hide();
			});
		});
    	
    	function goodCheck() {
			$.ajax({
				type : "post",
				url : "${ctp}/boGoodCount",
				data : {idx : ${vo.idx}},
				success : function () {
					location.reload();
				},
				error : function () {
					alert("전송오류~"); //f12 눌러서 404 or 405 오류가 뜨면 보낼때 오류 / 500번 오류는 문법 오류 
				}
			});
		}
    	
    	function goodUp() {
			$.ajax({
				type : "post",
				url : "${ctp}/boGoodUp",
				data : {idx : ${vo.idx}},
				success : function () {
					location.reload();
				},
				error : function () {
					alert("전송오류~"); 
				}
				
			});
		}
    	
    	function goodDown() {
			$.ajax({
				type : "post",
				url : "${ctp}/boGoodDown",
				data : {idx : ${vo.idx}},
				success : function () {
					location.reload();
				},
				error : function () {
					alert("전송오류~"); 
				}
				
			});
		}
    	
    	function boardDelCheck() {
			let ans = confirm("현 게시물을 삭제하시겠습니까?");
			if(ans) {
				location.href = "boDeleteOk?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
			}
		}
    	
    	// 댓글 입력 저장처리(aJax처리)
    	function replyCheck() {
			let content = $("#content").val();
			if(content.trim() == "") {
				alert("댓글을 입력하세요.");
				$("#content").focus();
				return false;
			}
			
			let query = {
				boardIdx 	: ${vo.idx},
				mid 		: '${sMid}',
				nickName 	: '${sNickName}',
				content 	: content,
				hostIp 		: '${pageContext.request.remoteAddr}'
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/board/boReplyInput",
				data : query,
				success : function(data) {
					if(data == "1") {
						alert("댓글이 입력되었습니다.");
						location.reload();
					}
					else {
						alert("댓글 입력실패~");
					}
				},
				error : function() {
					alert("전송오류!");
				}
			});
    	}
    	
   		// 댓글 삭제 처리
		function replyDelcheck(idx) {
			let ans = confirm("해당 댓글을 삭제하시겠습니까?");
			if(!ans) {
				return false;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/board/boReplyDeleteOk",
				data : {idx : idx},
				success : function(data) {
					location.reload();
				},
				error : function () {
					alert("전송오류");
				}
			});
		}
   		
   		
   		// 댓글 수정하기
   		function boReplyUpdate(idx) {
			let content = $("#content").val();
			let hostIp = '${pageContext.request.remoteAddr}';
			
			let query = {
				idx : idx,
				content : content,
				hostIp : hostIp
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/boReplyUpdateOk",
				data : query,
				success : function(data) {
					if(data == "1") {
						alert("댓글이 수정되었습니다.");
						location.href = "${ctp}/boContent.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
					}
					else {
						alert("댓글 수정 실패.");
					}
				},
				error : function () {
					alert("전송 오류");
				}
			});
		}
   		
   		//답변글(부모댓글의 댓글)
   		function insertReply(idx, level, levelOrder, nickName) {
			let insReply = '';
			insReply += '<div class="container">';
				insReply += '<table class="m-2 p-0" style="width:90%">';
					insReply += '<tr>';
						insReply += '<td class="p-0 text-left">';
							insReply += '<div class="form-group">';
							insReply += '답변 댓글 달기 : &nbsp;';
							insReply += '<input type="text" name="nickName" szie="6" value="${sNickName}" readonly class="p-0">';
							insReply += '</div>';
						insReply += '</td>';
						insReply += '<td class="p-0 text-right">';
							insReply += '<input type="button" value="답글달기" onclick="replyCheck2('+idx+', '+level+', '+levelOrder+')">';
						insReply += '</td>';
					insReply += '</tr>';
					insReply += '<tr>';
						insReply += '<td colspan="2" class="text-center p-0">';
							insReply += '<textarea rows="3" class="form-control p-0" name="content" id="content'+idx+'">';
							insReply += '@'+nickName+'\n';
							insReply += '</textarea>';
						insReply += '</td>';
					insReply += '</tr>';
				insReply += '</table>';
			insReply += '</div>';
			
			$("#replyBoxOpenBtn"+idx).hide();
			$("#replyBoxCloseBtn"+idx).show();
			$("#replyBox"+idx).slideDown(500);
			$("#replyBox"+idx).html(insReply);
		}
   		
   		//대댓글 입력폼 닫기 처리
   		function closeReply(idx) {
   			$("#replyBoxOpenBtn"+idx).show();
			$("#replyBoxCloseBtn"+idx).hide();
			$("#replyBox"+idx).slideUp(500);
		}
   		
   		//대댓글 저장하기
   		function replyCheck2(idx, level, levelOrder) {
			let boardIdx = "${vo.idx}";
			let mid = "${sMid}";
			let nickName = "${sNickName}";
			let content = "content" + idx;
			let contentVal = $("#" + content).val();
			let hostIp = '${pageContext.request.remoteAddr}';
   			
			if(contentVal == "") {
				alert("대댓글(답변글)을 입력하세요.");
				$("#" + content).focus();
				return false;
			}
			
   			let query = {
   				boardIdx : boardIdx,
   				mid : mid,
   				nickName : nickName,
   				content : contentVal,
   				hostIp : hostIp,
   				level : level,
   				levelOrder : levelOrder
   			}
   			
   			$.ajax({
   				type : "post",
   				url : "${ctp}/board/boardReplyInput2",
   				data : query,
   				success : function() {
					location.reload();
				},
				error : function() {
					alert("전송오류");
				}
   			});
		}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/><p>
<div class="container">
	<h2 class="text-center">글 내 용 보 기</h2>
	<br>
	<table class="table table-borderless">
		<tr>
			<td colspan="4" class="text-right">IP : ${vo.hostIp}</td>
		</tr>
	</table>
	<table class="table table-bordered">
		<tr>
			<th>글제목</th>
			<td colspan="3">${vo.title}</td>
		</tr>
		<tr>
			<th>글쓴이</th>
			<td>${vo.nickName}</td>
			<th>글쓴날짜</th>
			<td>${fn:substring(vo.WDate, 0, 19)}</td> <!-- 2022.05.11 10:13:20.5  -->
		</tr>
		<tr>
			<th>이메일</th>
			<td>${vo.email}</td>
			<th>조회수</th>
			<td>${vo.readNum}</td>
		</tr>
		<tr>
			<th>홈페이지</th>
			<td>${vo.homePage}</td>
			<th>좋아요/싫어요</th>
			<td>
			<%-- <a href="javascript:goodCheck()">❤️</a>(${vo.good}) /  --%>
			<a href="javascript:goodUp()">👍</a> / <a href="javascript:goodDown()">👎</a> (${vo.good}) </td>
		</tr>
		<tr>
			<th>글내용</th>
			<td colspan="3" style="height:300px">${fn:replace(vo.content, newLine, "<br/>")}</td>
		</tr>
	</table>

	<!-- 이전글/다음글 처리  -->
	<table class="table table-borderless">
		<tr>
			<td>
				<c:if test="${!empty pnVos[1]}">
					👆다음글 :<a href="boContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}"> ${pnVos[1].title}</a><br>
				</c:if>
				<c:if test="${!empty pnVos[0]}">
					<c:if test="${minIdx == vo.idx}">
						👆다음글 :
					</c:if>
					<c:if test="${minIdx != vo.idx}">
						👇이전글 :
					</c:if>
					<a href="boContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}"> ${pnVos[0].title}</a><br>
				</c:if>
			</td>
		</tr>
	</table>
	<br>
	<!-- 댓글 처리(출력/입력)  -->
	<div class="container text-center mb-3">
		<input type="button" value="댓글보이기" id="replyViewBtn" class="btn btn-secondary">
		<input type="button" value="댓글가리기" id="replyHiddenBtn" class="btn btn-info">
	</div>
	<!-- 댓글 출력 처리 -->
	<div id="reply">
		<table class="table table-hover text-center">
			<tr>
				<th>작성자</th>
				<th>댓글내용</th>
				<th>작성일자</th>
				<th>접속IP</th>
				<th>답글</th>
			</tr>
			<c:forEach var="replyVo" items="${replyVos}">
				<tr>
					<td class="text-left">
						<c:if test="${replyVo.level <= 0}"> <!-- 부모댓글의 경우는 들여쓰지 않는다.  -->
							${replyVo.nickName}
						</c:if>
						<c:if test="${replyVo.level > 0}"> <!-- 부모댓글의 경우는 들여쓴다.  -->
							
							<c:forEach var="i" begin="1" end="${replyVo.level}">
								&nbsp;&nbsp;
							</c:forEach>
							⨽ ${replyVo.nickName}
						</c:if>
						<c:choose>
							<c:when test="${sMid == replyVo.mid || sLevel == 0}">
								(<a href="javascript:replyDelcheck(${replyVo.idx})"><span class="glyphicon glyphicon-remove"></span></a>)
							</c:when>
						</c:choose>
					</td>
					<td class="text-left">
						${fn:replace(replyVo.content, newLine, "<br/>")}
						<%-- <c:if test="${vo.WNdate <= 24}"><img src="images/new.gif"></c:if> --%>
					</td>
					<td>
						${replyVo.WDate}
					</td>
					<td>${replyVo.hostIp}</td>
					<td>
						<input type="button" value="답글" onclick="insertReply('${replyVo.idx}','${replyVo.level}','${replyVo.levelOrder}','${replyVo.nickName}')" id="replyBoxOpenBtn${replyVo.idx}" class="btn btn-dark btn-sm">
						<input type="button" value="닫기" onclick="closeReply('${replyVo.idx}')" id="replyBoxCloseBtn${replyVo.idx}" class="btn btn-info btn-sm" style="display: none;">
					</td>
				</tr>
				<tr>
					<td colspan="5" class="m-0 p-0" style="border-top : none;">
						<div id="replyBox${replyVo.idx}"></div>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<!-- 댓글 입력 처리 -->
	<form name="replyForm" method="get" action="boReplyInput">
		<table class="table text-center">
			<tr>
				<td style="width: 90%" class="text-left">
					글내용 :
					<textarea rows="4" name="content" id="content" class="form-control"></textarea>
				</td>
				<td style="width: 15%">
					<br>
						<p>작성자 : ${sNickName}</p>
					<p>
						<input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-dark btn-sm"/>		
						<%-- 
						<c:if test="${!empty replyContent}">
							<input type="button" value="수정하기" onclick="boReplyUpdate(${replyIdx})" class="btn btn-dark btn-sm"/>		
						</c:if>
						 --%>
					</p>
				</td>
			</tr>
		</table>
		<%-- 
		<input type="hidden" name="boardIdx" value="${vo.idx}"/>
		<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
		<input type="hidden" name="mid" value="${sMid}"/>
		<input type="hidden" name="nickName" value="${sNickName}"/>
		<input type="hidden" name="pag" value="${pag}"/>
		<input type="hidden" name="pageSize" value="${pageSize}"/>
		 --%>
	</form>
	
	
	<div class="text-center">
		<c:if test="${flag == 's'}">
			<input type="button" value="돌아가기" onclick="location.href='boSearch?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn w3-amber"/> <!-- param을 안쓰고 커맨드객체에서 request로 값 보내는 방법이 있다. -->
		</c:if>
		<c:if test="${flag != 's'}">
			<input type="button" value="돌아가기" onclick="location.href='boList?pag=${pag}&pageSize=${pageSize}';" class="btn w3-amber"/> <!-- param을 안쓰고 커맨드객체에서 request로 값 보내는 방법이 있다. -->
		</c:if>
		<c:if test="${sMid == vo.mid || sLevel == 0}">
			<c:if test="${sMid == vo.mid}">
				<input type="button" value="수정하기" onclick="location.href='boUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn w3-amber"/>
			</c:if>
			<input type="button" value="삭제하기" onclick="boardDelCheck()" class="btn w3-amber"/>
		</c:if>
	</div>
</div>
<p><br/><p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>