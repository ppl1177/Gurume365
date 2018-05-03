<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.String.*,java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<c:url value="/resources/css/recentReview.css"/>">
<script type="text/javascript">
$(function(){
	
	//시작
	$('#recentReview')
		.ready(
				function() {
					$.ajax({
						url : "recentReview",
								type : "POST",
								dataType : "json",
								cache : false,
								success : function(data) {
									
							$.each(data.reviewList,function(i, list) {
												var companyName = list.companyName;
												var origin = list.originalfile;
												var saved = list.savedfile;
												var reviewText = list.reviewText;
												var signal = "%(&*%";
												var savedData = saved.split(signal);
												var originData = origin.split(signal);
												var id = list.id;
												var starScore = list.starScore;
												if (starScore == "0") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_0.png"/>" height="20px"width="60px">';
												} else if (starScore == "1") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_1.png"/>" height="20px"width="60px">';
												} else if (starScore == "2") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_2.png"/>" height="20px"width="60px">';
												} else if (starScore == "3") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_3.png"/>" height="20px"width="60px">';
												} else if (starScore == "4") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_4.png"/>" height="20px"width="60px">';
												} else if (starScore == "5") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_5.png"/>" height="20px"width="60px">';
												}
												var html = '<div class="reviewList"><div class="storePic"><img src="../review/download?origin='+originData[1]+'&saved='+savedData[1]+'"  style="width:50px; height:60px; class="shopImg"></div>'
												+ '<div class="storeName"><a>'+companyName+'</a><br></div>'
												+ '<div class="userId"><a>작성자 : '+id+'</a></div>'
												+ '<div class="star">'+star+'</div></div>';
										$('#recentReviewInput').append(html);
									})
									

							},
							error : function() {
							}

						})
					
				});
	
	//끝
});

</script>
	</head>
	<body>
		<!-- 여기에 데이터 뽑아내면 됨 -->
		<p id="recentReview">최근 작성된 리뷰</p>
			<div class="" id="recentReviewInput">
		</div>
								
		
		
		
		
		
	</body>
</html>