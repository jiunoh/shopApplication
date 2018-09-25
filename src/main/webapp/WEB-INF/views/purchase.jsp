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

$(document).ready(function() {
	var txt="";

	var url = window.location.pathname;
	var splitted = url.split("/");
	var id = splitted[splitted.length-1];
	console.log(id);
	
    $.ajax({
        type: "GET",
        url: "/details/getDetails/"+id,
        success: function (data) {
          var menuString = data.menu.slice(1);          
          console.log("메뉴스트링: "+menuString);

          coffees = getCoffees(menuString);
          var coffeeIdObj = {};
          
          txt += "<table border='1' style='border-collapse:collapse' cellpadding='5'>"+"<thead>"
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

var forSale = "";
var forSaleIndex = "";

function updateSaleInfo() {
    forSale = $("#choice option:selected").val(); //판매할 커피의 아이디
    forSaleIndex = $("#choice option").index($("#choice option:selected")); //판매할 커피의 coffees 배열 안 인덱스
    console.log("forSale: "+forSale);
    console.log("forSaleIndex: "+forSaleIndex);
}

function sellCoffee() {
    var quant = $('#quantity').val(); //구매 수량
    console.log("sell forSale: "+forSale);
    console.log("sell forSaleIndex: "+forSaleIndex);
    console.log("coffee for sale: "+coffees[forSaleIndex].name );    
    console.log(quant);
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