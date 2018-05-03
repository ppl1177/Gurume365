<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/css/joinForm.css'/>">
<script src="<c:url value='/resources/js/jquery-3.2.1.js' />">
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	// id 비교
	$('#email_id').on('blur',idCheck);
	$('email_domain').on('blur',idCheck);
	$('#email_select').change(idCheck);
	function idCheck(){
		// ajax로 아이디 체크
		var id = $('#email_id').val()+"@"+$('#email_domain').val();
		if($('#email_domain').val==""){
			$('#joinForm_idCheck').text("도메인을 선택해주세요");
		}
		/* $.ajax({
			url: 'idCheck'
			,type: 'post'
			,data: {
				id: id
			}
			,success: function(s){
				if(s=="Y"){
					$('#joinForm_idCheck').text("사용 가능");
				}else if(s=="N"){
					$('#joinForm_idCheck').text("중복");
				}
			}
			,error: function(err){
				console.log(err);
			}
		}); */
	}
	
	
	// 도메인 선택
	$('#email_select').change(function(){
		var joinForm_email_domain = $('#joinForm_email_domain');
		var email_select = $('#email_select').val();
		if(email_select == 0){
			joinForm_email_domain.html('@<input type="text" id="email_domain">');
		}
		else{
			joinForm_email_domain.html('@<input type="text" id="email_domain" value="'+email_select+'" readonly>');		
		}
		
	})
	
	
	
	// 비밀번호 비교
	$('#pw').on('keyup',pwCheck);	
	$('#pw').on('blur',pwCheck2);	
	$('#pw2').on('blur',pwCheck2);
	
		
	
	function pwCheck(){
			var length = $('#pw').val().length;
			$('#pw_cnt').css('color','black');
			if(length<8){
				$('#pw_cnt').text('('+length+') 8자 이상 써주십시오.');	
			}else
				$('#pw_cnt').text('good');
	}
	
	function pwCheck2(){
			var pw = $('#pw').val();
			var pw2 = $('#pw2').val();
			var length = $('#pw').val().length;
			
			if(pw!=pw2){
				$('#pw_cnt').text('비밀번호가 다릅니다.');
			}
			
			if(pw==pw2&&length>=8){
				$('#pw_cnt').text('사용가능');
		}
	}
})
$("input:radio[name=radio_name]:checked").val()

function join(){
	var id = $('#email_id').val()+"@"+$('#email_domain').val();
	var pw = $('#pw').val();
	var name = $('#name').val();
	var date_of_birth = $('#dateofbirth').val();
	var phone = $('#phone').val();
	var division = $('input:radio[name=division]:checked').val();
	
	$.ajax({
		url: 'join/insertUsers'
		,type: 'post'
		,data: {
			id: id
			,pw: pw
			,name: name
			,dateOfBirth: date_of_birth
			,phone: phone
			,division: division
		}
	
		,success: function(){
			alert('저장 완료');
			$('.close-modal').get(0).click();
			$('#ff').attr('href','join/joinComplement');
			$('#ff').get(0).click();
		}
		,error: function(err){
			console.log(err);
			console.log(id+pw+name+date_of_birth+phone+division);
		}
	});
}

function cancle(){
	$('.close-modal ').get(0).click();
}
</script>
<title>[ joinForm.jsp ]</title>
</head>
<body>

<div id="joinForm_main">
	<div class="joinTitle">Join</div>
	<div id="joinForm_center">
		<div id="joinForm_email">
			<div id="joinForm_email_id">
				id<input type="text" id="email_id"><!-- id입력부분+도메인 입력부분 콘캣 -->
			</div>
			<div id="joinForm_email_domain">
				@<input type="text" id="email_domain">
			</div>
			<div id="joinForm_email_select">
				<select id="email_select">
					<option value="0">직접입력</option><!-- 직접입력이 아닐 경우는 리드온리로 바꿔주고 @와 그 값들을 하나의 스트링으로 묶어서 비교하여 바로바로 띄워줌(ajax) --> 
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="yahoo.co.jp">yahoo.co.jp</option>
					<option value="nate.com">nate.com</option>
				</select>
			</div>
		</div>
		
		<div id="joinForm_pw">
			비밀번호<input type="password" id="pw"><!-- 두개 같은지 비교 -->
			<span id="pw_cnt"></span>
		</div>
		
		<div id="joinForm_pw2">
			비밀번호 확인<input type="password" id="pw2">
			<span id="pw2_cnt"></span>
		</div>
		
		<div id="joinForm_name">
			이름<input type="text" id="name">
		</div>
		
		<div id="joinForm_dateofbirth">
			생년월일<input type="text" id="dateofbirth">
		</div>
		
		<div id="joinForm_phone">
			전화번호<input type="text" id="phone">
		</div>
		
		<div id="joinForm_division">
			<input type="radio" class="radioBtn" name="division" value="0">개인
			<input type="radio" class="radioBtn" name="division" value="1">사업자
		</div>
		

		<div id="joinForm_button_area">
			
			<div id="joinForm_button_join">
				<input type="button" value="join" onclick="join()">
			</div>
			
			<div id="joinForm_button_cancle">
				<input type="button" value="cancle" onclick="cancle()">
			</div>
		</div>
	
	</div>



</div>





</body>
</html>