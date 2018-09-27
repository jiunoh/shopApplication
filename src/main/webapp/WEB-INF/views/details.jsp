<%@ page contentType="text/html; charset=UTF-8"%>
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
		<table id='menu' border='1' style='border-collapse:collapse' cellpadding='5'>
		</table>
    </div>
    <div>
    	<div id="noMenu"></div>
    </div>


</body>
<script>

$(document).ready(function() {
	var txt="";

	url = window.location.pathname;
	splitted = url.split("/");
	id = splitted[splitted.length-1];
	console.log(id);
	
    $.ajax({
        type: "GET",
        url: "/details/getDetails/"+id,
        success: function (data) {
          if (!data) {
        	  alert("없는 페이지입니다.");
//        	  window.location.href = "/list";
          }
      	  var items = [];
      	  if (data.isDeleted == "y") {
	     	  items.push("<h4>"+data.name+"</h4> 총 판매량: "+data.totalSale
	     			  +"<br>총 판매액: "+data.totalMoney+"<br><br>"
					+"<a href='/list'>목록으로</a> &nbsp; <a href='/'>홈으로 돌아가기</a> <br><br>");      		  
      	  }
      	  else {
	     	  items.push("<h4>"+data.name+"</h4> 등록일: "+data.regDate+"<br>수정일: "+data.modDate+"<br>"+"총 판매량: "+data.totalSale
     			  +"<br>총 판매액: "+data.totalMoney+"<br><br>"
				+"<a href='javascript:deleteShop("+data.id+");'"+">삭제</a> &nbsp; <a href='/modification/"
				+data.id+"'>수정</a> &nbsp; <a href='/list'>목록으로</a> &nbsp; <a href='/sale/"
				+data.id+"'>커피 판매</a> &nbsp; <a href='/'>홈으로 돌아가기</a> <br><br>");
      	  }
          $('.item').append(items);
          
          menuString = data.menu.slice(1);          
          console.log("메뉴스트링: "+menuString);
          var coffees = getCoffees(menuString)
          
          txt += "<thead>"+"<tr><th>이름</th>"+"<th>가격</th>"+"<th>재고</th>"
           +"<th>등록일</th>"+"<th>수정일</th>"+"<th>총 판매량</th>"+"<th>총 판매액</th>"+"</tr></thead><tbody>";
           for (i=0; i<coffees.length; i++) {
        	  txt += "<tr><td>"+coffees[i].name+"</td>";
        	  txt += "<td>"+coffees[i].price+"</td>";
        	  txt += "<td>"+coffees[i].inventory+"</td>";
        	  txt += "<td>"+coffees[i].register_date+"</td>";
        	  txt += "<td>"+coffees[i].update_date+"</td>";
        	  totalInfo = getTotalInfo(coffees[i].id);
        	  console.log("totalInfo: "+totalInfo);
        	  txt += "<td>"+totalInfo.total_sale+"</td>";
        	  txt += "<td>"+totalInfo.total_income+"</td>";
        	  txt += "</tr>"
           }           
           document.getElementById("menu").innerHTML = txt;
          
           if (coffees.length == 0) {
               document.getElementById("noMenu").innerHTML = "판매중인 커피 없음";        	   
           }
           
        }, error: function (jqXHR, textStatus, errorThrown) {
        }
   });   
});


///메뉴에 해당하는 커피 객체들을 받아옴
function getCoffees(menu){
    var coffees = [];
    if (menu == "") {
    	return coffees;    	
    }
    
	var param = "menu" + "=" + menu;
    $.ajax({
//    		url: "/getCoffees/",
            url: "http://9.240.101.88:8888/getCoffees/",
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
    console.log("getCoffees: "+coffees[0]);
    return coffees;
}

function getTotalInfo(id) {
	var total = "";
    $.ajax({
//        url: "/getTotalInfo/"+id,    	
        url: "http://9.240.101.88:8888/getTotalInfo/"+id,
        type: "GET",
        crossOrigin: true,
        async: false,
        success: function (data) {
        	total = data;
        }, error: function (request,status,error) {
           console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        },
   });
    return total;
}

function deleteShop(id) {
	$.ajax({
	       url: "/delete/shop/"+id,
	       type: "PUT",
	       success: function (data) {		    	   
	    	   alert("삭제되었습니다.");
	    	   window.location.href = "/list";
	       }, error: function (request,status,error) {
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            return false;
	       },
	});	
}

</script>
</html>