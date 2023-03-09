<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="container">
	<%--내 post일때만 보이는 삭제하기 수정하기 --%>
	<div class="d-flex justify-content-end  mb-1 mt-3">
		<span class="mr-3">게시글 :</span>
		<a class="btn btn-dark form-control col-1 mr-3" href="/post/post_modify_view?id=${post.id}">수정하기</a>
		<button id="delete-post-btn" type="button" class="btn btn-danger form-control col-1"> 삭제하기</button>
	</div>


	<hr>
	<div style="display: none" class="postId">${post.id}</div>
	<h2>${post.subject}</h2>
	<hr>
	<div class="content-box">${post.content}</div>
	<hr>
	<div>
		<img alt="이미지불러오기" src="">
	</div>
	<hr><hr>
	<div class="comment-box">
		<button type="block" class="comment-box form-control d-flex justify-content-start" >댓글</button>
		
		
		<c:forEach var="comment" items="${comments}">	
			<div class="d-flex ml-3">
				<div>${comment.loginId} :</div>
				<div class="ml-3 mr-5">${comment.content}</div>
				
				<c:if test="${comment.userId eq post.userId}">
				<input type="button" class="delete-comment-btn ml-5 btn btn-sm" data-comment-id="${comment.id}" value="댓글삭제">
				</c:if>
			
			</div>
		</c:forEach>	
			
		<div class="d-flex">
			<c:set var="postId" value="${post.id}"/>
			<input id="content" type="text" class="form-control mr-5" placeholder="댓글내용을 작성해주세요">
			<button id="post-comment-btn" type="button" class="btn btn-dark form-control col-1">댓글작성</button>
		</div>
	</div>
	<div class="d-flex justify-content-end  mb-1 ">
		<%--내글일때만 삭제하기 버튼 보이기 --%>
		
		<a href="/post/post_list_view" class="btn btn-secondary mt-3 mb-3">목록으로</a>
		
	</div>
</div>
 
    <!-- post-comment-box눌렀을때 data(post-id)값 넘김
    postId라는 변수를 선언하고 해당변수에 담아서 데이터 전달 
    댓글창만 redirect할지 아니면그냥 바로 post페이지를 바로 불러올지정하자 
    -->
    <!-- post.userId = comment.userId일때 댓글수정가능하게 -->
<script>
	$(document).ready(function(){
		$("#post-comment-btn").on("click",function(){
			let postId = $(".postId").text();
			console.log(postId);
			let content = $("#content").val();
			if(content == ""){
				alert("댓글 내용을 입력하세요");
				return;
			}
			$.ajax({
				type:"post"
				,url:"/post/post_comment"
				,data:{"postId":postId,"content":content}
				,success:function(data){
					if(data.code == 1){
						alert("댓글등록완료");
						document.location.replace("/post/post_detail_view?postId=${post.id}");
					}	
				}				
			});			
		});
		$(".delete-comment-btn").on('click',function(){
			alert("댓글을 삭제합니다.");
			let CommentId = $(this).data("comment-id");
			$.ajax({
				type:"delete"
				,url:"/post/delete_comment"
				,data:{"id":CommentId}
				,success:function(data){
					if(data.code== 1){
						//성공
						document.location.replace("/post/post_detail_view?postId=${post.id}"); 
					} else if (data.result == 500){
						alert(data.error_message); 
					}
				}
				,errer:function(e){
					alert("삭제하는데 통신이 실패하였습니다"+e);
				}
			});
		});
		$("#delete-post-btn").on('click',function(){
			alert("게시글을 삭제합니다");
			let postId = $(".postId").text();
			$.ajax({
				type:'delete'
				,url:"/post/delete"
				,data:{"id":postId}
				,success:function(data){
					if(data.code== 1){
						//성공
						document.location.replace("/post/post_list_view"); 
					} else if (data.result == 500){
						alert(data.error_message); 
					}
				}
				,errer:function(e){
					alert("삭제하는데 통신이 실패하였습니다"+e);
				}
			});
		});
	});

</script>    