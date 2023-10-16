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
<script src="<c:url value='/public/js/fontawesome.js' />"></script>
<link rel="stylesheet" href="<c:url value='/public/css/style-login.css' />" />

<style>
    .icon{
        margin-top: 15px !important;
    }
</style>

<title>User Register Page</title>
</head>
<body>
	<div class="signinform">
        <div class="container">
            <div class="w3l-form-info">
                <div class="w3_info">
                    <div class="head-form d-flex justify-content-between">
						<h2>Đăng ký</h2>
						<a href="${url.getUserLogin()}" type="button" class="btn btn-close"></a>
						
					</div>
					<c:if test="${not empty notify}">
						<h5 class="mt-1 mb-3 text-info">${notify}</h5>
					</c:if>
		    	    
		    	    <c:if test="${not empty user}">
		    	    <form action="${url.getUserRegister()}" method="POST">
                        <div class="input-group">
                            <span><i class="fas fa-envelope icon"></i></span>
                            <input type="email" placeholder="Email" name="email" id="email" value="${user.email}">
                            <p id="validEmail" class="text-danger d-none">Email không hợp lệ.</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-user icon"  aria-hidden="true"></i></span>
                            <input type="text" placeholder="Họ và tên" name="fullName" id="fullName" value="${user.fullName}">
                            <p id="validFullName" class="text-danger d-none">Không được để trống.</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-user icon" aria-hidden="true"></i></span>
                            <input type="text" placeholder="Tên đăng nhập" name="username" id="username" value="${user.username}">
                            <p id="validUsername" class="text-danger d-none">Tài khoản phải ít nhất 6 ký tự.</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-key icon" aria-hidden="true"></i></span>
                            <input type="Password" placeholder="Mật khẩu" name="password" id="password" value="${user.password}">
                            <p id="validPassword" class="text-danger d-none">Mật khẩu phải ít nhất 6 ký tự.</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-key icon" aria-hidden="true"></i></span>
                            <input type="Password" placeholder="Nhập lại mật khẩu" id="password2" value="${user.password}">
                            <p id="validPassword2" class="text-danger d-none">Mật khẩu phải ít nhất 6 ký tự.</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-mobile icon"></i></span>
                            <input type="text" placeholder="Số điện thoại" name="phoneNumber" id="phoneNumber" value="${user.phoneNumber}">
                            <p id="validPhoneNumber" class="text-danger d-none">Có 10 số và bắt đầu với số 0.</p>
                        </div>
                        <button class="btn btn-primary btn-block" type="submit">Đăng Kí</button>
                    </form>
		    	    </c:if>
		    	    <c:if test="${empty user}">
		    	    <form action="${url.getUserRegister()}" method="POST">
                        <div class="input-group">
                            <span><i class="fas fa-envelope icon"></i></span>
                            <input type="email" placeholder="Email" name="email" id="email">
                            <p id="validEmail" class="text-danger d-none">Email không hợp lệ.</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-user icon"  aria-hidden="true"></i></span>
                            <input type="text" placeholder="Họ và tên" name="fullName" id="fullName">
                            <p id="validFullName" class="text-danger d-none">Không được để trống.</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-user icon" aria-hidden="true"></i></span>
                            <input type="text" placeholder="Tên đăng nhập" name="username" id="username">
                            <p id="validUsername" class="text-danger d-none">Tài khoản phải ít nhất 6 ký tự.</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-key icon" aria-hidden="true"></i></span>
                            <input type="Password" placeholder="Mật khẩu" name="password" id="password">
                            <p id="validPassword" class="text-danger d-none">Mật khẩu phải ít nhất 6 ký tự.</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-key icon" aria-hidden="true"></i></span>
                            <input type="Password" placeholder="Nhập lại mật khẩu" id="password2">
                            <p id="validPassword2" class="text-danger d-none">Mật khẩu phải ít nhất 6 ký tự.</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-mobile icon"></i></span>
                            <input type="text" placeholder="Số điện thoại" name="phoneNumber" id="phoneNumber">
                            <p id="validPhoneNumber" class="text-danger d-none">Có 10 số và bắt đầu với số 0.</p>
                        </div>
                        <button class="btn btn-danger" type="submit">Đăng Ký</button>
                    </form>
		    	    </c:if>
                </div>
            </div>
        </div>
    </div>
<!-- script handle -->
<script>
$(document).ready(function () {
    const fullNameInput = $("#fullName");
    const emailInput = $("#email");
    const phoneNumberInput = $("#phoneNumber");
    const usernameInput = $("#username");

    const validFullNameError = $("#validFullName");
    const validEmailError = $("#validEmail");
    const validPhoneNumberError = $("#validPhoneNumber");
    const validUsernameError = $("#validUsername");


    
    var hasError = false;

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

    $('#password, #password2').on('input', function() {
        const password1 = $('#password').val().trim();
        const password2 = $('#password2').val().trim();

        if (password1.length >= 6 && password2.length >= 6) {
            if (password1 !== password2) {
                $('#validPassword').text('Mật khẩu không khớp').removeClass('d-none');
                $('#validPassword2').text('Mật khẩu không khớp').removeClass('d-none');
                hasError = true;
            } else {
                $('#validPassword').addClass('d-none');
                $('#validPassword2').addClass('d-none');
            }
        } 
        if(password1.length < 6 && password1.length != 0) {
            $('#validPassword').text('Mật khẩu phải có ít nhất 6 ký tự').removeClass('d-none');
            hasError = true;
        } 
        if(password2.length < 6 && password2.length != 0){
        	$('#validPassword2').text('Mật khẩu phải có ít nhất 6 ký tự').removeClass('d-none');
            hasError = true;
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

        const usernameInput = document.getElementById("username");
        const validUsername = document.getElementById("validUsername");
        if (usernameInput.value.trim().length < 6) {
            validUsername.classList.remove("d-none"); 
            isValid = false; 
        } else {
            validUsername.classList.add("d-none"); 
        }

        const password1 = $('#password').val().trim();
        const password2 = $('#password2').val().trim();
        if(password1.length < 6) {
            $('#validPassword').text('Mật khẩu phải có ít nhất 6 ký tự').removeClass('d-none');
            isValid = false;
        } 
        if(password2.length < 6){
        	$('#validPassword2').text('Mật khẩu phải có ít nhất 6 ký tự').removeClass('d-none');
            isValid = false;
        }
        if (password1.length >= 6 && password2.length >= 6) {
            if (password1 !== password2) {
                $('#validPassword').text('Mật khẩu không khớp').removeClass('d-none');
                $('#validPassword2').text('Mật khẩu không khớp').removeClass('d-none');
                isValid = false;
            } else {
                $('#validPassword').addClass('d-none');
                $('#validPassword2').addClass('d-none');
            }
        } 
        
        if (!isValid) {
            event.preventDefault();
        }
    });
});
</script>
    

</body>
</html>