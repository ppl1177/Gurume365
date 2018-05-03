<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/css/reservationFloor.css'/>">
<script src="<c:url value='/resources/js/jquery-3.2.1.js' />"></script>
<script type="text/javascript">
$(function() {
	// change event 반복 방지
	var ChangeFlag = false;
	
	var remain = parseInt($('#revValue').attr('p'));
	var datetime = $('#revValue').attr('d');
	
	var areaH = $('#floor-div').height();
	var areaW = $('#floor-div').width();
	var actualH;
	var actualW;
	var sizeRatio;
	
	var shopNo = parseInt($('#revValue').attr('shop_no')); // 더미데이터
	
	var tableInfo = new Array();
	$.ajax({
		url: 'loadFloor',
		type: 'post',
		data: {shopNo : shopNo
			,datetime : datetime},
		dataType: 'json',
		success: function(dat) {
			actualH = JSON.stringify(dat.floorInfo.floorHeight);
			actualW = JSON.stringify(dat.floorInfo.floorWidth);
			
			
			for(var d of dat.tablesInfo) {
				tableInfo.push({x: JSON.stringify(d.posX), y: JSON.stringify(d.posY), height: JSON.stringify(d.tableLength), width: JSON.stringify(d.tableWidth), shape: d.tableShape, angle: JSON.stringify(d.degree), min: JSON.stringify(d.personMin), max: JSON.stringify(d.personMax), ID: ('table' + JSON.stringify(d.tableNo))});

				var create_table_no = JSON.stringify(d.tableNo);
				var html = '' +
				'<div id="table' + create_table_no + '" tableNo="'+ create_table_no +'"  >' +
				'</div>';
				$( '#floor-enable' ).append(html);
				
				$('#table' + create_table_no).attr('min', JSON.stringify(d.personMin));
				$('#table' + create_table_no).attr('max', JSON.stringify(d.personMax));
				
				$('#table' + create_table_no).width(JSON.stringify(d.tableWidth));
				$('#table' + create_table_no).height(JSON.stringify(d.tableLength));
				
				$('#table' + create_table_no).addClass('table-' + d.tableShape);
				$('#table' + create_table_no).addClass('table-default');
				$('#table' + create_table_no).addClass('table-btn');
				
				$('#table' + create_table_no).html(d.personMin + '~' + d.personMax + '명');
				
				
				
				console.log(d.posX + ',' + d.posY);
				
			}
			if(dat.hasOwnProperty('tableReservation')){
				for(var r of dat.tableReservation){
					var tableNo = r.tableNo;
					$('#table'+tableNo).removeClass('table-default');
					$('#table'+tableNo).removeClass('table-btn');
					$('#table'+tableNo).addClass('resOn');
				}
			}
			
			setSize();
			// alert('불러오기 완료');
		},
		error: function(err) {
			alert('불러오기 오류');
			console.log(err);
		}
	});
	
	function setSize() {
		
		/* 
		areaH = $('#floor-div').height();
		areaW = $('#floor-div').width();
		if(areaW/areaH > actualW/actualH) {
			$('#floor-enable').height(areaH);
			$('#floor-enable').width(areaH*(actualW/actualH));
			sizeRatio = actualH/areaH;
		}
		else if(areaW/areaH < actualW/actualH) {
			$('#floor-enable').height(areaW*(actualH/actualW));
			$('#floor-enable').width(areaW);
			sizeRatio = actualW/areaW;
		}
		enableH = actualH/sizeRatio;
		enableW = actualW/sizeRatio;
		
		var t = (areaH-enableH)/2;
		var l = (areaW-enableW)/2;
		
		$('#floor-enable').css( 'top', t );
		$('#floor-enable').css( 'left', l);
		 */
		$('#floor-enable').height('90%');
		$('#floor-enable').width('100%');
		 
		
		
		for(var i=0; i<tableInfo.length; i++) {
			/*$('#' + tableID[i]).css('left', (tableX[i]/sizeRatio)+parseInt($('#floor-enable').css('left')));
			$('#' + tableID[i]).css('top', (tableY[i]/sizeRatio)+parseInt($('#floor-enable').css('top')));*/
			$('#' + tableInfo[i].ID).css('left', tableInfo[i].x*($('#floor-enable').width()-$('#' + tableInfo[i].ID).width())/100+parseInt($('#floor-enable').css('left')));
			$('#' + tableInfo[i].ID).css('top', tableInfo[i].y*($('#floor-enable').height()-$('#' + tableInfo[i].ID).height())/100+parseInt($('#floor-enable').css('top')));
			
			console.log('#' + tableInfo[i].ID);
		}
		//예약 인원 수
		 
		$('.table-btn').on('click', function() {
			var no = $(this).attr('tableNo');
			var min = parseInt($(this).attr('min'));
			var max = parseInt($(this).attr('max'));
			var html = '<select class="rv" no="'+ $(this).attr('tableNo') +'" >';
				html +='<option value="0">0명</option>';
				for(var i=min; i<=max; i++){
					html +='<option value="'+i+'">'+i+'명</option>'; 
				}	
				html +='</select>';
				
			
			$(this).html(html);
			$(this).removeClass('table-btn');
			$(this).off("click");
			var previous;
			$('.rv').on('focus',function(){
				//previous = this.value;
				
			
			}).change(function(){
				if(window.ChangeFlag) return;
				window.ChangeFlag = true;
				setTimeout(function(){window.ChangeFlag = false;},50);
				var select = parseInt($(this).val());
				var person = parseInt($('#revValue').attr('p'));
				var date = $('#revValue').attr('d');
				previous = parseInt($(this).val());
				remain = remain+(previous-select);
				/* alert("select: "+select+" person: "+person+" date: "+date+" remain: "+remain); */
				/* console.log("select: "+select+" person: "+person+" date: "+date+" remain: "+remain +"previous"+previous); */
				/* $('#revValue').attr('p',remain); */
				$('#info').html('남은 예약 인원: <span class="red">'+remain+'명</span> 예약 날짜 및 시간: '+date);
				if(remain>=0){
					$('.red').css('color','black');
				}
				if(remain<0){
					$('.red').css('color','red');
				}
			});
		});
		
	}
	

	
});

