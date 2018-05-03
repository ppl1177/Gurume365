<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>업체 등록 정보</title>
<link rel="stylesheet" href="<c:url value="/resources/css/store.css"/>">
<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.2.1.js'/>"></script>
<script type="text/javascript">
	function addressPopup(){
		var url="jusoPopup"
		window.open(url,"","width=400,height=400,left=600");
	}
	function addressCallback(roadFullAddr,roadAddrPart1,addrDetail,
			roadAddrPart2,engAddr,jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,
			bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,
			lnbrMnnm,lnbrSlno,emdNo){
		
		document.form.roadAddrPart1.value=roadAddrPart1;
		document.form.addrDetail.value=addrDetail;
		
		var address = $('#address');
		var address2 = $('#address2');
		address.attr("value",roadAddrPart1);
		address2.attr("value",addrDetail);	
		self.close;
	}
</script>
</head>
<body>
<div>
	<div id="big_title">
		<h1>업체 등록 정보</h1>
	</div>
	<div class="company_name">
		상호명<input type="text" id="company_name">
	</div>
	<div class="address">
		주소<input type="text" id="address">
	</div>
	<div class="address2">
		상세주소<input type="text" id="address2">
		<input type="button" value="주소검색" onclick="addressPopup();">
	</div>
	<div class="phone">
		연락처<input type="text" id="phone" >
	</div>
	<div class="shop_no">
		업체번호<input type="text" id="shop_no" >
	</div>
	<div class="company_no">
		사업자등록번호<input type="text" id="company_no">
	</div>
	<div class="time_of_open">
		영업시간<input type="text" id="time_of_open">
	</div>
	<div class="category">	
		업종<input type="text" id="category" >
	</div>
	<div class="introduce">
		소개 및 세부사항<textarea rows="5" cols="40" id="introduce"></textarea>
	</div>
	<div>
		<input type="submit" value="수정">
		<input type="button" value="취소">
	</div>
</div>
</body>
</html>