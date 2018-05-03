<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/banner/banner.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GURUME365-사업장 관리 페이지</title>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="<c:url value="/resources/css/joinInfoRes.css"/>">
<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.2.1.js'/>"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>


<style type="text/css">
	input::-webkit-outer-spin-button,
   input::-webkit-inner-spin-button {
       /* display: none; <- Crashes Chrome on hover */
       -webkit-appearance: none;
       margin: 0; /* <-- Apparently some margin are still there even though it's hidden */
   }
</style>	
<script type="text/javascript">


 $(function(){
	 var shopNo = $('#hiddenData').val();
	$.ajax({
		url:'../reservation/resList'
		,type: 'post'
		,data:{
			shopNo: shopNo
		}
		,dataType: 'json'
		,success: function(data){
			$.each(data, function(i, list){
				var html = '<div class="resDiv"><div class="resIdDiv">ID/<br><span class="resIdSpan">'+list.id+'</span></div><div class="redDateDiv">Date/'+list.datetime+' 인원/'+list.person+'</div><div class="resCommentDiv">Comment/<br><span class="resCommentSpan">'+list.content+'</span></div></div>';
				var html2 = '<div class="resDiv"><div class="resIdDiv">ID/<br><span class="resIdSpan">'+list.id+'</span></div><div class="redDateDiv">Date/'+list.datetime+' 인원/'+list.person+'</div><div class="resCommentDiv">Comment/<br><span class="resCommentSpan">'+list.content+'</span><div class="resSetDiv"><div class="resSetVisit" no="'+list.seqRes+'">이용 완료</div><div class="resSetNoshow" no="'+list.seqRes+'">no show</div></div></div></div>';
				if(list.situation == 1){
					// 1일 경우 왼쪽
					$('#newResDiv').append(html2);
				}else if(list.situation == 2){
					// 2일 경우 가운데
					$('#noshowResDiv').append(html);
				}else if(list.situation == 3){
					// 3일 경우 오른쪽
					$('#visitResDiv').append(html);
				}
			})
			
			
			$('.resSetVisit').on('click',function(){
				var con = confirm("손님이 오셨습니까?");
				if(con){
				var no = $(this).attr('no');
				$.ajax({
					url:'../reservation/resSetVisit'
					,type:'post'
					,data:{
						seqRes:no
					},
					success:function(){
						location.reload();
					},
					error:function(){
					}
				})
				}
			})
			$('.resSetNoshow').on('click',function(){
				var con = confirm("No Show?");
				if(con){
				var no = $(this).attr('no');
				$.ajax({
					url:'../reservation/resSetNoshow'
					,type:'post'
					,data:{
						seqRes:no
					},
					success:function(){
						location.reload();
					},
					error:function(){
					}
				})
				}
			})
		}
		,error: function(e){
			
		}
	})
	
	
	
}) 


</script>

</head>
<body>


	<div>
		<div class="userInfoArea">
			<div class="newInfoDiv">
				<div class="plusTitle">새로 등록된 예약</div>
				<div id="newResDiv">
				
				</div>
			</div>
			
			<div class="noshowInfoArea">
				<div class="plusTitle">no show</div>
				<div id="noshowResDiv">
					
				</div>
			</div>
			
			<div class="visitInfoArea">
				<div class="plusTitle">이용 완료 예약</div>
				<div id="visitResDiv">
					
				</div>
			</div>
			
			
		</div>
	</div>
<input type="hidden" id="hiddenData" value="${shopNo}">
</body>
</html>