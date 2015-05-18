<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <title>스프링프레임워크 게시판</title>
    <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="/js/field-selection.js"></script>
    <style type="text/css">
    #div_prove_bg{
	  position: absolute;
	  z-index: 1000;
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100%;
	  background-color: gray; 
	  opacity: .50;
	}
    #div_prove{
	  position: absolute;
	  z-index: 1000;
	  top: 100px;
	  left: 200px;
	  width: 600px;
	  height: 600px;
	  border: 2px solid blue;
	  background-color:white;
	  padding: 5px;
	}
	.prove_head{
		border: 1px solid blue;
		cursor:hand;
	}
    </style>
    <script type="text/javascript">
	
    var prove = 0;
	$(function(){	
		
		$("#btn_add_prove").mousedown(function() {
			prove++;
			var sel_txt = $("#content").fieldSelection().text;
			if(sel_txt == ""){
				sel_txt = "논증" +prove;
			}
			$("#content").fieldSelection("{"+prove+"}"+sel_txt+"{"+prove+"}");
//			$("#prove_container").append('<div><div id="prove'+prove+'" draggable="true" ondragstart="drag(event)">논증'+prove+'</div><iframe id="frm"'+prove+' src="/daumeditor/editor.html" width="500" height="300" style="border:1px;"></iframe></div>');
			$("#prove_container").append('<div id="prove'+prove+'" draggable="true" ondragstart="drag(event)" class="prove_head">'+
					'<a href="javascript:fnModifyProve('+prove+');">논증'+prove+'</a>'+
					'<input type="hidden" id="prove_seq'+prove+'" name="prove_seq'+prove+'"/>'+
					'<div id="prove_content'+prove+'" name="prove_content'+prove+'"></div>'+
					'</div>');
			$("#div_prove_bg").show();
			$("#div_prove").show();
			
		});
		
		$("#btn_hide").click(function(){
			fnClose();
		});
		
		
	});

	
	function fnClose(){
		$("#div_prove_bg").hide();
		$("#div_prove").hide();
	}
	function fnModifyProve(seq){
		
		var params = "seq="+$("#prove_seq"+seq).val();
		console.log(params);
		$.ajax({
			url: "/getProve.bn",
			type : "POST",
			dataType : "json",
			processData: false,
			data: params,
			success : function(response,status,xhr){
				//$("#prove_content"+seq).innerHTML(data.content);
			},
			error : function (jqXHR, textStatus, errorThrown) {
				console.log ("Error occurred.[" + errorThrown + "]"+jqXHR.responseText );
			},
			timeout : function () {
				alert ("Timeout");
			}
		});
		/*
		var p = $("#prove_seq"+seq).val();
		$.postJSON("/getProve.bn",{seq:p}, function(data){
			console.log(data);
		});*/
	}
	
	
	function allowDrop(ev) {
	    ev.preventDefault();
	    
	}

	function drag(ev) {
	    ev.dataTransfer.setData("text", ev.target.id);
	}

	function drop(ev) {
	    ev.preventDefault();
	    var data = ev.dataTransfer.getData("text");
	    data = data.replace("prove", "");
	    $("#content").fieldSelection("{"+data+"}논증"+data+"{"+data+"}");
	    //ev.target.appendChild(document.getElementById(data));
	}

	function fnSave(){
		
		$.ajax({
			url: "/save.bn",
			type : "POST",
			dataType : "json",
			processData: false,
			data: $("#form").serialize(),
			success : function(data){
				alert("저장되었습니다.");
			},
			error : function (jqXHR, textStatus, errorThrown) {
				alert ("Error occurred.[" + errorThrown + "]"+jqXHR.responseText );
			},
			timeout : function () {
				alert ("Timeout");
			}
		});
	}
	
	function fnSaveProve(content){
		
		$.ajax({
			url: "/saveProveTemp.bn",
			type : "POST",
			dataType : "json",
			processData: false,
			data: "content="+content,
			success : function(data){
				$("#prove_seq"+prove).val(data);
				fnClose();
			},
			error : function (jqXHR, textStatus, errorThrown) {
				alert ("Error occurred.[" + errorThrown + "]"+jqXHR.responseText );
			},
			timeout : function () {
				alert ("Timeout");
			}
		});
		
	}
	
	</script>
  </head>
  <body>
  <h1>${message}</h1>
  <form id="form" method="post">
  
  <table style="width:1000px;">
  	<colgroup>
  		<col width="50%"/>
  		<col width="50%"/>
  	</colgroup>
  	<tbody>
  		<tr>
  			<td colspan="2">
				<input type="text" name="idx" id="idx" value="${object.idx}" />
				<div>
					<span>제  목</span>
					<input type="text" id="subject" name="subject" value="${object.subject}" />
				</div>
				<div>
					<span>작성자</span>
					<input type="text" id="user_name" name="user_name" value="${object.user_name}" />
				</div>
  			</td>
  		</tr>
  		<tr>
  			<td>
	  			<div>
			  		<span>내용</span>
				  	<textarea id="content" name="content" rows="30" cols="50" ondrop="drop(event)" ondragover="allowDrop(event)">
				  	${object.content}
				  	</textarea>
		  		</div>
		  	</td>
		  	<td>
		  		<input type="button" value="논증추가" id="btn_add_prove"/>
		  		<div id="prove_container" style="width:100%;height:500px;overflow-y:scroll;" >
  				</div>
		  	</td>
  		</tr>
  	</tbody>
  </table>
  <div>
  	<input type="button" value="save" onClick="fnSave()"/>
  	<a href="./bbs.bn">목록</a>
  </div>
   </form>
   
   
<div id="div_prove_bg" style="display:none;">
</div>
<div id="div_prove" style="display:none;">
	<%@include file="./editor.jsp"%>
	<input type="button" id="btn_hide" value="닫기">
</div>

 
  </body>
</html>