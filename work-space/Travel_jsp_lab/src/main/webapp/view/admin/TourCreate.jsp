<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Tour Create Page</title>
	<jsp:include page="../../common/header.jsp" />
	<script>
		$(function(){
			$("#btnDong").on("click", function(){
				window.location.href = "/Travel_jsp_lab/TourList";
			});
			
			$("#btnLuu").on("click", function(){
				var tripName = $("#tripName").val();
				var price = $("#price").val();
				var address = $("#address").val();
				var image = $("#image").val();
				var description = $("#description").val();
				var startDate = new Date($("#startDate").val());
			    var endDate = new Date($("#endDate").val());
			    var today = new Date();
			    
			   	if(checkRequired("#errorTripName", "tên tour", tripName)){
			   		return;
			   	}
			   	if(checkRequired("#errorPrice", "giá tour", price)){
			   		return;
			   	}
			   	if(checkRequired("#errorStartDate", "ngày bắt đầu", $("#startDate").val())){
			   		return;
			   	}
			   	if(checkRequired("#errorEndDate", "ngày kết thúc", $("#endDate").val())){
			   		return;
			   	}
				if(checkRequired("#errorAddress", "địa chỉ", address)){
			   		return;
			   	}
				var imageInput = $("#image")[0];
				var imageFiles = imageInput.files;
				if (imageFiles.length === 0) {
				    $("#errorImage").removeClass("d-none");
					$("#errorImage").text("Vui lòng chọn một tệp hình ảnh.");
					return;
				}else{
					$("#errorImage").addClass("d-none");
				}
			   	if(checkRequired("#errorDescription", "mô tả chi tiết", description)){
			   		return;
			   	}
			   	
				if(startDate <= today){
					$("#errorStartDate").removeClass("d-none");
					$("#errorStartDate").text("Ngày bắt đầu phải lớn hơn hôm nay.")
					return;
				}else{
					$("#errorStartDate").addClass("d-none");
				}
				if(startDate >= endDate){
					$("#errorEndDate").removeClass("d-none");
					$("#errorEndDate").text("Ngày kết thúc phải sau ngày bắt đầu.")
					return;
				}else{
					$("#errorEndDate").addClass("d-none");
				}
				$("#form-create-tour").submit();
			});
			function checkRequired(selector, displayName, value){
			 	if(value.trim() == ""){
			    	$(selector).removeClass("d-none");
					$(selector).text("Vui lòng nhập " + displayName + ".")
					return true;
			    }else{
			    	$(selector).addClass("d-none");
			    }
			 	return false;
			}
		});
		
	</script>
</head>
<body>
	<div class="d-flex justify-content-center row">
		<div class="p-4 col-12 col-sm-12 col-md-8 col-lg-6">
			<h1>Thêm mới</h1>
			<hr>
			<form action="TourCreate" method="POST" enctype="multipart/form-data" id="form-create-tour">
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Tên chuyến du lịch: </label>
						<input class="form-control" name="tripName" id="tripName" />
						<span class="d-none text-danger fw-bold" id="errorTripName"></span>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Giá VND: </label>
						<input type="number" class="form-control" name="price" id="price"/>
						<span class="d-none text-danger fw-bold" id="errorPrice"></span>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Ngày bắt đầu: </label>
						<input type="date" class="form-control" name="startDate" id="startDate"/>
						<span class="d-none text-danger fw-bold" id="errorStartDate"></span>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Ngày kết thúc: </label>
						<input type="date" class="form-control" name="endDate" id="endDate" />
						<span class="d-none text-danger fw-bold" id="errorEndDate"></span>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Địa chỉ: </label>
						<input class="form-control" name="address" id="address"/>
						<span class="d-none text-danger fw-bold" id="errorAddress"></span>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Ảnh mô tả: </label>
						<input type="file" class="form-control" name="image" id="image" />
						<span class="d-none text-danger fw-bold" id="errorImage"></span>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12">
						<label>Mô tả chi tiết: </label>
						<textarea rows="4" class="form-control" name="description" id="description"></textarea>
						<span class="d-none text-danger fw-bold" id="errorDescription"></span>
					</div>
				</div>
				<div class="d-flex justify-content-end">
					<button type="button" class="btn btn-secondary me-3" id="btnDong">Đóng</button>
					<button type="button" class="btn btn-primary" id="btnLuu">Lưu</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>