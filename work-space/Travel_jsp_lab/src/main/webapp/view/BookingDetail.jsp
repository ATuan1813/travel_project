<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Booking Detail Page</title>
	<jsp:include page="../common/header.jsp" />	
	<script>
		function handleClickDong(){
			window.location.href = "/Travel_jsp_lab/";
		}
	</script>
</head>
<body>
	<div class="d-flex justify-content-center row">
		<div class="p-4 col-12 col-sm-12 col-md-10">
			<div class="d-flex">
				<h1>Thông tin chuyến du lịch</h1>
				<div class="flex-grow-1"></div>
				<button class="btn btn-secondary" onclick="handleClickDong()">Đóng</button>
			</div>
			<hr>
			<div>
				<img src="http://localhost:8080/Travel_jsp_lab/public/image/${tour.image}" alt="Tour Image" width="500" height="300">
			</div>
			<h3>${tour.name}</h3>
			<h4>${tour.price} VND </h4>
			<div>
				<h5>Ngày bắt đầu: ${tour.startDate}</h5>
			</div>
			<div class="my-3">
				${tour.description}
			</div>
			<h3>Booking</h3>
			<form action="BookingDetail" method="POST" >
				<input class="d-none" type="number" name="tourId" value="${tour.id}" />
				<input class="d-none" type="number" name="userId" value="1" />
				<div class="row">				
					<div class="col-12 col-sm-12 col-md-6 form-group">
						<label>Số lượng người lớn</label>
						<input type="number" name="quantityAdult" placeholder="Quantity Adult" class="form-control" />
					</div>
					<div class="col-12 col-sm-12 col-md-6 form-group">
						<label>Số lượng trẻ em</label>
						<input type="number" name="quantityChild" placeholder="Quantity Child" class="form-control" />
					</div>
					<div class="col-12">
						<button type="submit" class="btn btn-danger w-100 mt-3">Booking</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- HIDDEN FORM -->
	<form action="TourList" method="POST" id="formDeleteHidden" class="d-none">
		<input name="tourId" id="tourIdInput"/>
	</form>
</body>

</html>