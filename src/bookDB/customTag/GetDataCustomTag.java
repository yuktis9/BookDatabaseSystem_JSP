package bookDB.customTag;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.tagext.TagSupport;

import bookDB.database.DBQuery;
import bookDB.database.DBUpdate;
import bookDB.dto.AuthorISBN;

public class GetDataCustomTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	private String getType;
	private String ISBN;
	
	public int doStartTag(){
		
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
        HttpSession session = request.getSession();
        
        DBQuery dbQuery = new DBQuery();
        
        if(getType != null && getType.equals("allData")){
        	
        	if(ISBN != null && ISBN.length() > 0){
        		DBUpdate dbUpdate = new DBUpdate();
        		dbUpdate.deleteData(ISBN, (Connection)session.getAttribute("dbConnection"));
        	}
        	
        	pageContext.setAttribute("titles", dbQuery.getTitles((Connection)session.getAttribute("dbConnection")));
        	
        }else if(getType != null && getType.equals("SpecificData")){
        	
        	AuthorISBN authorISBN =dbQuery.getAuthorISBN(ISBN, (Connection)session.getAttribute("dbConnection"));
        	pageContext.setAttribute("authorISBN", authorISBN);
        	
        	if(authorISBN.getAuthorID2() != null){
        		pageContext.setAttribute("authorCount2", 2);
        	}
        	if(authorISBN.getAuthorID3() != null){
        		pageContext.setAttribute("authorCount3", 3);
        	}
        }
        return 1;
	}

	public String getGetType() {
		return getType;
	}

	public void setGetType(String getType) {
		this.getType = getType;
	}
	
	public String getISBN() {
		return ISBN;
	}

	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
}
