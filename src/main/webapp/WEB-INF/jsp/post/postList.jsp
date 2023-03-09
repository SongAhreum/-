<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!-- post list 비로그인상태 -->
<div  class="d-flex justify-content-center">	
	<div>
		<div class="d-flex align-items-center">
			<h1>글 목록</h1>
			<c:if test="${not empty userId}">
				<div class="mr-5">
				<a href="/post/post_create_view" class="btn btn-dark ml-3 font-weight-bold">글쓰기</a>
				<a href="/post/post_my_view" class="btn btn-dark ml-3 font-weight-bold">내 글 목록</a>
				</div>
			</c:if>
		</div>
		
		<table class="table post-list-table table-bordered">
			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성날짜</th>
					<th>수정날짜</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="postlist" items="${postList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					
					<td><a class="box" href="/post/post_detail_view?postId=${postlist.id}">${postlist.subject}</a></td>
					<td>${postlist.loginId}</td>
					<td><fmt:formatDate value="${postlist.createdAt}" pattern="yyyy.MM.dd"/></td>
					<td><fmt:formatDate value="${postlist.updatedAt}" pattern="yyyy.MM.dd"/></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</div>
