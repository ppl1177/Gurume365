<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.2.1.js'/>"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<style type="text/css">

	@import "/gurume365/resources/css/table-draggable.css";
	
	
	/* html { height: 100%; width: 100%; min-height: 600px; min-width: 700px; } */
	body { margin: 0px; }

	#floor-edit
	{
		position: absolute;
		height: 600px;
		width: 440px;
		float: left;
		/* background-color: #007200; */
	}
	
	
	
	#floor-div
	{
		height: 470px;
		width: 440px;
		background-color: #eeeeee;
		
		
	}
	
	#flooricon-div
	{
		height: 130px;
		width: 700px;
		/* background-color: blue; */
		border-top: 1px solid #a0a0a0;
		background-color: #d0d0ff;
	}
	
	#info-div
	{
		float: right !important;
		height: 470px;
		width: 260px;
		float: left;
		/* background-color: #000072; */
		overflow: auto;
		overflow-x: hidden;
		background-color: #d0d0ff;
	}
	
	#tableinfo-div
	{
		
		height: 470px;
		width: 260px;
		/* background-color: yellow; */
	}
		
	#floorinfo-div
	{
		height: 130px;
		width: 260px;
		/* background-color: red; */
		float: right;
		
	}
	
	#floor-size
	{
		/* height: 50px; */
		width: 100%;
		/* background-color: gray; */
	}
	
	#floor-H,#floor-W
	{
		width: 40px;
	}
	
	#floor-enable
	{
		position: relative;
		width: 100px;
		height: 100px;
		/* background-color: purple; */
		border-right: 1px solid #a0a0a0;
		
	}
	#setSizeBtn
	{
		/* float: left; */
	}
	
	#saveFloorLayout
	{
	}
	
	.floorBtn {
		background-color: #DC143C;
	} 
	.floorBtn:hover {
		background-color: #8B0000;
	}
	.floorBtn {
		border: none;
    	color: white;
	}
	
	
</style>

<script type="text/javascript" src="/gurume365/resources/js/floor-edit.js"></script>


<title>플로어 편집</title>


</head>
<body>


	<input id="currentShopNo" type="hidden" value="${currentShopNo}">
	<div id="floorCenterDiv" style=" width: auto; height: auto; margin-top: 40px;" align="center" >
		
		<div id="floorCenterDivChild" style="width: 700px; height: 600px; border: 2px solid #a0a0a0; border-radius: 0.5% ">
			<div id="floor-edit">
			
				<div id="floor-div">
				
					<div id="floor-enable">
									
					</div>
				
				</div>
				
				<div id="flooricon-div">
				
						<div id="floorinfo-div">
					<!-- <div id="floor-size" align="center">
						&nbsp;&nbsp;세로:<input type="text" id="floor-H" placeholder="">m&nbsp;/
						&nbsp;가로:<input type="text" id="floor-W" placeholder="">m<br>
						<button id="setSizeBtn">적용</button>
						
					</div> -->
					
					<br>
					<div align="center">
						<p id="floorSize-info">
						</p>
						<p id="floorTable-info">
						</p>
						<button id="saveFloorLayout" class="floorBtn">저장</button>
						
						<a rel="modal:close"><button class="floorBtn">돌아가기</button></a>
					</div>
				</div>		
					
				
				</div>
				
				<div id="draggable-circle">
					<div id="rotateable">
						<div id="rotate"></div>
					</div>
					<div id="drag"></div>
				</div>
				
					
			</div>
		
			<div id="info-div">
			
				<div id="tableinfo-div" align="center">
					<table id="table-info-table" style="margin-top: 6px; margin-bottom: 4px;">
						<tr>
							<th>No.</th><th>shape</th><th>min</th><th>max</th><th>del</th>
						</tr>
					</table>
				</div>
				
				
			
			</div>
		</div>
		
		
		<!-- <div align="center">
		
			<div id="floor-edit">
			
				<div id="floor-div">
				
					<div id="floor-enable">
									
					</div>
				
				</div>
				
				<div id="flooricon-div">
				
								
					
				
				</div>
				
				<div id="draggable-circle">
					<div id="rotateable">
						<div id="rotate"></div>
					</div>
					<div id="drag"></div>
				</div>
				
					
			</div>
		
			<div id="info-div">
			
				<div id="tableinfo-div" align="center">
					<table id="table-info-table">
						<tr>
							<th>No.</th><th>shape</th><th>min</th><th>max</th><th>del</th>
						</tr>
					</table>
				</div>
				
				<div id="floorinfo-div">
					<div id="floor-size" align="center">
						&nbsp;&nbsp;세로:<input type="text" id="floor-H" placeholder="">m&nbsp;/
						&nbsp;가로:<input type="text" id="floor-W" placeholder="">m<br>
						<button id="setSizeBtn">적용</button>
						
					</div>
					
					<br>
					<div align="center">
						<p id="floorSize-info">
						</p>
						<p id="floorTable-info">
						</p>
						<button id="saveFloorLayout">저장</button>
						<button href="">돌아가기</button>
					</div>
				</div>
			
			</div>
			
		</div> -->
	</div>


</body>
</html>