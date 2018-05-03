<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/banner/banner.jsp" %>    
<!DOCTYPE html>
<html>
<title>업체 리스트</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="<c:url value='/resources/js/jquery.minical.js' />"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/storeList.css"/>">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/jquery-ui.js"/>"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">
		

<script type="text/javascript">
	var j = 6;
$(function(){
	window.ScrollFlag = false;
	reload();
	  $(document).scroll(function() {
	    var maxHeight = $(document).height();
	    var currentScroll = $(window).scrollTop() + $(window).height();
		if (maxHeight <= currentScroll + 10) {
			if(window.ScrollFlag) return;
			window.ScrollFlag = true;
			setTimeout(function(){window.ScrollFlag = false;},500);
			j+=3;
			$.ajax({
				url: 'storeList'
					,type: 'post'
					,dataType : "json"
					,cache : false
					,success: function(data){
						$.each(data,function(i,storeList){
							 var storeTest = '<div class="setter">';
		                     storeTest += '<a href="shopInfo?shopNo='+storeList.shopNo+'"><div class="innersetter"><img class="picture" no="'+storeList.shopNo+'" src="<c:url value="/resources/img/'+storeList.savedfile+'"/>"><h6 class="companyName">'+storeList.companyName+'</h6><h6 class="addr1">'+storeList.address1+'</h6><h6 class="category">'+storeList.category+'</h6><h6 class="shopInfo">'+storeList.shopInfo+'</h6><div class="starGrade"><h6 class="grade">'+storeList.grade+'</h6></div><h6 class="budjet">'+storeList.budjet+'</h6><h6 class="hitbase">조회수</h6><h6 class="hits">'+storeList.hits+'</h6></div></a>';
		                     storeTest += '<div class="reservation"><img class="reserveButton" src="<c:url value="/resources/img/reservation.png"/>"></div>';
		                     storeTest += '<div class="comment"><img class="commentButton" src="<c:url value="/resources/img/comment.png"/>"></div></div>';
		                  if(i>=j-3 && i<j){
		                     $('.w3-content').append(storeTest);
		                  }
		                  });
		               }
		               ,error: function(err){
		                  console.log(err);
		               }
		     })

	$('.reserveButton').on('click', function(){
		var no = $(this).attr('no');
		/* location.href="shopInfo?shop_no="+no; */	
	});
			$(document).on($.modal.OPEN, function() {
				$('.modal').addClass('modal_open');
			});			
}
	  })

})

function btn333() {
	location.href = "shopInfo";
}
	
	
function reload(){
	$.ajax({
		url: 'storeList'
			,type: 'post'
			,dataType : "json"
			,cache : false
			,success: function(data){
				 $.each(data,function(i,storeList){
		               var storeTest = '<div class="setter" >';
		               	storeTest += '<a href="shopInfo?shopNo='+storeList.shopNo+'"><div class="innersetter"><img class="picture" no="'+storeList.shopNo+'" src="<c:url value="/resources/img/'+storeList.savedfile+'"/>"><h6 class="companyName">'+storeList.companyName+'</h6><h6 class="addr1">'+storeList.address1+'</h6><h6 class="category">'+storeList.category+'</h6><h6 class="shopInfo">'+storeList.shopInfo+'</h6><div class="starGrade"><h6 class="grade">'+storeList.grade+'</h6></div><h6 class="budjet">'+storeList.budjet+'</h6><h6 class="hitbase">조회수</h6><h6 class="hits">'+storeList.hits+'</h6></div></a>';
	                     storeTest += '<a href="<c:url value="/reservation/reservation?shop_no='+storeList.shopNo+'&budjet='+storeList.budjet+'"/>" rel="modal:open"><div class="reservation"><img class="reserveButton" src="<c:url value="/resources/img/reservation.png"/>"></div></a>';
	                     storeTest += '<div class="comment"><img class="commentButton" src="<c:url value="/resources/img/comment.png"/>"></div></div>';
	                   if(i<j){
		               $('.w3-content').append(storeTest);
		            }
		            });
		         }
		         ,error: function(err){
		            console.log(err);
		         }

		  });
}
</script>
<body>

	

	<!-- Header -->
	<div class="img">
		<div class="innerImg">
			<img src="<c:url value="/resources/img/storeList.jpg"/>">
			<div class="overlay"></div>
		</div>
	</div>
	
	
	
	<!-- First Grid -->
	<div class="w3-row-padding w3-padding-32 w3-container">
		<p class="w3-xlarge w3-container w3-center">레스토랑이 총 30개가 검색 되었습니다. </p>
		<c:if test="${noshow != null }">
		<p class="w3-xlarge w3-container w3-center">노쇼노쇼노쇼</p>
		</c:if>
		<div class="w3-content" style="height: 80%;width: 1000px; background-color: gray; margin-left: 205px;">

			
		</div>
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
	<a rel="modal:open" style="display: none;" id="ff"></a>
	

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
	
</body>
</html> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/banner/banner.jsp" %>    
<!DOCTYPE html>
<html>
<title>업체 리스트</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="<c:url value='/resources/js/jquery.minical.js' />"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/storeList.css"/>">
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
   <script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
