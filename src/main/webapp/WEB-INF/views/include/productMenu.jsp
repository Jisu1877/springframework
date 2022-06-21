<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
   <div>
	<div>
	  <div class="w3-bar w3-light-gray w3-card">
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button w3-dark-gray" title="More">상품관리 <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/shop/input/productInput" class="w3-bar-item w3-button">상품등록</a>
	        <a href="${ctp}/shop/input/productList" class="w3-bar-item w3-button">상품리스트</a>
	      </div>
	    </div>
	  </div>
	</div>    
   </div>