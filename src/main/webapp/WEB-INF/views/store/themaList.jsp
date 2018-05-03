	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/banner/banner.jsp" %>

<html>
<head>
	<title>GURUME365</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="<c:url value="/resources/css/store.css"/>">
</head>
<body>
	<!-- Header -->
	<header class="w3-container restImg w3-center" style="padding: 80px;">
		<h1 class="w3-margin w3-jumbo storeTitle">GURUME 35</h1>
	</header>
	
	<!-- First Grid -->
	<div class="w3-row-padding w3-padding-32 w3-container">
		<p class="w3-xlarge w3-container w3-center">최고의 레스토랑을</p>
		<p class="w3-xlarge w3-container w3-center">테마별로 쉽게 찾아보세요!</p>
		<div class="w3-content">
			<div class="w3-center image">
			
				<a href="thema?selector=noshow"><img
					src="<c:url value="/resources/img/noshow.png"/>" alt="Avatar"
					 height="150px"
					style=" width: 30%; padding-right:5px; padding-left:20px;">
				</a> 
				
				<a href="thema?selector=food"> <img src="<c:url value="/resources/img/res.png"/>"
					alt="Avatar"  height="150px"
					style=" width: 30%; padding-right: 5px;">
				</a> 
				
				<a href="thema?selector=thema" ><img
					src="<c:url value="/resources/img/theme.png"/>" alt=""
					 height="150px"
					style="width: 30%; padding-right: 5px;"> 
				</a>
				<br><br><br><br><br><br><br><br>
				<br><br><br><br><br><br><br>

			</div>
		</div>
	</div>
	<!-- Second Grid -->
	
	<div class="w3-container w3-black w3-center w3-opacity w3-padding-64">
		<h1 class="w3-margin w3-xlarge">Quote of the day: live life</h1>
	</div>
	<!-- Footer -->
	<footer class="w3-container w3-padding-64 w3-center w3-opacity">
	
		
	</footer>
	
</body>
</html>