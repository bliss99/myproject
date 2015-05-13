<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <title>스프링프레임워크 게시판</title>
    <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script type="text/javascript">
	
    var brace = "";
	$(function(){	
		
		$("#content").keydown(function(e) {
		    if (e.keyCode == 221){
		    	if(brace==""){
		    		brace = "}";
		    	}
		    	else{
		    		
		    	}
		    }else{
		    	brace = "";
		    }
		});
		
		
		$("#btn_add_link").click(function() {
			
		});
			
	});
	
	</script>
  </head>
  <body>
  <h1>${message}</h1>
  <form id="form" method="post" action="./write_ok.bn">
  <div>
	  <input type="hidden" name="idx" id="idx" value="${object.idx}" />
	  <div>
	  	<span>제목</span>
	  	<input type="text" id="subject" name="subject" value="${object.subject}" />
	  </div>
	  <div>
	  	<span>작성자</span>
	  	<input type="text" id="user_name" name="user_name" value="${object.user_name}" />
	  </div>
	  <div>
	  	<span>내용</span>
	  	<a href="#" title="내용">내용</a>
	  	<input type="button" value="내용"/>
	  	<textarea id="content" name="content" rows="40" cols="80">${object.content}</textarea>
	  </div>
	  <div>
	  	<select multiple="multiple" style="width:100px;height:200px;">
	  	</select>
	  </div>
  </div>
  <div>
  	<input type="submit" value="save" />
  	<a href="./bbs.bn">목록</a>
  </div>
  
  <div style="display:;">
   	<iframe src="/daumeditor/editor.html" width="500" height="500" style="border:1px;">
<!-- 
 	<iframe src="/ckeditor/samples/index.html" width="500" height="500" style="border:1px;">
 -->
  	</iframe>
  </div>
  
  </form>
  </body>
</html>