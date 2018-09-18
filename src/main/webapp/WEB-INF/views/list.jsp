<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" />
<title>가게 목록</title>
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
    $.ajax({
        type: "GET",
        url: "list/getShopList",
        success: function (data) {
      	  var items = [];
      	  $.each(data, function() {
      		  items.push("<h4>"+this.name+"</h4> <ul> <li> 등록: "+this.regDate+"</li><li>메뉴: "+this.menu
				+"</li><br><a href='/deleteShop/"+this.id+"'>삭제</a> &nbsp; <a href='/modification/"+this.id+"'>수정</a> &nbsp; <a href='/details/"+this.id+"+'자세히</a>")
      	  });
                $('.item').append(items);
        }, error: function (jqXHR, textStatus, errorThrown) {
        }
   });
});

</script>
</html>