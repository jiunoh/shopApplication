<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" />
<title>Demo Application</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>

	가게 이름 : &nbsp;
	<input type="text" name="shop_name" id="shop_name" />
	<input type="button" value="등록" onclick="passToAddition();">

	<script>   
   function passToAddition() {
      
      var modelObj = {
            name: $("#shop_name").val()
      };
      
      console.log("post data:"+modelObj);      
      
		 $.ajax({
	            type: "POST",
	            url: "/addShop",
	            headers: {
	                "Content-Type": "application/json"
	            },
	            data: JSON.stringify(modelObj),
	            success: function (data) {
	            	console.log("POST API RESPONSE::"+data);
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	            }
	        });
   }
   </script>
</body>
</html>