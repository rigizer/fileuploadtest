<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>boardList</title>
		
		<!-- Bootstrap Framework 사용 -->
		
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		
		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		
		<!-- Popper JS -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		
		<!-- Latest compiled JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		
		<!-- Bootstrap 4 Icons -->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
		
		<!-- Google Web Fonts -->
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=Righteous&display=swap" rel="stylesheet">
		
		<style>
			.center {
				margin: auto;
				text-align: center;
			}
			
			.ul-center {
				margin-left: auto;
 				margin-right: auto;
			}
			
			.title {
				font-family: 'Righteous', cursive;
			}

			.msg-title {
				white-space: nowrap;
				overflow: hidden;
				text-overflow: ellipsis;
			}

			.msg-writer {
				white-space: nowrap;
				overflow: hidden;
				text-overflow: ellipsis;
			}

			.tb-fixed {
				table-layout: fixed;
			}
			
			body {
				font-family: 'Noto Sans KR', sans-serif;
			}
			
			h1 {
				font-family: 'Do Hyeon', sans-serif;
			}
			
			th {
				background-color: #F9F9FB;
			}

			a:link {color: black;}
			a:visited {color: black;}
			a:active {color: black;}
			a:hover {color: black;}
		</style>
	</head>
	<body>
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
            <div class="container">
                <a class="navbar-brand title" href="${pageContext.request.contextPath}/">FileUploadTest</a>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/boardList/1">게시물 목록</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/addBoard">게시물 입력</a>
                    </li>
                </ul>
            </div>
        </nav>
		
		<div class="container center" style="width: 60%;">
			
			<br>
		
			<h1>게시물 목록</h1>
			
			<br>

			<button type="button" class="btn btn-sm btn-dark" style="float: right;" onclick="location.href='${pageContext.request.contextPath}/addBoard'">게시물 입력</button>

			<br><br>
			
			<table class="table table-hover center tb-fixed">
				<thead>
					<tr>
						<th width="20%">번호</th>
						<th width="80%">제목</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="b" items="${boardList}">
						<tr>
							<td>${b.boardId}</td>
							<td><a href="${pageContext.request.contextPath}/boardOne/${b.boardId}">${b.boardTitle}</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<br>
			
			<!-- 페이지 네비게이션 -->
			<ul class="pagination justify-content-center">
				<!-- 처음으로 버튼 -->
				<c:choose>
					<c:when test="${currentPage > 1}">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/boardList/1">
								<i class='fas fa-angle-double-left'></i>
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled">
							<a class="page-link" href="#">
								<i class='fas fa-angle-double-left'></i>
							</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<!-- 이전 버튼 -->
				<c:choose>
					<c:when test="${currentPage > 1}">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/boardList/${currentPage - 1}">
								<i class='fas fa-angle-left'></i>
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled">
							<a class="page-link" href="#">
								<i class='fas fa-angle-left'></i>
							</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<!-- 현재 페이지 표시 -->
				<c:forEach var="i" begin="${navFirstPage}" end="${navLastPage}">
					<c:if test="${i <= lastPage}">
						<c:choose>
							<%-- 현재 페이지 --%>
							<c:when test="${i == currentPage}">
								<li class="page-item active">
									<a class="page-link" href="#">${i}</a>
								</li>
							</c:when>
							<%-- 현재 페이지가 아닌 선택 가능한 페이지 --%>
							<c:otherwise>
								<li class="page-item">
									<a class="page-link" href="${pageContext.request.contextPath}/boardList/${i}">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
				
				<!-- 다음 버튼 -->
				<c:choose>
					<c:when test="${currentPage < lastPage}">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/boardList/${currentPage + 1}">
								<i class='fas fa-angle-right'></i>
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled">
							<a class="page-link" href="#">
								<i class='fas fa-angle-right'></i>
							</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<!-- 마지막으로 버튼 -->
				<c:choose>
					<c:when test="${currentPage < lastPage}">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/boardList/${lastPage}">
								<i class='fas fa-angle-double-right'></i>
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled">
							<a class="page-link" href="#">
								<i class='fas fa-angle-double-right'></i>
							</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
			
			<!-- 총 페이지 수 출력 -->
			<table style="margin: auto;">
				<tr>
					<td>
						<button type="button" class="btn btn-outline-dark btn-sm">
							${currentPage} / ${lastPage} 페이지
						</button>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>