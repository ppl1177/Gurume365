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
	
	
	var areaH = $('#floor-div').height();
	var areaW = $('#floor-div').width();
	var actualH;
	var actualW;
	var sizeRatio;
	
	var shopNo = parseInt($('#revValue').attr('shop_no')); // 더미데이터
	
	var tableInfo = new Array();
	$.ajax({
		url: '../floor/loadFloor',
		type: 'post',
		data: {shopNo : shopNo},
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
		$('#floor-enable').height('100%');
		$('#floor-enable').width('100%');
		 
		
		
		for(var i=0; i<tableInfo.length; i++) {
			/*$('#' + tableID[i]).css('left', (tableX[i]/sizeRatio)+parseInt($('#floor-enable').css('left')));
			$('#' + tableID[i]).css('top', (tableY[i]/sizeRatio)+parseInt($('#floor-enable').css('top')));*/
			$('#' + tableInfo[i].ID).css('left', tableInfo[i].x*($('#floor-enable').width()-$('#' + tableInfo[i].ID).width())/100+parseInt($('#floor-enable').css('left')));
			$('#' + tableInfo[i].ID).css('top', tableInfo[i].y*($('#floor-enable').height()-$('#' + tableInfo[i].ID).height())/100+parseInt($('#floor-enable').css('top')));
			
			console.log('#' + tableInfo[i].ID);
		}
		//예약 인원 수
		 
			
		
	}
	

	
});


</script>
<style type="text/css">
#floor-div
	{
		height: 500px;
		width: 100%;
	}
#floor-enable
	{
		position: relative;
		width: 200px;
		height: 200px;
		background-color: white;
	}
.table-circle {
	position: absolute;
	border-radius: 50%;
	width: 100%;
	height: 100%;
}

.table-rect {
	position: absolute;
	border-radius: 3%;	
	width: 100%;
	height: 100%;
	
}

.table-default {
	background-color: white;
	border: 2px solid #ff4040;
}

.table-noshow {
	
}

.table-reserv {
	
}

.table-btn {
	text-align: center;
    display: inline-block;
	
}

.table-select {
	
	
}

</style>
<title>floor</title>

</head>
<body>
<div id="floor-div"><div id="floor-enable"></div></div>
<input type="hidden" id="revValue" shop_no=${shopNo}>
</body>
</html>