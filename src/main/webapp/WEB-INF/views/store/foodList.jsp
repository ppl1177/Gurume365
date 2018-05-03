
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/banner/banner.jsp"%>

<html>
<head>
<title>GURUME365</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<c:url value="/resources/css/store.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/main.css"/>">
</head>
<body>
	<!-- Header -->
	<header class=" restImg ">
		<img src="<c:url value="/resources/img/hiber.PNG"/>" alt="Avatar" height="550px" style="width: 100%;">	
	</header>	
	<!-- First Grid -->
	<div class="w3-row-padding w3-padding-16 w3-container">
		<p class="w3-xlarge w3-container w3-center">최고의 레스토랑을</p>
		<p class="w3-xlarge w3-container w3-center">음식별로 쉽게 찾아보세요!</p>
		<div class="w3-content">
			<div class="w3-center image">
				<a href="foodList?food='한식'"><img
					src="<c:url value="/resources/img/korfood.PNG"/>" alt="Avatar"
					height="400px"
					style="width: 30%; padding-right: 5px; padding-left: 20px;">
				</a> <a href="foodList?food='일식'"> <img
					src="<c:url value="/resources/img/jafood.PNG"/>" alt="Avatar"
					height="400px" style="width: 30%; padding-right: 5px;">
				</a> <a href="foodList?food='중식'"><img
					src="<c:url value="/resources/img/chifood.PNG"/>" alt=""
					height="400px" style="width: 30%; padding-right: 5px;"> </a> 
				<br>
				<br>
				<br>
				<br>
				<br> 
				<a href="foodList?food='양식'"><img
					src="<c:url value="/resources/img/wesfood.PNG"/>" alt="Avatar"
					height="400px"
					style="width: 30%; padding-right: 5px; padding-left: 20px;">
				</a> <a href="foodList?food='디저트'"><img
					src="<c:url value="/resources/img/cafefood.PNG"/>" alt="Avatar"
					height="400px" style="width: 30%; padding-right: 5px;">
				</a> <a href="foodList?food='뷔페'"><img
					src="<c:url value="/resources/img/asiafood.PNG"/>" alt=""
					height="400px" style="width: 30%; padding-right: 5px;"> </a>
				<br>
				<br>
				<br>
				<br>
				<br>

			</div>
		</div>
	</div>
	<!-- Second Grid -->

	
	<!-- Footer -->
	

</body>
</html>