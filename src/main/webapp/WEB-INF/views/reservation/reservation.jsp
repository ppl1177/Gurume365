<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value='/resources/js/jquery-3.2.1.js' />"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<link href="<c:url value='/resources/css/jquery.datetimepicker.css' />" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/css/reservation.css'/>">
<title>Insert title here</title>


</head>

<body>
<div>
	<div class="asdf" style="font-size:40px; color:#888; font-family:'Karla'; margin:0 auto; text-align:center;">예약</div>

	<input type="hidden" value="${shop_no}" id="shop_no" budjet="${budjet}">
	<div class="container">
		<input type="text" id="datetimepicker" readonly="readonly" placeholder="날짜 및 시간을 선택해 주세요." name="datetimepicker">
		인원
		<input type="button" class="mBtn" value="-" onclick="mBtn()">
		<input type="text" value="1" readonly="readonly" id="person" name="person">
		<input type="button" class="pBtn" value="+" onclick="pBtn()">
	</div>
	<div class="container">
		<textarea rows="7" cols="55" id="content" placeholder="남기고 싶은 말"></textarea>
	</div>
	<div id="modalDiv">
		<input type="button" id="ee" onclick="reservationTable()" value="예약하기">
		<a id="dd"></a>
	</div>
	<div class="warning">※테이블 당 예약금:<fmt:formatNumber value="${budjet*0.1}" type="number"/>원</div>	
</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="<c:url value='/resources/js/jquery.datetimepicker.full.js' />"></script>
	<script>
		$('#datetimepicker').datetimepicker({
			 minDate: 0
		});
		function mBtn(){
			var person = $('#person').val();			
			$('#person').attr('value',(person-1));
		}
		function pBtn(){
			var person = $('#person').val();
			$('#person').attr('value',(person-(-1)));
		}
		
		
		function reservationTable(){
			var shop_no = $('#shop_no').val();
			var datetime = $('#datetimepicker').val();
			var person = $('#person').val();			
			var content = $('#content').val();
			var budjet = $('#shop_no').attr('budjet');
			var minute = datetime.substring(14,16);
			if(minute != '00'){
				alert('예약 시간을 1시간 단위로 선택해주세요.');
				return false;
			}
			if(person <= 0){
				alert('이용 인원을 1명 이상 선택 해 주세요.');
				return false;
			}
			$('.close-modal ').get(0).click();
			$('#ff').attr('href','../reservation/floor?shop_no='+shop_no+'&budjet='+budjet+'&datetimepicker='+datetime+'&person='+person+'&content='+content+'');
			$('#ff').get(0).click();
		}
	</script>
				


</body>
</html>