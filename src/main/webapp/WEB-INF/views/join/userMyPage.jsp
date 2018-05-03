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
<link rel="stylesheet" href="<c:url value="/resources/css/userMyInfoPage.css"/>">
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


function update(){
	
	var pw=$('#password').val();
	var phone=$('#phone').val();
	var pswd = $('#ownerId').attr('pw');
	var password2=$('#password2').val();
	if(pw!=password2||pw!=""||pw==null){
		alert('비밀번호가 일치하지 않습니다.');
		return false;
	}
	
	$.ajax({
		url: 'updateUsers'
		,type: 'post'	
		,data: {
			pw: pw
			,phone: phone
		}
		,success: function(){
			alert('정보가 수정되었습니다.');
			location.reload();
		}
		,error: function(){
			alert('수정에 실패했습니다.');
		}		
	});		
} 
 
 function restrictUsers(){
	 
	 location.href="withdrawPage";
 }
</script>
<body>
<sec:authentication var="user" property="principal" />
	<div class="img">
		<div class="innerImg">
			<img src="<c:url value="/resources/img/back.jpg"/>">
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
    			<ul class="midUl" style="left: -40px !important; border:1px ;">
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
    		
    		<div class="innerTop" style="background-color:#DC143C; margin-top: 0; padding-top: 10px; ">
    		<h2 style="color: white; position: relative; bottom: 15px;">회원 정보</h2>
    		</div>
    			<div class="userInfoDiv">
			
					
					<div class="id" >
						이메일<input type="text" id="id" class="idbox" value="${id}" readonly="readonly">
					</div>
			
					<div class="password">
						비밀번호<input type="password" class="pwbox" id="password" value="" required="required"> 
					</div>
				
					<div class="password2">
						비밀번호 확인<input type="password" class="pwbox2" id="password2" required="required">
					</div>
				
					<div class="name">
						이름<input type="text" id="name" class="namebox" value="${name}" readonly="readonly">
					</div>
				
					<div class="birth">
						생년월일<input type="text" class="birthbox" id="date_of_birth" value="${birth}">
					</div>
				
					<div class="phone">
						전화번호<input type="text" id="phone" class="phonebox" value="${phone}">
					</div>
					
			<div><input type="button" class="updateButton" value="수정" onclick="update()"><input type="button" class="cancelButton" value="취소"></div>
				
			</div>
			
		
    			
    			<!-- <ul class="midUl" style="width: 530px;">
    				<li class="midLi" >
    					<div style="background-color: yellow; float: left; width:30%;">가게 이름</div>
    					<div style="background-color: green; float: left; width:30%;">예약 날짜</div>
    					<div style="background-color: blue; float: left; width:25%;">예약 시간</div>
    					<div style="background-color: red; float: left; width:15%">예약 인원</div>
    					
    				</li>
    			</ul> -->
    			<%-- <div class="storeInfo" align="center">
    				<p>가게소개</p>
    				<div class="storeInfoInner">
    					<p>${store.comment}</p>
    				</div>
    			</div>
    			<div class="storeInfo" align="center">
    				<p>음식점 종류</p>
    				<div class="storeInfoInner">
    					<p>구이 / 한식 / 소고기 / 구이요리</p>
    				</div>
    			</div>
    			<div class="storeInfo" align="center">
    				<p>테이블 정보</p>
    				<div class="storeInfoInner">
    					<input type="button" class="tableButton" value="가게 테이블 정보 확인" onclick="">
    				</div>
    			</div>
    			<div class="storeInfo" align="center">
    				<p>예약하러 가기!</p>
    				<div class="storeInfoInner">
    					<input type="button" class="tableButton2" value="RESERVATION" onclick="">
    				</div>
    			</div> --%>
    			
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
	<input type="hidden" id="ownerId" value="${store.id}" pw="${pw}">
	
	<!-- 가게로 접속하면서 값 넘기기 -->
</body>
</html>