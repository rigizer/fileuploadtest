<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>login</title>
		
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/addBoard">파일 업로드</a>
                    </li>
                </ul>
            </div>
        </nav>
        
		<div class="container center" style="width: 60%;">
			
			<br>
		
			<h1>로그인</h1>
			
			<br>

			<form method="post" action="${pageContext.request.contextPath}/login">
				<table class="table center tb-fixed">
					<tr>
						<td width="30%">ID</td>
						<td width="80%">
							<input type="text" class="form-control" name="userId" value="${user.userId}">
						</td>
					</tr>
					<tr>
						<td>PW</td>
						<td>
							<input type="password" class="form-control" name="userPw">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="submit" class="btn btn-block btn-primary">로그인</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>