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
	<input type="text" name="shop_name" id="shop_name"/>
	<input type="button" value="등록" onclick="updateShop();">
	<br>
	<h4>현재 메뉴: </h4>
	<ul id="list">
	</ul>
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
		url = window.location.pathname; 
		splitted = url.split("/");
		id = splitted[splitted.length-1];
	    $.ajax({ //샵 디테일을 가져오는 부분
	        type: "GET",
	        url: "/details/getDetails/"+id,
	        success: function (data) {
	            if (!data) {
	            	  alert("없는 페이지입니다.");
	            	  window.location.replace("/list");
	            }
	            else if (data.menu == null) {
	            	  alert("없는 페이지입니다.");
	            	  window.location.replace("/list");        	  
	            }
	          document.getElementById('shop_name').value=data.name;
	          var menu = (getCoffeeNames(data.menu)).split(",");
 	  		  console.log(menu);
 	  		  for (var i=0; i<menu.length; i++) {
 		      	var li = document.createElement("li");
 		      	li.appendChild(document.createTextNode(menu[i]));
 		      	document.getElementById('list').appendChild(li); 	  			  
 	  		  }
	        }, error: function (jqXHR, textStatus, errorThrown) {
	        }
	   });
	    
	    $.ajax({ //커피에서 커피 종류 전체를 가져오는 부분
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
	    		  alert("수정을 진행할 수  없습니다.");
	    		  window.location.replace("/");
	    	  }
	          $('.item').append(items);
	        }, error: function (jqXHR, textStatus, errorThrown) {
	        }
	   });

	});
		
	function getCoffees(){ //체크박스에 체크된 메뉴들을 가져와서 스트링으로 리턴
		  var coffees = ",";
		  $(":checkbox[name='coffee']:checked").each(function(pi, po){
			  coffees += po.value+",";
		  });
		  return coffees;
	}
	
	function updateShop() { //실제 업데이트 로직
		var menu = getCoffees();
		var shopName = $("#shop_name").val();
		shopName = shopName.replace(/\s/gi, "");
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
		url = window.location.pathname; 
		splitted = url.split("/");
		id = splitted[splitted.length-1];

	   $.ajax({
	            type: "PUT",
	            url: "/modification/updateShop/"+id,
	            headers: {
	                "Content-Type": "application/json"
	            },
	            data: JSON.stringify(info),
	            success: function (data) {
	            	console.log("POST API RESPONSE::"+data);
	            	window.location.replace("/details/"+id);
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	            	console.log(textStatus);
	            }
	        });
   }

	function getCoffeeNames(menu){
	    if (menu == ",") {
	    	return "판매중인 커피 없음";    	
	    }
	    
	    coffeeNames = "";
	    menuString = menu.slice(1);
		var param = "menu" + "=" + menuString;
	    $.ajax({
//            url: "/getCoffees",	    	
	            url: "http://9.240.101.88:8888/getCoffees",
	            type: "GET",
	            data: param,
	            crossOrigin: true,
	            async: false,
	            success: function (data) {
	            	for (var i=0; i<data.length; i++) {
	                    coffeeNames += data[i].name+",";            		
	            	}
	            }, error: function (request,status,error) {
	               console.log(request.status);
	            },
	            complete : function() {
	               console.log("getcoffeenames 완료:"+coffeeNames);
	            }
	       });
	    return coffeeNames.slice(0, -1);    
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