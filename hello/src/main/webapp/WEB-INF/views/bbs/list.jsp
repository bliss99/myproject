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
    <script src="/js/pixi.js"></script>
	<script>
	   $(function(){
			
		   circleOpinion();
		  /* 
		   var renderer = PIXI.autoDetectRenderer(800, 600,{backgroundColor : 0x1099bb});
		   $("#pixi").append(renderer.view);

		   // create the root of the scene graph
		   var stage = new PIXI.Container();

		   stage.interactive = true;
		   
		   var container = new PIXI.Container();

		   var graphics = new PIXI.Graphics();

			// set a fill and line style
			graphics.beginFill(0xFF3300);
			graphics.lineStyle(4, 0xffd900, 1);
	
			// draw a shape
			graphics.moveTo(50,50);
			graphics.lineTo(250, 50);
			graphics.lineTo(100, 100);
			graphics.lineTo(50, 50);
			graphics.endFill();
	
			// set a fill and a line style again and draw a rectangle
			graphics.lineStyle(2, 0x0000FF, 1);
			graphics.beginFill(0xFF700B, 1);
			graphics.drawRect(50, 250, 120, 120);
	
			// draw a rounded rectangle
			graphics.lineStyle(2, 0xFF00FF, 1);
			graphics.beginFill(0xFF00BB, 0.25);
			graphics.drawRoundedRect(150, 450, 300, 100, 15);
			graphics.endFill();
	
			// draw a circle, set the lineStyle to zero so the circle doesn't have an outline
			graphics.lineStyle(0);
			graphics.beginFill(0xFFFF0B, 0.5);
			graphics.drawCircle(470, 90,60);
			graphics.endFill();
	
	
			stage.addChild(graphics);
		   
		   stage.addChild(container);

		   for (var j = 0; j < 5; j++) {

		       for (var i = 0; i < 5; i++) {
		           var bunny = PIXI.Sprite.fromImage('/js/bunny.png');
		           bunny.x = 40 * i;
		           bunny.y = 40 * j;
		           container.addChild(bunny);
		       };
		   };
		   container.x = 100;
		   container.y = 60;

		   // start animating
		   animate();

		   function animate() {

		       requestAnimationFrame(animate);

		       // render the root container
		       renderer.render(stage);
		   }*/
	   });
    
	   
	    
	   function circleOpinion(){
		   var arr = {	opinion:[{title:"의견1"
			   						,yesopinion:[{title:"찬성1"},{title:"찬성2"},{title:"찬성3"},{title:"찬성4"},{title:"찬성5"}]
		   							,noopinion:[{title:"반대1"},{title:"반대2"},{title:"반대3"}]}
		   						,{title:"의견2",noopinion:[{title:"반대1"},{title:"반대2"}]}
		   						,{title:"의견3",yesopinion:[{title:"찬성1"}],noopinion:[{title:"반대1"}]}
		   						,{title:"의견4",yesopinion:[{title:"찬성1"}],noopinion:[{title:"반대1"}]}
		   						,{title:"의견5",yesopinion:[{title:"찬성1"},{title:"찬성2"}],noopinion:[{title:"반대1"},{title:"반대2"},{title:"반대3"},{title:"반대4"}]}
				            ]
		   };
		   
		   
		   drawPoints(300,300,150, Math.PI, arr);
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
	   
	   function drawPoints(cx,cy,radius, degree, data){
		   	var canvas=document.getElementById("canvas");
			var ctx=canvas.getContext("2d");
			
			var spikes = data.opinion.length;
			
			var rot=degree;
			var x=cx;
			var y=cy;
			var ox;
			var oy;
			var step=2*Math.PI/spikes;
			
			circle(ctx,cx,cy, radius);
		
		//	drawEllipse(ctx,cx,cy, 400, 200);
		
			ctx.strokeStyle="red";
			ctx.beginPath();
			opinionCircle(ctx,cx,cy, 2);
//			ctx.moveTo(cx,cy-outerRadius);
			for(var i=0;i<spikes;i++){
				x=cx+Math.cos(rot)*radius;
				y=cy+Math.sin(rot)*radius;
				ctx.moveTo(x,y);
				opinionCircle(ctx, x,y,3);
				var txt = data.opinion[i].title;
				ctx.fillText(txt, x-(txt.length*10/2),y+15);
				if(data.opinion[i].hasOwnProperty("yesopinion")){
					drawYes(x,y,100,Math.PI,data.opinion[i]);
				}
				if(data.opinion[i].hasOwnProperty("noopinion")){
					drawNo(x,y,100,Math.PI,data.opinion[i]);
				}
			//	console.log(Math.cos(rot) +" , "+Math.sin(rot)+" --out--> "+Math.cos(rot)*outerRadius+" , " +Math.sin(rot)*outerRadius);
				rot+=step
				
			}
		//	ctx.lineTo(cx,cy-outerRadius);
		//	ctx.lineTo(ox,oy);
		//	ctx.stroke();
		//	ctx.closePath();
		
			
		}
	   
		function opinionCircle(context, x,y, radius, color){
			context.arc(x, y, radius, 0, 2 * Math.PI, false);
			context.fillStyle = color;
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
		
		function drawEllipse(context, centerX, centerY, width, height) {
			
			  context.beginPath();
			  
			  context.moveTo(centerX, centerY - height/2); // A1
			  
			  context.bezierCurveTo(
			    centerX + width/2, centerY - height/2, // C1
			    centerX + width/2, centerY + height/2, // C2
			    centerX, centerY + height/2); // A2

			  context.bezierCurveTo(
			    centerX - width/2, centerY + height/2, // C3
			    centerX - width/2, centerY - height/2, // C4
			    centerX, centerY - height/2); // A1
			 
			    context.strokeStyle = 'yellow';
			    context.stroke();
			  context.closePath();	
		}
		
		
		function drawYesArch(cx,cy,radius, degree, data){
		   	var canvas=document.getElementById("canvas");
			var ctx=canvas.getContext("2d");
			var spikes = data.yesopinion.length;
			
			var rot=Math.PI/2;
			var x=cx;
			var y=cy;
			var ox;
			var oy;
			var step=Math.PI/(spikes-1);
			
			ctx.arc(x, y, radius, 0, Math.PI, false);
			ctx.lineWidth = 1;
			ctx.strokeStyle = 'pink';
			ctx.stroke();
			
			ctx.strokeStyle="red";
			ctx.beginPath();
//			ctx.moveTo(cx,cy-outerRadius);
			for(var i=0;i<spikes;i++){
				x=cx+Math.cos(rot)*radius;
				y=cy+Math.sin(rot)*radius;
				ctx.moveTo(x,y);
				opinionCircle(ctx, x,y,3,"green");
				var txt = data.yesopinion[i].title;
				ctx.fillText(txt, x-(txt.length*10),y+5);
				rot+=step
				
			}
		}
		
		function drawYes(cx,cy,radius, degree, data){
		   	var canvas=document.getElementById("canvas");
			var ctx=canvas.getContext("2d");
			var ops = data.yesopinion.length;
			
			var txt_height = 20;
			var x=cx-30;
			var y=cy-(ops*txt_height/2);
			var ox;
			var oy;
			
			
			ctx.beginPath();
			for(var i=0;i<ops;i++){
				ctx.moveTo(x,y+(i*txt_height));
				opinionCircle(ctx, x,y+(i*txt_height),3,"green");
				var txt = data.yesopinion[i].title;
				ctx.fillText(txt, x-(txt.length*10),y+(i*txt_height)+5);
			}
		}
		
		function drawNo(cx,cy,radius, degree, data){
		   	var canvas=document.getElementById("canvas");
			var ctx=canvas.getContext("2d");
			var ops = data.noopinion.length;
			
			var txt_height = 20;
			var x=cx+30;
			var y=cy-(ops*txt_height/2);
			var ox;
			var oy;
			
			
			ctx.beginPath();
			for(var i=0;i<ops;i++){
				ctx.moveTo(x,y+(i*txt_height));
				opinionCircle(ctx, x,y+(i*txt_height),3,"black");
				var txt = data.noopinion[i].title;
				ctx.fillText(txt, x+10,y+(i*txt_height)+5);
			}
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
	<div><a href="./writeMesure.bn">안건토론</a>&nbsp;<a href="./writeYesno.bn">찬반토론</a></div>
  	</li>
  	<li>
  		<canvas id="canvas" width=800 height=600 style="border:0px solid;"></canvas>
  	</li>
  	<li>
  		<div id="pixi" style="border:1px solid red"></div>
  	</li>
  </ul>
  
  </body>
</html>