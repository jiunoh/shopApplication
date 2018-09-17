<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" />
<title>가게 등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>

	가게 이름 : &nbsp;
	<input type="text" name="shop_name" id="shop_name" value="${shop.name}" />
	<input type="button" value="등록" onclick="updateShop();">
	<input type="hidden" id="id" name="id" value="${shop.id}">
	<br>
	<h4>현재 메뉴: </h4>
	<ul>
	<c:forTokens var="coffee" items="${shop.menu}" delims="/">
		<li>${coffee}</li>
	</c:forTokens>
	</ul>
	
	<input type="checkbox" name="coffee" value="coffee1">coffee1
	<input type="checkbox" name="coffee" value="coffee2">coffee2
	<input type="checkbox" name="coffee" value="coffee3">coffee3
	<input type ="button" value="메인으로" onclick="location.href='/home'">
	<input type="button" value="목록으로" onClick="location.href='/list'"></body>
	
</body>
	<script>
	
	function getCoffees(){
		  var coffees = "";
		  $(":checkbox[name='coffee']:checked").each(function(pi, po){
			  coffees += po.value+"/";
		  });
		  return coffees;
	}
	
	function updateShop() {
		var info = {}
		info["shopName"] = $("#shop_name").val();
		info["menu"] = getCoffees();
		id = $("#id").val();

	   $.ajax({
	            type: "POST",
	            url: "/updateShop/"+id,
	            headers: {
	                "Content-Type": "application/json"
	            },
	            data: JSON.stringify(info),
	            success: function (data) {
	            	console.log("POST API RESPONSE::"+data);
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	            	console.log(textStatus);
	            }
	        });
   }

   </script>
</html>