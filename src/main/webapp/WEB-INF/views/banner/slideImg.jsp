<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<c:url value="/resources/css/slideImg.css"/>">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  	<script src="<c:url value="/resources/js/jquery.slides.min.js"/>"></script>
	<script type="text/javascript">
	$(function(){
	      $("#slides").slidesjs({
	        width: 300,
	        height: 200
	      });
	    });
	</script>
	<body>
		<div id="slides">
    		<img src="<c:url value="/resources/img/g1.jpg"/>">
    		<img src="<c:url value="/resources/img/g2.jpg"/>">
    		<img src="<c:url value="/resources/img/g3.jpg"/>">
    		<img src="<c:url value="/resources/img/g4.jpg"/>">
    		<img src="<c:url value="/resources/img/g5.jpg"/>">
  		</div>
	</body>
</html>