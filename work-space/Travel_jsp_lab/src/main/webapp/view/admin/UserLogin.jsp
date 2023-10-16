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

<title>User Login Page</title>
</head>
<body>
	<div class="signinform">
        <div class="container">
            <div class="w3l-form-info">
                <div class="w3_info">        
					<div class="head-form d-flex justify-content-between">
						<h2>Đăng nhập</h2>
						<a href="${url.getHome()}" type="button" class="btn btn-close"></a>
						
					</div>
					<c:if test="${not empty notify}">
						<h5 class="mt-1 mb-3 text-info">${notify}</h5>
					</c:if>
					
		    	    <c:if test="${not empty user}">
		    	    <form action="${url.getUserLogin()}" method="POST">
                        <div class="input-group">
                            <span><i class="fas fa-user icon" aria-hidden="true"></i></span>
                            <input 
	                            type="text" 
	                            placeholder="Tài khoản hoặc email" 
	                            name="username" id="username" 
	                            value="${user.username}"
                            >
							<p id="validUsername" class="text-danger d-none">Tài khoản phải ít nhất 6 ký tự .</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-key icon" aria-hidden="true"></i></span>
                            <input 
	                            type="Password" 
	                            placeholder="Mật khẩu" 
	                            name="password" id="password" 
	                            value="${user.password}"
                            >
							<p id="validPassword" class="text-danger d-none">Mật khẩu phải ít nhất 6 ký tự.</p>
                        </div>
                        <div class="form-row bottom">
                            <div class="form-check">
                                <input type="checkbox" id="remenber" name="remenber" value="remenber">
                                <label for="remenber">Ghi nhớ đăng nhập?</label>
                            </div>
                        </div>
                        <button class="btn btn-primary btn-block" type="submit">Đăng nhập</button>
                    </form>
		    	    </c:if>
		    	    <c:if test="${empty user}">
		    	    <form action="${url.getUserLogin()}" method="POST">
                        <div class="input-group">
                            <span><i class="fas fa-user icon" aria-hidden="true"></i></span>
                            <input type="text" placeholder="Tài khoản hoặc email" name="username" id="username">
							<p id="validUsername" class="text-danger d-none">Tài khoản phải ít nhất 6 ký tự .</p>
                        </div>
                        <div class="input-group">
                            <span><i class="fas fa-key icon" aria-hidden="true"></i></span>
                            <input type="Password" placeholder="Mật khẩu" name="password" id="password">
							<p id="validPassword" class="text-danger d-none">Mật khẩu phải ít nhất 6 ký tự.</p>
                        </div>
                        <div class="form-row bottom">
                            <div class="form-check">
                                <input type="checkbox" id="remenber" name="remenber" value="remenber">
                                <label for="remenber">Ghi nhớ đăng nhập?</label>
                            </div>
                        </div>
                        <button class="btn btn-primary btn-block" type="submit">Đăng nhập</button>
                    </form>
		    	    </c:if>

                    
                    <p class="account">Bạn chưa có tài khoản? <a href="${url.getUserRegister()}">Đăng ký</a></p>
                </div>
            </div>
        </div>
    </div>
<!-- script handle -->
<script>
$(document).ready(function () {
    const usernameInput = $("#username");
    const passwordInput = $("#password");

    const validUsernameError = $("#validUsername");
    const validPasswordError = $("#validPassword");

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
});
document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form"); 

    form.addEventListener("submit", function (event) {
        let isValid = true;

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