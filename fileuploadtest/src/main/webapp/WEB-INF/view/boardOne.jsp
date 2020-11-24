<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>boardOne</title>
		
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
		
			<h1>게시물 조회</h1>
			
			<br>

			<div class="btn-group" style="float: right;">
				<button type="button" class="btn btn-sm btn-primary" onclick="location.href='${pageContext.request.contextPath}/modifyBoard/${board[0].boardId}'">수정</button>
				<button type="button" class="btn btn-sm btn-danger" onclick="location.href='${pageContext.request.contextPath}/removeBoard/${board[0].boardId}'">삭제</button>
			</div>
		
			<br><br>
		
			<table class="table table-hover center tb-fixed">
				<tr>
					<td width="20%">번호</td>
					<td width="80%">
						${board[0].boardId}
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>
						${board[0].boardTitle}
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						${board[0].boardContent}
					</td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td>
						<c:if test="${null ne board[0].boardfile[0]}">
							<c:forEach var="bf" items="${board[0].boardfile}">
								<div>
									<a href="${pageContext.request.contextPath}/upload/${bf.boardfileName}">
										${bf.boardfileName}
									</a>
								</div>
							</c:forEach>
					    </c:if>
					    <c:if test="${null eq board[0].boardfile[0].boardfileName}">
							(첨부파일이 없습니다)
					    </c:if>
					</td>
				</tr>
			</table>
			
			<br>
			
			<table class="table center tb-fixed">
				<thead>
					<th width="20%"></th>
					<th width="60%">댓글</th>
					<th width="20%"></th>
				</thead>
				<tbody>
					<c:forEach var="c" items="${board[0].commentList}">
						<c:if test="${!empty c.commentContent}">
							<tr>
								<td>${c.commentId}</td>
								<td>${c.commentContent}</td>
								<td>
									<button type="button" class="btn btn-sm btn-danger" onclick="location.href='${pageContext.request.contextPath}/removeComment/${c.commentId}/${c.boardId}'">삭제</button>
								</td>
							</tr>
						</c:if>
						
						<c:if test="${empty c.commentContent}">
							<tr>
								<td colspan="3">(댓글이 없습니다)</td>
							</tr>
						</c:if>
					</c:forEach>
					
					<tr>
						<td colspan="3">
							<form action="${pageContext.request.contextPath}/addComment" method="post">
								<input type="hidden" name="boardId" value="${board[0].boardId}">
								<div class="input-group mb-3">
									<input type="text" class="form-control" name="commentContent"></input>
									<div class="input-group-append">
										<button type="submit" class="btn btn-sm btn-dark">댓글 입력</button>
									</div>
								</div>
							</form>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>