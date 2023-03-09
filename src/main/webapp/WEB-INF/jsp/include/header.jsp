<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
<div class="d-flex justify-content-between align-items-center header-box">
	
	<%-- logo --%>
	<div class="m-5">
		<a class="logo" href="/post/post_list_view"><h1 class="font=weight-bold">자유 게시판</h1></a>
	</div>

	<%-- 로그인 때만 노출: 환영멘트/로그아웃버튼 --%>
	<c:if test="${not empty userId}">
		<div class="m-3">
			<span>${userName}님 안녕하세요</span>
			<a href="/user/sign_out_view" class="btn btn-dark ml-3 font-weight-bold">로그아웃</a>
		</div>
	</c:if>
	
	<!-- 로그인x: 로그인/ 회원가입버튼 -->
	<c:if test="${empty userId}">
		<div class="mr-5">
		<a href="/user/sign_up_view" class="btn btn-dark ml-3 font-weight-bold">회원가입</a>
		<a href="/user/sign_in_view" class="btn btn-dark ml-3 font-weight-bold">로그인</a>
		</div>
	</c:if>
</div>