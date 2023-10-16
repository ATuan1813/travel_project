<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Tour Detail Page</title>
	<jsp:include page="../../common/header.jsp" />	
	<script>
		function handleClickDong(){
			window.location.href = "/Travel_jsp_lab/TourList";
		}
	</script>
</head>
<body>
	<div class="d-flex justify-content-center row">
		<div class="p-4 col-12 col-sm-12 col-md-10">
			<h1>Mô tả chi tiết</h1>
			<hr>
			<div>
				${tour.description}
			</div>
			<div class="d-flex justify-content-end">
				<button class="btn btn-secondary" onclick="handleClickDong()">Đóng</button>
			</div>
		</div>
	</div>
	<!-- HIDDEN FORM -->
	<form action="TourList" method="POST" id="formDeleteHidden" class="d-none">
		<input name="tourId" id="tourIdInput"/>
	</form>
</body>

</html>