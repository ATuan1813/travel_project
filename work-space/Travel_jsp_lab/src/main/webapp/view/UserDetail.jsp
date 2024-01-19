<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common/header.jsp" />
<script src = "../public/js/jquery-3.7.1.min.js"></script>

<title>User Detail Page</title>
</head>
<body>

	<div class="d-flex justify-content-center row">
		<div class="p-4 col-12 col-sm-12 col-md-8 col-lg-6">

			<div class="head-form d-flex justify-content-between">
				<h3>Chi tiết</h3>
				<a href="/Travel_jsp_lab" type="button" class="btn btn-close"></a>
			</div>

			<hr>
			<form action="${url.getUserUpdate()}" method="POST">
				<input class="form-control d-none" name="id" value="${user.id}" disabled/>
			
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Họ và tên: </label> 
						<input  type="text" class="form-control" name="fullName" id="fullName" value="${user.fullName}" disabled/>
						<p id="validFullName" class="text-danger d-none">Không được để trống.</p>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Email: </label> 
						<input type="email" class="form-control" name="email" id="email" value="${user.email}" disabled/>
						<p id="validEmail" class="text-danger d-none">Email không hợp lệ.</p>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Số điện thoại: </label> 
						<input class="form-control" name="phoneNumber" id="phoneNumber" value="${user.phoneNumber}" disabled/>
						<p id="validPhoneNumber" class="text-danger d-none">Có 10 số và bắt đầu với số 0.</p>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Địa chỉ: </label> 
						<input type="text" class="form-control" name="address" id="address" value="${user.address}" disabled/>
						<p id="validAddress" class="text-danger d-none">Không được để trống.</p>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Tài khoản: </label> 
						<input type="text" class="form-control" name="username" id="username" value="${user.username}" disabled/>
						<p id="validUsername" class="text-danger d-none">Tài khoản phải ít nhất 6 ký tự .</p>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Mật khẩu: </label> 
						<input type="text" class="form-control" name="password" id="password" value="********" disabled/>
						<p id="validPassword" class="text-danger d-none">Mật khẩu phải ít nhất 6 ký tự.</p>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-12">
						<label>Vai trò: </label>
						<select class="form-select" name="role" id="role" value="${user.role_id}" disabled>
							<option value="1">ADMIN</option>
        					<option value="2">USER</option>
						</select>
					</div>
				</div>
				<!-- <div class="d-flex justify-content-end">
					<button class="btn btn-secondary" >
			      		<a class="text-decoration-none text-light" href="/Travel_jsp_lab/user-list">Đóng</a>
			      	</button>
				</div> -->
			</form>
		</div>
		<div class="p-4 col-12 col-sm-12 col-md-10"> 
			<table class="table">
				<thead>
					<tr>
						<th scope="col">Tên chuyến DL</th>
						<th scope="col">SL người lớn</th>
						<th scope="col">SL trẻ em</th>
						<th scope="col">Khách hàng</th>
						<th scope="col">Tổng tiền</th>
						<th scope="col">Ngày đặt</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${listBooking.size() gt 0}">
						<c:forEach items="${listBooking}" var="booking">
							<tr>
								<td>${booking.name}</td>
								<td>${booking.adult}</td>
								<td>${booking.child}</td>
								<td>${booking.fullName}</td>
								<td>${booking.price}</td>
								<td>${booking.dateStr}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${listTour.size() eq 0}">
						<tr>
							<td>Không có booking nào.</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>

<script>
    var userRole = ${user.role_id};
    var roleSelect = document.getElementById("role");
    for (var i = 0; i < roleSelect.options.length; i++) {
        if (parseInt(roleSelect.options[i].value) === userRole) {
            roleSelect.options[i].selected = true;
        }
    }
</script>

</body>
</html>