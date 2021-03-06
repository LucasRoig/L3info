package simplejdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import javax.sql.DataSource;

public class SimpleDataAccessObject {

	private final DataSource myDataSource;
        
	/**
	 *
	 * @param dataSource la source de données à utiliser
	 */
	public SimpleDataAccessObject(DataSource dataSource) {
		this.myDataSource = dataSource;
	}

	/**
	 *
	 * @return le nombre d'enregistrements dans la table CUSTOMER
	 * @throws SQLException
	 */
	public int numberOfCustomers() throws SQLException {
            int result = 0;
            
            String query = "SELECT COUNT(CUSTOMER_ID) AS NUMBER FROM APP.CUSTOMER";
            Connection connection = myDataSource.getConnection();
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            
            if(rs.next()){
                result = rs.getInt("NUMBER");
            }
            
            rs.close();
            stmt.close();
            connection.close();
            return result;      
	}

	/**
	 *
	 * @param customerId la clé du client à recherche
	 * @return le nombre de bons de commande pour ce client (table PURCHASE_ORDER)
	 * @throws SQLException
	 */
	public int numberOfOrdersForCustomer(int customerId) throws SQLException {
            int result = 0;
            
            String query = "SELECT COUNT(ORDER_NUM) FROM APP.PURCHASE_ORDER WHERE CUSTOMER_ID = ?";
            Connection connection = myDataSource.getConnection();
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery(query);
            if(rs.next()){
                result = rs.getInt(1);
            }
            return result;
	}

	/**
	 * Trouver un Customer à partir de sa clé
	 *
	 * @param customedID la clé du CUSTOMER à rechercher
	 * @return l'enregistrement correspondant dans la table CUSTOMER, ou null si pas trouvé
	 * @throws SQLException
	 */
	CustomerEntity findCustomer(int customedID) throws SQLException {
		throw new UnsupportedOperationException("Pas encore implémenté");
	}

	/**
	 * Liste des clients localisés dans un état des USA
	 *
	 * @param state l'état à rechercher (2 caractères)
	 * @return la liste des clients habitant dans cet état
	 * @throws SQLException
	 */
	List<CustomerEntity> customersInState(String state) throws SQLException {
		throw new UnsupportedOperationException("Pas encore implémenté");
	}

}
