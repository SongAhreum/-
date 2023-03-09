<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!-- 내가 쓴 글 목록 -->
<div  class="d-flex justify-content-center">	
	<div>
		<h1>내 글 목록</h1>
		<table class="table post-list-table table-bordered">
			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>작성날짜</th>
					<th>수정날짜</th>
				</tr>
			</thead>
			<tbody>
			
				<c:forEach var="postmylist" items="${postMyList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td><a href="/post/post_detail_view?postId=${postmylist.id}">${postmylist.subject}</a></td>
					<td><fmt:formatDate value="${postmylist.createdAt}" pattern="yyyy.MM.dd"/></td>
					<td><fmt:formatDate value="${postmylist.updatedAt}" pattern="yyyy.MM.dd"/></td>
				</tr>
				</c:forEach>			
			</tbody>
		</table>
	</div>
</div>