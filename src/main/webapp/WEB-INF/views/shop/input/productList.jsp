<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>productList.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <script>
    	'use strict';
    	/* 중분류 가져오기  */
    	$(function() {
			$("#product1").change(function() {
				let product1 = $(this).val();
				if(product1 == "") {
					alert("대분류를 선택하세요.");
					return false;
				}
				
				$.ajax({
					type : "post",
					url : "${ctp}/shop/input/getProduct2",
					data : {product1 : product1},
					success : function(vos) {
						let str = '';
	    				str += '<option value="">중분류</option>';
	    				for(let i=0; i<vos.length; i++) {
	    					if(vos[i].product2 == null) break;
	    					str += '<option value="'+vos[i].product2+'">'+vos[i].product2+'</option>'
	    				}
	    				
	    				$("#product2").html(str);
					},
					error : function() {
	    				alert("전송오류!");
	    			}
				});
				
			});
		});
    	
    	/* 소분류 가져오기  */
    	$(function() {
			$("#product2").change(function() {
				let product2 = $(this).val();
				if(product2 == "") {
					alert("중분류를 선택하세요.");
					return false;
				}
				
				$.ajax({
					type : "post",
					url : "${ctp}/shop/input/getProduct3",
					data : {product2 : product2},
					success : function(vos) {
						let str = '';
	    				str += '<option value="">소분류</option>';
	    				for(let i=0; i<vos.length; i++) {
	    					if(vos[i].product3 == null) break;
	    					str += '<option value="'+vos[i].product3+'">'+vos[i].product3+'</option>'
	    				}
	    				
	    				$("#product3").html(str);
					},
					error : function() {
	    				alert("전송오류!");
	    			}
				});
				
			});
		});
    	
    	function Search() {
    		let product1 = $("#product1").val();
    		let product2 = $("#product2").val();
    		let product3 = $("#product3").val();
    		
    		if(!product3 == "" && product2 == "") {
    			alert("중분류를 선택해주세요.");
    			return false;
    		}
    		else {
    			//document.getElementById("result").style.display = "block";
    			
    			myForm.submit();
    		}
    		
		}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/productMenu.jsp" />
    <div class="text-center" style="margin: 20px;"><h2><strong>상품 리스트</strong></h2></div>
    <div class="w3-row">
    	<form name="myForm" method="post" action="${ctp}/shop/input/productList">
	    	<div class="input-group mb-3 w3-third" id="result">
	    		<b>${select.product1} <font color="blue">${select.product2}</font> <font color="brown">${select.product3}</font> 로 검색한 결과</b>
	    	</div>
			<div class="input-group mb-3 w3-third"></div>
			<div class="input-group mb-3 w3-third" style="padding-left: 20px;">
				<select  id="product1" name="product1">
					<option value="">대분류</option>
					<c:forEach var="vo" items="${producut1}">
						<option value="${vo.product1}">${vo.product1}</option>
					</c:forEach>
				</select> &nbsp;&nbsp;
				<select  id="product2" name="product2">
					<option value="">중분류</option>
				</select> &nbsp;&nbsp;
				<select id="product3" name="product3">
					<option value="">소분류</option>
				</select> &nbsp;&nbsp;
				<input type="button" class="btn btn-secondary btn-sm" value="검색" onclick="Search()"> 
			</div>
		</form>
	</div>
    <table class="table table-hover table-borderless">
    	<tr class="w3-khaki text-center">
    		<th>번호</th>
    		<th>상품명</th>
    		<th>가격</th>
    		<th>타이틀</th>
    		<th>비고</th>
    	</tr>
    	<c:forEach var="vo" items="${vos}">
    		<tr>
    			<td>${vo.idx}</td>
    			<td>${vo.product}</td>
    			<td>￦<fmt:formatNumber value="${vo.price}"/></td>
    			<td>${vo.title}</td>
    			<td>
    				<input type="button" value="수정" class="btn btn-outline-warning btn-sm" onclick=""> 
    				<input type="button" value="삭제" class="btn btn-outline-danger btn-sm" onclick="">
    			</td>
    		</tr>
    	</c:forEach>
    </table>
      <div class="text-center">
	<%--   <form name="searchForm" method="post" action="${ctp}/shop/list/productSearch"> --%>
	  <form name="searchForm">
	    상품검색 :
	    <input type="text" name="product"/> &nbsp;
	    <input type="button" value="상품검색" onclick="productSearch()" class="btn btn-info"/>
	  </form>
	  <script>
	    function productSearch() {
	    	let product = document.searchForm.product.value;
	    	if(product.trim() == "") {
	    		alert("검색할 품명을 입력하세요");
	    		searchFrom.product.focus();
	    	}
	    	else {
	    		location.href = "${ctp}/shop/list/productSearch?product="+product;
	    	}
	    }
	  </script>
  </div>
</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>