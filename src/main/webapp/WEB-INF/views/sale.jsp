<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" />
<title>커피 판매</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">		</script>
</head>
<body>

	<div>
		<div class="menu" id="menu"></div>
	</div>

	<br>
	구매할 커피: 
	<br>
	<div>
		<select id="choice" name="choice" onchange="updateSaleInfo()"></select>		
    </div>
    
    <br>
    
 	구매 수량 : &nbsp;
	<input type="text" name="quantity" id="quantity" value="0"/>
	
	&nbsp; 	<input type="button" value="구매하기" onclick="sellCoffee()" />

</body>

<script>
var coffees;
var id = "";
var saleCoffeeId = "1";
var coffeesIndex = "0";

$(document).ready(function() {
	var txt="";

	var url = window.location.pathname;
	var splitted = url.split("/");
	id = splitted[splitted.length-1];
	console.log(id);
	
    $.ajax({
        type: "GET",
        url: "/details/getDetails/"+id,
        success: function (data) {
          var menuString = data.menu.slice(1);          
          console.log("메뉴스트링: "+menuString);

          coffees = getCoffees(menuString);
          var coffeeIdObj = {};
          
          txt += "<table id='menuTable' border='1' style='border-collapse:collapse' cellpadding='5'>"+"<thead>"
          +"<tr><th>번호</th> <th>이름</th>"+"<th>가격</th>"+"<th>재고</th>"+"</tr></thead><tbody>";
           for (i=0; i<coffees.length; i++) {
         	  txt += "<tr><td>"+coffees[i].id+"</td>";
        	  txt += "<td>"+coffees[i].name+"</td>";
        	  txt += "<td>"+coffees[i].price+"</td>";
        	  txt += "<td>"+coffees[i].inventory+"</td>";
        	  txt += "</tr>"
        	  coffeeIdObj[coffees[i].id] = i;
           }
           document.getElementById("menu").innerHTML = txt; //여기까지 메뉴 테이블 띄움
          
          var choices = "";
          for (i=0; i<coffees.length; i++) {
        	  choices += "<option value="+coffees[i].id+">"+coffees[i].name+"</option>";
          }
          document.getElementById("choice").innerHTML = choices;
          //여기까지 커피 선택 셀렉트박스                    
        }, error: function (jqXHR, textStatus, errorThrown) {
        }
   });
    
});

function updateSaleInfo() {
	saleCoffeeId = $("#choice option:selected").val(); //판매할 커피의 아이디
	coffeesIndex = $("#choice option").index($("#choice option:selected")); //판매할 커피의 coffees 배열 안 인덱스
    console.log("saleCoffeeId: "+saleCoffeeId);
    console.log("coffeesIndex: "+coffeesIndex);
}

function sellCoffee() {
    var quant = $('#quantity').val(); //구매 수량
    var inventory = 0;
    var menuTable = document.getElementById("menuTable");

    console.log("sell saleCoffeeId: "+saleCoffeeId);
    console.log("sell coffeesIndex: "+coffeesIndex);
    console.log("coffee for sale: "+coffees[coffeesIndex].name );    
    console.log(quant);
    
	$.ajax({
       url: "/sale/getInventory/"+saleCoffeeId,
       type: "GET",
       crossOrigin: true,
       async: false,
       success: function (data) {
    	   inventory = data;
       }, error: function (request,status,error) {
          console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       },
     });
	
	console.log(inventory);
	if (quant > inventory) {
		alert("재고가 부족합니다.");
		menuTable.rows[coffeesIndex].cells[2].innerHTML = inventory-quant;
	}
	else {
		var price = coffees[coffeesIndex].price;
		var saleInfo = {};
		saleInfo["totalSale"] = quant;
		saleInfo["totalMoney"] = price*quant;
		
		$.ajax({
		       url: "/sale/postSaleData/"+saleCoffeeId,
		       type: "POST",
		       crossOrigin: true,
		       async: false,
	           data: quant,
		       success: function (data) {
		    	   console.log(data);
		       }, error: function (request,status,error) {
	               console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		       },
		});
		$.ajax({
		       url: "/sale/updateSaleData/"+id,
		       type: "POST",
		       data: JSON.stringify(saleInfo),
		       success: function (data) {		    	   
		    	   menuTable.rows[coffeesIndex].cells[2].innerHTML = inventory-quant;		    	   
		    	   alert("판매되었습니다.");
		       }, error: function (request,status,error) {
	               console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		       },
		});
	}
	
	
}


///메뉴에 해당하는 커피 객체들을 받아옴
function getCoffees(menu){
    var coffees = [];
    $.ajax({
	        url: "/getCoffees/"+menu,
//            url: "http://9.240.101.88:8888/getCoffees/"+menuString,
            type: "GET",
            crossOrigin: true,
            async: false,
            success: function (data) {
            	for (var i=0; i<data.length; i++) {
            		coffees.push(data[i]);
            	}
            }, error: function (request,status,error) {
               console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
    });
    console.log(menu);
    console.log("getCoffees: "+coffees[0]);
    return coffees;
}

</script>
</html>