<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script>
	function memDeleteCheck() {
		let ans = confirm("정말로 탈퇴하시겠습니까?");
		if(!ans) return false;
		else location.href='${ctp}/member/memDeleteOk';
	}
</script>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-black w3-card">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="${ctp}/" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">GUEST</a>
    <c:if test="${sLevel <= 4}">
	    <a href="${ctp}/board/boList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">BOARD</a>
	    <a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">PDS</a>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">STUDY1 <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/study/password/passCheck1" class="w3-bar-item w3-button">암호화연습</a>
	        <a href="${ctp}/study/password2/operatorMenu" class="w3-bar-item w3-button">암호화연습2</a>
	        <a href="${ctp}/study/password3/aria" class="w3-bar-item w3-button">암호화(ARIA)</a>
	        <a href="${ctp}/study/password3/securityCheck" class="w3-bar-item w3-button">암호화3(BCryptPasswordEncoder)</a>
	        <a href="${ctp}/study/ajax/ajaxMenu" class="w3-bar-item w3-button">AJax연습</a>
	        <a href="${ctp}/study/mail/mailForm" class="w3-bar-item w3-button">메일연습</a>
	        <a href="${ctp}/study/uuid/uuidForm" class="w3-bar-item w3-button">UUID연습</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">STUDY2 <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/study/fileUpload/fileUpload" class="w3-bar-item w3-button">파일업로드연습</a>
	        <a href="${ctp}/study/personInput" class="w3-bar-item w3-button">트랜잭션연습</a>
	      </div>
	    </div>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">MINI SHOP <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/shop/input/goodsMenu" class="w3-bar-item w3-button">대/중/소분류 등록</a>
	        <a href="${ctp}/shop/input/productMenu" class="w3-bar-item w3-button">상품메뉴</a>
	        <a href="${ctp}/shop/input/optionMenu" class="w3-bar-item w3-button">옵션등록</a>
	      </div>
	    </div>
		    <div class="w3-dropdown-hover w3-hide-small">
		      <button class="w3-padding-large w3-button" title="More">${sNickName} <i class="fa fa-caret-down"></i></button>     
		      <div class="w3-dropdown-content w3-bar-block w3-card-4">
		        <a href="${ctp}/member/memMain" class="w3-bar-item w3-button">회원메인</a>
		        <a href="${ctp}/member/memList" class="w3-bar-item w3-button">회원리스트</a>
		        <a href="${ctp}/member/memPwdCheck" class="w3-bar-item w3-button">정보수정</a>
		        <a href="javascript:memDeleteCheck()" class="w3-bar-item w3-button">회원탈퇴</a>
		      </div>
		    </div>
    </c:if>
    <c:if test="${sLevel == 0}">
	   <div class="w3-dropdown-hover w3-hide-small">
	     <button class="w3-padding-large w3-button" title="More">ADMIN <i class="fa fa-caret-down"></i></button>     
	     <div class="w3-dropdown-content w3-bar-block w3-card-4">
	       <a href="${ctp}/admin/adminInputCheck" class="w3-bar-item w3-button">관리자등록</a>
	       <a href="${ctp}/admin/adminLogin" class="w3-bar-item w3-button">관리자 로그인</a>
	       <a href="${ctp}/admin/adminLogout" class="w3-bar-item w3-button">관리자 로그아웃</a>
	     </div>
	   </div>
    </c:if>
    <c:if test="${empty sLevel}">
    	<a href="${ctp}/member/memLogin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">LOGIN</a>
    </c:if>
    <c:if test="${!empty sLevel}">
    	<a href="${ctp}/member/memLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">LOGOUT</a>
    </c:if>
    <div class="w3-bar-item w3-padding-large">
    	<c:if test="${!empty sMid}">
    		<font color="yellow">${sMid}</font>님 환영합니다.
    	</c:if>
    </div>
    <a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a>
  </div>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#band" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">GUEST</a>
  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">BOARD</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">PDS</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">STUDY</a>
</div>