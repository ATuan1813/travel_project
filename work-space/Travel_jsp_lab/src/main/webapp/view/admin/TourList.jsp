<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Tour List Page</title>
	<jsp:include page="../../common/header.jsp" />
	<script>
		$(function(){
			$("#createTourButton").on("click", function(){
		    	window.location.href = "/Travel_jsp_lab/TourCreate";
		  	});
			$("#selectEntries").on("change",function() {
				var selectValue = $(this).val();
				window.location.href = "/Travel_jsp_lab/TourList?size="+ selectValue;
			});
		});
		function handleToEditPage(tourId){
			window.location.href = "/Travel_jsp_lab/TourEdit?tourId="+tourId;
		}
		function handleDelete(tourId){
			const result = confirm("Are you sure to delete?");
			if(result == true){
				var elementInput = $("#formDeleteHidden").find("#tourIdInput");
				elementInput.val(tourId);
				$("#formDeleteHidden").submit();
			}
		}
		function handlePagination(page, size, keysearch){
			if(keysearch!= null && keysearch != "" && keysearch != "undefined"){
				window.location.href = "/Travel_jsp_lab/TourList?keysearch="+keysearch+"&page=" + page+"&size=" + size;
			}else{
				window.location.href = "/Travel_jsp_lab/TourList?page="+page+"&size="+ size;
			}
		}
	</script>
</head>
<body>
	
	<div class="d-flex justify-content-center row">
		<div class="p-4 col-12 col-sm-12 col-md-10">
			<jsp:include page="MenuBar.jsp">
			    <jsp:param name="pageIndex" value="1" />
			</jsp:include>
			<h1>Danh sách chuyến du lịch</h1>
			<hr>
			<button class="btn btn-success" id="createTourButton">Thêm mới</button>
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
					<form action="TourList" method="POST">
						<input type="hidden" name="action" value="search" />
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
					<th scope="col">Giá VND</th>
					<th scope="col">Ảnh mô tả</th>
					<th scope="col">Mô tả chi tiết</th>
					<th scope="col">Ngày bắt đầu</th>
					<th scope="col">Ngày kết thúc</th>
					<th scope="col">Địa chỉ</th>
					<th scope="col">Hành động</th>
				</tr>
				</thead>
				<tbody>
					<c:if test = "${listTour.size() gt 0}">
					<c:forEach items="${listTour}" var="tour">  
						<tr>
					      <td>${tour.name}</td>
					      <td>${tour.price}</td>
					      <%-- <td>${tour.image}</td> --%>
					      <td><img src="http://localhost:8080/Travel_jsp_lab/public/image/${tour.image}" alt="Tour Image" width="100" height="100"></td>
					      <td><a href="http://localhost:8080/Travel_jsp_lab/TourDetail?tourId=${tour.id}">Xem chi tiết</a></td>
					      <td>${tour.startDate}</td>
					      <td>${tour.endDate}</td>
					      <td>${tour.address}</td>
					      <td>
					      	<button class="btn btn-primary" onclick="handleToEditPage(${tour.id})">Cập nhật</button>
					      	<button class="btn btn-danger" onclick="handleDelete(${tour.id})">Xóa</button>
					      </td>
					    </tr>
					</c:forEach>  
					</c:if>
					<c:if test = "${listTour.size() eq 0}">
						<tr>
					      <td>Không có chuyến du lịch nào.</td>
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
	<form action="TourList" method="POST" id="formDeleteHidden" class="d-none">
		<input type="hidden" name="action" value="delete" />
		<input name="tourId" id="tourIdInput"/>
	</form>
</body>

</html>