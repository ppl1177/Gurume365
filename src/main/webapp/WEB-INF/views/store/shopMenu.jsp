<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>    
<!DOCTYPE html>
<html>
<title>업체 리스트</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<c:url value="/resources/css/storeList.css"/>">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">
	
<style>
body, h1, h2, h3, h4, h5, h6 {
	font-family: "Lato", sans-serif
}

.w3-bar, h1, button {
	font-family: "Montserrat", sans-serif
}

.fa-anchor, .fa-coffee {
	font-size: 200px
}
</style>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
<script type="text/javascript">
$(function(){
	var storeTest = '<div style="width:152px; height:200px; margin-bottom: 10px; margin-left: 7px; margin-right: 7px; float: left; background-color: green;" >';
	storeTest += '<div class="" style="width:152px; height: 130px; border: 1px solid;"></div>';
	storeTest += '<div style="float:left; width: 70px; height: 30px; margin-left: 5px; margin-right: 5px; margin-top: 30px; margin-bottom: 10px; background-color: white;"></div>';
	storeTest += '<div style="float:right width: 70px; height: 30px; margin-left: 5px; margin-right: 5px; margin-top: 30px; margin-bottom: 10px; background-color: blue;"></div></div>';
	var j = 1;
	  $(document).scroll(function() {
	    var maxHeight = $(document).height()-500;
	    var currentScroll = $(window).scrollTop() + $(window).height();
		/* alert(maxHeight+" "+$(window).scrollTop()+" "+$(window).height()); */
	    
		if (maxHeight <= currentScroll + 200) {
	    	j+=1;
	    	for(var i=0; i<j; i++){
	    		$('.w3-content').append(storeTest);
	    		
	      /* $.ajax({
				url: 'StoreList'
	  			,type: 'post'
	  			,data: {
	  				page: page
	  				,
	  			}
	  			,success: function(s){
	  				location.reload();
	  			}
	  			,error: function(err){
	  				console.log(err);
	  			}

	      }); */
	    	}
	    }
	  })
$('#btn222').on('click', function(){
	$('.w3-content').append(storeTest);
	});
})


	

function btn333() {
	alert("가즈아");
	location.href = "shopInfo?shopNo=101";
}
	
	

</script>
<body>

	<!-- Navbar -->
	<div class="w3-top">
		<div class="w3-bar w3-dark-grey w3-card w3-left-align w3-large">
			<a
				class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-light-grey w3-padding-large w3-hover-white w3-large"
				href="javascript:void(0);" onclick="myFunction()"
				title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a> <a
				href="#" class="w3-bar-item w3-button w3-padding-large w3-white">Home</a>
			<a href="#"
				class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Link
				1</a> <a href="#"
				class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Link
				2</a> <a href="#"
				class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Link
				3</a> <a href="#"
				class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Link
				4</a>

		</div>
		<div class="w3-top2 ">
			<a href="#" class="w3-button2 w3-white w3-hover-blue">이벤트</a> <a
				href="#" class="w3-button2 w3-white w3-hover-blue">추천 테마</a> <a
				href="#" class="w3-button2 w3-white w3-hover-blue">리뷰</a>
		</div>
		<!-- Navbar on small screens -->
		<div id="navDemo"
			class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium w3-large">
			<a href="#" class="w3-bar-item w3-button w3-padding-large">Link 1</a>
			<a href="#" class="w3-bar-item w3-button w3-padding-large">Link 2</a>
			<a href="#" class="w3-bar-item w3-button w3-padding-large">Link 3</a>
			<a href="#" class="w3-bar-item w3-button w3-padding-large">Link 4</a>
		</div>
	</div>

	<!-- Header -->
	<header class="w3-container w3-light-grey w3-center"
		style="padding: 80px;">
		<h1 class="w3-margin w3-jumbo">지역정보:${zone}//테마 종류:${thema}//음식 종류:${food}</h1>
	</header>
<<<<<<< HEAD
	<a href="<c:url value="/reservation/reservation" />" rel="modal:open"><input type="button" id="btn222" value="????"></a>
=======
	<input type="button" id="btn222" value="????">
	
	
	
	<!-- 스토어 이동 버튼, 추후 변경 -->
	<input type="button" onclick="btn333()" value="스토어 페이지로 이동">
	
	
	
>>>>>>> branch 'master' of https://github.com/inspiration33/gurumeF
	<!-- First Grid -->
	<div class="w3-row-padding w3-padding-32 w3-container">
		<p class="w3-xlarge w3-container w3-center">레스토랑이 총 0개가 검색 되었습니다. </p>
		<c:if test="${noshow != null }">
		<p class="w3-xlarge w3-container w3-center">노쇼노쇼노쇼</p>
		</c:if>
		<div class="w3-content" style="height: 80%; width: 500px; background-color: gray;">

			
		</div>
	</div>
	<div class="aritcleView">
       <div>1</div>
       <div>2</div>
       <div>3</div> 
	</div>

	

	<div class="w3-container w3-black w3-center w3-opacity w3-padding-64">
		<h1 class="w3-margin w3-xlarge">Quote of the day: live life</h1>
	</div>

	<!-- Footer -->
	<footer class="w3-container w3-padding-64 w3-center w3-opacity">
		<div class="w3-xlarge w3-padding-32">
			<i class="fa fa-facebook-official w3-hover-opacity"></i> <i
				class="fa fa-instagram w3-hover-opacity"></i> <i
				class="fa fa-snapchat w3-hover-opacity"></i> <i
				class="fa fa-pinterest-p w3-hover-opacity"></i> <i
				class="fa fa-twitter w3-hover-opacity"></i> <i
				class="fa fa-linkedin w3-hover-opacity"></i>
		</div>
		<p>
			Powered by <a href="https://www.w3schools.com/w3css/default.asp"
				target="_blank">w3.css</a></p>
	</footer>
	<script>
		// Used to toggle the menu on small screens when clicking on the menu button
		function myFunction() {
			var x = document.getElementById("navDemo");
			if (x.className.indexOf("w3-show") == -1) {
				x.className += " w3-show";
			} else {
				x.className = x.className.replace(" w3-show", "");
			}
		}
	</script>
	<script type="text/javascript" charset="utf-8">
		$(function() {
			function log_modal_event(event, modal) {
				if (typeof console != 'undefined' && console.log)
					console.log("[event] " + event.type);
			}
			;
			$(document).on($.modal.BEFORE_BLOCK, log_modal_event);
			$(document).on($.modal.BLOCK, log_modal_event);
			$(document).on($.modal.BEFORE_OPEN, log_modal_event);
			$(document).on($.modal.OPEN, log_modal_event);
			$(document).on($.modal.BEFORE_CLOSE, log_modal_event);
			$(document).on($.modal.CLOSE, log_modal_event);
			$(document).on($.modal.AFTER_CLOSE, log_modal_event);
			$(document).on($.modal.AJAX_SEND, log_modal_event);
			$(document).on($.modal.AJAX_SUCCESS, log_modal_event);
			$(document).on($.modal.AJAX_COMPLETE, log_modal_event);

			
			$(document).on($.modal.OPEN, function(){
				$('.modal').attr('style','position:relative');
			});
			})
	</script>	

</body>
</html>