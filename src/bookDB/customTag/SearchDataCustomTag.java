package bookDB.customTag;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.tagext.TagSupport;

import bookDB.database.DBQuery;
import bookDB.dto.AuthorISBN;

public class SearchDataCustomTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	
	private String finalRestriction;
	
	public int doStartTag(){
		
		String sql  = "SELECT distinct authorisbn.ISBN FROM authorisbn join  titles on titles.ISBN = authorisbn.ISBN ";
		
		System.out.println("finalRestriction "+finalRestriction);
		if(finalRestriction != null ){
			sql = sql + "where "+ finalRestriction;
		}
		System.out.println("sql: "+sql);
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
        HttpSession session = request.getSession();
        	
        DBQuery dbQuery = new DBQuery();
        List<AuthorISBN> authorISBNs = dbQuery.searchData(sql,(Connection)session.getAttribute("dbConnection"));
        if(authorISBNs.size() > 0)
        	pageContext.setAttribute("authorISBNs", authorISBNs);
        	pageContext.setAttribute("authorISBNs", authorISBNs);

        pageContext.setAttribute("authorISBNCount", authorISBNs.size());
		return 1;
	}

	public String getFinalRestriction() {
		return finalRestriction;
	}

	public void setFinalRestriction(String finalRestriction) {
		this.finalRestriction = finalRestriction;
	}
}
