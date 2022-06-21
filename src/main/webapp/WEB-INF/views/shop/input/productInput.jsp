<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품등록</title>
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
	    				str += '<option value="">중분류를 선택하세요.</option>';
	    				for(let i=0; i<vos.length; i++) {
	    					if(vos[i].product2 == null) break;
	    					str += '<option>'+vos[i].product2+'</option>'
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
				let product1 = $("#product1").val();
				let product2 = $(this).val();
				
				if(product1 == "") {
					alert("대분류를 선택하세요.");
					return false;
				}
				else if(product2 == "") {
					alert("중분류를 선택하세요.");
					return false;
				}
				
				
				
				$.ajax({
					type : "post",
					url : "${ctp}/shop/input/getProduct3",
					data : {product2 : product2},
					success : function(vos) {
						let str = '';
	    				str += '<option value="">소분류를 선택하세요.</option>';
	    				for(let i=0; i<vos.length; i++) {
	    					if(vos[i].product3 == null) break;
	    					str += '<option>'+vos[i].product3+'</option>'
	    				}
	    				
	    				$("#product3").html(str);
					},
					error : function() {
	    				alert("전송오류!");
	    			}
				});
				
			});
		});
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/productMenu.jsp" />
	<p><br></p>
    <div>
    <form name="myForm" method="post" class="was-validated">
	    <div class="text-center mb-2"><h2><strong>상품등록</strong></h2></div>
		    	<div class="w3-row">
					<div class="w3-col m2 l2 w3-margin-bottom"></div>
					<div class="w3-col m8 l8 w3-margin-bottom">
			    	<div class="form-group">
			    		<div class="w3-row-padding w3-padding-16">
			      		<div class="input-group mb-3 w3-third">
			      			<label>대분류 </label>
				            <select class="w3-select w3-border" id="product1" name="product1">
				            	<option value="">대분류를 선택하세요.</option>
				            	<c:forEach var="vo" items="${vos}">
				            		<option value="${vo.product1}">${vo.product1}</option>
				            	</c:forEach>
				            </select>
			    		</div>
			    		<div class="input-group mb-3 w3-third">
			    			<label>중분류 </label>
				            <select class="w3-select w3-border" id="product2" name="product2">
				            	<option value="">중분류를 선택하세요.</option>
				            </select>
			    		</div>
			    		<div class="input-group mb-3 w3-third">
			    			<label>소분류 </label>
				            <select class="w3-select w3-border" id="product3" name="product3">
				            	<option value="">소분류를 선택하세요.</option>
				            </select>
			    		</div>
			    		</div>
			    	</div>
		    	</div>
		    	<div class="w3-col m2 l2 w3-margin-bottom"></div>
		    	</div>
		    	<div class="w3-row">
				<div class="w3-third w3-margin-bottom"></div>
				<div class="w3-third w3-margin-bottom">
			    	<div class="form-group">
			    		<label for="name">상품명 : &nbsp; &nbsp;</label>
			      		<div class="input-group mb-3">
			    			<input class="input w3-padding-16 w3-border form-control" id="product" name="product" type="text" placeholder="상품명을 입력하세요." required>
			    		</div>
			    	</div>
			    	<div class="form-group">
			    		<label for="mid">가격 : &nbsp; &nbsp;</label>
			      		<div class="input-group mb-3">
			    			<input class="input w3-padding-16 w3-border form-control" id="price" name="price" type="number" min="0" required>
						    <div class="input-group-append">
						      	<input type="button" value="￦" class="btn w3-gray" readonly/>
						    </div>
			    		</div>
			    	</div>
			    	<div class="form-group">
			    		<label for="pwd">상품 간단설명 : &nbsp; &nbsp;</label>
			      		<div class="input-group mb-3">
			    			<input class="input w3-padding-16 w3-border form-control" id="title" name="title" type="text" placeholder="상품의 간단한 설명을 입력하세요." required>
			    		</div>
			    	</div>
			    	<div class="form-group">
			    		<label for="pwd">상품 상세설명 : &nbsp; &nbsp;</label>
			      		<div class="input-group mb-3">
			    			<textarea rows="3" class="input w3-padding-16 w3-border form-control" id="content" name="content" placeholder="상품의 상세 설명을 입력하세요."></textarea>
			    		</div>
			    	</div>
				  <p><br></p>
			      <p style="text-align: center;">
				      <button class="w3-button w3-black w3-hover-black" type="submit">상품 등록</button>&nbsp; &nbsp;
				      <button class="w3-button w3-dark-gray w3-hover-black" type="reset">다시입력</button>&nbsp; &nbsp;
				     <%--  <a class="w3-button w3-black" type="button" href="${ctp}/">홈으로</a> --%>
			      </p>
			      </div>
			     </div>
		    </form>
	    </div>
	    <div class="w3-third w3-margin-bottom">
	    </div>
    </div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>