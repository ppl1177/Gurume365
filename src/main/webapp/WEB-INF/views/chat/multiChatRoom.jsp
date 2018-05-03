<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/sockjs-0.3.4.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/stomp.js"/>"></script>
	<link rel="stylesheet" href="<c:url value="/resources/css/chat.css"/>">
	
	<sec:authorize access="isAuthenticated()">
	<script type="text/javascript"></script>
	
	<script type="text/javascript">
		
		$(function(){
			var ownerId = $('#goOwnerId').html();
			var loginId = $('#goLoginId').html();
			var companyName = $('#comName').html();				
			
			connect();
			
			console.log("웹소켓 커넥트 시도");
			
			
			$("#sendBtn").on("click",function(){
				sendMessage();
			})
			document.onkeydown = function ( event ) {
			    if ( event.keyCode == 116  // F5
			        || event.ctrlKey == true && (event.keyCode == 82) // ctrl + r
			    ) {
			        //접속 강제 종료
			        disconnect();
			        // keyevent
			        event.cancelBubble = true; 
			        event.returnValue = false; 
			        setTimeout(function() {
			            window.location.reload();
			        }, 100);
			        return false;
			    }
			}
		})
		
		var stompClient = null;
		
		//채팅방 연결
		function connect() {
			
			
			// WebsocketMessageBrokerConfigurer의 registerStompEndpoints() 메소드에서 설정한 endpoint("/endpoint")를 파라미터로 전달
			var socket = new SockJS('/gurume365/endpoint');
			stompClient = Stomp.over(socket);
			console.log(stompClient);
			stompClient.connect({}, function(frame) {
				
				
				// 메세지 구독
				// WebsocketMessageBrokerConfigurer의 configureMessageBroker() 메소드에서 설정한 subscribe prefix("/subscribe")를 사용해야 함
				// 멀티 채팅방
				stompClient.subscribe('/subscribe/chat/${roomName}', function(message){
					var data = JSON.parse(message.body);
					//데이터 안에 정보 다 있음
					console.log(data);
					var loginId = document.getElementById("loginId").value;
					var ownerId = document.getElementById("ownerId").value;
					var id = data.id;
					console.log(data.id);
					var companyName = document.getElementById("companyName").value;			
						
						if (loginId == ownerId) {
							$("#data").append(id+"<br/>"+data.message+"<br/><br/>");	
						}else{
							if (id == ownerId || id == loginId) {
								$("#data").append(id+"<br/>"+data.message+"<br/><br/>");
							}
						}
				
						//스크롤 인식, 자동 내려감
						$(".chatDisplay").scrollTop($(".chatDisplay")[0].scrollHeight);

				});	
				
			});
		}
		//채팅 메세지 전달
		function sendMessage(){
			var str = $("#message").val();
			
			str = str.replace(/ /gi, '&nbsp;')
			str = str.replace(/(?:\r\n|\r|\n)/g, '<br />');
			
			if(str.length > 0){
				// WebsocketMessageBrokerConfigurer의 configureMessageBroker() 메소드에서 설정한 send prefix("/")를 사용해야 함
				// 멀티 채팅방
				stompClient.send("/chat/${roomName}", {}, JSON.stringify({
					
					message : str
					
				}));
				
			}
			
			$("#message").val("");
		}
		
		// 채팅방 연결 끊기
		function disconnect() {
			stompClient.disconnect();
		}
		
		//가게주인 호출
		function callOwner() {
			alert("가게주인 호출");
		}
	</script>
	
	</sec:authorize>
	
</head>
		<body>
			
				<!-- 채팅 헤더부분 -->
				<header>
					<div class="headerDiv">
						<div id="goCompanyName"></div>	
					
					<div>
						<img src="<c:url value="/resources/img/signal_off.png"/>" class="noSignal">
						<img src="<c:url value="/resources/img/signal_on.png"/>" class="onSignal">
					</div>
					
					</div>
				</header>
				
				
    			<div class="chatDisplay">
    					<br>
    					<span style="text-align: center; font-size: 1.00em;">GURUME365</span>
    					<hr class="chatHr">

    					
 						<sec:authorize access="isAuthenticated()">
 								<div id="data" class="data">
    							</div>
						</sec:authorize>
						
						<!-- 비 로그인 처리 -->
						<sec:authorize access="isAnonymous()">
							<p style="text-align: center; font-size: 15px;">로그인 하지 않았습니다!<br><br> 로그인해주세요</p>
						</sec:authorize>
				
				<!-- 전송, 버튼부분 -->
 				</div>
 				<sec:authorize access="isAuthenticated()">
    			<div class="sendMessage">
        			<input type="text" class="sendText" id="message">
        			
        			<button class="sendBtn" id="sendBtn" style="vertical-align:middle"><span>SEND</span></button>
        			
        			
        			<c:if test="${loginId != ownerId}">
        				<input type="button" value="가게호출하기" onclick="callOwner();" class="callBtn">
        			</c:if>
        			<c:if test="${loginId == ownerId}">
        				<select>
        					<option></option>
        				</select>
        			</c:if>
        		</div>
        		</sec:authorize>
 		 

		</body>
</html>