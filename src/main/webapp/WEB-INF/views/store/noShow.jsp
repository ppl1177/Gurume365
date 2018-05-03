<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@ include file="/WEB-INF/views/banner/banner.jsp" %>

<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<c:url value="/resources/css/noShow.css"/>">
		<title>GURUME365-NoShow</title>
	</head>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">
	
	<script type="text/javascript">
		$(document).on(function(){
			
		})
	
		function pagingFormSubmit(currentPage) {
		var form = document.getElementById("pagingForm");
		var page = document.getElementById("page");
		page.value = currentPage;
		
		form.submit();
		}
	</script>
	<script type="text/javascript">
	
	</script>
	
	<body>
		<div class="img">
			<div class="innerImg">
				<img src="<c:url value="/resources/img/reservation.jpeg"/>">
				<div class="overlay"></div>
			</div>
			<div class="upperImg">
				<div class="content">
					<p>NoSHOW 특가가격으로 바로 예약하세요</p>
					<p>당신의 지갑을 응원합니다!</p>
					<p></p>
				</div>
			</div>
		</div>
		<div class="MainDiv">
		<!-- 천체DIV -->
				<!-- 로컬DIV -->
				<nav class="middleInfo">
    				<ul class="midUl">
    					<li class="midLi" style="border-top: 2px solid #DC143C;"><a href="">서울</a></li>
    					<li class="midLi"><a href="">부산</a></li>
    					<li class="midLi"><a href="">제주</a></li>
    					<li class="midLi"><a href="">대구</a></li>
	    				<li class="midLi"><a href="">대전</a></li>
    					<li class="midLi"><a href="">인천</a></li>
    					<li class="midLi"><a href="">전주</a></li>
    					<li class="midLi"><a href="">광주</a></li>
    				</ul>
    			</nav>
    			<!-- 로컬DIV -->
			<!-- 총 16개 게시물 -->
			<div class="infoTable">
					<p class="noShowListTitle">No SHOW 바로 예약하기</p>
					
					<c:forEach var="list" items="${list}" varStatus="status">
					<div class="infoDiv" style="border-top: 1px solid #c8c8c8;">
						<div class="infoPic">
							<img src="<c:url value="/resources/img/${list.savedfile}"/>">
							<div class="imgCover">
							</div>
						</div>
						<div class="infoStoreText">
							<p class="storeTitle">${list.companyName}</p>
							<div class="storePrice">
								<span class="motoPrice">${list.budjet}원</span><span class="waribikiPrice">-><fmt:formatNumber value="${list.budjet*0.9}" type="number"/>원</span>
							</div>
						</div>
						<div class="pay">
							<!-- storeList 참조 -->
							<a href="../reservation/noshowPermit?seq_res=${list2[status.index].seqRes}&budjet=${list.budjet}" rel="modal:open" class="kakaoModal"><img src="<c:url value="/resources/img/kakaoPay.PNG"/>"></a>
							<script type="text/javascript" charset="utf-8">
      							$(function() {
         							$(document).on($.modal.OPEN, function() {
            						$('.modal').addClass('modal_open');
         							});
      							})
   							</script>
						</div>
					</div>
				</c:forEach>
				<br><br><br><br><br><br>
				
				<div id="searchTestNav">
					<a href="javascript:pagingFormSubmit(${navi.currentPage-5})">◁◁</a>
					<a href="javascript:pagingFormSubmit(${navi.currentPage-1})">◀</a>
						<c:forEach begin="${navi.startPageGroup}" end="${navi.endPageGroup}" var="counter">
							<c:if test="${counter == navi.currentPage}">
								<b>
							</c:if>
								<a href="javascript:pagingFormSubmit(${counter})">${counter}</a>
							<c:if test="${counter == navi.currentPage}">
								</b>
							</c:if>
						</c:forEach>
					<a href="javascript:pagingFormSubmit(${navi.currentPage+1})">▶</a>
					<a href="javascript:pagingFormSubmit(${navi.currentPage+5})">▷▷</a>
				</div>
				<form action="noShowInfo" method="get" id="pagingForm">
					<input type="hidden" name="page" id="page">
				</form>	
				
			</div>
			<div class="rightTable" align="center">
				<div class="eventCouponTitle">
					<p>금주의 이벤트 & 쿠폰</p>
				</div>
				<div class="blank"></div>
				<div class="locationDiv">
					<a href=""><img class="locationInnerImg" src="<c:url value="/resources/img/event1.jpg"/>"></a>
					<div class="cover">
						<span>금주의 이벤트</span>
					</div>
				</div>
				<div class="blank"></div>
				<div class="couponDiv">
					<a href=""><img class="couponInnerImg" src="<c:url value="/resources/img/coupon.png"/>"></a>
				</div>
			</div>
			<!-- 천체DIV 끝-->
		</div>
		
		<footer>
    	<div class="innerFooter">
    		<div class="innerTitle">
    			<span>GURUME365</span>
    		</div>
    		<br>
    		<div class="innerContent">
    			<span>사업자는 노쇼를 줄이고</span><br>
				<span>손님은 더 저렴하게 예약할수 있습니다.</span><br>
				<span>당신의 방문을 환영합니다.</span><br><br><br>
				<span>© GURUME365. All rights reserved.</span>
    		</div>
    		
    	</div>
   	 </footer>
		
		
		
	<a rel="modal:open" id="ff"></a>
	</body>
</html>