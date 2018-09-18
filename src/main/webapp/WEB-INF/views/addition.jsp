<%@ page contentType="text/html; charset=UTF-8"%>
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
	<input type="text" name="shop_name" id="shop_name" />
	<input type="button" value="등록" onclick="addShop();">
	<br>
	<input type="checkbox" name="coffee" value="coffee1">coffee1
	<input type="checkbox" name="coffee" value="coffee2">coffee2
	<input type="checkbox" name="coffee" value="coffee3">coffee3
	
	<input type ="button" value="메인으로" onclick="location.href='/'">
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
	
	function addShop() {
		var info = {}
		info["shopName"] = $("#shop_name").val();
		info["menu"] = getCoffees();

	   $.ajax({
	            type: "POST",
	            url: "/addShop",
	            headers: {
	                "Content-Type": "application/json"
	            },
	            data: JSON.stringify(info),
	            success: function (data) {
	            	window.location.replace("/list");
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	            }
	        });
   }

   </script>
</html>