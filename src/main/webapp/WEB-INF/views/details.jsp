<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" />
<title>상세 정보</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">		</script>
</head>
<body>
<table>
   <thead>
      <tr>
         <th>이름</th>
         <th>등록일</th>
         <th>수정일</th>
         <th>판매량</th>
         <th>판매액</th>         
      </tr>
   </thead>
      <tr>
         <td>${shop.name}</td>
         <td>${shop.regDate}</td>
         <td>${shop.modDate}</td>
         <td>${shop.totalSale}</td>         
         <td>${shop.totalMoney}</td>
      </tr>
</table>
      
      </br>
      <h4>현재 메뉴: </h4>
      <table>
      <tr>
      	<th>이름</th>
      	<th>가격</th>      	
      	<th>재고</th>
      	<th>판매량</th>      	
      	<th>판매액</th>      	
      	<th>등록일</th>
      	<th>수정일</th>
      </tr>
      </table>


<input type ="button" value="메인으로" onclick="location.href='/'">
<input type="button" value="등록확인" onClick="history.go(0)"></body>

</body>
</html>