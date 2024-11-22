<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 내용</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" 
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" 
	crossorigin="anonymous">

		
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script
	src= "https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" 
	crossorigin="anonymous">"></script>

</head>
<body>
	<br />
	<h1 class="text-center">게시판 내용</h1>
	<br />
	<br />
	
	
	<div class="container">
		<form action="updateList.do" id="listDetail" method="post">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<th style="text-align: center; vertical-align:middle;">게시글 번호</th>
						<td style="text-align: center; vertical-align:middle;">
							<input name="testId" type="text" value="${vo.testId}" class="form-control" readonly style="text-align: center;"/>
						</td>
						<th style="text-align: center; vertical-align:middle;">작성자</th>
						<td style="text-align: center; vertical-align:middle;">
							<input name="testName" type="text" value="${vo.testName}" class="form-control" readonly style="text-align: center;"/>
						</td>
						<th style="text-align: center; vertical-align:middle;">작성 일자</th>
						<td style="text-align: center; vertical-align:middle;">
							<fmt:formatDate value="${vo.testDate}" pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align:middle;">제목</th>
						<td colspan="5"><input type="text" value="${vo.testTitle}"
							name="testTitle" class="form-control" maxlength="50" <c:if test="${!editMode}">readonly</c:if> /></td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align:middle;">내용</th>
						<td colspan="5"><textarea name="testContent" class="form-control"
								style="height: 200px;" maxlength="255" <c:if test="${!editMode}">readonly</c:if> >${vo.testContent}</textarea></td>
					</tr>
					<tr>
						<td colspan="7" style="text-align: right;">
							<c:if test="${editMode}">
								<button id="btn_modify" type="submit" class="btn btn-warning text-white">저장</button>
							</c:if>
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
        
        <!-- 커스텀 confirm modal -->
        <div class="modal fade" id = "customConfirmModal" tabindex="-1" aria-labelledby="customConfirmLabel" aria-hidden="true">
        	<div class="modal-dialog">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h5 class="modal-title" id = "customConfirmLabel">확인</h5>
        				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        			</div>
        			<div class="modal-body" id="customConfirmMessage">
        				
        			</div>
        			<div class="modal-footer">
        				<button type="button" class="btn btn-primary" id="customConfirmOk">확인</button>
        				<button type="button" class="btn btn-secondary" id="customConfirmCancel" data-bs-dismiss="modal">취소</button>
        			</div>
        		</div>
        	</div>
        </div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		<c:if test="${not empty message}">
			var message = "<c:out value='${message}'/>";
			$('#customAlertMessage').text(message);
			$('#customAlertModal').modal('show');
		</c:if>
		
		function showCustomConfirm(message, onConfirm) {
			$('#customConfirmMessage').text(message);
			$('#customConfirmModal').modal('show');
			
			$('#customConfirmOk').off('click').on('click', function() {
				$('#customConfirmModal').modal('hide');
				if (onConfirm) onConfirm();
			});
		}
    	
		//수정 버튼 클릭 시 이벤트 처리
    	 $("#btn_modify").on("click", function(e) {
        	e.preventDefault();
        	showCustomConfirm("정말 수정하시겠습니까?", function() {
        	    $("#listDetail").attr("action", "updateList.do");
        	    $("#listDetail").submit();
        	});
    	 });
    	

    	// 목록 버튼 클릭 시 이벤트 처리
    	$("#btn_previous").click(function() {
        	$(location).attr('href', 'testList.do');
    	});
	});
	
</script>
</html>
