<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="<c:url value='/resources/js/jquery-3.2.1.js' />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/jquery-ui.js"/>"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"  
	href="<c:url value="/resources/css/banner.css"/>">
<script type="text/javascript">
$(function(){
	$(".select3").on('keyup', function(event) {
		var keycode = event.keyCode;
		var text = $('.select3').val();
		//백스페이스가 들어갈 때 ajax값을 불러오기 때문에 백스페이스 키 값인 8을 눌렀을 때,
		//ajax를 실행 안 하게 막아 놓았습니다.
		if (keycode != 8) {
			$.ajax({
				url : "../review/search",
				type : "GET",
				data : {
					text : text
				},
				dataType : "json",
				success : function(data) {
					//셀렉트한 값이 널이 아닐 경우 화면에 그 리스트를 넣어준다.			
					var availableTags = [];
					var map = new Map();
					$.each(data, function(index, item) {
						//해당 객체의 이름들이 다 담겨있다.
						availableTags.push(item.companyName);
						map.set(item.shopNo, item.companyName);
					});
					$(".select3").autocomplete({
						source : availableTags
					});
					
					$('.serchBtn').click(function(){
						$.each(data, function(index, item) {
							if($('.select3').val()==item.companyName){
								location.href="../store/shopInfo?shopNo="+item.shopNo;
							}
						});
					})
				},
				error : function() {
					alert("실패");
				}
			});
			}}
	);
	
})



</script>
	

	</head>
	<body>
		<header>
			<div class="headerTop">
				<div class="logoImg">
					<a href="../"><img src="<c:url value="/resources/img/Logo_1.jpg"/>"></a>
				</div>
				<div class="topSerch">
					<!-- <select class="select1">
						<option value="" selected="selected" style="size: 7;">지역</option>
						<option value="서울" class="seoul">서울(Seoul)</option>
						<option value="부산" class="busan">부산(Busan)</option>
						<option value="제주" class="jeju">제주(Jeju)</option>
						<option value="대구" class="deagu">대구(Daegu)</option>
						<option value="대전" class="daejeon">대전(Daejeon)</option>
						<option value="인천" class="inchon">인천(Inchon)</option>
						<option value="전주" class="jeonju">전주(Jeonju)</option>
						<option value="광주" class="gwangju">광주(Gwangju)</option>
					</select>
					<select class="select2">
						<option value="" selected="selected" style="size: 6;">음식종류</option>
						<option value="한식">한식</option>
						<option value="일식">일식</option>
						<option value="중식">중식</option>
						<option value="양식">양식</option>
						<option value="카페/베이커리">카페/베이커리</option>
						<option value="아시아식">아시아식</option>
					</select> -->
					<input type="text" class="select3" placeholder="가게명을 입력하세요">
					<button class="serchBtn" onclick="serchBtn()">검색</button>
				</div>
				<div class="headerTopRight">
					<sec:authorize access="isAuthenticated()">
						<a href="../join/userMyPage">내정보확인</a>
						<a href="/gurume365/logout">로그아웃</a>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
						<a href="<c:url value="/login/loginForm"/>" rel="modal:open" id="loginTest">로그인</a>
						<a href="<c:url value="/join/joinPermitBanner" />" rel="modal:open">회원가입</a>
					</sec:authorize>
					
				</div>
			</div>
			<div class="topnav">
  				<a href="../">메인페이지</a>
  				<a href="../event/eventInfo">이벤트</a>
  				<a href="../noShow/noShowInfo">NOSHOW 특가</a>
  				<a href="<c:url value="/review/review"/>">리뷰</a>
			</div>
		</header>
	
		<a rel="modal:open" style="display: none;" id="hiddenModal"></a>
	</body>
</html>