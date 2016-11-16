package bookDB.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

import bookDB.dto.AuthorISBN;

public class DBUpdate {

	private Statement statement = null;
	private PreparedStatement preparedStatement = null;
	private ResultSet resultSet = null;

    public void deleteData(String ISBN, Connection connection) {
    	
    	try {
			statement = connection.createStatement();
			resultSet = statement.executeQuery("select * from authorisbn where ISBN="+ISBN);
			
			while(resultSet.next()){
				deleteAuthorISBN(resultSet.getString(1), ISBN, connection);
				deleteRow("authors", "AuthorID", resultSet.getString(1), connection);
			}
			System.out.println("Inside Delete");
			deleteRow("titles", "ISBN", ISBN, connection);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
    public void deleteRow(String tableName, String columnName,
			String selectedIds, Connection connect) {

		String deleteSQL = "DELETE FROM " + tableName + " WHERE " + columnName
				+ " IN (" + selectedIds + ")";
		try {
			preparedStatement = (PreparedStatement) connect
					.prepareStatement(deleteSQL);
			preparedStatement.executeUpdate();

		} catch (SQLException ex) {
			Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null,
					ex);
		}
	}
    
    public void deleteAuthorISBN(String authorID, String ISBN, Connection connect) {

		String deleteAuthorISBN = "DELETE FROM authorisbn WHERE AuthorID=? and ISBN=?";

		try {
			preparedStatement = (PreparedStatement) connect
					.prepareStatement(deleteAuthorISBN);
			preparedStatement.setString(1, authorID);
			preparedStatement.setString(2, ISBN);
			preparedStatement.executeUpdate();

		} catch (SQLException ex) {
			Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null,
					ex);
		}
	}
    
    public void updateData(AuthorISBN authorISBN, Connection connect){
		
    	updateTitle(authorISBN, connect);
		
		updateAuthor(authorISBN.getAuthorID1(), authorISBN.getFirstName1(), authorISBN.getLastName1(), connect);
		
		if(authorISBN.getAuthorID2() != null){
			updateAuthor(authorISBN.getAuthorID2(), authorISBN.getFirstName2(), authorISBN.getLastName2(), connect);
		}
		
		if(authorISBN.getAuthorID3() != null){
			updateAuthor(authorISBN.getAuthorID3(), authorISBN.getFirstName3(), authorISBN.getLastName3(), connect);
		}
	}

    public int updateAuthor(Integer authorID, String firstName, String lastName, Connection connect){
        
    	String updateSQL = "UPDATE authors SET FirstName=?, LastName=? where AuthorID= ?";
    	
         try {
             preparedStatement = (PreparedStatement) connect.prepareStatement(updateSQL);
             preparedStatement.setString(1, firstName);
             preparedStatement.setString(2, lastName);
             preparedStatement.setInt(3, authorID);
             
             return preparedStatement.executeUpdate();
             
         } catch (SQLException ex) {
             Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null, ex);
         }
         return 0;
     }
    
    public int updateTitle(AuthorISBN authorISBN, Connection connect){
        
    	String updateSQL = "UPDATE titles SET title=?, EditionNumber=?, Copyright=? where ISBN= ?";

         try {
             preparedStatement = (PreparedStatement) connect.prepareStatement(updateSQL);
             preparedStatement.setString(1, authorISBN.getTitle());
             preparedStatement.setInt(2, authorISBN.getEditionNo());
             preparedStatement.setInt(3, authorISBN.getCopyRight());
             preparedStatement.setString(4, authorISBN.getISBN());
             
             return preparedStatement.executeUpdate();
             
         } catch (SQLException ex) {
             Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null, ex);
         }
         return 0;
     }
}
