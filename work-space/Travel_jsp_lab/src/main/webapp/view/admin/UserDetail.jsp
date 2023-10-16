<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../../common/header.jsp" />
<script src = "../../public/js/jquery-3.7.1.min.js"></script>

<title>User Detail Page</title>
</head>
<body>

	<div class="d-flex justify-content-center row">
		<div class="p-4 col-12 col-sm-12 col-md-8 col-lg-6">

			<div class="head-form d-flex justify-content-between">
				<h3>Chi tiết</h3>
				<a href="/Travel_jsp_lab/user-list" type="button" class="btn btn-close"></a>
			</div>

			<hr>
			<form action="${url.getUserUpdate()}" method="POST">
				<input class="form-control d-none" name="id" value="${user.id}" />
			
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
				
				<div class="d-flex justify-content-end">
					<button class="btn btn-secondary" >
			      	<a class="text-decoration-none text-light" href="/Travel_jsp_lab/user-list">Đóng</a>
			      	</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>