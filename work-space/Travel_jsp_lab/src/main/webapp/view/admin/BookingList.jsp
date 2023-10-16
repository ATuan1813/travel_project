<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking List Page</title>
<jsp:include page="../../common/header.jsp" />
<script>
	$(function() {
		$("#selectEntries").on(
				"change",
				function() {
					var selectValue = $(this).val();
					window.location.href = "/Travel_jsp_lab/BookingList?size="
							+ selectValue;
				})
	});

	function handlePagination(page, size, keysearch){
		if(keysearch!= null && keysearch != "" && keysearch != "undefined"){
			window.location.href = "/Travel_jsp_lab/BookingList?keysearch="+keysearch+"&page="+page+"&size="
			+ size;
		}else{
			window.location.href = "/Travel_jsp_lab/BookingList?page="+page+"&size="
				+ size;
		}
	}
</script>
</head>
<body>
	<div class="d-flex justify-content-center row">
		<div class="p-4 col-12 col-sm-12 col-md-10">
			<jsp:include page="MenuBar.jsp">
			    <jsp:param name="pageIndex" value="3" />
			</jsp:include>
			<h1>Danh sách đặt chuyến du lịch</h1>
			<hr>
			<div class="d-flex align-items-center">
				<select id="selectEntries" class="me-3 p-1" style="width:125px;border-radius:8px">
					<c:forEach var="option" items="${sizeOptions}">
						<c:choose>
							<c:when test="${option == size}">
								<option value="${option}" selected>${option}</option>
							</c:when>
							<c:otherwise>
								<option value="${option}">${option}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select> entries per page
				<button class="mx-3 btn btn-success" onclick="handlePagination(${page - 1}, ${size}, '${keysearch}')"><</button>
				<button class="btn btn-success" onclick="handlePagination(${page + 1}, ${size},'${keysearch}')">></button>
				<div class="flex-grow-1"></div>
				<div>
					<form action="BookingList" method="POST">
						<div class="d-flex">
							<input class="form-control" name="keysearch" placeholder="Search..." />
							<button type="submit" class="btn btn-success">FIND</button>
						</div>
					</form>
				</div>
			</div>

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
								<td>${booking.createDate}</td>
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
	<!-- HIDDEN FORM -->
	<form action="TourList" method="POST" id="formDeleteHidden"
		class="d-none">
		<input name="tourId" id="tourIdInput" />
	</form>
</body>

</html>