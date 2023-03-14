/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            // Edit URL , username, password to authenticate with your MS SQL Server

            String url = "jdbc:mysql://localhost:3306/";
            String dbName = "SWP391";
            String driver = "com.mysql.cj.jdbc.Driver";
            String userName = "root";
            String password = "tu0912029226";
            Class.forName(driver);
            connection = DriverManager.getConnection(url + dbName, userName, password);
        } catch (ClassNotFoundException e) {
            System.out.println(e);
        } catch (SQLException ex) {
            System.out.println(ex);
        } catch (Exception es) {
            System.out.println(es);
        }
    }

}
