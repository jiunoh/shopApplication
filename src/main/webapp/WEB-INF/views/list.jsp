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
<a href='/'>홈으로 돌아가기</a> &nbsp;  <a href='/addition'>카페 등록</a>
<br>
<br>
	<div>
		<div class="item" id="item"></div>
    </div>


</body>
<script>

$(document).ready(function() {
    $.ajax({
        type: "GET",
        url: "/list/getShopList",
        success: function (data) {
      	  var items = [];
      	  $.each(data, function() {
      		  items.push("<h4>"+this.name+"</h4> <ul> <li> 등록: "+this.regDate+"</li><li>메뉴: "
      				  +getCoffeeNames(this.menu, this.id)
				+"</li> <a href='/details/"+this.id+"'>자세히</a>")
      	  });
      	  if (items.length == 0)
      		  items.push("등록된 가게가 없습니다.");
      	  
          $('.item').append(items);
        }, error: function (jqXHR, textStatus, errorThrown) {
        }
   });
});

function getCoffeeNames(menu, id){
    var coffeeNames = "";
    var menuString = menu.slice(1);
	var param = "menu" + "=" + menuString;
    var newMenu = ",";
    $.ajax({
	        url: "/getCoffees",    	
//            url: "http://9.240.101.88:8888/getCoffees",
            type: "GET",
            crossOrigin: true,
            async: false,
            data: param,
            success: function (data) {
            	for (var i=0; i<data.length; i++) {
                	console.log("for문 "+i+": "+data[i].name);
                    coffeeNames += data[i].name+", ";            		
      			    newMenu += data[i].id+",";                    
            	}
            }, error: function (request,status,error) {
               console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            complete : function() {
               console.log("getcoffeenames 완료:"+coffeeNames);
            }
       });

    if (newMenu != menu) {
        console.log(newMenu);
	    updateMenu(newMenu, id);
    }
    return coffeeNames.slice(0, -2);    
}

function updateMenu(newMenu, id) {
	var param = "menu" + "=" + newMenu;
	   $.ajax({
           type: "POST",
           url: "/list/updateMenu/"+id,
           data: param,
           success: function (data) {
        	   console.log(data);
           },
           error: function (jqXHR, textStatus, errorThrown) {
           }
       });	
}
</script>
</html>