	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/banner/banner.jsp" %>

<html>
<head>
<script type="text/javascript"
	src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
	
<script>
$(function(){
	
	//시작
	$('#bestReview')
		.ready(
				function() {
					$.ajax({
						url : "bestReview",
								type : "POST",
								dataType : "json",
								cache : false,
								success : function(data) {
									
							$.each(data.reviewList,function(i, list) {
												
												var origin = list.originalfile;
												var saved = list.savedfile;
												var reviewText = list.reviewText;
												var signal = "%(&*%";
												var savedData = saved.split(signal);
												var originData = origin.split(signal);
												var id = list.id;
												var starScore = list.starScore;
												if (starScore == "0") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_0.png"/>" height="25px"width="30%">';
												} else if (starScore == "1") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_1.png"/>" height="25px"width="30%">';
												} else if (starScore == "2") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_2.png"/>" height="25px"width="30%">';
												} else if (starScore == "3") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_3.png"/>" height="25px"width="30%">';
												} else if (starScore == "4") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_4.png"/>" height="25px"width="30%">';
												} else if (starScore == "5") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_5.png"/>" height="25px"width="30%">';
												}
												var html = '<div style="width: 31%; height:450px; border: 1px solid; float:left; margin-right: 20px;"><div style="heigth:35%; width:100%;">'
												+ '<img src="../review/download?origin='+originData[1]+'&saved='+savedData[1]+'" style="width:100px; height:100px;">'
												+ '</div><div style="heigth:20%; width:40%; padding-left:15px; padding-top:15px;">작성자 : '+list.id+'</div>'
												+ '<div style="heigth:20%; width:100%; padding-left:15px;">'
												+ '별점 : '+star+'</div>'	
												+ '<div style="heigth:25%; width:100%; padding-left:15px;margin-top:10px;">'+reviewText+'</div>'
												+ '<div style="float:right;">더보기</div></div>';
										$('#bestReviewInput').append(html);
									})

							},
							error : function() {
							}

						})
					
				});
	
	//끝
});
</script>	
	
	
	
	
	
	
	
	<title>GURUME365</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
		<link rel="stylesheet" href="<c:url value="/resources/css/main.css"/>">
</head>
<body>
	<!-- Header -->
	<header class=" restImg ">
		<img src="<c:url value="/resources/img/hiber.PNG"/>" alt="Avatar" height="550px" style="width: 100%;">	
	</header>	
	
	<!-- First Grid -->
	<div class="w3-row-padding w3-padding-32 w3-container">
		<p class="w3-xlarge w3-container w3-center">당신의 특별한 식사를 위해</p>
		<p class="w3-xlarge w3-container w3-center">저희가 준비했습니다</p>
		<div class="w3-content">
			<div class="w3-center image">
			
				<a href="../noShow/noShowInfo"><img
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
				<br><br><br><br><br><br>
			</div>
		<p class="w3-xlarge w3-container w3-center">GURUME365 사용자들의 생생한 후기</p>
		<p id="bestReview" class="w3-xlarge w3-container w3-center">베스트 리뷰</p>
		<div class="" id="bestReviewInput">
		<!-- 시작 -->
			<!-- 사진 들어가는 곳 -->
			
			
			<!-- 끝 -->
		</div>
		</div>
	</div>
	<!-- Second Grid -->
	<br><br><br><br><br><br><br><br><br><br><br><br><br>
	<footer>
    	<div class="innerFooter" style="color: white; padding-left: 30px;">
    		<br>
    		<div class="innerTitle">
    			<span style="font-size: 40px; font-weight: bold;">GURUME365</span>
    		</div>
    		<br>
    		<div class="innerContent">
    			<span style="font-size: 20px; ">사업자는 노쇼를 줄이고</span><br>
				<span style="font-size: 20px; ">손님은 더 저렴하게 예약할수 있습니다.</span><br>
				<span style="font-size: 20px; ">당신의 방문을 환영합니다.</span><br><br><br>
				<span style="font-size: 20px; ">© GURUME365. All rights reserved.</span>
    		</div>
    	</div>
    </footer>
	
	
</body>
</html>