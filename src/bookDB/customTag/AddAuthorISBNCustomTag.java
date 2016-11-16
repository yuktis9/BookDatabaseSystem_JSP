package bookDB.customTag;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.tagext.TagSupport;

import bookDB.database.DBQuery;
import bookDB.database.DBUpdate;
import bookDB.dto.AuthorISBN;

public class AddAuthorISBNCustomTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	
	private AuthorISBN authorISBN;
	private String formType;

	public int doStartTag(){
		
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
        HttpSession session = request.getSession();

        if(formType != null && formType.equals("edit")){
        	
        	DBUpdate dbUpdate = new DBUpdate();
        	dbUpdate.updateData(authorISBN, (Connection)session.getAttribute("dbConnection"));        	
        	
        }else if(formType != null && formType.equals("add")){
        	DBQuery dbQuery = new DBQuery();
        	dbQuery.addData(authorISBN, (Connection)session.getAttribute("dbConnection"));
        }
        
        try {
        	//pageContext.getRequest().setAttribute("ISBN","");
			pageContext.forward("dbUpdate.jsp?ISBN=");
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        return 1;
	}
	
	public AuthorISBN getAuthorISBN() {
		return authorISBN;
	}
	
	public void setAuthorISBN(AuthorISBN authorISBN) {
		this.authorISBN = authorISBN;
	}

	public String getFormType() {
		return formType;
	}

	public void setFormType(String formType) {
		this.formType = formType;
	}
		
}
