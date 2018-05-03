$(function() {
	jQuery.ajaxSettings.traditional = true;	// ajax로 배열을 보낼 수 있다.
	
	var currentShopNo = document.getElementById('currentShopNo').value;
	var borderSize = $('#floorCenterDivChild').css('border').split('px');
	var paddingL = parseInt($('.modal').css('padding-left').replace('px', ''));
	var paddingT = parseInt($('.modal').css('padding-top').replace('px', ''));
	
	var tableC_W = 50;
	var tableR_W = 60;
	var tableR_H = 35;
	// 440 * 470
	var areaH = $('#floor-div').height();
	var areaW = $('#floor-div').width();
	var actualH = 10;
	var actualW = 10;
	var sizeRatio = actualH/areaH;
	var enableH = actualH/sizeRatio;
	var enableW = actualW/sizeRatio;
	var xPos;
	var yPos;
	var currentDrag;
	/*var tableX = new Array();
	var tableY = new Array();*/
	
	/*var tableX;
	var tableY;
	var tableShape;
	var tableAngle;
	var tablemin;
	var tablemax;
	var tableID = $('.draggable-table').map(function(idx, elem) {
		return elem.id;
	});*/
	
	var tableInfo = $('.draggable-table').map(function(idx, elem) {
		return {x: 0, y: 0, shape: '?', angle: 0, min: 0, max: 0, ID: '?'};
	});
	
	
	// alert(currentShopNo);
	$.ajax({
		url: '/gurume365/floor/loadFloor',
		type: 'post',
		data: {shopNo: currentShopNo},
		dataType: 'json',
		success: function(dat) {
			actualH = JSON.stringify(dat.floorInfo.floorHeight);
			actualW = JSON.stringify(dat.floorInfo.floorWidth);
			
			
			for(var d of dat.tablesInfo) {	
				
				createTable('#draggable-' + d.tableShape,
						d.posX*$('#floor-enable').width()/100
						 + parseInt($('#floor-enable').css('left'))
						 + paddingL + parseInt(borderSize[0]),
						d.posY*$('#floor-enable').height()/100
						 + parseInt($('#floor-enable').css('top'))
						 + paddingT + parseInt(borderSize[0]),
												
						JSON.stringify(d.personMin), JSON.stringify(d.personMax), JSON.stringify(d.degree), JSON.stringify(d.tableLength), JSON.stringify(d.tableWidth), JSON.stringify(d.tableNo));
				

				
				$('#draggable-table' + JSON.stringify(d.tableNo)).width(JSON.stringify(d.tableWidth));
				$('#draggable-table' + JSON.stringify(d.tableNo)).height(JSON.stringify(d.tableLength));
				$('#drag-table' + JSON.stringify(d.tableNo)).addClass('drag-table-' + d.tableShape);
				
				$('#draggable-table' + JSON.stringify(d.tableNo)).addClass('draggable-table');
				
				// console.log(d.posX + ',' + d.posY);
			}
			// alert(paddingL + ',' + paddingT);

			$('#table-info-table').html('<tr><th>No.</th><th>shape</th><th>min</th><th>max</th><th>del</th></tr>');
			
			var floorMax = 0;
			for(var i=0; i<tableInfo.length; i++) {
				/*console.log(tableInfo[i]);*/
				var no = tableInfo[i].ID;
				no = no.replace('draggable-table', '');
				var html = '<tr><td>' + no + '</td><td>' + tableInfo[i].shape +
				'</td><td><input type="number" id="min' + no + '" value="' + tableInfo[i].min + '" class="tableMinMax" min="0" style="width: 30px;"></td><td><input type="number" id="max' + no + '" value="' + tableInfo[i].max + '" class="tableMinMax" min="0" style="width: 30px;"></td><td>' +
				'<button id="del' + no + '" class="tableDelBtn">×</button></td></tr>';
				$('#table-info-table').append(html);
				floorMax += parseInt(tableInfo[i].max);
				// console.log(tableInfo[i].shape);
			}
			
			$('#floorTable-info').html('테이블 수: ' + tableInfo.length + '<br>' + '최대 수용인원: ' + floorMax + '명');
			
			$('.tableDelBtn').on('click', function() {
				// alert(this.id);
				
				delTable(this.id.replace('del', ''));
				
			});
			
			$('.tableMinMax').on('blur', function() {
				editMinMax(this.id);
			});
			
			setSize();
			// alert('불러오기 완료');
		},
		error: function(err) {
			alert('불러오기 오류');
			console.log(err);
		}
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	setSize();
	
	/*$(window).on('resize', function() {
		setSize();
	});*/
	
	// 탭 생성, 삭제 기능 추가/ DB에도 floor_name 추가할 것!!
	$('#setSizeBtn').on('click', function() {
		
		var tableInfo = $('.draggable-table').map(function(idx, elem) {
			return {x: 0, y: 0, shape: '?', angle: 0, min: 0, max: 0, ID: '?'};
		});
		/*alert(tableInfo.length);*/
		
		if(tableInfo.length!=0) {
			alert('테이블이 있을 때 플로어를 변경할 수 없습니다.');
			return;
		}
		
		if(isNaN($('#floor-H').val())||isNaN($('#floor-W').val())) {
			alert('숫자를 입력하세요.');
			return;
		}
		if($('#floor-H').val()<3||$('#floor-W')<3) {
			alert('3 이상의 숫자를 입력하세요.');
			return;
		}
		actualH = $('#floor-H').val();
		actualW = $('#floor-W').val();
		
		setSize();
		$('#floorSize-info').text('매장 가로: ' + actualW + 'm, ' + '세로: ' + actualH + 'm');
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
		$('#floor-enable').height($('#floor-div').height());
		$('#floor-enable').width($('#floor-div').width());
		
		
		
		
		var cnt = 0;
		
		for(var i=0; i<tableInfo.length; i++) {
			/*$('#' + tableID[i]).css('left', (tableX[i]/sizeRatio)+parseInt($('#floor-enable').css('left')));
			$('#' + tableID[i]).css('top', (tableY[i]/sizeRatio)+parseInt($('#floor-enable').css('top')));*/
			$('#' + tableInfo[i].ID).css('left',
										(tableInfo[i].x*$('#floor-enable').width()/100	));
			
			$('#' + tableInfo[i].ID).css('top',
										(tableInfo[i].y*$('#floor-enable').height()/100	));
			
			// console.log(tableInfo[i].x + ',' + tableInfo[i].y);
			
			/*console.log((tableInfo[i].x*($('#floor-enable').width())/100) + ',' + $('#' + tableInfo[i].ID).css('left'));
			console.log((parseInt($('#' + tableInfo[i].ID).css('left')) - (tableInfo[i].x*($('#floor-enable').width())/100)));
			*/
		}
		
		
		
		
		
		setTableIcon();
		
		/*$('html').css( 'overflow', 'hidden' );
		if($(window).width()<800) {
			$('html').css( 'overflow-x', 'visible' );
		}
		if($(window).height()<600) {
			$('html').css( 'overflow-y', 'visible' );
		}*/
	}
	
	
	// $('#floor-enable').css({ top: '0px' });
	
	
	
	
	
	function setTableIcon() {
		$( "#draggable-circle" ).remove();
		$( "#draggable-rect" ).remove();
		
		var html = '' +
			'<div id="draggable-circle" min="2" max="4">' +
				/*'<div id="rotateable-circle">' +
					'<div id="rotate-circle"></div>' +
				'</div>' +*/
				'<div id="drag-circle"></div>' +
			'</div>';
		
		html += 
		'<div id="draggable-rect" min="2" max="5">' +
			/*'<div id="rotateable-rect">' +
				'<div id="rotate-rect"></div>' +
			'</div>' +*/
			'<div id="drag-rect"></div>' +
		'</div>';
		
		/*$('#flooricon-div').html($('#flooricon-div').html() + html);*/
		$( '#flooricon-div' ).append(html);
		
		
		$('#draggable-circle').draggable({
			handle: '#drag-circle',
			containment: '#floor-edit',
			drag: function(event) {
				currentDrag = "#draggable-circle";
			}
			
		});
		
		$('#draggable-rect').draggable({
			handle: '#drag-rect',
			containment: '#floor-edit',
			drag: function(event) {
				currentDrag = "#draggable-rect";
			}
		});
		
		
		
		
		
		/*$('#rotateable-circle').draggable({
		  handle: '#rotate-circle',
		  opacity: 0.001,
		  helper: 'clone',
		  drag: function(event) {
		    var // get center of div to rotate
		      pw = document.getElementById('rotateable-circle'),
		      pwBox = pw.getBoundingClientRect(),
		      center_x = (pwBox.left + pwBox.right) / 2,
		      center_y = (pwBox.top + pwBox.bottom) / 2,
		      // get mouse position
		      mouse_x = event.pageX,
		      mouse_y = event.pageY,
		      radians = Math.atan2(mouse_x - center_x, mouse_y - center_y),
		      degree = Math.round((radians * (180 / Math.PI) * -1) + 100);
		
		    var rotateCSS = 'rotate(' + (degree + 170) + 'deg)';
		    $('#rotateable-circle').css({
		      '-moz-transform': rotateCSS,
		      '-webkit-transform': rotateCSS
		    });
		    
		    
		    
		  }
		});*/
		
		
		/*$('#rotateable-rect').draggable({
			  handle: '#rotate-rect',
			  opacity: 0.001,
			  helper: 'clone',
			  drag: function(event) {
			    var // get center of div to rotate
			      pw = document.getElementById('rotateable-rect'),
			      pwBox = pw.getBoundingClientRect(),
			      center_x = (pwBox.left + pwBox.right) / 2,
			      center_y = (pwBox.top + pwBox.bottom) / 2,
			      // get mouse position
			      mouse_x = event.pageX,
			      mouse_y = event.pageY,
			      radians = Math.atan2(mouse_x - center_x, mouse_y - center_y),
			      degree = Math.round((radians * (180 / Math.PI) * -1) + 100);
			
			    var rotateCSS = 'rotate(' + (degree + 170) + 'deg)';
			    $('#rotateable-rect').css({
			      '-moz-transform': rotateCSS,
			      '-webkit-transform': rotateCSS
			    });
			  }
			});*/
		
		$('#draggable-circle').width(tableC_W);
		$('#draggable-circle').height(tableC_W);
		$('#draggable-rect').width(tableR_W);
		$('#draggable-rect').height(tableR_H);
		$('#draggable-circle').css('bottom', ($('#flooricon-div').height() - $('#draggable-circle').height())/2);
		$('#draggable-rect').css('bottom', ($('#flooricon-div').height() - $('#draggable-rect').height())/2);
		
		
		$('#draggable-circle').css('left', ($('#floor-enable').width()/2 - $('#draggable-circle').width())/2 + 40);
		$('#draggable-rect').css('right', ($('#floor-enable').width()/2 - $('#draggable-rect').width())/2 + 40);
		
		
		/*$('#rotateable-circle').width('100%');
		$('#rotateable-circle').height('100%');
		$('#rotateable-rect').width('100%');
		$('#rotateable-rect').height('100%');*/
		
		
		
		

	}
	
	
	
	
	
	
	
	
	
	$('#floor-enable').droppable({
		drop: function(event) {
			
            
            if(currentDrag=="#draggable-circle"||currentDrag=="#draggable-rect") {
            	var pos = $(currentDrag).position();
            	// alert(pos.left + ',' + pos.top);
            	xPos = pos.left;
            	yPos = pos.top;

            	createTable(currentDrag, xPos, yPos, $(currentDrag).attr('min'), $(currentDrag).attr('max'), 0, $(currentDrag).height(), $(currentDrag).width(), 0);
            	/*currentDrag = '';*/
			}
            else {
            	setTableInfo();
            	for(var i=0; i<tableInfo.length; i++) {
            		// console.log(tableInfo[i].x + ',' + tableInfo[i].y);            	
            	}
            }
            // alert(currentDrag);
            
		}
		
	});
	
	$('#floor-edit').droppable({
		drop: function(event) {
			setTableIcon();				
			if(currentDrag=="#draggable-circle"||currentDrag=="#draggable-rect") {
			}
			else {
			}
			
			/*tableInfo = $('.draggable-table').map(function(idx, elem) {
				var abX = (parseInt($(elem).css('left')) - parseInt($('#floor-enable').css('left')))/($('#floor-enable').width()-$(elem).width())*100;
				var abY = (parseInt($(elem).css('top')) - parseInt($('#floor-enable').css('top')))/($('#floor-enable').height()-$(elem).height())*100;
				return {x: abX, y: abY, shape: '?', angle: 0, min: 2, max: 4, ID: elem.id};
			});
			*/
			
			
			
		
			
		}
	});
	
	$('#flooricon-div').droppable({
		drop: function(event) {
			if(!(currentDrag=="#draggable-circle"||currentDrag=="#draggable-rect")) {
				$(currentDrag).remove();
				setTableInfo();
				

				
				
				
				
			}
		}
	});
	
	
	
	function createTable(cd, x, y, mi, ma, deg, h, w, no) {
		
		var create_table_no = 1;
		
		if(no == 0) {
			while(true) {
				if($('#draggable-table' + create_table_no).length==0) {
					break;
				}
				create_table_no += 1;
			}
		}
		else{
			create_table_no = no;
		}
		
		/*var tableShape = '?';*/
		/*var tableAngle = 0;*/
		/*var tableMin = 2;*/
		/*var tableMax = 4;*/
		/*if(cd=="#draggable-circle") {
			table_shape = "circle";
		} else if(cd=="#draggable-rect") {
			table_shape = "rect"
		}*/
		
		var html = '' +
		'<div id="draggable-table' + create_table_no + '">' +
		/*'<div id="rotateable-circle">' +
				'<div id="rotate-circle"></div>' +
			'</div>' +*/
		'<div id="drag-table' + create_table_no + '"></div>' +
		'</div>';
		$( '#floor-edit' ).append(html);
		
		$('#draggable-table' + create_table_no).attr('min', mi);
		$('#draggable-table' + create_table_no).attr('max', ma);
		
		
		$('#draggable-table' + create_table_no).draggable({
			handle: '#drag-table' + create_table_no,
			containment: '#floor-edit',
			drag: function(event) {
				currentDrag = "#draggable-table" + create_table_no;
			}
		
		});
		
		if(cd=="#draggable-circle") {
			/*tableShape = 'circle';*/
			$('#draggable-table' + create_table_no).width(w);
			$('#draggable-table' + create_table_no).height(w);
			/*$('#drag-table' + create_table_no).css('border-radius', '50%');*/
			
			/*$('#draggable-table' + create_table_no).addClass('draggable-table');*/
			$('#drag-table' + create_table_no).addClass('drag-table-circle');
		}
		else if(cd=="#draggable-rect") {
			/*tableShape = 'rect';*/
			$('#draggable-table' + create_table_no).width(w);
			$('#draggable-table' + create_table_no).height(h);

			/*$('#draggable-table' + create_table_no).addClass('draggable-table');*/
			$('#drag-table' + create_table_no).addClass('drag-table-rect');
			/*$('#drag-table' + create_table_no).css('border-radius', '3%');*/
		}
		
		
		/*$('#draggable-table' + create_table_no).css('position', 'absolute');*/
		$('#draggable-table' + create_table_no).css('top', y);
		$('#draggable-table' + create_table_no).css('left', x);
		$('#draggable-table' + create_table_no).addClass('draggable-table');
		
		/*$('#drag-table' + create_table_no).width('100%');
		$('#drag-table' + create_table_no).height('100%');
		$('#drag-table' + create_table_no).css('position', 'absolute');
		$('#drag-table' + create_table_no).css('background-color', '#808080');
		$('#drag-table' + create_table_no).css('border', '1px solid #ff0000');*/
		
		/*alert(cd + '');*/
		
		
		
		setTableInfo();
		
		
		
		
		
		
		
		
	}
	
	

	/*
	
	$('#' + tableInfo[i].ID).css('left', (tableInfo[i].x*($('#floor-enable').width())/100+parseInt($('#floor-enable').css('left'))+($('body').width()-$('#floorCenterDivChild').width())/2 + parseInt(borderSize[0])));
	$('#' + tableInfo[i].ID).css('top', ((tableInfo[i].y*($('#floor-enable').height())/100)+(parseInt($('#floor-enable').css('top')))+ parseInt($('#floorCenterDiv').css('margin-top').replace('px',''))+parseInt(borderSize[0])));
	
	*/
	
	
	
	function setTableInfo() {
		tableInfo = $('.draggable-table').map(function(idx, elem) {
			var abX = parseInt($(elem).css('left'))/($('#floor-enable').width()) * 100;
			var abY = parseInt($(elem).css('top'))/($('#floor-enable').height()) * 100;
			/*var tableHeight;
			var tableWidth;*/
			var tableShape = '?';
			var tableAngle = 0;
			var tableMin = $(elem).attr('min');
			var tableMax = $(elem).attr('max');
			
			if($('#drag-table' + elem.id.replace('draggable-table', '')).hasClass('drag-table-circle')) {
				tableShape = 'circle';
			}
			else if($('#drag-table' + elem.id.replace('draggable-table', '')).hasClass('drag-table-rect')) {
				tableShape = 'rect';
			}
			// console.log('쉬바:' + abX + ',' + abY);
			
			return {x: abX, y: abY, height: $(elem).height(), width: $(elem).width(), shape: tableShape, angle: tableAngle, min: tableMin, max: tableMax, ID: elem.id};
		});
		
		$('#table-info-table').html('<tr><th>No.</th><th>shape</th><th>min</th><th>max</th><th>del</th></tr>');
		
		var floorMax = 0;
		for(var i=0; i<tableInfo.length; i++) {
			/*console.log(tableInfo[i]);*/
			var no = tableInfo[i].ID;
			no = no.replace('draggable-table', '');
			var html = '<tr><td>' + no + '</td><td>' + tableInfo[i].shape +
			'</td><td><input type="number" id="min' + no + '" value="' + tableInfo[i].min + '" class="tableMinMax" min="0" style="width: 30px;"></td><td><input type="number" id="max' + no + '" value="' + tableInfo[i].max + '" class="tableMinMax" min="0" style="width: 30px;"></td><td>' +
			'<button id="del' + no + '" class="tableDelBtn">×</button></td></tr>';
			$('#table-info-table').append(html);
			floorMax += parseInt(tableInfo[i].max);
		}
		
		$('#floorTable-info').html('테이블 수: ' + tableInfo.length + '<br>' + '최대 수용인원: ' + floorMax + '명');
		
		$('.tableDelBtn').on('click', function() {
			delTable(this.id.replace('del', ''));
		});
		
		$('.tableMinMax').on('blur', function() {
			editMinMax(this.id);
		});
		
		
		
	}
	
	
	$('#saveFloorLayout').on('click', function() {
		
		var jsonData = new Array();
		
		for(var i=0; i<tableInfo.length; i++) {
			var str = tableInfo[i].x + '/' + tableInfo[i].y + '/' + 
			tableInfo[i].height + '/' + tableInfo[i].width + '/' + tableInfo[i].shape + '/' + 
			tableInfo[i].angle + '/' + tableInfo[i].min + '/' + tableInfo[i].max + '/' + tableInfo[i].ID;
			
			jsonData.push(str);
		}
		// alert(JSON.stringify(jsonData));
		// alert(actualH + ',' + actualW + ',' + currentShopNo);
		
		$.ajax({
			url:'/gurume365/floor/saveFloorLayout',
			type: 'post',
			dataType: 'text',
			data: {
				jsonData: JSON.stringify(jsonData),
				floorNo: 1,
				floorH: actualH,
				floorW: actualW,
				shopNo: currentShopNo
				
			},
			success: function(dat) {
				if(dat!=0) {
					alert("저장 완료");
				}
				else {
					alert("저장 실패");
				}
			},
			error: function(err) {
				console.log(err);
			}
			
		});
	});
	
	function delTable(tableNo) {
		$('#draggable-table' + tableNo).remove();
		setTableInfo();
	}


	function editMinMax(minMaxId) {
		var att = minMaxId.substr(0,3);
		var no = minMaxId.replace(/min|max/g, '');
		var val = $('#' + minMaxId).val();
		
		$('#draggable-table' + no).attr(att, val);
		setTableInfo();
		
	}
});






