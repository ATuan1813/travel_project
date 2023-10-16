<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Objects" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <script>
    	function handleRedirectTourList(){
    		window.location.href = "/Travel_jsp_lab/TourList";
    	}
    	function handleRedirectUserList(){
    		window.location.href = "/Travel_jsp_lab/user-list";
    	}
    	function handleRedirectBookingList(){
    		window.location.href = "/Travel_jsp_lab/BookingList";
    	}
    	function handleRedirectHome(){
    		window.location.href = "/Travel_jsp_lab/";
    	}
    </script>
</head>
<body>
    <div>
		<ul class="nav nav-pills">
		  <li class="nav-item">
		    <a class="nav-link" data-bs-toggle="pill" onclick="handleRedirectHome()">Trang chủ</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link ${Objects.equals(param.pageIndex, '1') ? 'active' : ''}" data-bs-toggle="pill" onclick="handleRedirectTourList()">Quản lý tour du lịch</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link ${Objects.equals(param.pageIndex, '2') ? 'active' : ''}" data-bs-toggle="pill"  onclick="handleRedirectUserList()">Quản lý User</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link ${Objects.equals(param.pageIndex, '3') ? 'active' : ''}" data-bs-toggle="pill" onclick="handleRedirectBookingList()">Quản lý Booking</a>
		  </li>
		</ul>
	</div>
</body>
</html>