<script type="text/javascript"
   src="<c:url value="/resources/js/jquery-ui.js"/>"></script>
<link rel="stylesheet"
   href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">
      

<script type="text/javascript">
   var j = 6;
$(function(){
   window.ScrollFlag = false;
   reload();
     $(document).scroll(function() {
       var maxHeight = $(document).height();
       var currentScroll = $(window).scrollTop() + $(window).height();
      if (maxHeight <= currentScroll + 10) {
         if(window.ScrollFlag) return;
         window.ScrollFlag = true;
         setTimeout(function(){window.ScrollFlag = false;},500);
         j+=3;
         $.ajax({
            url: 'storeList'
               ,type: 'post'
               ,dataType : "json"
               ,cache : false
               ,success: function(data){
                  $.each(data,function(i,storeList){
                      var storeTest = '<div class="setter">';
                           storeTest += '<a href="shopInfo?shopNo='+storeList.shopNo+'"><div class="innersetter"><img class="picture" no="'+storeList.shopNo+'" src="<c:url value="/resources/img/'+storeList.savedfile+'"/>"><h6 class="companyName">'+storeList.companyName+'</h6><h6 class="addr1">'+storeList.address1+'</h6><h6 class="category">'+storeList.category+'</h6><h6 class="shopInfo">'+storeList.shopInfo+'</h6><div class="starGrade"><h6 class="grade">'+storeList.grade+'</h6></div><h6 class="budjet">'+storeList.budjet+'</h6><h6 class="hitbase">조회수</h6><h6 class="hits">'+storeList.hits+'</h6></div></a>';
                           storeTest += '<div class="reservation"><img class="reserveButton" src="<c:url value="/resources/img/reservation.png"/>"></div>';
                           storeTest += '<div class="comment"><img class="commentButton" src="<c:url value="/resources/img/comment.png"/>"></div></div>';
                        if(i>=j-3 && i<j){
                           $('.w3-content').append(storeTest);
                        }
                        });
                     }
                     ,error: function(err){
                        console.log(err);
                     }
           })

   $('.reserveButton').on('click', function(){
      var no = $(this).attr('no');
      /* location.href="shopInfo?shop_no="+no; */   
   });
}
     })

})

function btn333() {
   location.href = "shopInfo";
}
   
   
function reload(){
   $.ajax({
      url: 'storeList'
         ,type: 'post'
         ,dataType : "json"
         ,cache : false
         ,success: function(data){
             $.each(data,function(i,storeList){
                     var storeTest = '<div class="setter" >';
                        storeTest += '<a href="shopInfo?shopNo='+storeList.shopNo+'"><div class="innersetter"><img class="picture" no="'+storeList.shopNo+'" src="<c:url value="/resources/img/'+storeList.savedfile+'"/>"><h6 class="companyName">'+storeList.companyName+'</h6><h6 class="addr1">'+storeList.address1+'</h6><h6 class="category">'+storeList.category+'</h6><h6 class="shopInfo">'+storeList.shopInfo+'</h6><div class="starGrade"><h6 class="grade">'+storeList.grade+'</h6></div><h6 class="budjet">'+storeList.budjet+'</h6><h6 class="hitbase">조회수</h6><h6 class="hits">'+storeList.hits+'</h6></div></a>';
                        storeTest += '<a href="<c:url value="/reservation/reservation?shop_no='+storeList.shopNo+'&budjet='+storeList.budjet+'"/>" rel="modal:open"><div class="reservation"><img class="reserveButton" src="<c:url value="/resources/img/reservation.png"/>"></div></a>';
                        storeTest += '<div class="comment"><img class="commentButton" src="<c:url value="/resources/img/comment.png"/>"></div></div>';
                      if(i<j){
                     $('.w3-content').append(storeTest);
                  }
                  });
               }
               ,error: function(err){
                  console.log(err);
               }

        });
}
</script>
<body>

   

   <!-- Header -->
   <div class="img">
		<div class="innerImg">
			<img src="<c:url value="/resources/img/storeList.jpg"/>">
			<div class="overlay"></div>
		</div>
	</div>
   
   <!-- 스토어 이동 버튼, 추후 변경 -->
   
   
   
   <!-- First Grid -->
   <div class="w3-row-padding w3-padding-32 w3-container">
      <p class="w3-xlarge w3-container w3-center">레스토랑이 총 30개가 검색 되었습니다. </p>
      <c:if test="${noshow != null }">
      <p class="w3-xlarge w3-container w3-center">노쇼노쇼노쇼</p>
      </c:if>
      <div class="w3-content" style="height: 80%;width: 1000px; background-color: gray; margin-left: 205px;">

         
      </div>
   </div>

   <a rel="modal:open" style="display: none;" id="ff"></a>
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
            target="_blank">Gurume365</a></p>
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
         $(document).on($.modal.OPEN, function() {
            $('.modal').addClass('modal_open');
         });
      })
   </script>   
</body>
</html>