<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/banner/banner.jsp" %>

<html>
<title>GURUME365-StoreReview</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<c:url value="/resources/css/store.css"/>">
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/sockjs-0.3.4.js"/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="<c:url value="/resources/js/jquery-ui.js"/>"></script>

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






<script>
	var xhr = new XMLHttpRequest();
		
	function submitAction() {
		alert("서브밋 진입");
		var data = new FormData();
		var starValue = $("#starValue").val();
		var reviewText = $("#review").val();
		
		
		data.append("starValue", starValue);
		data.append("reviewText", reviewText);
		
		for (var i = 0, len = sel_files.length; i < len; i++) {
			var name = "image_" + i;
			data.append(name, sel_files[i]);
		}
		data.append("image_count", sel_files.length);

		//data = [object FormData]
		xhr.open("POST", "../review/submitAction2");

		xhr.onload = function(e) {

			if (this.status == 200) {
				
			}
		}
		xhr.send(data);
		alert("리뷰 등록이 완료되엇습니다.");
		
		//$("#reviewComplete").attr('href','reviewComplete?searchName='+searchName);
		$("#reviewUpload").css("visibility","hidden");
	}

	function deleteImageAction(index) {

		sel_files.splice(index, 1);

		var img_id = "#img_id" + index;

		$(img_id).remove();

	}

	$(function() {
		//별모양 바꾸기
		$("#starValue").on(
				'click',
				function() {
					var starValue = $("#starValue").val();
					$("#starPicture").attr("style","height:25px; weight:25px");
					if (starValue == "star_0") {
						$("#starPicture").attr("src",
								"<c:url value="/resources/img/star_0.png"/>");
						
					} else if (starValue == "star_1") {
						$("#starPicture").attr("src",
								"<c:url value="/resources/img/star_1.png"/>");
					} else if (starValue == "star_2") {
						$("#starPicture").attr("src",
								"<c:url value="/resources/img/star_2.png"/>");
					} else if (starValue == "star_3") {
						$("#starPicture").attr("src",
								"<c:url value="/resources/img/star_3.png"/>");
					} else if (starValue == "star_4") {
						$("#starPicture").attr("src",
								"<c:url value="/resources/img/star_4.png"/>");
					} else if (starValue == "star_5") {
						$("#starPicture").attr("src",
								"<c:url value="/resources/img/star_5.png"/>");
					}
				});
		//리뷰 쓰기
		$("#review")
				.on('click',function() {
							$("#review").attr( "rows", "5");
							$("#review").attr( "placeholder" , "매장에 대한 리뷰를 30자 이상 작성해주세요. 매장과 관계없는 글, 광고성, 욕성, 비방, 도배 등의 글은 예고 없이 삭제됩니다.");
						});

		$("#camera").on('click', function() {

			$("#input_img").trigger('click');
		});

		$(document).ready(function() {
			//인풋이미지에 변화가 있으면 함수 실행한다.
			$("#input_img").on("change", handleImgFileSelect);
		});
		function handleImgFileSelect(e) {
			//이미지 정보들을 초기화
			sel_files = [];
			$(".imgs_wrap").empty();
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);
			var index = 0;
			filesArr.forEach(function(f) {
						if (!f.type.match("image.*")) {
							return;
						}
						sel_files.push(f);
						var reader = new FileReader();
						reader.onload = function(e) {
							var html = "<a href='javascript:void(0);' onclick='deleteImageAction("
									+ index
									+ ")' id='img_id"
									+ index
									+ "'><img style='width:80px; height:80px' src='"+e.target.result+"' data-file='"+f.name+"'  title='Click to remove'></a>";

							$(".imgs_wrap").append(html);
							index++;
						}
						reader.readAsDataURL(f);
					});
		}
	});
</script>









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
    			<!-- 리뷰창 시작 -->
    			<div class="reviewFrame">
    			<div class="storeReviewSet">
    				<span>${store.companyName}에 리뷰를 남기세요!</span>
  					<input type="hidden" id="search">	  			
    			</div>
    			<div class="storeReviewStar">
    				등급을 선택하세요! 
						<select name='stars' id="starValue" >
							<option value="star_0">매우 불만족</option>
							<option value="star_1">불만족</option>
							<option value="star_2">보통</option>
							<option value="star_3">만족</option>
							<option selected value="star_4">매우 만족</option>
							<option value="star_5">최고에요!</option>
						</select>
					<img id="starPicture">
    			</div>
    			<div class="reviewContent">
    				<textarea cols="40" rows="3" id="review" placeholder=""></textarea>
    			</div>
    			<div class="picInsert">
    				<img id="camera" src="<c:url value="/resources/img/camera2.png"/>" height="50px" width="50px">
    				<span>사진 삭제는 클릭으로 가능합니다.</span>
    				<input type="file" id="input_img" multiple="multiple" />
    				
    				<div class="imgs_wrap">
						<img id="images" />
					</div>
					<a href="javascript:" class="uploadBtn" id="reviewUpload" onclick="submitAction()">업로드</a>
    			</div>
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