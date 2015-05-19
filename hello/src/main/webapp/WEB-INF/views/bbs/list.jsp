<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <style type="text/css">
    	ul	{list-style: none;padding:0;margin:0}
    	li	{list-style: none;padding:0;margin:0; float:left;}
    </style>
    <title>스프링프레임워크 게시판</title>
    <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script>
	   $(function(){
			
		   circleOpinion();
		   
	   });
    
	   function circleOpinion(){
		   var arr = new Array();
		   arr[0] = "의견1";
		   arr[1] = "의견2";
		   arr[2] = "의견3";
		   arr[3] = "의견4";
		   
		   drawPoints(300,300,2,100, Math.PI, arr);
	   }
	   
	   function drawStar(cx,cy,spikes,outerRadius,innerRadius, degree){
		   var canvas=document.getElementById("canvas");
			var ctx=canvas.getContext("2d");
			var rot=degree;
			$("#test").val(rot);
			var x=cx;
			var y=cy;
			var ox;
			var oy;
			var step=Math.PI/spikes;
			
			ctx.strokeStyle="green";
			ctx.beginPath();
//			ctx.moveTo(cx,cy-outerRadius);
			for(i=0;i<spikes;i++){
				x=cx+Math.cos(rot)*outerRadius;
				y=cy+Math.sin(rot)*outerRadius;
				if(i==0){
					ctx.moveTo(x,y);
					ox = x;
					oy = y;
				}
				else{
					ctx.lineTo(x,y);
				}
			//	ctx.fillText("("+Math.round(x)+" , "+Math.round(y)+")",x+5,y+10);
			//	console.log(Math.cos(rot) +" , "+Math.sin(rot)+" --out--> "+Math.cos(rot)*outerRadius+" , " +Math.sin(rot)*outerRadius);
				rot+=step
				

				x=cx+Math.cos(rot)*innerRadius;
				y=cy+Math.sin(rot)*innerRadius;
				ctx.lineTo(x,y)
			//	console.log(Math.cos(rot) +" , "+Math.sin(rot)+" --in--> "+Math.cos(rot)*innerRadius+" , " +Math.sin(rot)*innerRadius);
			//	ctx.fillText("("+Math.round(x)+" , "+Math.round(y)+")",x+5,y+10);
				rot+=step
				
			}
		//	ctx.lineTo(cx,cy-outerRadius);
			ctx.lineTo(ox,oy);
			ctx.stroke();
			ctx.closePath();
		}
	   
	   function drawPoligons(cx,cy,spikes,radius, degree){
		   	var canvas=document.getElementById("canvas");
			var ctx=canvas.getContext("2d");
			
			var rot=degree;
			var x=cx;
			var y=cy;
			var ox;
			var oy;
			var step=2*Math.PI/spikes;
			
			ctx.strokeStyle="red";
			ctx.beginPath();
//			ctx.moveTo(cx,cy-outerRadius);
			for(i=0;i<spikes;i++){
				x=cx+Math.cos(rot)*radius;
				y=cy+Math.sin(rot)*radius;
				if(i==0){
					ctx.moveTo(x,y);
					ox = x;
					oy = y;
				}
				else{
					ctx.lineTo(x,y);
				}
			//	ctx.fillText("("+Math.round(x)+" , "+Math.round(y)+")",x+5,y+10);
			//	console.log(Math.cos(rot) +" , "+Math.sin(rot)+" --out--> "+Math.cos(rot)*outerRadius+" , " +Math.sin(rot)*outerRadius);
				rot+=step
				
			}
		//	ctx.lineTo(cx,cy-outerRadius);
			ctx.lineTo(ox,oy);
			ctx.stroke();
			ctx.closePath();
		}
	   
	   function drawPoints(cx,cy,spikes,radius, degree, arr_opinions){
		   	var canvas=document.getElementById("canvas");
			var ctx=canvas.getContext("2d");
			
			spikes = arr_opinions.length;
			
			var rot=degree;
			var x=cx;
			var y=cy;
			var ox;
			var oy;
			var step=2*Math.PI/spikes;
			
			circle(ctx,cx,cy, radius);
			
			ctx.strokeStyle="red";
			ctx.beginPath();
			opinionCircle(ctx,cx,cy, 20);
//			ctx.moveTo(cx,cy-outerRadius);
			for(i=0;i<spikes;i++){
				x=cx+Math.cos(rot)*radius;
				y=cy+Math.sin(rot)*radius;
				ctx.moveTo(x,y);
				opinionCircle(ctx, x,y,3);
				ctx.fillText(arr_opinions[i], x+5,y+10);
			//	console.log(Math.cos(rot) +" , "+Math.sin(rot)+" --out--> "+Math.cos(rot)*outerRadius+" , " +Math.sin(rot)*outerRadius);
				rot+=step
				
			}
		//	ctx.lineTo(cx,cy-outerRadius);
		//	ctx.lineTo(ox,oy);
		//	ctx.stroke();
		//	ctx.closePath();
		
			
		}
	   
		function opinionCircle(context, x,y, radius){
			context.arc(x, y, radius, 0, 2 * Math.PI, false);
			context.fillStyle = 'green';
			context.fill();
			context.lineWidth = 2;
			context.strokeStyle = '#003300';
		//	context.stroke();
		}
		
		function circle(context, x,y, radius){
			context.arc(x, y, radius, 0, 2 * Math.PI, false);
			context.lineWidth = 1;
			context.strokeStyle = 'yellow';
			context.stroke();
		}
	</script>
  </head>
  <body>
	
  <h1>${message}</h1>
  <ul>
  	<li>
  <table border="1">
    <colgroup>
  		<col width="60">
  		<col>
  		<col width="115">
  		<col width="85">
  	</colgroup>
  <thead>
    <tr>
      <th scope="col">번호</th>
      <th scope="col">제목</th>
      <th scope="col">작성자</th>
      <th scope="col">등록일</th>
    </tr>
    </thead>

    <tbody>
    <!-- 목록이 반복될 영역 -->
    <c:forEach var="item" items="${list}" varStatus="status">
    <tr>
      <td>${item.idx}</td>
      <td><a href="./${item.idx}.bn">${item.subject}</a></td>
      <td>${item.user_name}</td>
      <td>${item.reg_datetime}</td>
    </tr>
    </c:forEach>

    </tbody>
  </table>
  <input type="text" id="test"/>
	<div><a href="./write.bn">쓰기</a></div>
  	</li>
  	<li>
  		<canvas id="canvas" width=800 height=600 style="border:0px solid;"></canvas>
  	</li>
  </ul>
  
  </body>
</html>