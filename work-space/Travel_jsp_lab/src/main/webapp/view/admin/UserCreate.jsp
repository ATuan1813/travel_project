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

<title>User Create Page</title>
</head>
<body>

	<div class="d-flex justify-content-center row">
		<div class="p-4 col-12 col-sm-12 col-md-8 col-lg-6">

			<div class="head-form d-flex justify-content-between">
				<h3>Thêm mới</h3>
				<c:if test="${not empty notify}">
		        	<h5 class="mt-1 mb-1 text-info">${notify}</h5>
		    	</c:if>
				<a href="${url.getUserList()}" type="button" class="btn btn-close"></a>
			</div>

			<hr>
			<c:if test="${not empty user}">
				<form action="${url.getUserCreate()}" method="POST">
				<input class="form-control d-none" name="id" value="${user.id}" />
			
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Họ và tên: </label> 
						<input  type="text" class="form-control" name="fullName" id="fullName" value="${user.fullName}"/>
						<p id="validFullName" class="text-danger d-none">Không được để trống.</p>
						
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Email: </label> 
						<input type="email" class="form-control" name="email" id="email" value="${user.email}"/>
						<p id="validEmail" class="text-danger d-none">Email không hợp lệ.</p>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Số điện thoại: </label> 
						<input class="form-control" name="phoneNumber" id="phoneNumber" value="${user.phoneNumber}"/>
						<p id="validPhoneNumber" class="text-danger d-none">Số điện thoại không hợp lệ.</p>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Địa chỉ: </label> 
						<input type="text" class="form-control" name="address" id="address" value="${user.address}"/>
						<p id="validAddress" class="text-danger d-none">Không được để trống.</p>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Tài khoản: </label> 
						<input type="text" class="form-control" name="username" id="username" value="${user.username}"/>
						<p id="validUsername" class="text-danger d-none">Tài khoản phải ít nhất 6 ký tự .</p>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Mật khẩu: </label> 
						<input type="text" class="form-control" name="password" id="password" value="${user.password}"/>
						<p id="validPassword" class="text-danger d-none">Mật khẩu phải ít nhất 6 ký tự.</p>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-12">
						<label>Vai trò: </label>
						<select class="form-select" name="role" id="role" value="${user.role_id}">
							<option value="1" selected>ADMIN</option>
        					<option value="2" selected>USER</option>
						</select>
					</div>
				</div>
				
				<div class="d-flex justify-content-end">
					<button class="btn btn-secondary me-3" >
			      	<a class="text-decoration-none text-light" href="${url.getUserList()}">Đóng</a>
			      	</button>
					<button type="submit" class="btn btn-primary">Lưu</button>
				</div>
			</form>
			</c:if>
			<c:if test = "${empty user}">
			<form action="${url.getUserCreate()}" method="POST">
				
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Họ và tên: </label> 
						<input  type="text" class="form-control" name="fullName" id="fullName"/>
						<p id="validFullName" class="text-danger d-none">Không được để trống.</p>
						
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Email: </label> 
						<input type="email" class="form-control" name="email" id="email" />
						<p id="validEmail" class="text-danger d-none">Email không hợp lệ.</p>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Số điện thoại: </label> 
						<input class="form-control" name="phoneNumber" id="phoneNumber"/>
						<p id="validPhoneNumber" class="text-danger d-none">Có 10 số và bắt đầu với số 0.</p>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Địa chỉ: </label> 
						<input type="text" class="form-control" name="address" id="address"/>
						<p id="validAddress" class="text-danger d-none">Không được để trống.</p>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Tài khoản: </label> 
						<input type="text" class="form-control" name="username" id="username"/>
						<p id="validUsername" class="text-danger d-none">Tài khoản phải ít nhất 6 ký tự .</p>
					</div>
					<div class="form-group col-12 col-sm-12 col-md-6">
						<label>Mật khẩu: </label> 
						<input type="text" class="form-control" name="password" id="password"/>
						<p id="validPassword" class="text-danger d-none">Mật khẩu phải ít nhất 6 ký tự.</p>
					</div>
				</div>
				<div class="row mb-2">
					<div class="form-group col-12 col-sm-12 col-md-12">
						<label>Vai trò: </label> 
						<select class="form-select" name="role" id="role">
							<option value="1">ADMIN</option>
							<option value="2" selected>USER</option>
						</select>
					</div>
				</div>
				
				<div class="d-flex justify-content-end">
					<button class="btn btn-secondary me-3" >
			      	<a class="text-decoration-none text-light" href="${url.getUserList()}">Đóng</a>
			      	</button>					
			      	<button type="submit" class="btn btn-primary">Lưu</button>
				</div>
			</form>
			</c:if>
			
		</div>
	</div>

