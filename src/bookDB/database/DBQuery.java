package bookDB.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import bookDB.dto.AuthorISBN;

public class DBQuery {
	
	private Statement statement = null;
	private PreparedStatement preparedStatement = null;
	private ResultSet resultSet = null;

	public boolean checkISBNExist(String ISBN, Connection connect) {

		boolean isISBNExist = false;
		String url = "select * from titles where ISBN=?";
		try {
			preparedStatement = (PreparedStatement) connect
					.prepareStatement(url);
			preparedStatement.setString(1, ISBN);

			resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				isISBNExist = true;
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null,
					ex);
		}

		return isISBNExist;
	}
	
	public void addData(AuthorISBN authorISBN, Connection connect){
		
		addTitle(authorISBN, connect);
		
		int aurhorID1 = addAuthor("authors", authorISBN.getFirstName1(), authorISBN.getLastName1(), connect);
		addAuthorISBN(aurhorID1, authorISBN.getISBN(), connect);
		System.out.println("aurhorID1 "+aurhorID1);
		
		if(authorISBN.getFirstName2() != null && authorISBN.getLastName2() != null){
			int aurhorID2 = addAuthor("authors", authorISBN.getFirstName2(), authorISBN.getLastName2(), connect);
			System.out.println("aurhorID2 "+aurhorID2);
			addAuthorISBN(aurhorID2, authorISBN.getISBN(), connect);
		}
		
		if(authorISBN.getFirstName3() != null && authorISBN.getLastName3() != null){
			int aurhorID3 = addAuthor("authors", authorISBN.getFirstName3(), authorISBN.getLastName3(), connect);
			System.out.println("aurhorID3 "+aurhorID3);
			addAuthorISBN(aurhorID3, authorISBN.getISBN(), connect);
		}
	}
	
	public void addAuthorISBN(int authorID, String ISBN, Connection connect){
        
        String sql = "INSERT INTO authorisbn (`AuthorID`, `ISBN`) VALUES (?, ?)";
        try {
            preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
            preparedStatement.setInt(1,  authorID);
            preparedStatement.setString(2,  ISBN);
            System.out.println("sql: "+sql);
            preparedStatement.executeUpdate();   
        } catch (SQLException ex) {
            Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
	
	public int addAuthor(String tableName, String firstName, String lastName,
			Connection connect) {

		String addSQL = "INSERT INTO " + tableName
				+ "(`FirstName`, `LastName`) values (?,?)";

		try {
			preparedStatement = (PreparedStatement) connect
					.prepareStatement(addSQL ,Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setString(1, firstName);
			preparedStatement.setString(2, lastName);

			preparedStatement.executeUpdate();
			
			preparedStatement.executeUpdate();
			ResultSet rs = preparedStatement.getGeneratedKeys();
			if (rs.next()) {
			  return rs.getInt(1); 
			}

		} catch (SQLException ex) {
			Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null,
					ex);
		}
		return 0;
	}

	public int addTitle(AuthorISBN authorISBN, Connection connect) {

		String addTitleSQL = "INSERT INTO titles"
				+ "(`ISBN`, `Title`, `EditionNumber`, `Copyright`) values (?,?,?,?)";

		try {
			preparedStatement = (PreparedStatement) connect
					.prepareStatement(addTitleSQL);
			preparedStatement.setString(1, authorISBN.getISBN());
			preparedStatement.setString(2, authorISBN.getTitle());
			preparedStatement.setInt(3, authorISBN.getEditionNo());
			preparedStatement.setInt(4, authorISBN.getCopyRight());
			
			System.out.println("Add Title SQL: "+addTitleSQL);
			return preparedStatement.executeUpdate();

		} catch (SQLException ex) {
			Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null,
					ex);
		}
		return 0;
	}
	
	public List<AuthorISBN> getTitles(Connection connect) {

		List<AuthorISBN> titles = new ArrayList<AuthorISBN>();

		try {
			statement = connect.createStatement();
			resultSet = statement.executeQuery("select * from titles");

			while (resultSet.next()) {

				AuthorISBN title = new AuthorISBN();

				title.setTitle(resultSet.getString(2));
				title.setISBN(resultSet.getString(1));
				title.setEditionNo(Integer.parseInt(resultSet.getString(3)));
				title.setCopyRight(Integer.parseInt(resultSet.getString(4)));

				titles.add(title);
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null,
					ex);
		}
		return titles;
	}
	
	public AuthorISBN getAuthorISBN(String ISBN, Connection connect) {

		AuthorISBN authorISBN = new AuthorISBN();

		try {
			statement = connect.createStatement();
			resultSet = statement.executeQuery("select * from authorisbn where isbn="+ISBN);
			
			int authorCount = 0;
			while (resultSet.next()) {
				
				Statement statement2 = connect.createStatement();
				ResultSet resultSet2 = statement2.executeQuery("select * from authors where AuthorID="+resultSet.getInt(1));
				
				if(authorCount == 0){
					while (resultSet2.next()) {
						authorCount ++ ;
						authorISBN.setAuthorID1(resultSet2.getInt(1));
						authorISBN.setFirstName1(resultSet2.getString(2));
						authorISBN.setLastName1(resultSet2.getString(3));
					}
				}else if(authorCount == 1){
					while (resultSet2.next()) {
						authorCount ++ ;
						authorISBN.setAuthorID2(resultSet2.getInt(1));
						authorISBN.setFirstName2(resultSet2.getString(2));
						authorISBN.setLastName2(resultSet2.getString(3));
					}
				}else if(authorCount == 2){
					while (resultSet2.next()) {
						authorCount ++ ;
						authorISBN.setAuthorID3(resultSet2.getInt(1));
						authorISBN.setFirstName3(resultSet2.getString(2));
						authorISBN.setLastName3(resultSet2.getString(3));
					}
				}

			}
			
			statement = connect.createStatement();
			resultSet = statement.executeQuery("select * from titles where isbn="+ISBN);

			while (resultSet.next()) {

				authorISBN.setTitle(resultSet.getString(2));
				authorISBN.setISBN(resultSet.getString(1));
				authorISBN.setEditionNo(Integer.parseInt(resultSet.getString(3)));
				authorISBN.setCopyRight(Integer.parseInt(resultSet.getString(4)));

			}
		} catch (SQLException ex) {
			Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null,
					ex);
		}
		return authorISBN;
	}
	
	public List<AuthorISBN> searchData(String sql, Connection connection){
		
		List<AuthorISBN> authorISBNs = new ArrayList<AuthorISBN>();
		
		try {
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);

			while (resultSet.next()) {
				
				AuthorISBN authorISBN = new AuthorISBN();
				String ISBN = resultSet.getString(1);
				
				Statement statement2 = connection.createStatement();
				ResultSet resultSet2 = statement2.executeQuery("select * from authorisbn where ISBN="+ISBN);
				
				int authorCount = 0;
				while (resultSet2.next()) {
					
					Statement statement3 = connection.createStatement();
					ResultSet resultSet3 = statement3.executeQuery("select * from authors where AuthorID="+resultSet2.getInt(1));
					
					while (resultSet3.next()) {
						
						if(authorCount == 0){
							authorISBN.setFirstName1(resultSet3.getString(2));
							authorISBN.setLastName1(resultSet3.getString(3));
							authorCount++;
						}
						else if(authorCount == 1){
							authorISBN.setFirstName2(resultSet3.getString(2));
							authorISBN.setLastName2(resultSet3.getString(3));
							authorCount++;
						}
						else if(authorCount == 2){
							authorISBN.setFirstName3(resultSet3.getString(2));
							authorISBN.setLastName3(resultSet3.getString(3));
							authorCount++;
						}							
					}
				}
				statement2 = connection.createStatement();
				resultSet2 = statement2.executeQuery("select * from titles where ISBN="+ISBN);
				
				while (resultSet2.next()) {
					
					authorISBN.setISBN(resultSet2.getString(1));
					authorISBN.setTitle(resultSet2.getString(2));
					authorISBN.setEditionNo(resultSet2.getInt(3));
					authorISBN.setCopyRight(resultSet2.getInt(4));
				}
				authorISBNs.add(authorISBN);
			}
		} catch (SQLException ex) {
			Logger.getLogger(DBQuery.class.getName()).log(Level.SEVERE, null,
					ex);
		}
		
		return authorISBNs;
	}
}
