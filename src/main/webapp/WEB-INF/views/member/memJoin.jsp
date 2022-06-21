<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memJoin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
  	'use strict';
  	let idCheckSw = 0;
    let nickCheckSw = 0;
    
  	// 회원가입폼 체크 후 서버로 전송하기
  	function fCheck() {
		let mid = myForm.mid.value;
		let pwd = myForm.pwd.value;
		let nickName = myForm.nickName.value;
		let name = myForm.name.value;
		let email1 = myForm.email1.value;
		let email2 = myForm.email2.value;
		let email = email1 + '@' + email2;
		let homePage = myForm.homePage.value;
		let tel1 = myForm.tel1.value;
	    let tel2 = myForm.tel2.value; 
	    let tel3 = myForm.tel3.value;
	    let tel = myForm.tel1.value + "-" + myForm.tel2.value + "-" + myForm.tel3.value;
		
		//정규식
		let regMid = /^[a-z0-9_]{4,20}$/;
		let regPwd = /(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).{6,24}/;
		let regNickName = /^[가-힣]+$/;
		let regName = /^[가-힣a-zA-Z]+$/;
		let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		let regURL = /^(https?:\/\/)?([a-z\d\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?$/;
		let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
	      
	    let submitFlag = 0; //전송체크버튼으로 값이 1이면 체크완료되어 전송처리한다.
	    
		//사진업로드체크
 		let fName = myForm.fName.value;
 		let ext = fName.substring(fName.lastIndexOf(".")+1); //파일 확장자 발췌
		let uExt = ext.toUpperCase(); //확장자를 대문자로 변환
 		let maxSize = 1024 * 1024 * 2 //업로드할 회원사진의 용량은 2MByte까지로 제한한다.
 		
		
		// 기타 추가로 체크해야할 항목들을 모두 체크하세요...
		if(!regMid.test(mid)) {
            alert("아이디는 영문 소문자와 숫자, 언더바(_)만 사용가능합니다.(길이는 4~20자리까지 허용)");
            myForm.mid.focus();
            return false;
        }
/* 		else if(!regPwd.test(pwd)) {
            alert("비밀번호는 1개이상의 문자와 특수문자 조합의 6~24 자리로 작성해주세요.");
            myForm.pwd.focus();
            return false;
        } */
		else if(!regNickName.test(nickName)) {
            alert("닉네임은 한글만 사용가능합니다.");
            myForm.nickName.focus();
            return false;
        }
		else if(!regName.test(name)) {
            alert("성명은 한글과 영문대소문자만 사용가능합니다.");
            myForm.name.focus();
            return false;
        }
		else if(!regEmail.test(email)) {
            alert("이메일 형식에 맞지않습니다.");
            myForm.email1.focus();
            return false;
        }
		else if(homePage != "http://" && homePage != "") {
			if(!regURL.test(homePage)) {
	            alert("작성하신 홈페이지 주소가 URL 형식에 맞지않습니다.");
	            myForm.homePage.focus();
	            return false;
		    }
		    else {
		    	submitFlag = 1;
		    }
		}
		if(tel2 != "" || tel3 != "") {
			if(!regTel.test(tel)) {
		        alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
		        myForm.tel2.focus();
		        return false;
		    }
		    else {
		    	submitFlag = 1;
		    }
	    }
		
		//전송 전에 주소를 하나로 묶어서 전송처리 준비한다.
		let postcode = myForm.postcode.value + " ";
		let roadAddress = myForm.roadAddress.value  + " ";
		let detailAddress = myForm.detailAddress.value  + " ";
		let extraAddress = myForm.extraAddress.value + " ";
		myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
			
		//전송 전에 파일에 관한 사항 체크
		if(fName.trim() == "") {
			myForm.photo.value = "noimage";
			submitFlag = 1;
		}
		else {
			let fileSize = document.getElementById("file").files[0].size;  //첫번째 파일의 사이즈..! 아이디를 예약어인 file 로 주기.
		
			if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG") {
				alert("업로드 가능한 파일은 'JPG/GIF/PNG'파일입니다.") 					
				return false;
			} 				// 혹시 파일명에 공백이 있으면~~~
			else if(fName.indexOf(" ") != -1) {
				alert("업로드 파일명에 공백을 포함할 수 없습니다.");
				return false;
			}
			else if(fileSize > maxSize) {
				alert("업로드 파일의 크기는 2MByte를 초과할 수 없습니다.");
				return false;
			}
			submitFlag = 1;
		}	
			
			
		// 전송전에 모든 체크가 끝나서 submitFlag가 1이되면 서버로 전송한다.
		if(submitFlag == 1) {
			if(idCheckSw == 0) {
				alert("아이디 중복체크버튼을 눌러주세요!");
			}
			else if(nickCheckSw == 0) {
				alert("닉네임 중복체크버튼을 눌러주세요!");
			}
			else {
				//묶여진 필드(email/tel)를 폼태그안에 hidden태그의 값으로 저장시켜준다.
				myForm.email.value = email;
				myForm.tel.value = tel;
				
				myForm.submit();
			}
		}
		else {
			alert("회원가입 실패~~");
		}
  	}
  	//아이디 중복체크
  	function idCheck() {
  		let mid = $("#mid").val();
		
  		if(mid == "" || $("#mid").val().length < 4 || $("#mid").val().length >= 20) {
			alert("아이디를 확인하세요.(아이디는 4~20자 이내로 입력)");
			myForm.mid.focus();
			return false;
		}
  		
  		$.ajax({
  			type: "post",
  			url : "${ctp}/member/memIdCheck",
  			data : {mid : mid},
  			success : function(res) {
				if(res == "1") {
					alert("이미 사용중인 아이디 입니다.");
					$("#mid").val();
					$("#mid").focus();
				}
				else {
					alert("사용 가능한 아이디 입니다.");
	  				idCheckSw = 1;
				}
			},
			error : function () {
				alert("전송오류.");
			}
  		});
	}
  	
  	//닉네임 중복체크
  	function nickCheck() {
  		let nickName = $("#nickName").val();
		
  		if(nickName == "" || $("#nickName").val().length < 2 || $("#nickName").val().length >= 20) {
			alert("닉네임를 확인하세요.(닉네임은 2~20자 이내로 입력)");
			myForm.nickName.focus();
			return false;
		}
  		
  		$.ajax({
  			type: "post",
  			url : "${ctp}/member/nickNameCheck",
  			data : {nickName : nickName},
  			success : function(res) {
				if(res == "1") {
					alert("이미 사용중인 닉네임 입니다.");
					$("#nickName").focus();
				}
				else {
					alert("사용 가능한 닉네임 입니다.");
					nickCheckSw = 1;
				}
			},
			error : function () {
				alert("전송오류.");
			}
  		});
	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<div class="container" style="padding:30px">
  <form name="myForm" method="post" class="was-validated" enctype="multipart/form-data">
    <h2 class="text-center">회 원 가 입</h2>
    <br/>
    <div class="form-group">
      <label for="mid">아이디 : &nbsp; &nbsp;</label>
      <div class="input-group mb-3">
	      <input type="text" class="form-control" id="mid" placeholder="아이디를 입력하세요." name="mid" required autofocus/>
	      <div class="input-group-append">
	      	<input type="button" value="아이디 중복체크" class="btn btn-success" onclick="idCheck()"/>
	      </div>
		  <div class="invalid-feedback">회원 아이디는 필수 입력사항입니다. <br> '영문 소문자'와 '숫자', '언더바(_)'만 사용가능합니다.(길이는 4~20자리까지 허용) </div>
      </div>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 :</label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
      <div class="invalid-feedback">비밀번호는 필수 입력사항입니다. 
      <!-- <br> 1개이상의 '문자'와 '특수문자' 조합의 6~24 자리로 작성하세요.  -->
      </div>
    </div>
    <div class="form-group">
      <label for="nickname">닉네임 : &nbsp; &nbsp;</label>
      <div class="input-group mb-3">
	      <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" required />
	      <div class="input-group-append">
	      	<input type="button" value="닉네임 중복체크" class="btn btn-success" onclick="nickCheck()"/>
	      </div>
	      <div class="invalid-feedback">닉네임은 필수 입력사항입니다. <br> '한글'로만 작성하세요. </div>
      </div>
    </div>
    <div class="form-group">
      <label for="name">성명 :</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
      <div class="invalid-feedback">성명은 필수 입력사항입니다. <br> '한글'과 '영문 대소문자'로만 작성하세요. </div>
    </div>
    <div class="form-group">
      <label for="email">Email address:</label>
		<div class="input-group mb-3">
		  <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
		  <div class="input-group-append">
		    <select name="email2" class="custom-select">
			    <option value="naver.com" selected>naver.com</option>
			    <option value="hanmail.net">hanmail.net</option>
			    <option value="hotmail.com">hotmail.com</option>
			    <option value="gmail.com">gmail.com</option>
			    <option value="nate.com">nate.com</option>
			    <option value="yahoo.com">yahoo.com</option>
			  </select>
		  </div>
		  <div class="invalid-feedback">이메일은 필수 입력사항입니다. </div>
		</div>
	</div>
	<br>
	<p><b>*선택 입력사항*</b></p>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="여자">여자
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <c:set var="now" value="<%=new java.util.Date()%>"></c:set>
      <fmt:formatDate var="birthday" value="${now}" pattern="yyyy-MM-dd"/>
	  <input type="date" name="birthday" class="form-control" value="${birthday}"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
			      <select name="tel1" class="custom-select">
					    <option value="010" selected>010</option>
					    <option value="02">서울</option>
					    <option value="031">경기</option>
					    <option value="032">인천</option>
					    <option value="041">충남</option>
					    <option value="042">대전</option>
					    <option value="043">충북</option>
			        <option value="051">부산</option>
			        <option value="052">울산</option>
			        <option value="061">전북</option>
			        <option value="062">광주</option>
					  </select>-
	      </div>
	      <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>-
	      <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
	    </div> 
    </div>
    <div class="form-group">
      <label for="address">주소</label><br>
			<div class="input-group mb-1">
				<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
				<div class="input-group-append">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-success">
				</div>
			</div>
			<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
			<div class="input-group mb-1">
				<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
				<div class="input-group-append">
					<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
				</div>
			</div>
    </div>
    <div class="form-group">
	    <label for="homepage">Homepage address:</label>
	    <input type="text" class="form-control" name="homePage" value="http://" placeholder="홈페이지를 입력하세요." id="homePage"/>
	  </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <option>학생</option>
        <option>회사원</option>
        <option>공무원</option>
        <option>군인</option>
        <option>의사</option>
        <option>법조인</option>
        <option>세무인</option>
        <option>자영업</option>
        <option>기타</option>
      </select>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">취미</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요."></textarea>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp; 
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="공개" checked/>공개
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="비공개"/>비공개
			  </label>
			</div>
    </div>
    <div  class="form-group">
      회원 사진(파일용량:2MByte이내) :
      <input type="file" name="fName" id="file" class="form-control-file border"/>
    </div>
    <button type="button" class="btn btn-primary" onclick="fCheck()">회원가입</button>
    <button type="reset" class="btn btn-secondary">다시작성</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/member/memLogin';">돌아가기</button>
  	<input type="hidden" name="photo"/>
  	<input type="hidden" name="address"/>
  	<input type="hidden" name="email"/>
  	<input type="hidden" name="tel"/>
  </form>
  <p><br/></p>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>