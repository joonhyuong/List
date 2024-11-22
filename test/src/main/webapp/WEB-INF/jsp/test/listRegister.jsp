<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시글 작성</title>
    <!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" 
		crossorigin="anonymous">

    <!-- Optional theme -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" 
		integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" 
		crossorigin="anonymous">


    <!-- jQuery 먼저 로드 -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" 
		crossorigin="anonymous"></script>
</head>
<body>
	<br />
	<h1 class="text-center">게시글 작성</h1>
	<br />
	<br />
	<div class="container">
		<form id="form_test" action="insertList.do" method="post" >
			<table class="table table-bordered">
				<tbody>
					<tr>
						<th style="text-align: center; vertical-align:middle;">제목</th>
						<td><input type="text" maxlength="50" placeholder="제목을 입력하세요." name="testTitle" class="form-control"/></td>
						<th style="text-align: center; vertical-align:middle;">작성자</th>
						<td><input type="text" maxlength="50" placeholder="작성자를 입력하세요." name="testName" class="form-control"/></td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align:middle;">내용</th>
						<td colspan="5"><textarea maxlength="255" placeholder="내용을 입력하세요" name="testContent"
								class="form-control" style="height: 200px;"></textarea>
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align:middle;">비밀번호</th>
						<td colspan="5"><input type="password" maxlength="50" placeholder="비밀번호를 입력하세요." name="password" class="form-control" /></td>
					</tr>
					<tr>
						<td colspan="5" style="text-align: right;">
							<button id="btn_register" type="submit" class="btn btn-primary">등록</button>
							<button id="btn_previous" type="button" class="btn btn-secondary">목록</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		
		<!-- 커스텀 alert modal -->
        <div class="modal fade" id = "customAlertModal" tabindex="-1" aria-labelledby="customAlertLabel" aria-hidden="true">
        	<div class="modal-dialog">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h5 class="modal-title" id = "customAlertLabel">알림</h5>
        				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        			</div>
        			<div class="modal-body" id="customAlertMessage">
        				
        			</div>
        			<div class="modal-footer">
        				<button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
        			</div>
        		</div>
        	</div>
        </div>
	</div>
</body>
<script type="text/javascript">

	function showCustomAlert(message) {
		$('#customAlertMessage').text(message);
		$('#customAlertModal').modal('show');
	}
	$("input[name='testTitle']").focus();
	// 글쓰기 버튼 클릭 시 폼 제출
	$(document).on('click', '#btn_register', function(e) {
		e.preventDefault();
		

		
	    var testTitle = $("input[name='testTitle']").val().trim();
	    var testContent = $("textarea[name='testContent']").val().trim();
	    var password = $("input[name='password']").val().trim();
	    var testName = $("input[name='testName']").val().trim();

	    if (testTitle === "" || testContent === "" || password ==="" || testName ==="") {
	    	showCustomAlert("제목, 내용, 작성자, 비밀번호를 모두 입력해 주세요.");
	        return; // 폼 제출 중단
	    }
	    
	    $("#form_test").submit();
	});

	// 이전 버튼 클릭 시 리스트 페이지로 이동
	$(document).on('click', '#btn_previous', function(e) {
		$(location).attr('href', 'testList.do');
	});
</script>
</html>
