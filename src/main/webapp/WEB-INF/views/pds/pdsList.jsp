<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>pdsList.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    	'use strict';
    	
    	//분류별 검색
    	function partCheck() {
			let part = partForm.part.value;
			location.href = "${ctp}/pds/pdsList?part="+part;
		}
    	
    	//페이지사이즈 검색
      	function pageCheck() {
			let pageSize = $("#pageSize").val();
			location.href="pdsList?part=${pageVo.part}&?pag=${pag}&pageSize="+pageSize;
		}
      	
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
      	
      	//동적폼을 이용한 비밀번호 박스 보여주기
      	function pdsDelCheckOpen(idx) {
      		$(".deletePwd").slideUp(500);
      		$(".delCheckOpenBtn").show();
      		$(".delCheckCloseBtn").hide();
      		$(".deleteTr").hide();
			let str = '';
			str += '<div id="deletePwd'+idx+'" class="text-center deletePwd">';
			str += '등록시 입력했던 비밀번호를 입력하세요.&nbsp;&nbsp;';
			str += '<input type="password" name="pwd" id="pwd'+idx+'">&nbsp;';
			str += '<input type="button" value="입력" onclick="pwdCheck('+idx+')">';
			str += '</div>';
			
			$("#delCheckOpenBtn"+idx).hide();
			$("#delCheckCloseBtn"+idx).show();
			$("#deleteTr"+idx).show();
			/* $("#deleteForm"+idx).slideDown(500); */
			$("#deleteForm"+idx).html(str);
		}
      	
      	//비밀번호 확인(자료삭제처리)
      	function pwdCheck(idx) {
			let pwd = $("#pwd"+idx).val();
			if(pwd.trim() == "") {
				alert("비밀번호를 입력하세요.");
				$("#pwd"+idx).focus();
				return false;
			}
			$.ajax({
				type : "post",
				url : "${ctp}/pds/pdsPwdCheck",
				data : {
					idx : idx,
					pwd : pwd
				},
				success : function(res) {
					if(res != "1") {
						alert("비밀번호가 일치하지 않습니다.");
						$("#pwd"+idx).focus();
					}
					else {
						alert("삭제 처리가 완료되었습니다.");
						location.reload();
					}
				},
				error : function () {
					alert("전송오류.");
				}
			});
		}
      	
      	
      	function pdsDelCheckClose(idx) {
      		$("#delCheckOpenBtn"+idx).show();
			$("#delCheckCloseBtn"+idx).hide();
			/* $("#deleteForm"+idx).slideUp(500); */
			$("#deleteTr"+idx).hide();
		}
      	// 자료 삭제처리
      	function pdsDelCheck(idx,fSName) {
			let ans = confirm("해당 자료를 삭제하시겠습니까?");
			if(!ans) return false;
			
			let pwd = prompt("비밀번호를 입력하세요?");
			let query = {
				idx : idx,
				fSName : fSName,
				pwd : pwd
			}
			$.ajax({
				type : "post",
				url : "${ctp}/pdsDelete.pds",
				data : query,
				success : function(data) {
					if(data == 'pdsDeleteOk') {
						alert("삭제되었습니다.");
						location.reload();
					}
					else {
						alert("삭제에 실패했습니다.");
					}
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
      	
      	
      	function newWindow(idx) {
			let url = "${ctp}/pds/pdsContent?idx="+idx;
			window.open(url, "newWindow", "width=850px,height=600px");
		}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/><p>
<div class="container">
	<h2 class="text-center">자 료 실 리 스 트(${pageVo.part})</h2>
	<br>
	<table class="table table-borderless">
		<tr>
			<td class="text-left" style="width:15%">
				<form name="partForm">
					<select name="part" onchange="partCheck()" class="form-control">
						<option value="전체" ${pageVo.part == '전체' ? 'selected' : ''}>전체</option>
						<option value="학습" ${pageVo.part == '학습' ? 'selected' : ''}>학습</option>
						<option value="여행" ${pageVo.part == '여행' ? 'selected' : ''}>여행</option>
						<option value="음식" ${pageVo.part == '음식' ? 'selected' : ''}>음식</option>
						<option value="기타" ${pageVo.part == '기타' ? 'selected' : ''}>기타</option>
					</select>
				</form>
			</td>
			<td class="text-left" style="width:10%">
				<select name="pageSize" id="pageSize" onchange="pageCheck()" class="form-control">
					<option value="5" ${pageVo.pageSize == 5 ? 'selected' : '' }>5건</option>
					<option value="10" ${pageVo.pageSize == 10 ? 'selected' : '' }>10건</option>
					<option value="15" ${pageVo.pageSize == 15 ? 'selected' : '' }>15건</option>
					<option value="20" ${pageVo.pageSize == 20 ? 'selected' : '' }>20건</option>
				</select>
			</td>
			<td style="text-align:right"><a href="${ctp}/pds/pdsInput" class="btn w3-border-pink w3-text-pink">자료올리기</a></td>
		</tr>
	</table>
	<table class="table table-hover table-borderless text-center">
		<tr class="table w3-pale-red">
			<th>번호</th>
			<th>자료제목</th>
			<th>올린이</th>
			<th>올린날짜</th>
			<th>분류</th>
			<th>파일명(사이즈)</th>
			<th>다운 수</th>
			<th>비고</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td>${curScrStartNo}</td>
				<td>
					<c:if test="${vo.openSw == '공개' || sMid == vo.mid || sLevel == 0}">
					 <a href="javascript:newWindow(${vo.idx});"> ${vo.title}</a>
					</c:if>
					<c:if test="${vo.openSw != '공개' && sMid != vo.mid && sLevel != 0}">
					${vo.title}
					</c:if>
				</td>
				<td>${vo.nickName}</td>
				<td>${fn:substring(vo.FDate,0,10)}</td>
				<td>${vo.part}</td>
				<td>
					<c:if test="${vo.openSw == '공개' || sMid == vo.mid || sLevel == 0}">
						<%-- ${vo.fName}<br> --%>
						<c:set var="fNames" value="${fn:split(vo.FName,'/')}"/>
						<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
						<c:forEach var="fName" items="${fNames}" varStatus="st">
							<!-- 저장은 fSName의 파일명을 가진 파일을 다운받지만, 다운받을때 파일명은 FName명으로 다운된다. -->
							<a href="${ctp}/data/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br> <!-- download="${fName}"는 "" 안에 있는 글자로 다운받을 때 파일명을 바꿔달라는 것.(브라우저가 바꿔서 저장해줌) -->
						</c:forEach>
						
						(<fmt:formatNumber value="${vo.FSize /1024}" pattern="#,##0"/>KByte)
					</c:if>
					<c:if test="${vo.openSw != '공개' && sMid != vo.mid && sLevel != 0}">
						- 비공개 -
					</c:if>
				</td>
				<td>${vo.downNum}</td>
				<td>
					<c:if test="${sMid == vo.mid || sLevel == 0}">
						<a href="javascript:pdsDelCheckOpen(${vo.idx})" id="delCheckOpenBtn${vo.idx}" class="btn w3-red btn-sm delCheckOpenBtn">삭제</a>
						<a href="javascript:pdsDelCheckClose(${vo.idx})" id="delCheckCloseBtn${vo.idx}" class="btn w3-indigo btn-sm delCheckCloseBtn" style="display:none">닫기</a>
					</c:if>
						<a href="${ctp}/pds/pdsTotalDown?idx=${vo.idx}&fName=${vo.FName}&fSName=${vo.FSName}&title=${vo.title}" class="btn w3-amber btn-sm">다운로드</a>
				</td>
			</tr>
			<tr style="display:none" id="deleteTr${vo.idx}" class="deleteTr">
				<td colspan="8" style="background-color:#ccc">
					<div id="deleteForm${vo.idx}"></div>
				</td>			
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		</c:forEach>
		<tr><td colspan="8" class="p-0"></td></tr>
	</table>
</div>
<!-- 블록 페이징 처리 시작 -->
<div class="text-center">
	<ul class="pagination justify-content-center pagination-sm">
	  <c:if test="${pageVo.pag > 1}">
	  	<li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVo.part}&pag=1&pageSize=${pageVo.pageSize}">◁◁</a></li>
	  </c:if>
	  <c:if test="${pageVo.curBlock > 0}">
	  	<li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVo.part}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}">
	    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}">
	      <li class="page-item active"><a class="page-link text-light border-secondary bg-secondary" href="pdsList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}">
	      <li class="page-item"><a class="page-link text-secondary" href='pdsList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}'>${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
	     <li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}&pageSize=${pageVo.pageSize}">▶</a></li>
	  </c:if>
	  <c:if test="${pageVo.pag != pageVo.totPage}">
		 <li class="page-item"><a class="page-link text-secondary" href="pdsList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">▷▷</a></li>
	  </c:if>
	 </ul>
</div>
<!-- 블록 페이징 처리 끝 -->

<p><br/><p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>