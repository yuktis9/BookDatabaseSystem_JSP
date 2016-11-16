
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

$(document).ready(function(){

	var addAuthorCount = 2;
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
	<center>
		<div class="m">
			<form name="register" id="addDataForm" method="post" action="addAuthorISBNFormSubmit.jsp?formType=add">
				<fieldset>
					<legend style="color: #1812C4">Add Author and Book</legend>
					<h4 id="errorMsg" style="color: red; display: none">Fields marked with * are mandatory!</h4>
					
					<div class="a">
								<div class="l"><h4>Add Authors: </h4></div>
								<div class="r">&nbsp;</div>
					</div>
					<div class="a"></div>
					<div>				
					<div id="mainDiv">
						<div class="divBorder">
							<div class="a">
								<div class="l">First Name <span style="color: red">*</span></div>
								<div class="r">
									<INPUT type="text" name="firstName1">
								</div>
							</div>
							<div class="a">
								<div class="l">Last Name <span style="color: red">*</span></div>
								<div class="r">
									<INPUT type="text" name="lastName1">
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
							<a id="addAuthor" href="#" >Add More Author</a>
						</div>
						<div class="r">&nbsp;</div>
					</div>
					<div class="a"></div>
					
					
					<div class="a">
								<div class="l"><h4>Add Title: </h4></div>
								<div class="r">&nbsp;</div>
					</div>
					<div class="a"></div>
					
					<div id="mainDiv">
						<div class="divBorder">
							<div class="a">
								<div class="l">Title <span style="color: red">*</span></div>
								<div class="r">
									<INPUT type="text" name="title">
								</div>
							</div>
							<div class="a">
								<div class="l">ISBN <span style="color: red">*</span></div>
								<div class="r">
									<INPUT  id="ISBN" type="text" name="ISBN">
								</div>
							</div>
							<div class="a">
								<div class="l">Copyright <span style="color: red">*</span></div>
								<div class="r">
									<INPUT id="copyRight" type="text" name="copyRight">
								</div>
							</div>
							<div class="a">
								<div class="l">Edition No <span style="color: red">*</span></div>
								<div class="r">
									<INPUT id="editionNo" type="text" name="editionNo">
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
</html>