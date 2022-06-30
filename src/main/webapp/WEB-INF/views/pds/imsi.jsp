<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!doctype html>
<html lang="kr">
<head>
  <meta charset="utf-8">
  <title>demo</title>
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
  <script>
    $(document).ready( function() {
 
        $("input[type=file]").change(function () {
            
            var fileInput = document.getElementById("contract_file");
            
            var files = fileInput.files;
            var file;
            
            for (var i = 0; i < files.length; i++) {
                
                file = files[i];
 
                alert(file.name);
            }
            
        });
 
    });
     
  </script>
</head>
<body>
    <input type="file" id="contract_file" multiple>
</body>
</html>
