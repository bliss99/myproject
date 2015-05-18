<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <style type="text/css">
    pre {
    white-space: -moz-pre-wrap; /* Mozilla, supported since 1999 */
    white-space: -pre-wrap; /* Opera */
    white-space: -o-pre-wrap; /* Opera */
    white-space: pre-wrap; /* CSS3 - Text module (Candidate Recommendation) http://www.w3.org/TR/css3-text/#white-space */
    word-wrap: break-word; /* IE 5.5+ */
}
    </style>
    <title>스프링프레임워크 게시판</title>
  </head>
  <body>

    <script>
    function del(){
      if (confirm("삭제하시겠습니까?")) document.form.submit();
    }
    
    function fnOpenProve(num){
    	var params = "idx="+$("#idx").val()+"&num="+num;
		console.log(params);
		$.ajax({
			url: "/getProve2.bn",
			type : "POST",
			dataType : "json",
			processData: false,
			data: params,
			success : function(response){
				$("#prove_content").html(response.content);
				$("#prove_content").show();
			},
			error : function (jqXHR, textStatus, errorThrown) {
				console.log ("Error occurred.[" + errorThrown + "]"+jqXHR.responseText );
			},
			timeout : function () {
				alert ("Timeout");
			}
		});
    }
    
    
    </script>

    <form id="form" name="form" method="post" action="./delete.bn">
      <input type="hidden" id="idx" name="idx" value="${object.idx}" />
    </form>
    <p>${object.subject}</p>

    <div style="width:1000px;">
    <pre>
    ${object.content}
    </pre>
    </div>

    <div>
    <p>작성자 : ${object.user_name}</p>
    <p>등록일 : ${object.reg_datetime}</p>
    </div>
<div id="prove_content"></div>

    <div>
      <button type="button" onclick="del()">삭제</button>
      <a href="./write.bn?idx=${object.idx}">수정</a>
      <a href="./bbs.bn">목록</a>
      <a href="./writeAgree.bn?idx=${object.idx}">찬성</a>
      <a href="./writeOppose.bn?idx=${object.idx}">반대</a>
    </div>
  </body>
</html>