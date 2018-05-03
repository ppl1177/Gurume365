<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@ include file="/WEB-INF/views/banner/banner.jsp" %>


<html>
<title>GURUME365-StoreInfo</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<c:url value="/resources/css/store.css"/>">
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/sockjs-0.3.4.js"/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">
<link rel="stylesheet" href="<c:url value="/resources/css/recentReview.css"/>">


<style>
.locker {
	position: fixed;
    right: 0;
    bottom: 0;
    width: 320px;
    height: 380px;
    overflow: auto;
    z-index: 1;
    padding: 20px;
    box-sizing: border-box;
    text-align: center;
}
.modals{
	display: none;
    vertical-align: middle;
    position: relative;
    z-index: 2;
    max-width: 500px;
    box-sizing: border-box;
    width: 90%;
    background: #fff;
}
.close{

 	  text-decoration: none;
      font-size:1.2rem;
      color:white;
      display:inline-block;
      background-color: #483D8B;
	  width: 100%;
	  
}
}
</style>

<script type="text/javascript">
$(function() {
	var ownerCheck='<c:if test="${loginId == store.id}">당신은 오너입니다.</c:if>';
	var ownerCheckFail='<c:if test="${loginId != store.id}">당신은 오너가 아닙니다.</c:if>';

	$(document).on($.modal.OPEN, function(){
		$('.blocker').attr('class','locker');
		$('#chat').attr('style','display:none');
		$('.modal').attr('class','modals');
		$('.close-modal').attr('class','close');
		$('#goCompanyName').text($('#companyName').val());
		$('#comName').text(${store.companyName});
		$('#goLoginId').text(${loginId});
		$('#goOwnerId').text(${store.id});
		});
	
	$(document).on($.modal.CLOSE, function (){
		$('#chat').css('display','');
		location.reload();
	});
	
});
</script>
<body>
	<div class="img">
		<div class="innerImg">
			<img src="<c:url value="/resources/img/sample1.jpg"/>">
			<div class="overlay"></div>
		</div>
	</div>
	<div class="upperImg">
        <div class="content">
        	<div class="titleTitle">
        		<span>${store.companyName}</span>
        	</div>
        	<div class="titleRoot">
        		광복동/구이/한식
        	</div>
        	<div class="titleState">
        		리뷰 3건/조회 ${store.hits}건
        	</div>
		</div>
		<div class="content2">  	
        	<div class="titleContent">
         		<table>
         			<tr>
         				<td>별점</td>
         				<c:choose>
         					<c:when test="${store.grade==null}"><td>☆☆☆☆☆ 0점</td></c:when>
         					<c:when test="${store.grade==1}"><td>★☆☆☆☆ 1.0점</td></c:when>
         					<c:when test="${store.grade==2}"><td>★★☆☆☆ 2.0점</td></c:when>
         					<c:when test="${store.grade==3}"><td>★★★☆☆ 3.0점</td></c:when>
         					<c:when test="${store.grade==4}"><td>★★★★☆ 4.0점</td></c:when>
         					<c:when test="${store.grade==5}"><td>★★★★★ 5.0점</td></c:when>
         				</c:choose>
         			</tr>
         			<tr>
         				<td class="jump">전화번호</td>
         				<td class="jump">${store.phone}</td>
         			</tr>
         			<tr>
         				<td class="jump">주소</td>
         				<td class="jump">${store.address1} ${store.address2}</td>
         			</tr>
         			<tr>
         				<td class="jump">영업시간</td>
         				<td class="jump">${store.timeOfOpen}~</td>
         			</tr>
         			<tr>
         				<td class="jump">휴무일</td>
         				<td class="jump">${store.holiday}</td>
         			</tr>
         		</table>
         	</div>
        </div>
        <div class="content3">
        	<div class="titleRecentReviewTitle">
        		가장 최근 리뷰
        	</div>
        	<div class="titleRecentReview">
        		<div class="reviewImg">
        			<img src="<c:url value="/resources/img/1.jpg"/>">
        		</div>
        		<div class="reviewId">
        			${review.id} 유저님
        		</div>
        		<div class ="reviewContent">
        			${review.reviewText}
        		</div>
        	</div>
        </div>
        <div class="slideImg">
        	<div class="slide">
        		<jsp:include page="../banner/slideImg.jsp"/>
        	</div>
        </div>
        <div class="img-cover"></div>
    </div>
    
    <div class="mainInfo" align="right">
    	
    	<div class="left">
    		<nav class="middleInfo">
    			<ul class="midUl">
    				<li class="midLi"><a href="<c:url value="/store/shopInfo?shopNo=${store.shopNo}"/>">정보</a></li>
    				<li class="midLi"><a href="<c:url value="/store/shopReview?shopNo=${store.shopNo}"/>">리뷰</a></li>
    				<li class="midLi"><a href="<c:url value="/store/shopImg?shopNo=${store.shopNo}"/>">사진</a></li>
    				<li class="midLi"><a href="<c:url value="/store/shopMenu?shopNo=${store.shopNo}"/>">메뉴</a></li>
    			</ul>
    		</nav>
    		<div class="middleRight">
    			<div class="menuImg">
    				<img id="menuImgImg" src="<c:url value="/resources/img/g_menu.jpg"/>">
    			</div>
    			
    		</div>
    	</div>
    	
    	<div class="middle">
    		<div class="setButton" align="center">
    			<a href="<c:url value="/store/shopReview?shopNo=${store.shopNo}"/>"><input type="button" value="리뷰 남기러 가기" class="reviewBtn"></a>
    		</div>
    		<div class="editerSusume" align="center">
    			<div class="innerSusume">
    				<div class="susumeTitle">
    					<div class="reviewList">
    					<div class="includeReview">
    						<jsp:include page="../banner/recentReview.jsp"/>
    					</div>
    					</div>
    				</div>
    				
    			</div>
    		</div>
    	</div>
    	<div class="right" id="googleMap"></div>
    	<script>
      function initMap() {
       var center= new google.maps.LatLng(37.250943, 127.028344);
        var map = new google.maps.Map(document.getElementById('googleMap'), {
          zoom: 16,
          center: center
        });
        var geocoder = new google.maps.Geocoder();

          geocodeAddress(geocoder, map);
        
      }

      function geocodeAddress(geocoder, resultsMap) {
    	  var add = $('#companyName').attr('geo');
        geocoder.geocode({'address': add}, function(results, status) {
          if (status === 'OK') {
            resultsMap.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
              map: resultsMap,
              position: results[0].geometry.location,
              animation:google.maps.Animation.BOUNCE
            });
          } else {
            alert('정보가 없습니다.');
          }
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAD_AQLECL4Gnp6L3gYZzFz8litKmsVZt8&callback=initMap">
    </script>
    	
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
  
	<input type="hidden" id="companyName" value="${store.companyName}" geo="${store.address1}">
	<input type="hidden" id="loginId" value="${loginId}">
	<input type="hidden" id="ownerId" value="${store.id}">
	<!-- 가게로 접속하면서 값 넘기기 -->
	<div class="navbar">
		<a id="chat" rel="modal:open" 
		href="../chat/multiChatRoom?roomName=${store.shopNo}" 
		class="chatBtn">
			Restaurant Chat
		</a>
	</div>
</body>
</html>