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
    <br>
    <br>
    <div>
		<div class="menu" id="menu"></div>
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
     	  items.push("<h4>"+data.name+"</h4> 등록일: "+data.regDate+"<br>수정일: "+data.modDate+"<br>"+"총 판매량: "+data.totalSale
     			  +"<br>총 매출: "+data.totalMoney);
//			+"<a href='/deleteShop/"+data.id+"'>삭제</a> &nbsp; <a href='/modification/"+data.id+"'>수정</a>")
          $('.item').append(items);
        }, error: function (jqXHR, textStatus, errorThrown) {
        }
   });
    
  	    $.ajax({ //커피에서 커피 종류 전체를 가져오는 부분
	        type: "GET",
	        url: "/getTotalCoffeeList",
            crossOrigin: true,
            async: false,
	        success: function (data) {
	      	  var items = [];
	    	  for (var i=0; i<data.length; i++) {
	    		var ul = document.createElement("ul");
	    		var li = [];
	    		for (var i=0; i<7; i++)
	    			li[i] = document.createElement("li");
	 		    li[0].appendChild(document.createTextNode(data[i].name) );
	 		    li[1].appendChild(document.createTextNode(data[i].price) );
	 		    li[2].appendChild(document.createTextNode(data[i].inventory) );
	 		    li[3].appendChild(document.createTextNode(data[i].total_sale) );
	 		    li[4].appendChild(document.createTextNode(data[i].total_money) );
	 		    li[5].appendChild(document.createTextNode(data[i].register_date) );
	 		    li[6].appendChild(document.createTextNode(data[i].mod_date) );
	 		    ul.appendChild(li);
	    	  }
	    	  items.push('<br>');
	          $('.menu').append(items);
	        }, error: function (jqXHR, textStatus, errorThrown) {
	        }
	   });
});

</script>
</html>