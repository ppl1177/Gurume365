<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
setInterval(function(){
   var address = document.getElementById('addr1').value;
   var address2 = document.getElementById('addr2').value;
   
   if(opener.currentJusoNo == -1) {
	   opener.document.getElementById('address1').value = address2;
	   opener.document.getElementById('address2').value = address;
   }
   else {
	   opener.document.getElementById('address1' + opener.currentJusoNo).value = address2;
	   opener.document.getElementById('address2' + opener.currentJusoNo).value = address;
   }
   this.close();
   
}, 50);
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="hidden" id="addr1" value="${address}">
<input type="hidden" id="addr2" value="${address2}" >
</body>
</html>