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
<table>
   <thead>
      <tr>
         <th>이름</th>
         <th>등록일</th>
         <th>수정일</th>
         <th>판매량</th>
         <th>판매액</th>
         <th>삭제</th>
         <th>수정</th>
      </tr>
   </thead>
   <c:forEach items="${shopList}" var="shop">
      <tr>
         <td>${shop.name}</td>
         <td>${shop.regDate}</td>
         <td>${shop.modDate}</td>
         <td>${shop.totalSale}</td>         
         <td>${shop.totalMoney}</td>         
         <td>
         <spring:url value="/deleteShop/${shop.id}" var="deleteById" />
             <a href="${deleteById}">삭제</a>
             </td>
             <td>
             <spring:url value="/updateShop/${shop.id }" var="updateById" />
             <a href="${updateById }">수정</a>
             </td>
      </tr>
   </c:forEach>
</table>

<input type ="button" value="메인으로가기" onclick="location.href='/index'">
<input type="button" value="등록확인" onClick="history.go(0)"></body>

</body>
<script>
function getDataFromAPI() {
    $.ajax({
        url: "/list",
        type: "GET",
        success: function (data) {
        	
        }, error: function (jqXHR, textStatus, errorThrown) {
        }
   });
}
</script>
</html>