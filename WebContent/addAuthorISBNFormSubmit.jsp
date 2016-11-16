<jsp:useBean id="authorISBN" class="bookDB.dto.AuthorISBN" scope="request"/>
<jsp:setProperty name="authorISBN" property="*"/> 

<%@ taglib prefix="custTag" uri="WEB-INF/custom.tld"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<custTag:addAuthorISBNCustomTag authorISBN="<%=authorISBN%>" formType='<%=request.getParameter("formType")%>'/>

</body>
</html>