<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Tour Edit Page</title>
	<jsp:include page="../../common/header.jsp" />
	<script>
		$(function(){
			$("#btnDong").on("click", function(){
				window.location.href = "/Travel_jsp_lab/TourList";
			});
		})
	</script>
</head>
<body>
	<div class="d-flex justify-content-center row">
		<div class="p-4 col-12 col-sm-12 col-md-8 col-lg-6">
			<h1>Cập nhật</h1>
			<hr>
			<form action="TourEdit" method="POST" enctype="multipart/form-data">
				<input class="form-control d-none" name="tourId" value="${tour.id}" />
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Tên chuyến du lịch: </label>
						<input class="form-control" name="tripName" value="${tour.name}" />
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Giá VND: </label>
						<input type="number" class="form-control" name="price" value="${tour.price}"/>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Ngày bắt đầu: </label>
						<input type="date" class="form-control" name="startDate" value="${tour.startDate}"/>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Ngày kết thúc: </label>
						<input type="date" class="form-control" name="endDate" value="${tour.endDate}"/>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Địa chỉ: </label>
						<input class="form-control" name="address" value="${tour.address}"/>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Ảnh mô tả: </label>
						<input type="file" class="form-control" name="image"/>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12">
						<label>Mô tả chi tiết: </label>
						<textarea rows="4" class="form-control" name="description">${tour.description}</textarea>
					</div>
				</div>
				<div class="d-flex justify-content-end">
					<button type="button" class="btn btn-secondary me-3" id="btnDong">Đóng</button>
					<button type="submit" class="btn btn-primary">Lưu</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>