function reservationTable(){
	// 배열
	var pno = $('.rv').map(function(idx, elem){
		return $(elem).val();
	});
	var tno = $('.rv').map(function(idx, elem){
		return $(elem).attr('no');
	});
	// 한 문장으로
	var ttno = '';	// table_no번호 저장
	var ppno = '';	// person_table저장
	var pppno = 0;	// 예약 인원
	for (var int = 0; int < tno.length; int++) {
		if(pno[int]!='0'){
		ttno += tno[int];
		ppno += pno[int];
		pppno += parseInt(pno[int]);
		}
	}
	
	var datetime = $('#revValue').attr('d');
	var shop_no = $('#revValue').attr('shop_no');
	var person = parseInt($('#revValue').attr('p'));
	var content = $('#revValue').attr('c');
	var budjet = $('#revValue').attr('budjet');
	if(pppno!=person){
		alert('예약 인원을 확인해주세요.');
		return false;
	}
	$('.close-modal ').get(0).click();
	$('#ff').attr('href','../reservation/reservationPermit?shop_no='+shop_no+'&budjet='+budjet+'&datetimepicker='+datetime+'&person='+person+'&content='+content+'&ppno='+ppno+'&ttno='+ttno+'');
	/* $('#ff').attr('href','../reservation/reservationTable?datetimepicker="'+datetime+'"&person="'+person+'"&content="'+content+'"'); */
	$('#ff').get(0).click();
}
</script>
<title>floor</title>

</head>
<body>
	<div id="floor-div">
	<div id="info">남은 예약 인원: <span class="red">${p}명</span> 예약 날짜 및 시간: ${d}</div>
		<div id="floor-enable"></div>
			<span>예약 하고자 하는 테이블을 선택하여 인원을 설정해 주세요</span>
			<input type="button" id="reserBtn" onclick="reservationTable()" value="선택 완료">
			<a id="reservationModal"></a>
	</div>
<input type="hidden" id="revValue" p=${p} d='${d}' c='${c}' shop_no=${shop_no} budjet=${budjet}>
</body>
</html>