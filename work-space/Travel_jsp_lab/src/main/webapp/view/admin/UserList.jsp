<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>User List Page</title>
	<jsp:include page="../../common/header.jsp" />
	<script src="<c:url value='/public/js/jquery.twbsPagination.min.js' />" type="text/javascript"></script>
	<!-- script handle -->
	<script>
		var userIdSession = '<%= request.getAttribute("userId") %>';
		$(function() {
			$("#selectEntries").on("change", function() {
					var selectValue = $(this).val();
					window.location.href = "/Travel_jsp_lab/user-list?size="+ selectValue;
				});
		});
		function handlePagination(page, size, keysearch, searchType){
			if(keysearch!= null && keysearch != "" && keysearch != "undefined"){
				window.location.href = "/Travel_jsp_lab/user-list?keysearch="+keysearch+"&searchType="+searchType+"&page="+page+"&size="+ size;
			}else{
				window.location.href = "/Travel_jsp_lab/user-list?page="+page+"&size="+ size;
			}
		}
		function confirmDelete(userId, username) {
			if(userIdSession == userId){
				alert("Không thể xóa chính mình");
				return;
			}
		    if (confirm("Bạn muốn xóa tài khoản " + username +" ?")) {
		       $("input#idDelete").val(userId);
		       $("#form-delete-hidden").submit();
		    }
		}
		function confirmLock(userId, username) {
			if(userIdSession == userId){
				alert("Không thể khóa chính mình");
				return;
			}
		    if (confirm("Bạn muốn khóa tài khoản " + username +" ?")) {
		       $("input#idLock").val(userId);
		       $("#form-lock-hidden").submit();
		    }
		}
		function confirmOpen(userId, username) {
		    if (confirm("Bạn muốn mở lại tài khoản " + username +" ?")) {
		       $("input#idOpen").val(userId);
		       $("#form-open-hidden").submit();
		    }
		}
		function handleRedirectThemMoi(deleteUrl, username) {
			window.location.href = "/Travel_jsp_lab/user-create";
		}
		function handleRedirecEdit(userId) {
			window.location.href = "/Travel_jsp_lab/user-update?id=" + userId;
		}
	</script>
