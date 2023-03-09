<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="login-box mt-5">
		<h1>로그인</h1>
		
		<form id="loginForm" action="/user/sign_in" method="post">
			<div class="input-group mt-4 mb-2">
				<div class="input-group-prepend">
					<span class="input-group-text">ID</span>
				</div>
				<input type="text" class="form-control" id="loginId" name="loginId">
			</div>
			
			<div class="input-group mb-5">
				<div class="input-group-prepend">
					<span class="input-group-text">PW</span>
				</div>
				<input type="password" class="form-control" id="password" name="password">
			</div>
			<%-- btn-block: 로그인 박스 영역에 버튼을 가득 채운다. --%>
			<input type="submit" class="btn btn-block btn-success" value="로그인">
			<a class="btn btn-block btn-dark" href="/user/sign_up_view">회원가입</a>
		
		</form>
		
	</div>
</div>

<script>
	$(document).ready(function(){
		$('#loginForm').on('submit',function(e){
			e.preventDefault();
			
			//validation
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val();
			
			if(loginId == ""){
				alert("아이디를 입력하세요");
				return false;
			}
			if(password == ''){
				alert('비밀번호를 입력하세요');
				return false;
			}
			//ajax
			let url = $(this).attr('action');
			let params = $(this).serialize();
			
			$.post(url, params) //request
			.done(function(data){ //response
				if (data.code == 1){ //성공
					location.href = "/post/post_list_view";
				} else{
					alert(data.errorMessage);
				}
			});
		});
	}); 
</script>