
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/views/banner/banner.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">
<link rel="stylesheet" href="<c:url value="/resources/css/review.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/main.css"/>">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script type="text/javascript"
	src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/jquery-ui.js"/>"></script>
<script>
	var xhr = new XMLHttpRequest();
		
	function submitAction() {
		// alert("서브밋 진입");
		var data = new FormData();
		var starValue = $("#starValue").val();
		var reviewText = $("#review").val();
		var searchName = $("#search").val();
		data.append("starValue", starValue);
		data.append("reviewText", reviewText);
		data.append("searchName", searchName);

		for (var i = 0, len = sel_files.length; i < len; i++) {
			var name = "image_" + i;
			data.append(name, sel_files[i]);
		}
		data.append("image_count", sel_files.length);

		//data = [object FormData]
		xhr.open("POST", "submitAction");

		xhr.onload = function(e) {

			if (this.status == 200) {
				
			}
		}

		xhr.send(data);
		
		$("#reviewComplete").css("visibility","visible");
		$("#reviewComplete").attr('href','reviewComplete?searchName='+searchName);
		$("#reviewUpload").css("visibility","hidden");
	}

	function deleteImageAction(index) {

		sel_files.splice(index, 1);

		var img_id = "#img_id" + index;

		$(img_id).remove();

	}

	$(function() {
		$('#realtimeReview')
		.click(
				function() {
					$.ajax({
						url : "realtimeReview",
								type : "POST",
								dataType : "json",
								cache : false,
								success : function(data) {
									
									var hourMinSec = data.hourMinSec;
									//21:04:35
									var yearMonthDay = data.yearMonthDay;
									var hourMinSecSplit = hourMinSec.split(":");
									var yearMonthDaySplit = yearMonthDay.split("-")
									//2018-04-23
							$.each(data.reviewList,function(i, list) {
												
												var picture = list.picture;				
												var origin = list.originalfile;
												var saved = list.savedfile;
												
												var signal = "%(&*%";
												
												var savedData = saved.split(signal);
												var originData = origin.split(signal);
												
												
												
												var starScore = list.starScore;
												
												if (starScore == "0") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_0.png"/>" height="25px"width="100px">';
												} else if (starScore == "1") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_1.png"/>" height="25px"width="100px">';
												} else if (starScore == "2") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_2.png"/>" height="25px"width="100px">';
												} else if (starScore == "3") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_3.png"/>" height="25px"width="100px">';
												} else if (starScore == "4") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_4.png"/>" height="25px"width="100px">';
												} else if (starScore == "5") {
													var star = '<img id="starPicture" src="<c:url value="/resources/img/star_5.png"/>" height="25px"width="100px">';
												}
												var image = list.savedfile
														.split('%(&*%');
												//데이터베이스에서 받아온 값
												var inputdate = list.inputdate
														.split(' ');
												//게시글의 시간												
												var date_day = inputdate[0];
												var date_time = inputdate[1];
												date_timeSplit = date_time.split(":");
												var time_hour = date_timeSplit[0];
												var time_min = date_timeSplit[1];
												var time_sec = date_timeSplit[2];
												
												//현재 날짜와 시간21:04:352018-04-23 게시글의 시간 =2018-04-2320:48:41.0
												//만약 날짜가 같지 않다면 
												var realtime = "";
												//2018-04-232018-04-23dd
												if (yearMonthDay != date_day) {
													date_day = date_day.split("-");
													var year = parseFloat(yearMonthDaySplit[0])
															- parseFloat(date_day[0]);
													
													var month = parseFloat(yearMonthDaySplit[1])
															- parseFloat(date_day[1]);
													
													var day = parseFloat(yearMonthDaySplit[2])
															- parseFloat(date_day[2]);
													
													if (year == 0) {
														if (month == 0) {
															realtime = day + " 일 전";
														}else if(month != 0){
															realtime = month + " 달 전";
														}
													} else if(year != 0){
														realtime = year+ " 년 전";
													}
													//만약 날짜가 같다면 시,분 비교
												} else if(yearMonthDay == date_day){
									
													//hdd21:04:35dddd2
													var hour = parseFloat(hourMinSecSplit[0])
															- parseFloat(time_hour);
													
													//hour : 21hour2 : 2
													var min = parseFloat(hourMinSecSplit[1])
															- parseFloat(time_min);
													
													//min : NaNhour2 : 0
													var sec = parseFloat(hourMinSecSplit[2])
															- parseFloat(time_sec);
													
													
													//hour 차이 : 19 min 차이 : NaN sec 차이 : NaN
													if (hour == 0) {
														if (min == 0) {
															realtime = sec
																	+ "초 전";
														} else if(min != 0){
															realtime = min
																	+ "분 전";
														}
													} else if(hour != 0){
														realtime = hour
																+ "시간 전";
													}
												}
										var html = '<div class="w3" style="background-color:gray;"><div style="width:700px; height:500px; margin-top:40px; margin-bottom:20px;  border:1px solid; margin-left: 40px; margin-right: 27px; padding-top:15px; float: left; background-color: #fff;"><div style="margin-left:40px;"><a href="#" >'
												+ list.companyName
												+ '</a><br>'
												+ list.category
												+ '</div><div style="float:right; margin-right:50px; margin-top:20px">'
												+ realtime
												+ '</div><div style="margin-top:20px; margin-left:40px; width:400px; height:60px;">'
												+ star
												+ '</div><div style="margin-left:40px;">'
												+ list.id
												+ ' 회원님</div><div style="margin-left:40px; margin-top:10px;margin-right:40px;">'+list.reviewText+'</div>';			
												for(var j=1; j<originData.length; j++){
													html+= '<div style="width:100px; height:100px; float:left; margin-left:20px; margin-top:40px;"><img src="download?origin='+originData[j]+'&saved='+savedData[j]+'" style="width:100px; height:100px;"></div>';
												}
												html +='</div></div>';
										$('#realtime').append(html);
									})

							},
							error : function() {
							}

						})
					
				});
		
		
		
		
		
		//레스토랑 검색
		$("#search").on('keyup', function(event) {
			var keycode = event.keyCode;
			var text = $('#search').val();
			//백스페이스가 들어갈 때 ajax값을 불러오기 때문에 백스페이스 키 값인 8을 눌렀을 때,
			//ajax를 실행 안 하게 막아 놓았습니다.
			if (keycode != 8) {
				$.ajax({
					url : "search",
					type : "GET",
					data : {
						text : text
					},
					dataType : "json",
					success : function(data) {
						//셀렉트한 값이 널이 아닐 경우 화면에 그 리스트를 넣어준다.			
						var availableTags = [];
						var map = new Map();
						$.each(data, function(index, item) {
							//해당 객체의 이름들이 다 담겨있다.
							availableTags.push(item.companyName);
							map.set(item.shopNo, item.companyName);
						});
						$("#search").autocomplete({
							source : availableTags
						});
					},
					error : function() {
						alert("실패");
					}
				});
				}}
		);
		$("#starValue").on(
				'click',
				function() {
					var starValue = $("#starValue").val();
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
									+ "'><img style='width:250px; height:250px' src='"+e.target.result+"' data-file='"+f.name+"'  title='Click to remove'></a>";

							$(".imgs_wrap").append(html);
							index++;
						}
						reader.readAsDataURL(f);
					});
		}
	});
