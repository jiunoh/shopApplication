<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" />
<title>자세히 보기</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">		</script>
</head>
<body>

	<div>
		<div class="item" id="item"></div>
    </div>

<a href='/'>홈으로 돌아가기</a>

</body>
<script>

$(document).ready(function() {
	url = window.location.pathname;
	splitted = url.split("/");
	id = splitted[splitted.length-1];
	console.log(id);
    $.ajax({
        type: "GET",
        url: "/details/getDetails/"+id,
        success: function (data) {
      	  var items = [];
	      console.log(data);
	      console.log(data.name);
     	  items.push("<h4>"+data.name+"</h4> 등록: "+data.regDate+"<br>수정: "+data.modDate+"<br>"+"총 판매량: "+data.totalSale
     			  +"<br>총 매출: "+data.totalMoney+"<br><br>"
     			  +""
			+"<a href='/deleteShop/"+data.id+"'>삭제</a> &nbsp; <a href='/modification/"+data.id+"'>수정</a>")
          $('.item').append(items);
        }, error: function (jqXHR, textStatus, errorThrown) {
        }
   });
});

</script>
</html>