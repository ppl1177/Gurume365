<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
		<script type="text/javascript">
			var stmnLEFT = 50;//오른쪽여백
			var stmnGAP1 = 0;//위쪽 여백
			var stmnGAP2 = 150;//스크롤시 브라우저 위쪽과 떨어지는 거리
			var stmnBASE = 150;//스크롤 시작위치
			var stmnActivateSpeed = 30;//스크롤을 인식하는 딜레이(숫자 클수록 느림)
			var stmnScrollSpeed = 20;//스크롤 속도(클수록 느림)
			var stmnTimer;
			
			function RefreshStaticMenu() {
				var stmnStartPoint,stmnEndPoint;
				stmnStartPoint = parseInt(document.getElementById('STATICMENU').style.top, 10);
				stmnEndPoint = Math.max(document.documentElement.scrollTop, document.body.scrollTop)+stmnGAP2;
				if (stmnEndPoint < stmnGAP1) stmnEndPoint = stmnGAP;
				if (stmnStartPoint != stmnEndPoint) {
					stmnScrollAmount = Math.ceil(Math.abs(stmnEndPoint - stmnStartPoint)/15);
					document.getElementById('STATICMENU').style.top = parseInt(document.getElementById('STATICMENU').style.top,10)+((stmnEndPoint < stmnStartPoint)?-stmnScrollAmount : stmnScrollAmount)+'px';
					stmnRefreshTimer = stmnScrollSpeed;
				}
				stmnTimer = setTimeout("RefreshStaticMenu();",stmnActivateSpeed);
			}
			function InitializeStaticMenu() {
				document.getElementById('STATICMENU').style.right = stmnLEFT + 'px';
				document.getElementById('STATICMENU').style.top = document.body.scrollTop + stmnBASE + 'px';
				RefreshStaticMenu();
			}
		</script>
		<script type="text/javascript">
			
			$("button").click(function () { $("div").remove(); });

		</script>
	</head>
		
	<body onload="InitializeStaticMenu();">
	
	<div id="STATICMENU" class="menuMain">
		<!-- 배너 코드 -->
		<div class="endButtonDiv">
			<button class="endButton" id="encButton">
				퀵메뉴 끄기
			</button>
			<hr>
		</div>
		<div>
			노쇼 할인 업체
			<hr>
		</div>
		<div>
			노쇼 할인 업체
			<hr>
		</div>
		<div>
			노쇼 할인 업체
			<hr>
		</div>
		<div>
			노쇼 할인 업체
			<hr>
		</div>
		<div>
			노쇼 할인 업체
			<hr>
		</div>
	</div>

	</body>
</html>