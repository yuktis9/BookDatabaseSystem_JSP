<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="custTag" uri="WEB-INF/custom.tld"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function() {

		$("#selectTablesButton").click(function() {

			var selectedValues = $('#selectTables').val();

			$('#selctedTables').find('option').remove();

			if (selectedValues.length > 1) {
				
				addAuthors();
				addTitles();
			} else if (selectedValues == "authors") {
				addAuthors();
			} else if (selectedValues == "titles") {
				addTitles();
			}
		});
		
		$("#selectColumnButton").click(function() {
						
			var selectedColumns = $('#selctedTables').val();
		});

		$("#insertFinalRestrictionsButton").click(function() {
			
			var selectedColumns = $('#selctedTables').val();
			var selectTypeOption = $('#selectTypeOption').val();

			if(selectTypeOption == "numericType"){

				var selectRestriction = $('#selectRestriction').val();
				if(selectRestriction ==  0){
				}else{
					var numericValue = $('#numericValue').val();
					var finalRestrictionValue = selectedColumns + " "+ selectRestriction + " "+ numericValue;

					addOptionsToFinalRestriction(finalRestrictionValue);
				}
			}else if(selectTypeOption == "stringType"){
				
				var likeValue = $('#likeValue').val();
				var finalRestrictionValue = selectedColumns + " Like'%"+ likeValue + "%' ";
				
				addOptionsToFinalRestriction(finalRestrictionValue);
			}	
		});
		
		$("#selectTypeOption").change(function() {
			
			var selectTypeOption = $('#selectTypeOption').val();

			if(selectTypeOption == "numericType"){

				$('#selectRestrictionLabel').show();
				$('#selectRestrictionRow').show();

				$('#likeValueLabel').hide();
				$('#likeValueRow').hide();

				$('#searchDataLabel').hide();
				$('#searchDataRow').hide();

				$('#finalRestrictionRow').hide();
				$('#finalRestrictionLabel').hide();

				$('#insertFinalRestrictionRow').hide();
				$('#insertFinalRestrictionLabel').hide();
				
			}else if(selectTypeOption == "stringType"){
				
				$('#likeValueLabel').show();
				$('#likeValueRow').show();

				$('#searchDataLabel').show();
				$('#searchDataRow').show();

				$('#finalRestrictionRow').show();
				$('#finalRestrictionLabel').show();

				$('#insertFinalRestrictionRow').show();
				$('#insertFinalRestrictionLabel').show();
				
				$('#selectRestrictionLabel').hide();
				$('#selectRestrictionRow').hide();
				$('#numericValueLabel').hide();
				$('#numericValueRow').hide();
				
			}else{

				$('#selectRestrictionLabel').hide();
				$('#selectRestrictionRow').hide();
				
				$('#likeValueLabel').hide();
				$('#likeValueRow').hide();
				
				$('#numericValueLabel').hide();
				$('#numericValueRow').hide();
				
				$('#searchDataLabel').hide();
				$('#searchDataRow').hide();

				$('#finalRestrictionRow').hide();
				$('#finalRestrictionLabel').hide();

				$('#insertFinalRestrictionRow').hide();
				$('#insertFinalRestrictionLabel').hide();
				
			}
		});

		$("#selectRestriction").change(function() {
			
			var selectRestriction = $('#selectRestriction').val();
			if(selectRestriction ==  0){

				$('#numericValueLabel').hide();
				$('#numericValueRow').hide();

				$('#searchDataLabel').hide();
				$('#searchDataRow').hide();

				$('#finalRestrictionRow').hide();
				$('#finalRestrictionLabel').hide();

				$('#insertFinalRestrictionRow').hide();
				$('#insertFinalRestrictionLabel').hide();
				
			}else{

				$('#numericValueLabel').show();
				$('#numericValueRow').show();

				$('#searchDataLabel').show();
				$('#searchDataRow').show();

				$('#finalRestrictionRow').show();
				$('#finalRestrictionLabel').show();

				$('#insertFinalRestrictionRow').show();
				$('#insertFinalRestrictionLabel').show();
			}

		});
	});

	function addAuthors() {

		addOptions("authors.FirstName");
		addOptions("authors.LastName");

	}

	function addTitles() {

		addOptions("titles.Title");
		addOptions("titles.ISBN");
		addOptions("titles.EditionNumber");
		addOptions("titles.Copyright");
	}

	function addOptions(optionVal) {

		$('#selctedTables').append($("<option/>", {
			value : optionVal,
			text : optionVal
		}));
	}

	function addOptionsToFinalRestriction(optionVal) {

		$('#finalRestrictios').append($("<option/>", {
			value : optionVal,
			text : optionVal
		}));
	}

	function validateForm(){
		$('#finalRestrictios option').prop('selected', true);
		return true;
	}
