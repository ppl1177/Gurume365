<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@ include file="/WEB-INF/views/banner/banner.jsp" %>

<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<c:url value="/resources/css/event.css"/>">
		<title>GURUME365-Event</title>
	</head>
	
	<body>
		<header>
			<div class="noShowTitle">
				<p align="center">미식의 시작, 프로모션</p>
			</div>
		</header>
		<div class="MainDiv">
		<!-- 천체DIV -->
			
			<div class="infoTable">
				
				<a href="event1">
					<img src="<c:url value="/resources/img/event1.PNG"/>" alt="Avatar"  height="500px"style=" width: 30%;margin-top: 50px; padding-left: 8%; padding-right: 70px;">
				</a>
				<a href="event2">
					<img src="<c:url value="/resources/img/event2.PNG"/>" alt="Avatar"  height="500px"style=" width: 30%;margin-top: 50px;  ">
				</a>
				<a href="event3">
					<img src="<c:url value="/resources/img/event3.PNG"/>" alt="Avatar"  height="500px"style=" width: 30%;padding-left:8%;margin-top: 70px;  padding-right: 70px;">
				</a>
				
					<img src="<c:url value="/resources/img/event4.PNG"/>" alt="Avatar"  height="500px"style=" width: 30%;margin-top: 70px; ">
					<img src="<c:url value="/resources/img/event5.PNG"/>" alt="Avatar"  height="500px"style=" width: 30%;padding-left:8%;margin-top: 70px;  padding-right: 70px;">
					<img src="<c:url value="/resources/img/event6.PNG"/>" alt="Avatar"  height="500px"style=" width: 30%;margin-top: 70px; ">
				
				</div>	
							
					
				<!--<c:forEach var="list" items="${list}" >
				</c:forEach>-->
			</div>
		
			<!-- 천체DIV 끝-->
		
		
		
	</body>
</html>