</head>
<body>
	<div class="d-flex justify-content-center row">
		<div class="p-4 col-12 col-sm-12 col-md-10">
			<jsp:include page="MenuBar.jsp">
			    <jsp:param name="pageIndex" value="2" />
			</jsp:include>
			<a class="text-decoration-none text-dark" href="${url.getUserList()}">
				<h1 style="cursor:pointer; width : 35%" >Danh sách người dùng</h1>
			</a>
		
			<hr>
			<button class="btn btn-success" onclick="handleRedirectThemMoi()">Thêm mới</button>
			<c:if test="${not empty notify}">
		        <h5 class="mt-1 mb-1 text-info">${notify}</h5>
		    </c:if>
			<c:if test="${not empty searchType}">
				<form action="user-list" class="mt-3 mb-2" method="POST">
					<div class="input-group mb-2 md-2" >
					    <select class="form-select" name="searchType" id="searchType" value="${searchType}">
					     	<option value="1" ${searchType == 1 ? 'selected' : ''}>Username</option>
			                <option value="2" ${searchType == 2 ? 'selected' : ''}>Email</option>
			                <option value="3" ${searchType == 3 ? 'selected' : ''}>Phone number</option>
			                <option value="4" ${searchType == 4 ? 'selected' : ''}>Full name</option>
					    </select>
						<input type="hidden" name="action" value="search" />
					    <input
							style="width: 70%"
							name="keyword"
							class="form-control"
							type="search"
							placeholder="Search..."
							aria-label="Search" 
							value="${keyword}">
			  		</div>
				</form>
  		
				<div class="input-group mb-2 md-2 d-flex align-items-center">
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
					<button type="button" class="mx-3 btn btn-success" onclick="handlePagination(${page - 1}, ${size}, '${keysearch}', ${searchType})"><</button>
					<button type="button" class="btn btn-success" onclick="handlePagination(${page + 1}, ${size}, '${keysearch}', ${searchType})">></button>	
				</div>
			</c:if>
			<c:if test="${empty searchType}">
				<form action="user-list" class="mt-3 mb-2" method="POST">
					<div class="input-group mb-2 md-2" >
					    <select class="form-select" id="searchType" name="searchType" id="form">
					      <option value="1">Username</option>
					      <option value="2">Email</option>
					      <option value="3">Phone number</option>
					      <option value="4">Full name</option>
					    </select>
						<input type="hidden" name="action" value="search" />
					    <input
					      style="width: 70%"
					      name="keyword"
					      class="form-control"
					      type="search"
					      placeholder="Search..."
					      aria-label="Search"
					      value = "">
			  		</div>
			  					    		    
				</form>
			  		<div class="input-group mb-2 md-2 d-flex align-items-center">
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
						<button type="button" class="mx-3 btn btn-success" onclick="handlePagination(${page - 1}, ${size}, '${keysearch}', ${searchType})"><</button>
						<button type="button" class="btn btn-success" onclick="handlePagination(${page + 1}, ${size}, '${keysearch}', ${searchType})">></button>
 			  		</div>
		
			</c:if>
			
			<table class="table table-responsive" style="overflow-x: scroll;">
				<thead class="thead-light">
				<tr>
					<th scope="col">Tài khoản</th>
					<th scope="col">Email</th>
					<th scope="col">Họ và tên</th>
					<th scope="col">Số điện thoại</th>
					<th scope="col">Tình trạng</th>
					<th scope="col">Vai Trò</th>
					<th scope="col">Hành động</th>
				</tr>
				</thead>
				<tbody>
					<c:if test = "${users.size() gt 0}">
					<c:forEach items="${users}" var="user">  
						<tr>
					      <td>${user.username}</td>
					      <td>${user.email}</td>
					      <td>${user.fullName}</td>
					      <td>${user.phoneNumber}</td>
					      <td>${user.status}</td>
					      <td id="role_id">
							  <c:choose>
							    <c:when test="${user.role_id == 1}">
							      ADMIN
							    </c:when>
							    <c:when test="${user.role_id == 2}">
							      USER
							    </c:when>
							    <c:otherwise>
							      Unknown
							    </c:otherwise>
							  </c:choose>
						  </td>				      
					      <td>
					      	<button class="btn btn-primary" onclick="handleRedirecEdit(${user.id})">Sửa</button>
					      	<button class="btn btn-danger" onclick="confirmDelete(${user.id},'${user.username}')">Xóa</button>
					      	<button class="btn btn-warning" onclick="confirmLock(${user.id},'${user.username}')">Khóa</button>
					      	<p></p>
					      	<button class="btn btn-success" onclick="confirmOpen(${user.id},'${user.username}')">Mở</button>
					      	<button class="btn btn-info" >
    							<a class="text-decoration-none text-light" href="${url.getAdminUserDetail()}?userId=${user.id}">Chi tiết</a>
					      	</button>
					      </td>
					    </tr>
					</c:forEach>  
					</c:if>
					<c:if test = "${users.size() eq 0}">
						<tr>
					      <td>Không có người dùng nào.</td>
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
	<div class="d-none">
		<form action="user-list" method="POST" id="form-delete-hidden">
			<input type="hidden" name="action" value="delete" />
			<input name="id" id="idDelete" />
		</form>
		<form action="user-list" method="POST" id="form-lock-hidden">
			<input type="hidden" name="action" value="lock" />
			<input name="id" id="idLock" />
		</form>
		<form action="user-list" method="POST" id="form-open-hidden">
			<input type="hidden" name="action" value="open" />
			<input name="id" id="idOpen" />
		</form>
	</div>
</body>

</html>