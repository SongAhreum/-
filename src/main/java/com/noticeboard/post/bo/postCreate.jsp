<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center ml-5">
	<div class="w-75 mt-5 ml-5">
		<h1 class="ml-5">  글작성하기</h1>
		
		<%--제목입력박스--%>
		<div class="d-flex justify-content-start mt-3">
			<span class="mr-3">제목 :</span>
			<input id="subject" type="text" class="form-control col-6 ml-3" placeholder="제목을 입력하세요">
		</div>
		<%--내용입력박스--%>
		<div class="d-flex justify-content-start mt-3">
			<span>글 내용 :</span>
			<textarea id="content" class="ml-3 form-control col-8" rows="10" placeholder="내용을 입력하세요"></textarea>
		</div>
		<%--첨부--%>
		
		<div class="d-flex justify-content-end w-75 mt-3">
			<!-- 파일형식 유효성검사따로 필요함 -->
			<input type="file" id="file" class="form-control w-50 mr-4" accept=".jpg,.jpeg,.png,.gif">
		</div>
		
		
		<%--글쓰기 버튼--%>
		<div class="d-flex justify-content-end w-75 mr-5 mt-3 mb-5">
			<button type="button" id="clearBtn" class="btn btn-secondary mr-3">모두 지우기</button>
			<button type="button" id="postCreateBtn" class="btn btn-info mr-4">저장</button>
		</div>
		<div class="d-flex justify-content-end w-75 mr-5 mt-3 mb-5">
			<a href="/post/post_list_view" class="btn btn-dark ml-3 font-weight-bold mr-3 mb-3">목록으로</a>
		</div>
	</div>	
</div>

<script>
	$(document).ready(function(){
		$("#clearBtn").on('click',function(){
			$('#subject').val("");
			$('#content').val("");
			$('#file').val("");
		});
		
		<%--submit?아니라서 엔터안먹힘 클릭만! --%>
		$('#postCreateBtn').on('click',function(){
			let subject = $('#subject').val();
			let content = $('#content').val();
			let file = $('#file').val();
			
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
			formData.append("subject", subject);
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			
			
			$.ajax({
				type:"POST"
					, url:"/post/create"
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