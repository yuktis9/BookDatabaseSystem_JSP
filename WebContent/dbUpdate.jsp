<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib prefix="custTag" uri="WEB-INF/custom.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>
<body>
<%@include file="header/header.jsp" %>
<custTag:getDataCustomTag getType="allData" ISBN='<%= request.getParameter("ISBN") %>'/>
<table border="1">
	<thead>
		<tr>
			<th>Title</th>
			<th>ISBN</th>
			<th>Copyright</th>
			<th>Edition No</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${titles}" var="title">
			<tr>
				<td><c:out value="${title.title}"></c:out></td>
				<td><c:out value="${title.ISBN}"></c:out></td>
				<td><c:out value="${title.copyRight}"></c:out></td>
				<td><c:out value="${title.editionNo}"></c:out></td>
				<td>
					<a href=editAuthorISBN.jsp?ISBN=<c:out value="${title.ISBN}"></c:out>>Edit</a>
					<a href=dbUpdate.jsp?ISBN=<c:out value="${title.ISBN}"></c:out> onclick="confirm('Are You Sure?')">Delete</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>