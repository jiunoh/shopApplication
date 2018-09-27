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
	<br>
	<div>
		<input type="checkbox" name="checkAll" id="checkAll" onclick="checkAll();"/>전체선택
		<div class="item" id="item"></div>
    </div>
	
	<input type ="button" value="메인으로" onclick="location.href='/'">
	<input type="button" value="목록으로" onClick="location.href='/list'"></body>
</body>
	<script>
	
	$(document).ready(function() {
	    $.ajax({
	        type: "GET",
//	        url: "/getCoffeeList",
	        url: "http://9.240.101.88:8888/getCoffeeList",
            crossOrigin: true,
            async: false,
	        success: function (data) {
	      	  var items = [];
	    	  for (var i=0; i<data.length; i++) {
	      		  items.push('<input type="checkbox" name="coffee" value="'+data[i].id+'">'+data[i].name+"<br>")
	    	  }
	    	  items.push('<br>');
	    	  if (items.length == 1) {
	    		  alert("등록을 진행할 수  없습니다.");
	    		  window.location.href = "/";
	    	  }
	          $('.item').append(items);
	        }, error: function (jqXHR, textStatus, errorThrown) {
	        }
	   });
	});
	
	function getCoffees(){
		  var coffees = ",";
		  $(":checkbox[name='coffee']:checked").each(function(pi, po){
			  coffees += po.value+",";
		  });
		  return coffees;
	}
	
	function addShop() {
		var menu = getCoffees();
		var shopName = $("#shop_name").val();
		if (!shopName) {
			alert("가게 이름은 비워둘 수 없습니다.");
			return false;			
		}
		if (menu == ",") {
			alert("하나 이상의 커피를 선택하세요.");
			return false;
		}
			
		var info = {}
		info["shopName"] = shopName;
		info["menu"] = menu;

	   $.ajax({
	            type: "POST",
	            url: "/addition/addShop",
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
	
	function checkAll(){
	      if( $("#checkAll").is(':checked') ){
	        $("input[name=coffee]").prop("checked", true);
	      }else{
	        $("input[name=coffee]").prop("checked", false);
	      }
	}
   </script>
</html>