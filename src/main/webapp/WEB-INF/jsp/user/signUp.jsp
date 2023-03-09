<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="sign-up-box mt-5">
		<h1>회원가입</h1>
	 	<form id="signUpForm" method="post" action="/user/sign_up">
			<%--form태그3종세트 id,name,submit버튼 --%>
			<table class="sign-up-table table table-bordered">
				<tr>
					<th>* 아이디(4자 이상)<br></th>
					<td>
						
						<div class="d-flex">
							<input type="text" id="loginId" class="form-control" placeholder="아이디를 입력하세요.">
							<button type="button" id="loginIdCheckBtn" class="ml-2 btn btn-info">중복확인</button>
						</div>
						
						<%-- 아이디 체크결과 보이기 --%>
						<div id="idCheckLength" class="small text-danger d-none"> ID를 4자 이상 입력해주세요.</div>
						<div id="idCheckDuplicated" class="small text-danger d-none"> 이미 사용중인 ID입니다.</div>
						<div id="idCheckOk" class="small text-success d-none"> 사용 가능한 ID 입니다.</div>
					
					</td>
				</tr>
				<tr>
					<th>* 비밀번호</th>
					<td><input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr>
					<th>* 비밀번호 확인</th>
					<td><input type="password" id="confirmPassword" class="form-control" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr>
					<th>* 이름</th>
					<td><input type="text" id="name" name="name" class="form-control" placeholder="이름를 입력하세요."></td>
				</tr>
				<tr>
					<th>* 이메일 주소</th>
					<td><input type="text" id="email" name="email" class="form-control" placeholder="이메일 주소를 입력하세요."></td>
				</tr>
			</table>
			
			<button type="submit" id="signUpBtn" class="btn btn-warning  float-right">회원가입</button>

		</form>
	</div>
</div>

<script>
	$(document).ready(function(){
		//중복확인버튼 클릭
		$("#loginIdCheckBtn").on('click',function(){
			//alert("중복확인")
			
			//초기화
			/* idCheckLength
			idCheckDuplicated
			idCheckOk */
			$('#idCheckLength').addClass('d-none'); 
			$('#idCheckDuplicated').addClass('d-none');
			$('#idCheckOk').addClass('d-none');
			
			let loginId = $("#loginId").val().trim(); //alert(loginId);
			
			if(loginId.length < 4 ){
				$('#idCheckLength').removeClass('d-none'); //경고문구노출 
				return; //서버에가면안됨,return필수(이벤트명 submit이면 return false;)
			}
			
			//AJAX 중복확인
			$.ajax({
				//request
				type:"GET"
				,url:"/user/is_duplicated_id"
				,data:{"loginId":loginId}				
				//response
				,success:function(data){
					if(data.code == 1){
						//성공
						if(data.result){
							//중복
							$('#idCheckDuplicated').removeClass('d-none');
						} else{
							//사용가능
							$('#idCheckOk').removeClass('d-none');
						}
						
					} else {
						//실패
						alert(data.errorMessage);
					}
				}
				,error:function(e){
					alert("에러확인에 실패하였습니다")
				}				
			});	
		});
		
		//회원가입
		$("#signUpForm").on('submit',function(e){
			e.preventDefault(); // 서브밋 기능 중단
			
			//validation
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val();
			let confirmPassword = $('#confirmPassword').val();
			let name = $('#name').val().trim();
			let email = $('#email').val().trim();
			
			if(loginId == ""){
				alert("아이디를 입력하세요");
				return false;
			}
			if(password == '' || confirmPassword == ''){
				alert('비밀번호를 입력하세요');
				return false;
			}
			if(password != confirmPassword){
				alert("비밀번호가 일치하지 않습니다")
				return false;
			}
			if(name == ""){
				alert("이름을 입력하세요");
				return false;
			}
			if(email == ""){
				alert("이메일을 입력하세요");
				return false;
			}
			//아이디 중복확인 완료여부 d-none여부로체크
			if($('#idCheckOk').hasClass('d-none')){
				alert("아이디 중복확인을 다시 해주세요")
				return false;
			}
			
			//post 회원가입데이터전송
			let url = $(this).attr('action');
			
			//$.post안되서 바꿈 ㅠㅠ흐-ㄱ
			$.ajax({
				// request
				type:"post"
				,url:url
				,data:{"loginId":loginId,"password":password,"name":name,"email":email}
				//response
				,success:function(data){
					if (data.code == 1) {
						// 성공
						alert("가입을 환영합니다! 로그인 해주세요.");
						location.href = "/user/sign_in_view";
					} else {
						// 실패
						alert(data.errorMessage);
					}
				}				
			});				
				
		});			
	});
</script>