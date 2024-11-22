<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
        crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/custom-style.css">
<title>게시판</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous">
<style type="text/css">
a {
	text-decoration: auto;
}

.row>* {
	width: auto;
}
</style>

<style>
.custom-select {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	background:
		url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="%23000" d="M7 10l5 5 5-5z"/></svg>')
		no-repeat right 10px center;
	background-size: 1em;
	padding-right: 2em;
}
</style>

</head>

<body>
	<br />
	<h1 class="text-center">
		<a href="testList.do" style="text-decoration: none; color: black;">게시판</a>
	</h1>

	<div class="d-flex justify-content-end mt-2 align-items-center" style="width: 100%">
		<span class="total-posts">총 게시물 수 : <strong>${totalPosts}</strong></span>
	</div>
	<br />
	<div class="container">
		<table class="table table-hover table-striped text-center"
			style="border: 1px solid;">
			<colgroup>
				<col width="3%" />
				<col width="10%" />
				<col width="20%" />
				<col width="40%" />
				<col width="10%" />
				<col width="17%" />
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th>번호</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성자</th>
					<th>등록일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="result" varStatus="status">
					<tr>
						<td><input type="checkbox" class="postCheck"
							value="${result.testId}" /></td>
						<!-- 고유한 testId 출력 -->
						<td>${result.testId}</td>
						<td>	
							<a href="listDetail.do?testId=${result.testId}">
							<c:if test="${result.isNew}">
								<span class="title-with-badge">
									<span class="badge bg-danger blink">N</span>
								</span>
							</c:if>						
							<c:choose>
								<c:when test="${fn:length(result.testTitle) > 15}">
									${fn:substring(result.testTitle, 0 , 15)}...
								</c:when>
								<c:otherwise>
									${result.testTitle}
								</c:otherwise>
							</c:choose>

						</td>
						<td>
							<c:choose>
								<c:when test="${fn:length(result.testContent) > 30}">
									${fn:substring(result.testContent, 0 , 30)}...
								</c:when>
								<c:otherwise>
									${result.testContent}
								</c:otherwise>
							</c:choose>
						</td>
						<td>							
						<c:choose>
								<c:when test="${fn:length(result.testName) > 5}">
									${fn:substring(result.testName, 0 , 5)}...
								</c:when>
								<c:otherwise>
									${result.testName}
								</c:otherwise>
							</c:choose>
						</td>
						<td><fmt:formatDate value="${result.testDate}"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="paginationBox" class="pagination1">
			<ul class="pagination" style="justify-content: center;">
				<c:if test="${pagination.prev}">
					<li class="page-item"><a class="page-link" href="#"
						onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', 
						'${pagination.listSize}', '${search.searchType}', '${search.keyword}')">이전</a>
					</li>
				</c:if>

				<c:forEach begin="${pagination.startPage}"
					end="${pagination.endPage}" var="testId">
					<li
						class="page-item ${pagination.page == testId ? 'active' : ''}">
						<a class="page-link" href="javascript:void(0)"
						onClick="fn_pagination('${testId}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.listSize}'
							,'${search.searchType}', '${search.keyword}')">
							${testId} </a>
					</li>
				</c:forEach>

				<c:if test="${pagination.next}">
					<li class="page-item"><a class="page-link" href="#"
						onClick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', 
						'${pagination.listSize}', '${search.searchType}', '${search.keyword}')">다음</a>
					</li>
				</c:if>
			</ul>
		</div>
		<hr />
		<div class="d-flex justify-content-between align-items-center mt-3">
			<!-- 왼쪽 검색 영역 -->
			<div class="form-group d-flex align-items-center">
				<div class="me-2">
					<select class="form-control form-control-sm custom-select"
						name="searchType" id="searchType">
						<option value="testTitle">제목</option>
						<option value="testContent">내용</option>
						<option value="testName">작성자</option>
					</select>
				</div>
				<div class="me-2">
					<input type="text" class="form-control form-control-sm"
						name="keyword" id="keyword">
				</div>
				<div>
					<button class="btn btn-sm btn-primary" name="btnSearch"
						id="btnSearch">검색</button>
					<button id="btn_previous" type="button" class="btn btn-sm btn-secondary">목록</button>	
					
				</div>
			</div>

			<!-- 오른쪽 버튼 영역 -->
			<div>
				<button id="btn_move" class="btn btn-warning text-white me-2"
					style="display: none;">수정</button>
				<button id="btn_delete" class="btn btn-danger me-2"
					style="display: none;">삭제</button>
				<a class="btn btn-primary" href="listRegister.do">글쓰기</a>
			</div>
		</div>

		<!-- 비밀번호 입력 모달 -->
        <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="passwordModalLabel">비밀번호 확인</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="passwordForm" method="POST">
                            <input type="hidden" name="testId" id="testId">
                            <div class="mb-3">
                                <label for="inputPassword" class="form-label">비밀번호</label>
                                <input type="password" class="form-control" id="inputPassword" name="password" placeholder="비밀번호를 입력하세요">
                            </div>
                            <div style="text-align: right;">
                            	<button type="submit" class="btn btn-primary">확인</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
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
        				<button type="button" clss="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
    <script>
		//비밀번호 모달에 포커스
		$('#passwordModal').on('shown.bs.modal', function(){
			$('#inputPassword').focus();
		});
	</script>
	
	<br>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW"
		crossorigin="anonymous"></script>
	<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"
			integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU"
			crossorigin="anonymous"></script>
	<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js"
			integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj"
			crossorigin="anonymous"></script>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		let selectedTestId = null;
		
		<c:if test="${not empty message}">
			console.log(message);
			var message = "<c:out value='${message}'/>";
			$('#customAlertMessage').text(message);
			$('#customAlertModal').modal('show');
		</c:if>
		
		function showCustomAlert(message) {
			$('#customAlertMessage').text(message);
			$('#customAlertModal').modal('show');
		}
		
		function showCustomConfirm(message, onConfirm) {
			$('#customConfirmMessage').text(message);
			$('#customConfirmModal').modal('show');
			
			$('#customConfirmOk').off('click').on('click', function(){
				$('#customConfirmModal').modal('hide');
				if (onConfirm) onConfirm();
			})
		}
		
		// 게시물 체크박스를 선택했을 때 이벤트 처리
		$(".postCheck").on("change", function () {
			$(".postCheck").not(this).prop("checked", false); // 다른 체크박스는 해제
			if ($(this).is(":checked")) {
				selectedTestId = $(this).val();
				$("#testId").val(selectedTestId); // 선택한 testId를 hidden 필드에 저장
				$("#btn_move, #btn_delete").show(); // 수정, 삭제 버튼 표시
			} else {
				selectedTestId = null;
				$("#tsetId").val('');
				$("#btn_move, #btn_delete").hide(); //체크를 해제했을 때 수정, 삭제 버튼 숨김
			}
		});

		// 수정 버튼 클릭 시 이벤트 처리
		$("#btn_move").on("click", function () {
			if (selectedTestId) {
				$("#passwordModal").modal("show"); 
				$('#inputPassword').val('');
				$("#passwordForm").attr("action", "listDetail.do?editMode=true"); 
			} else {
				showCustomAlert("게시물을 선택하세요.");
			}
		});

		let isDeleteAction = false;
		// 삭제 버튼 클릭 시 이벤트 처리
		$("#btn_delete").on("click", function () {
			if (selectedTestId) {
				isDeleteAction = true;
				$("#passwordModal").modal("show");
				$('#inputPassword').val('');
				$("#passwordForm").attr("action", "deleteList.do"); 
			} 
		});

		// 비밀번호 폼 제출 시 이벤트 처리
		$("#passwordForm").on("submit", function (e) {
			e.preventDefault(); // 기본 제출 방지
			if (!$("#inputPassword").val()) {
				showCustomAlert("비밀번호를 입력하세요.");
				return;
			} 
			
			const form = this;
			
			if (isDeleteAction) {
				showCustomConfirm("정말 삭제하시겠습니까?", function() {
					form.submit();
				})
			} else {
				form.submit();
			}
        });



		// 이전 버튼 이벤트
		window.fn_prev = function(page, range, rangeSize, listSize, searchType, keyword) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;

			var url = "<%= request.getContextPath() %>/testList.do";
				url += "?page=" + page;
				url += "&range=" + range;
				url += "&listSize=" + listSize;
				url += "&searchType=" + searchType;
				url += "&keyword=" + keyword;
				location.href = url;
		}

		// 페이지 번호 클릭 이벤트
		window.fn_pagination = function(page, range, rangeSize, listSize, searchType, keyword) {
			var url = "<%= request.getContextPath() %>/testList.do";
			url += "?page=" + page;
			url += "&range=" + range;
			url += "&listSize=" + listSize;
			url += "&searchType=" + searchType;
			url += "&keyword=" + keyword;

			console.log(url);
			location.href = url;
		}

		// 다음 버튼 이벤트
		window.fn_next = function(page, range, rangeSize, listSize, searchType, keyword) {
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;

			var url = "<%= request.getContextPath() %>/testList.do";
				url += "?page=" + page;
				url += "&range=" + range;
				url += "&listSize=" + listSize;
				url += "&searchType=" + searchType;
				url += "&keyword=" + keyword;
				location.href = url;
		}
		
		//검색 필드에서 엔터 키 입력 시 겸색 버튼 클릭 처리
		$('#keyword').on('keyup', function(e) {
			if (e.key === 'Enter' || e.keyCode === 13) {
				$('#btnSearch').click();
			}
		});

		// 검색 버튼 이벤트
		$(document).on('click', '#btnSearch', function(e) {
			e.preventDefault();
			var url = "<%= request.getContextPath() %>/testList.do";
				url += "?searchType=" + $('#searchType').val();
				url += "&keyword=" + $('#keyword').val();
				location.href = url;
				console.log(url);
		});
		
    	// 목록 버튼 이벤트
    	$("#btn_previous").click(function() {
        	$(location).attr('href', 'testList.do');
    	});
    });
</script>
</html>
