<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addBoard</title>
		
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
		
		<script>
			$(document).ready(function() {
				// 파일 추가 버튼을 누를 때
				$('#addBtn').click(function() {
					html = '<div><input type="file" class="form-control boardfile" name="boardfile"></div>';
					$('#fileinput').append(html);
				});

				// 파일 삭제 버튼을 누르면 마지막에 append된 첨부파일이 삭제
				$('#delBtn').click(function() {
					$('#fileinput').children().last().remove();
				});

				// 입력 버튼을 누를 때
				$('#submitBtn').click(function() {
					// 비어있는 파일이 있는지 체크 (없으면 true, 하나라도 있으면 false)
					let ck = true;
					
					// 반복문을 돌리면서 각 첨부파일을 확인
					$('.boardfile').each(function(index, item) {
						console.log($(item).val());
						
						// 비어있는 파일이 하나라도 있는 경우
						if($(item).val() == '') {
							ck = false;
						}
					});

					// ck가 true일 때만 폼 입력 가능
					if (ck == true) {
						$('#fileuploadForm').submit();
					} else {	// 아닌 경우 경고창 띄우기
						alert('선택하지 않은 파일이 있습니다.\n다시 한 번 확인해주세요.');
					}
				});
			});
		</script>
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
		
			<h1>게시물 입력</h1>
			
			<br>
			
			<form id="fileuploadForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/addBoard">
			
				<button type="button" class="btn btn-sm btn-dark" style="float: right;" id="submitBtn">게시물 입력</button>
			
				<br><br>
			
				<table class="table table-hover center tb-fixed">
					<tr>
						<td width="20%">제목</td>
						<td width="80%">
							<input type="text" class="form-control" name="boardTitle">
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea name="boardContent" class="form-control" rows="10" cols="50"></textarea>
						</td>
					</tr>
					<tr>
						<td>파일</td>
						<td>
							<div>
								<button type="button" class="btn btn-sm btn-dark" id="addBtn">파일 추가</button>
								<button type="button" class="btn btn-sm btn-dark" id="delBtn">파일 삭제</button>
							</div>
							<div id="fileinput"></div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>