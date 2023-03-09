<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--제목입력박스--%>

<div class="container">
	<div class="d-flex justify-content-start mt-3">
		<span class="mr-3">제목 :</span>
		<input id="subject" type="text" class="form-control col-6 ml-3" value="${post.subject}">
	</div>
	<%--내용입력박스--%>
	<div class="d-flex justify-content-start mt-3">
		<span>글 내용 :</span>
		<textarea id="content" class="ml-3 form-control col-8" rows="10">${post.content}</textarea>
	</div>
	<%--첨부--%>
	
	<div class="d-flex justify-content-end w-75 mt-3">
		<!-- 파일형식 유효성검사따로 필요함 -->
		<input type="file" id="file" class="form-control w-50 mr-4" accept=".jpg,.jpeg,.png,.gif" value="${post.imagePath}">
	</div>
	<div class="d-flex justify-content-end  mb-1 w-75 ">
		<button id="post-update-btn" class="btn btn-secondary form-control col-2 mr-3 mt-4">수정하기</button>
	</div>
	
</div>

<script>
	$(document).ready(function(){
		$("#post-update-btn").on('click',function(){
			let id = ${post.id};
			let subject = $('#subject').val().trim();
			let content = $('#content').val();
			alert(content);			
			let file = $('#file').val();
			//유효성검사
			if(subject == ""){
				alert("제목을 입력하세요");
				return;
			}
			//확장자 체크
			if(file != ""){
				let ext = file.split(".").pop().toLowerCase();
				if ($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {
					alert("이미지 파일만 업로드 할 수 있습니다.");
					$('#file').val(""); // 파일을 비운다.
					return;
				}
			}
			// 이미지를 업로드 할 때는 form태그가 있어야 한다.(자바스크립트에서 만듦)
			// append 로 넣는 값은 폼태그의 name으로 넣는 것과 같다(request parameter)
			let formData = new FormData();
			formData.append("id", id);
			formData.append("subject", subject);
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			$.ajax({
				type:"put"
					, url:"/post/update"
					, data:formData  // 폼객체를 통째로
					, enctype:"multipart/form-data" // 파일 업로드를 위한 필수 설정
					, processData:false  // 파일 업로드를 위한 필수 설정
					, contentType:false  // 파일 업로드를 위한 필수 설정
					, success:function(data) {
						if (data.code == 1) {
							// 성공
							alert("게시글이 저장되었습니다.");
							location.href = "/post/post_list_view";
						} else {
							// 실패
							alert(data.errorMessage);
						}
					}
					, error:function(e) {
						alert("게시글 저장에 실패했습니다.");
					}		
			});
		});
	});

</script>		