</script>
</head>
<body>
<%@include file="header/header.jsp" %>
	<custTag:searchDataCustomTag finalRestriction='<%= request.getParameter("finalRestrictios") %>'/>
	<form action="searchData.jsp" method="post">
		<table>
			<tr>
				<td>Select Table</td>
				<td></td>
				<td>Select Column</td>
				<td id="selectTypeLabel">Select Type</td>
				<td style="display: none" id="likeValueLabel">Like Value</td>
				<td style="display: none" id="selectRestrictionLabel">Select Restriction</td>
				<td style="display: none" id="numericValueLabel">Numeric Value</td>
				<td style="display: none" id="insertFinalRestrictionLabel"></td>
				<td style="display: none" id="finalRestrictionLabel">Final Restriction</td>
				<td style="display: none" id="searchDataLabel"></td>
				
			</tr>
			<tr>
				<td><select style="height: 100px; width: 100px"
					id="selectTables" name="selectTables" multiple>
						<option value="authors">authors</option>
						<option value="titles">titles</option>
				</select></td>
				<td>
					<input type="button" value=">>" id="selectTablesButton">
				</td>
				<td>
					<select style="height: 100px; width: 150px" id="selctedTables" multiple></select>
				</td>
				<td id="selectTypeRow">
					<select style="width: 120px" id="selectTypeOption" name="selectType">
						<option value="0">Select Type</option>
						<option value="numericType">Numeric Type</option>
						<option value="stringType">String Type</option>
					</select>
				</td>
				<td style="display: none" id="likeValueRow">
					<input type="text" id="likeValue" name="likeValue"/>
				</td>
				<td style="display: none" id="selectRestrictionRow">
					<select style="width: 120px" name= "selectRestriction" id="selectRestriction">
						<option value="0">Select restriction</option>
                 		<option value="&gt;">&gt;</option>
                 		<option value="&lt;">&lt;</option>
                 		<option value="&gt;=">&gt;=</option>
                 		<option value="&lt;=">&lt;=</option>
                		<option value="=">=</option>
					</select>
				</td>
				<td style="display: none" id="numericValueRow">
					<input type="number" min="0" name="numericValue" id="numericValue"/>
				</td>
				<td style="display: none" id="insertFinalRestrictionRow">
					<input type="button" value=">>" id="insertFinalRestrictionsButton">
				</td>
				<td style="display: none" id="finalRestrictionRow">
					<select style="height: 100px; width: 200px" id="finalRestrictios" name="finalRestrictios" multiple></select>
				</td>
				<td style="display: none" id="searchDataRow">
					<input type="submit" value="Search Data" onclick="return validateForm()"/>
				</td>
			</tr>
		</table>
	</form>
	
	<br/><br/>
	<h2>${authorISBNCount} Records Found</h2><hr>
		<c:forEach items="${authorISBNs}" var="authorISBN">
			<table >
				<tr><td>
				<table>
				<tr>
					<td><h3>Author 1: </h3></td>
					<td></td>
				</tr>
				<tr>
					<td>First Name: </td>
					<td><c:out value="${authorISBN.firstName1}"></c:out></td>
				</tr>
				
				<tr>
					<td>Last Name: </td>
					<td><c:out value="${authorISBN.lastName1}"></c:out></td>
				</tr>
				
				<c:if test="${authorISBN.firstName2 != null}">
				<tr>
					<td><h3>Author 2: </h3></td>
					<td></td>
				</tr>
				<tr>
					<td>First Name: </td>
					<td><c:out value="${authorISBN.firstName2}"></c:out></td>
				</tr>
				
				<tr>
					<td>Last Name: </td>
					<td><c:out value="${authorISBN.lastName2}"></c:out></td>
				</tr>	
				</c:if>
				
				<c:if test="${authorISBN.firstName3 != null}">
				<tr>
					<td><h3>Author 3: </h3></td>
					<td></td>
				</tr>
				<tr>
					<td>First Name: </td>
					<td><c:out value="${authorISBN.firstName3}"></c:out></td>
				</tr>
				
				<tr>
					<td>Last Name: </td>
					<td><c:out value="${authorISBN.lastName3}"></c:out></td>
				</tr>	
				</c:if>
				
				</table></td>
				<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				<td>
				<table>
				<tr>
					<td><h3>Book Detail: </h3></td>
					<td></td>
				</tr>
				
				<tr>
					<td>ISBN</td>
					<td><c:out value="${authorISBN.ISBN}"></c:out></td>
					
				</tr>
				<tr>
					<td>Title</td>
					<td><c:out value="${authorISBN.title}"></c:out></td>
				</tr>
				<tr>
					<td>Edition Number</td>
					<td><c:out value="${authorISBN.editionNo}"></c:out></td>
				</tr>
				<tr>
					<td>Copyright</td>
					<td><c:out value="${authorISBN.copyRight}"></c:out></td>
				</tr>
				
				</table></td></tr>
			</table>
			<hr style="color: #cc0000">
		</c:forEach>
</body>
</html>