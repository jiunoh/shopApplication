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
		<table id='menuTable' border='1' style='border-collapse:collapse' cellpadding='5'>
		</table>
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
	
	<br>
	<a href='/list'>목록으로</a> &nbsp; <a href='/'>홈으로</a>

</body>

<script>
var coffees;
var id = "";
var saleCoffeeId;
var coffeesIndex = 0;
var menuTable;

$(document).ready(function() {
	var txt="";

	var url = window.location.pathname;
	var splitted = url.split("/");
	id = splitted[splitted.length-1];
	
    $.ajax({
        type: "GET",
        url: "/details/getDetails/"+id,
        success: function (data) {
          var menuString = data.menu.slice(1);          

          coffees = getCoffees(menuString);
          var coffeeIdObj = {};
          
          txt += "<thead>"
          +"<tr><th>번호</th> <th>이름</th>"+"<th>가격</th>"+"<th>재고</th>"+"</tr></thead><tbody>";
           for (i=0; i<coffees.length; i++) {
         	  txt += "<tr><td>"+coffees[i].id+"</td>";
        	  txt += "<td>"+coffees[i].name+"</td>";
        	  txt += "<td>"+coffees[i].price+"</td>";
        	  txt += "<td>"+coffees[i].inventory+"</td>";
        	  txt += "</tr>"
        	  coffeeIdObj[coffees[i].id] = i;
           }
           saleCoffeeId = coffees[0].id;
           document.getElementById("menuTable").innerHTML = txt; //여기까지 메뉴 테이블 띄움
          
          var choices = "";
          for (i=0; i<coffees.length; i++) {
        	  choices += "<option value="+coffees[i].id+">"+coffees[i].name+"</option>";
          }
          document.getElementById("choice").innerHTML = choices;
          //여기까지 커피 선택 셀렉트박스                    
        }, error: function (jqXHR, textStatus, errorThrown) {
        }
   });
    menuTable = document.getElementById("menuTable");
});

function updateSaleInfo() {
	saleCoffeeId = $("#choice option:selected").val(); //판매할 커피의 아이디
	coffeesIndex = $("#choice option").index($("#choice option:selected")); //판매할 커피의 coffees 배열 안 인덱스
    console.log("saleCoffeeId: "+saleCoffeeId);
    console.log("coffeesIndex: "+coffeesIndex);
}

function sellCoffee() {
    var quant = $('#quantity').val(); //구매 수량
    var inventory = 0; //다시 받아올 재고
    var price = 0; //다시 받아올 가격
	var tableIndex = coffeesIndex+1;
    var coffee;

    console.log("sell saleCoffeeId: "+saleCoffeeId);
    console.log("sell coffeesIndex: "+coffeesIndex);
    console.log("sell tableIndex: "+tableIndex);
    console.log("coffee for sale: "+coffees[coffeesIndex].name );    
    console.log(quant);
    
	$.ajax({
       url: "http://9.240.101.88:8888/getOneCoffee/"+saleCoffeeId,
       type: "GET",
       crossOrigin: true,
       async: false,
       success: function (data) {
    	   console.log("data: "+data);
    	   coffee = data;
    	   inventory = data.inventory;
    	   price = data.price;
       }, error: function (request,status,error) {
          console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       },
     });
	
	if (!coffee) { //그사이 커피가 삭제됐을 경우
		menuTable.deleteRow(tableIndex);
		choice.remove(coffeesIndex);
		alert("망설이시는 사이 커피가 사라졌습니다.");		
		return false;
	}			
			
	console.log(inventory);
	menuTable.rows[tableIndex].cells[3].innerHTML = inventory; //재고 업데이트
	if (quant > inventory) { //구매수량이 재고보다 많을 경우
		alert("재고가 부족합니다.");
		return false;
	}
	else if (quant < 0) { //수량이 음수일 경우
		alert("잘못된 수량입니다.");
		return false;
	}
	else if (isNaN(quant)) {
		alert("잘못된 수량입니다.");
		return false;
	}	
	else {
		console.log("new price: "+price);
		console.log("old price: "+menuTable.rows[tableIndex].cells[2].innerHTML);
		if (price != menuTable.rows[tableIndex].cells[2].innerHTML) { //커피 가격이 변동되었을 경우
			menuTable.rows[tableIndex].cells[2].innerHTML = price;
			var willBuy = confirm("커피의 가격이 "+price+"원으로 변경되었습니다. 구매하시겠습니까?");
			if (willBuy == true) {
				doSale(quant, price, inventory, tableIndex);
			}	
			else {
				return false;
			}
		}
		else //커피 가격에 변동이 없을 경우
			doSale(quant, price, inventory, tableIndex);
		
	}//else
		
}//function

function doSale(quant, price, inventory, tableIndex) {
	var saleInfo = {};
	saleInfo["totalSale"] = quant;
	saleInfo["totalMoney"] = price*quant;
	console.log(saleInfo);
	console.log(quant);
	console.log("tableIndex: "+tableIndex);
    
	$.ajax({
		url: "http://9.240.101.88:8888/postSaleData/"+saleCoffeeId,		
//	       url: "/postSaleData/"+saleCoffeeId,
	       type: "POST",
	       crossOrigin: true,
	       async: false,
           data: quant,
	       success: function (data) {
	    	   console.log(data);		    	   
	       }, error: function (request,status,error) {
               console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               alert("커피에서 오류 발생");
               return false;
	       },
	});
	$.ajax({
	       url: "/sale/updateSaleData/"+id,
	       type: "POST",
           headers: {
                "Content-Type": "application/json"
           },
	       data: JSON.stringify(saleInfo),
	       success: function (data) {		    	   
	    	   menuTable.rows[tableIndex].cells[3].innerHTML = inventory-quant;		    	   
	    	   alert("판매되었습니다.");
	       }, error: function (request,status,error) {
               console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
               alert("샵에서 오류 발생");
               return false;
	       },
	});	
}

function getCoffees(menu){
    var coffees = [];
	var param = "menu" + "=" + menu;
    $.ajax({
//	        url: "/getCoffees",
            url: "http://9.240.101.88:8888/getCoffees",
            type: "GET",
            data: param,
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
    return coffees;
}

</script>
</html>