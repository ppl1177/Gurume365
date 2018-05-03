<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@ include file="/WEB-INF/views/banner/banner.jsp" %>

<html>
<title>GURUME365-MyPage</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="<c:url value="/resources/css/myReservation.css"/>">
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/sockjs-0.3.4.js"/>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">
<link rel="stylesheet" href="<c:url value="/resources/css/joinInfoPage.css"/>">


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
	$.ajax({
		url: '/gurume365/review/getMyReview',
		type: 'get',
		dataType: 'json',
		 success: function(dat) {
			 console.log(dat);
			 $.ajax({
			      url: '/gurume365/review/getMyReview',
			      type: 'get',
			      dataType: 'json',
			      success: function(dat) {
			          var cnt = 0;
			         for(var d of dat) {
			            ++cnt
			            console.log(d);
			            var inputdate = (d.reviewInfo.inputdate).split(' ');
			            console.log('안녕123' + inputdate);
			            var html = '<tr id="reviewRow' +d.replyNo+ '" class="revRow">' +
			                        '<td><a href="../store/shopInfo?shopNo=' +d.reviewInfo.shopNo+ '">' +d.companyName  + '</a></td>' +
			                        '<td>' +d.reviewInfo.starScore+ '</td>'+
			                        '<td>' +d.reviewInfo.reviewText+ '</td>'+
			                        '<td>' +inputdate[0]+ '</td>'+
			                     '</tr>';
			            $('#listBody').append(html);
			            if(cnt%2==1) {
			               $('#reviewRow' + d.replyNo).css('background-color', '#ffffff');
			            }
			            else {
			               $('#reviewRow' + d.replyNo).css('background-color', '#e0e0e0');
			            }
			          
			         } 
			        
			      },
			      error: function(err) {
			         console.log(err);
			      }
			   }); 
		 },
			 error: function(err) {
	         console.log(err);
	      }
		 
	   });
	
});	
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GURUME365-MyPage</title>
</head>
<body>

<sec:authentication var="user" property="principal" />
	<div class="img">
		<div class="innerImg">
			<img src="<c:url value="/resources/img/back3.jpg"/>">
			<div class="overlay"></div>
		</div>
	</div>
	<div class="upperImg">
        <div class="content">
        	<div class="titleTitle">
        		<span>${store.companyName}</span>
        	</div>
        	<div class="titleRoot">
        		<p>${user.id}님의 정보</p>
        	</div>
        	<div class="titleState">
  
        	</div>
		</div>
		<div class="content2">  	
        	<div class="titleContent">
         		<table>
         			<tr>
         				<td>이름</td>
         				<td><p>${user.name}</p></td>
         			</tr>
         			<tr>
         				<td class="jump">전화번호</td>
         				<td class="jump"><p>${user.phone}</p></td>
         			</tr>
         			<tr>
         				<td class="jump">사용자 분류</td>
         				<td class="jump">
         				<c:choose>
         					<c:when test="${user.division==1}">
         					<p>사업자입니다.</p>
         					</c:when>
         					<c:when test="${user.division!=0}">
         					<p>일반 유저입니다.</p>	
         					</c:when>
         				</c:choose>
         				</td>
         			</tr>
         		</table>
         	</div>
        </div>
        
        
        <div class="img-cover"></div>
    </div>
    
    <div class="mainInfo" align="right">
    	
    	<div class="left">
    		<nav class="middleInfo">
    			<ul class="midUl" style="left: -40px !important;">
    				<sec:authorize access="!hasRole('ROLE_AUTH_USER')">
						<li class="midLi"><a href="joinPermitComplement">본인 인증</a></li>
    				</sec:authorize>
    				<sec:authorize access="hasRole('ROLE_AUTH_USER')">
	    				<li class="midLi"><a href="myReservation">내 예약</a></li>
	    				<li class="midLi"><a href="myReview">내 리뷰</a></li>
	    			</sec:authorize>
    				<li class="midLi"><a href="userMyPage">정보 수정</a></li>
    				<li class="midLi"><a href="withdrawPage">회원 탈퇴</a></li>
    			</ul>
    		</nav>
    		<div class="middleRight" align="center">
    			<div class="innerTitle" style="background-color:#DC143C; margin-top: 0; padding-top: 10px; ">
    			<h2 style="color: white; position: relative; bottom: 15px;">내 리뷰</h2>
    			</div>
    			<table cellspacing="0" cellpadding="0" style="width: 100%; padding-left: 10px; padding-right: 10px;">
    				<tbody id="listBody">
    				
	    				<tr>
	    					<th>
	    						가게 이름
	    					</th>
	    					<th>
	    						별점
	    					</th>
	    					<th>
	    						리뷰 내용
	    					</th>
	    					<th>
	    						날짜
	    					</th>
	    					
	    				</tr>
	    				
    				</tbody>
    			</table>
    			
    			
    		</div>
    	</div>
    	
    	<div class="middle">
    		<div class="setButton" align="center">
    			<input type="button" value="리뷰 남기러 가기" class="reviewBtn">
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
  
	<input type="hidden" id="companyName" value="${store.companyName}">
	<input type="hidden" id="loginId" value="${loginId}">
	<input type="hidden" id="ownerId" value="${store.id}">
	<!-- 가게로 접속하면서 값 넘기기 -->

</body>
</html>