<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>pdsInput.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
    <script>
	    'use strict';
		function fCheck() {
    		let maxSize = 1024 * 1024 * 20;
    		let title = $("#title").val();
    		let pwd = $("#pwd").val();
    		let file = $("#file").val();
    		
    		if(file == "" || file == null) {
    			alert("업로드할 파일을 선택하세요.");
    			return false;
    		}
    		else if(title.trim() == "") {
    			alert("파일 제목을 입력하세요.");
    			document.getElementById("title").focus();
    			return false;
    		}
    		else if(pwd.trim() == "") {
    			alert("비밀번호를 입력하세요.");
    			document.getElementById("pwd").focus();
    			return false;
    		}
    		
    		let fileSize = 0;
    		var files= document.getElementById("file").files;
    		for(let i=0; i< files.length; i++) {
    			
    			let fName = files[i].name;
    			
    			if(fName != "") {
	   				let ext = fName.substring(fName.lastIndexOf(".")+1);
	   	    		let uExt = ext.toUpperCase();
	
	   	    		if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "ZIP" && uExt != "HWP" && uExt != "PPT" && uExt != "PPTX" && uExt != "PDF") {
	   	    			alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/ppt/pptx/pdf' 입니다.");
	   	    			return false;
	   	    		}
	   	    		else {
		   	    		fileSize += files[i].size;
	   	    		}
    			}
    		}
    		
    		if(fileSize > maxSize) {
    			alert("업로드할 파일의 총 최대 용량은 20MByte 입니다.");
    			return false;
    		}    		
    		else {
    			myForm.fileSize.value = fileSize;
				myForm.submit();
    		}
		}
		
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/><p>
<div class="container"> <!-- 파일 업로드를 위해선 pom 추가/ servlet 설정이 필요하다. -->
	<form name="myForm" method="post" enctype="multipart/form-data">
		<h2 class="text-center">자 료 올 리 기</h2>
		<div class="form-group">
			<input type="file" name="file" id="file" multiple="multiple" class="form-control-file border" accept=".jpg,.gif,.png,.zip,.ppt,.pptx,.hwp,.pdf"/>
		</div>
		<div class="form-group">올린이 : ${sNickName}</div>
		<div class="form-group">
			<label for="title">제목 : </label>
			<input type="text" name="title" id="title" placeholder="자료 제목을 입력하세요" class="form-control" required/>
		</div>
		<div class="form-group">
			<label for="content">내용 : </label>
			<textarea rows="4" class="form-control" name="content" id="content"></textarea>
		</div>
		<div class="form-group">
			<label for="part">분류 : </label>
			<select name="part" id="part" class="form-control">
				<option value="전체">전체</option>
				<option value="학습">학습</option>
				<option value="여행">여행</option>
				<option value="음식">음식</option>
				<option value="기타">기타</option>
			</select>
		</div>
		<div class="form-group">
			<label for="openSw">공개여부 : &nbsp;&nbsp;</label>
			<input type="radio" name="openSw" value="공개" checked/>공개 &nbsp;&nbsp;
			<input type="radio" name="openSw" value="비공개"/>비공개
		</div>
		<div class="form-group">
			<label for="pwd">비밀번호 : </label>
			<input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control"/>
		</div>
		<div class="form-group text-center">
			<input type="button" value="자료올리기" onclick="fCheck()" class="btn w3-amber"/>
			<input type="reset" value="다시쓰기" class="btn w3-lime"/>
			<input type="button" value="돌아가기" onclick="location.href='${ctp}/pds/pdsList?pag=${pageVo.pag}&pageSize=${pageVo.pageSize}&part=${pageVo.part}';" class="btn w3-khaki"/>
		</div>
		<input type="hidden" name="mid" value="${sMid}"/>
		<input type="hidden" name="nickName" value="${sNickName}"/>
		<input type="hidden" name="fileSize"/>
	</form>
</div>
<p><br/><p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>