<!-- script handle -->
<script>

$(document).ready(function () {
    const fullNameInput = $("#fullName");
    const emailInput = $("#email");
    const phoneNumberInput = $("#phoneNumber");
    const addressInput = $("#address");
    const usernameInput = $("#username");
    const passwordInput = $("#password");

    const validFullNameError = $("#validFullName");
    const validEmailError = $("#validEmail");
    const validPhoneNumberError = $("#validPhoneNumber");
    const validAddressError = $("#validAddress");
    const validUsernameError = $("#validUsername");
    const validPasswordError = $("#validPassword");
    
    const hasError = false;

    fullNameInput.on("input", function () {
        if (fullNameInput.val().trim() === "") {
            validFullNameError.removeClass("d-none");
            hasError = true;
        } else {
            validFullNameError.addClass("d-none");
        }
    });

    emailInput.on("input", function () {
        const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        const email = emailInput.val().trim();
        if (emailPattern.test(email)) {
            validEmailError.addClass("d-none");
        } else {
            validEmailError.removeClass("d-none");
            hasError = true;
        }
    });

    phoneNumberInput.on("input", function () {
        const phoneNumber = phoneNumberInput.val().trim();
        const phoneNumberPattern = /^0\d{9}$/;

        if (phoneNumberPattern.test(phoneNumber)) {
            validPhoneNumberError.addClass("d-none");
        } else {
            validPhoneNumberError.removeClass("d-none");
            hasError = true;
        }
    });

    usernameInput.on("input", function () {
        if (usernameInput.val().length < 6) {
            validUsernameError.removeClass("d-none");
            hasError = true;
        } else {
            validUsernameError.addClass("d-none");
        }
    });

    passwordInput.on("input", function () {
        if (passwordInput.val().length < 6) {
            validPasswordError.removeClass("d-none");
            hasError = true;
        } else {
            validPasswordError.addClass("d-none");
        }
    });

    addressInput.on("input", function () {
        if (addressInput.val().trim() === "") {
            validAddressError.removeClass("d-none");
            hasError = true;
        } else {
            validAddressError.addClass("d-none");
        }
    });
    
    if(hasError == true){
    	const submitButton = form.querySelector('button[type="submit"]');
    	submitButton.addEventListener('click', () => {
  		    event.preventDefault();  
    	});
    }
});

document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form"); 

    form.addEventListener("submit", function (event) {
        let isValid = true;

        const fullNameInput = document.getElementById("fullName");
        const validFullName = document.getElementById("validFullName");
        if (fullNameInput.value.trim() === "") {
            validFullName.classList.remove("d-none"); 
            isValid = false; 
        } else {
            validFullName.classList.add("d-none"); 
        }

        const emailInput = document.getElementById("email");
        const validEmail = document.getElementById("validEmail");
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; 
        if (!emailRegex.test(emailInput.value.trim())) {
            validEmail.classList.remove("d-none");
            isValid = false; 
        } else {
            validEmail.classList.add("d-none"); 
        }

        const phoneNumberInput = document.getElementById("phoneNumber");
        const validPhoneNumber = document.getElementById("validPhoneNumber");
        const phoneNumberPattern = /^0\d{9}$/;
        if (!phoneNumberPattern.test(phoneNumberInput.value.trim())) {
        	validPhoneNumber.classList.remove("d-none");
            isValid = false; 
        } else {
        	validPhoneNumber.classList.add("d-none"); 
        }

        const addressInput = document.getElementById("address");
        const validAddress = document.getElementById("validAddress");
        if (addressInput.value.trim() === "") {
            validAddress.classList.remove("d-none"); 
            isValid = false; 
        } else {
            validAddress.classList.add("d-none"); 
        }

        const usernameInput = document.getElementById("username");
        const validUsername = document.getElementById("validUsername");
        if (usernameInput.value.trim().length < 6) {
            validUsername.classList.remove("d-none"); 
            isValid = false; 
        } else {
            validUsername.classList.add("d-none"); 
        }

        const passwordInput = document.getElementById("password");
        const validPassword = document.getElementById("validPassword");
        if (passwordInput.value.trim().length < 6) {
            validPassword.classList.remove("d-none"); 
            isValid = false; 
        } else {
            validPassword.classList.add("d-none"); 
        }
        if (!isValid) {
            event.preventDefault();
        }
    });
});
</script>

</body>
</html>