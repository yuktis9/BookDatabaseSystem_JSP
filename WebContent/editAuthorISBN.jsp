<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="custTag" uri="WEB-INF/custom.tld"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/bookDB/css/addAuthorISBN.css"></link>
<title>Insert title here</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="js/addTitle.js"></script>
<script type="text/javascript">

var addAuthorCount = 2;
$(document).ready(function(){

    $("#addAuthor").click(function(){  
    	
        $('#mainDiv').append("<div id=authorBlock"+addAuthorCount+"><div class='divBorder'>"
				+"<div class='a'>"
				+"<div class='l'>First Name <span style='color: red'>*</span> </div>"
				+"<div class='r'>"
				+"<INPUT type='text' name=firstName"+addAuthorCount+">"
				+"</div>"
				+"</div>"
				+"<div class='a'>"
				+"<div class='l'>Last Name <span style='color: red'>*</span></div>"
				+"<div class='r'>"
				+"<INPUT type='text' name=lastName"+addAuthorCount+">"
				+"</div>"
				+"</div>"
				+"<div class='a'>"
				+"<div class='l'><a onclick='removeAuthorBlock("+addAuthorCount+")' href='#'>Remove Author</a></div>"
				+"<div class='r'>&nbsp;</div>"
				+"</div>"
				+"</div><div>");
		
        addAuthorCount ++;    
    });   
});

	function removeAuthorBlock(addAuthorCount) {
		$('#authorBlock' + addAuthorCount).remove();
		addAuthorCount -- ;
	}
	
	function validateForm(){
		
		var formValidated = true;

		$('#addDataForm *').filter(':input').each(function(){
			
		    if($(this).val() == ""){
		    	$('#errorMsg').show();
		    	formValidated = false;
		    	$(this).css("border-color","red");
			}else{
				$(this).css("border-color","");
			}
		});
		return formValidated;
	}
	
</script>
</head>
<body>
<%@include file="header/header.jsp" %>
	<custTag:getDataCustomTag ISBN='<%=request.getParameter("ISBN")%>' getType="SpecificData"/>
	<center>
		<div class="m">
			<form name="register" id="addDataForm" method="post" action="addAuthorISBNFormSubmit.jsp?formType=edit">
				<fieldset>
					<legend>Edit Author and Book</legend>
					<h4 id="errorMsg" style="color: red; display: none">Fields marked with * are mandatory!</h4>
					<div>
					<div id="mainDiv">
						<div class="divBorder">
							<div class="a">
								<div class="l">First Name <span style="color: red">*</span></div>
								<div class="r">
									<INPUT type="hidden" name="authorID1" value="${authorISBN.authorID1}">
									<INPUT type="text" name="firstName1" value="${authorISBN.firstName1}">
								</div>
							</div>
							<div class="a">
								<div class="l">Last Name <span style="color: red">*</span></div>
								<div class="r">
									<INPUT type="text" name="lastName1" value="${authorISBN.lastName1}">
								</div>
							</div>
							<div class="a">
								<div class="l">&nbsp;</div>
								<div class="r">&nbsp;</div>
							</div>
						</div>
					</div>
					</div>
					<div class="a">
						<div class="l">
							&nbsp;
						</div>
						<div class="r">&nbsp;</div>
					</div>
					<div class="a"></div>
					
					<div id="mainDiv">
						<div class="divBorder">
							<div class="a">
								<div class="l">Title <span style="color: red">*</span></div>
								<div class="r">
									<INPUT type="text" name="title" value="${authorISBN.title}">
								</div>
							</div>
							<div class="a">
								<div class="l">ISBN <span style="color: red">*</span></div>
								<div class="r">
									<INPUT type="text" id="ISBN" name="ISBN" value="${authorISBN.ISBN}" readonly="readonly">
								</div>
							</div>
							<div class="a">
								<div class="l">Copyright <span style="color: red">*</span></div>
								<div class="r">
									<INPUT type="text" id="copyRight" name="copyRight" value="${authorISBN.copyRight}">
								</div>
							</div>
							<div class="a">
								<div class="l">Edition No <span style="color: red">*</span></div>
								<div class="r">
									<INPUT type="text" id="editionNo" name="editionNo" value="${authorISBN.editionNo}">
								</div>
							</div>
						</div>
					</div>
					
					<div class="a">
						<div class="l">
							<input type="submit" value="Submit" onclick="return validateForm()"/>
						</div>
						<div class="r">&nbsp;</div>
					</div>
					<div class="a"></div>
					
				</fieldset>
			</form>
		</div>
	</center>
</body>

<script type="text/javascript">

	var authorCount2 = '${authorCount2}';
	if(authorCount2 == 2){
		$('#mainDiv').append("<div id=authorBlock"+addAuthorCount+"><div class='divBorder'>"
				+"<div class='a'>"
				+"<div class='l'>First Name <span style='color: red'>*</span> </div>"
				+"<div class='r'>"
				+"<INPUT type='text' name=firstName"+addAuthorCount+" value='${authorISBN.firstName2}'>"
				+"<INPUT type='hidden' name='authorID2' value='${authorISBN.authorID2}'>"
				+"</div>"
				+"</div>"
				+"<div class='a'>"
				+"<div class='l'>Last Name <span style='color: red'>*</span></div>"
				+"<div class='r'>"
				+"<INPUT type='text' name=lastName"+addAuthorCount+" value='${authorISBN.lastName2}'>"
				+"</div>"
				+"</div>"
				+"<div class='a'>"
				+"<div class='l'></div>"
				+"<div class='r'>&nbsp;</div>"
				+"</div>"
				+"</div><div>");

		addAuthorCount ++;
	}

	var authorCount3 = '${authorCount3}';
	if(authorCount3 == 3){
		$('#mainDiv').append("<div id=authorBlock"+addAuthorCount+"><div class='divBorder'>"
				+"<div class='a'>"
				+"<div class='l'>First Name <span style='color: red'>*</span> </div>"
				+"<div class='r'>"
				+"<INPUT type='text' name=firstName"+addAuthorCount+" value='${authorISBN.firstName3}'>"
				+"<INPUT type='hidden' name='authorID3' value='${authorISBN.authorID3}'>"
				+"</div>"
				+"</div>"
				+"<div class='a'>"
				+"<div class='l'>Last Name <span style='color: red'>*</span></div>"
				+"<div class='r'>"
				+"<INPUT type='text' name=lastName"+addAuthorCount+" value='${authorISBN.lastName3}'>"
				+"</div>"
				+"</div>"
				+"<div class='a'>"
				+"<div class='l'></div>"
				+"<div class='r'>&nbsp;</div>"
				+"</div>"
				+"</div><div>");

		addAuthorCount ++;
	}
	
</script>

</html>
