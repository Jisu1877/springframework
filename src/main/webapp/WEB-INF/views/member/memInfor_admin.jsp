<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
    <title>memInfor.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
	html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif}
	span {
		background-color: coral;
	}
	</style>
    <script type="text/javascript">
	    function userDelCheck(idx) {
			let ans = confirm("정말 해당 회원을 삭제처리하시겠습니까?");
			if(ans) location.href="${ctp}/memUserDelete.mem?idx="+idx;
			
		}
    </script>
</head>
<body class="w3-light-grey">

<!-- Page Container -->
<div class="w3-content w3-margin-top" style="max-width:1400px;">

  <!-- The Grid -->
  <div class="w3-row-padding">
  <h2 class="text-center"><span>&nbsp;&nbsp;회원 상세 정보&nbsp;&nbsp;</span></h2><br>
    <!-- Left Column -->
    <div class="w3-half">
    
      <div class="w3-white w3-text-grey w3-card-4">
        <div class="w3-display-container">
          <div class="w3-display-bottomleft w3-container w3-text-black">
          </div>
        </div>
        <div class="w3-container">
          <p></p>
          <table class="table table-borderless" >
	  		<tr><td>아이디&nbsp; |&nbsp; ${vo.mid}</td></tr>
	  		<tr><td>닉네임&nbsp; |&nbsp; ${vo.nickName}</td></tr>
	  		<tr><td>성명&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; ${vo.name}</td></tr>
	  		<tr><td>성별&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; ${vo.gender}</td></tr>
	  		<c:set var="birthday" value="${vo.birthday}"></c:set>
	  		<tr><td>생일&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; ${fn:substring(birthday,0,10)}</td></tr>
	  		<c:set var="homePage" value="${vo.homePage}"></c:set>
	  		<c:choose>
		  		<c:when test="${fn:length(homePage)<8}">
					<tr><td><i class="fa fa-globe fa-fw w3-margin-right w3-large w3-text-teal"></i>&nbsp;&nbsp; |&nbsp; - 미입력 -</td></tr>
		  		</c:when>
		  		<c:otherwise>
		  			<tr><td><i class="fa fa-globe fa-fw w3-margin-right w3-large w3-text-teal"></i>&nbsp;&nbsp; |&nbsp; ${homePage}</td></tr>
		  		</c:otherwise>
	  		</c:choose>
	  		<c:set var="tel" value="${vo.tel}"/>
	  		<c:choose>
		  		<c:when test="${fn:length(tel)<6}">
		  			<tr><td><i class="fa fa-phone fa-fw w3-margin-right w3-large w3-text-teal"></i>&nbsp;&nbsp; |&nbsp; - 미입력 -</td></tr>
		  		</c:when>
		  		<c:otherwise>
		  			<tr><td><i class="fa fa-phone fa-fw w3-margin-right w3-large w3-text-teal"></i>&nbsp;&nbsp; |&nbsp; ${tel}</td></tr>
		  		</c:otherwise>
	  		</c:choose>
	  		<c:set var="address" value="${vo.address}"></c:set>
	  		<c:choose>
		  		<c:when test="${fn:length(address)<8}">
		  			<tr><td><i class="fa fa-home fa-fw w3-margin-right w3-large w3-text-teal"></i>&nbsp;&nbsp; |&nbsp; - 미입력 -</td></tr>
		  		</c:when>
		  		<c:otherwise>
		  			<tr><td><i class="fa fa-home fa-fw w3-margin-right w3-large w3-text-teal"></i>&nbsp;&nbsp; |&nbsp;  ${fn:replace(address, '/', '')}</td></tr>
		  		</c:otherwise>
	  		</c:choose>
	  		<%-- <tr><td><i class="fa fa-home fa-fw w3-margin-right w3-large w3-text-teal"></i>&nbsp;&nbsp; |&nbsp; ${fn:replace(address, '/', '')}</td></tr> --%>
	  		<tr><td><i class="fa fa-envelope fa-fw w3-margin-right w3-large w3-text-teal"></i>&nbsp;&nbsp; |&nbsp; ${vo.email}</td></tr>
	  		<tr><td><i class="fa fa-briefcase fa-fw w3-margin-right w3-large w3-text-teal"></i>&nbsp;&nbsp; |&nbsp; ${vo.job}</td></tr>
	  		<tr><td>취미&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; ${vo.hobby}</td></tr>
	  		<tr><td>등급&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; ${vo.strLevel}</td></tr>
	  	 </table>
          <hr>
          <p class="w3-large"><b><i class="fa fa-asterisk fa-fw w3-margin-right w3-text-teal"></i>자기소개 글</b></p>
          <c:set var="content" value="${vo.content}"/>
          <c:choose>
          	<c:when test="${fn:length(content)>1}">
          		${fn:replace(content, newLine, '<br/>')}
          	</c:when>
          	<c:otherwise>
          		- 미입력 -
          	</c:otherwise>
          </c:choose>
          <p></p>
          <br>
        </div>
      </div><br>

    <!-- End Left Column -->
    </div>
    
    <!-- Left Column -->
    <div class="w3-half">
    
      <div class="w3-white w3-text-grey w3-card-4">
        <div class="w3-display-container">
          <img src="images/na2.png" style="width:100%" alt="Avatar">
          <div class="w3-display-topleft w3-container w3-text-black">
            <h2>${vo.mid}</h2>
          </div>
        </div>
        <div class="w3-container">
          <p></p>
          <p class="w3-large w3-text-theme"><b><i class="fa fa-globe fa-fw w3-margin-right w3-text-teal"></i>기타 정보</b></p>
          <table class="table table-borderless" >
          	<c:set var="startDate" value="${vo.startDate}"></c:set>
          	<c:set var="lastDate" value="${vo.lastDate}"></c:set>
	  		<tr><td>가입일&nbsp; |&nbsp; ${fn:substring(startDate,0,10)}</td></tr>
	  		<tr><td>최종방문일&nbsp; |&nbsp; ${fn:substring(lastDate,0,10)}</td></tr>
	  		<tr><td>포인트&nbsp; |&nbsp; ${vo.point}point</td></tr>
	  		<tr><td>정보공개 여부&nbsp; |&nbsp; ${vo.userInfor}</td></tr>
	  		<c:choose>
	  			<c:when test="${vo.userDel == 'NO'}">
	  				<tr><td>탈퇴신청 여부&nbsp; |&nbsp; 활동중</td></tr>
	  			</c:when>
	  			<c:otherwise>
	  				<tr><td>탈퇴신청 여부&nbsp; |&nbsp; 
	  				<c:if test="${vo.userDel == 'OK'}">
						<font color="red">탈퇴신청</font>&nbsp; 
						(경과일 : <font color="red">${vo.applyDiff}</font>일)&nbsp;&nbsp;
						<c:if test="${vo.applyDiff > 30}">
							<button type="button" class="btn btn-danger btn-sm" onclick="javascript:userDelCheck(${vo.idx})">탈퇴처리</button>
						</c:if>
					</c:if>
	  				</td></tr>
	  			</c:otherwise>
	  		</c:choose>
	  		<tr><td>오늘 방문횟수&nbsp; |&nbsp; ${vo.todayCnt}회</td></tr>
	  		<tr><td>총 방문횟수&nbsp; |&nbsp; ${vo.visitCnt}회</td></tr>
	  	 </table>
          <br>
        </div>
      </div><br>

    <!-- End Left Column -->
    </div>
    
      <!-- End Grid -->
  </div>
  
  <!-- End Page Container -->
</div>

</body>
</html>