</script>

<title>리뷰페이지</title>
</head>
<body>

	<div id="main" style="background-color: #e6e6ff">
		<br> <br> <br> <br> <br> <br>
		<div class="w3-left-align" style="font-weight: bold;">
			리뷰 쓰기
			<div class="w3" style="background-color: #fff;">
				<div class="review_title">
					레스토랑 검색 &nbsp;&nbsp;&nbsp; <input class="ui-widget" type="text"
						id="search" placeholder="리뷰를 작성할 매장을 검색하세요">

					<div id="searchResult"></div>
				</div>

				<div class="review_title">
					별점&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select
						name='stars' id="starValue">
						
						<option value="star_0">매우 불만족</option>
						<option value="star_1">불만족</option>
						<option value="star_2">보통</option>
						<option value="star_3">만족</option>
						<option selected value="star_4">매우 만족</option>
						<option value="star_5">최고에요!</option>
					</select> &nbsp;&nbsp;&nbsp;&nbsp; <img id="starPicture"
						src="<c:url value="/resources/img/star_4.png"/>" height="25px"
						width="100px">
				</div>

				<div class="review_title">
					리뷰 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<textarea cols="40" rows="3" id="review" placeholder=""></textarea>
				</div>
				<div class="review_title">
					사진 등록 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img
						id="camera" src="<c:url value="/resources/img/camera2.png"/>"
						height="50px" width="50px">
					<h7>사진 삭제는 클릭으로 가능합니다.</h7>
					<input type="file" id="input_img" multiple="multiple" />
					<div class="imgs_wrap">
						<img id="images" />
					</div>
					<a href="javascript:" id="reviewUpload" style="background-color:#e6e6ff;" onclick="submitAction()">업로드</a>			
				<a id="realtimeReview"  style="background-color:#e6e6ff;">실시간 리뷰</a>
					<a href="#" id="reviewComplete"  style="background-color:#e6e6ff; visibility: hidden;">리뷰 확인하러 가기</a>
				</div>
			</div>
		</div>
		<div class="w3-left-align" id="realtime" style="font-weight: bold;">
			실시간 리뷰
			<div class="w3" style="background-color:gray;">
				
			</div>		
		</div>
		
	
	<br>
	<br>
	<br>

</body>
</html>