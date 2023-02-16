/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import module.Account;
import module.GooglePojo;
import module.Role;

/**
 *
 * @author tient
 */
public class AccountDAO extends DBContext {

    public Account loginAccount(String user, String password) {
        try {
            String sql = "SELECT `account`.`accountID`,\n"
                    + "	`account`.`username`,\n"
                    + "    `account`.`roleID`,\n"
                    + "    `account`.`password`,\n"
                    + "    `account`.`avatar`,\n"
                    + "    `account`.`firstname`,\n"
                    + "    `account`.`lastname`,\n"
                    + "    `account`.`email`,\n"
                    + "    `account`.`phone`,\n"
                    + "    `account`.`address`,\n"
                    + "    `account`.`typeAccount`,\n"
                    + "    `account`.`isActive`,\n"
                    + "     `roles`.`rolename`\n"
                    + "FROM `swp391`.`account` inner join `swp391`.`roles`\n"
                    + "ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "  WHERE username = ? AND password = ? AND typeAccount = -1";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            Account a = new Account();
            if (rs.next()) {
                Role role = new Role(rs.getInt("roleID"), rs.getString("rolename"));
                a.setAccountID(rs.getInt(1));
                a.setUserName(user);
                a.setRoleID(rs.getInt(3));
                a.setPassword(password);
                a.setAvatar(rs.getString(5));
                a.setFirstName(rs.getString(6));
                a.setLastName(rs.getString(7));
                a.setEmail(rs.getString(8));
                a.setPhone(rs.getString(9));
                a.setAddress(rs.getString(10));
                a.setTypeAccount(rs.getInt(11));
                a.setIsActive(rs.getBoolean(12));
                a.setRole(role);
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Account loginAccountGoogle(GooglePojo gb) {
        try {
            String sql = "SELECT `account`.`accountID`,\n"
                    + "	`account`.`username`,\n"
                    + "    `account`.`roleID`,\n"
                    + "    `account`.`password`,\n"
                    + "    `account`.`avatar`,\n"
                    + "    `account`.`firstname`,\n"
                    + "    `account`.`lastname`,\n"
                    + "    `account`.`email`,\n"
                    + "    `account`.`phone`,\n"
                    + "    `account`.`address`,\n"
                    + "    `account`.`typeAccount`,\n"
                    + "    `account`.`isActive`,\n"
                    + "     `roles`.`rolename`\n"
                    + "FROM `swp391`.`account` inner join `swp391`.`roles`\n"
                    + "ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "  WHERE email = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, gb.getEmail());
            ResultSet rs = st.executeQuery();
            Account a = new Account();
            if (rs.next()) {
                Role role = new Role(rs.getInt("roleID"), rs.getString("rolename"));
                a.setAccountID(rs.getInt(1));
                a.setUserName(rs.getString(2));
                a.setRoleID(rs.getInt(3));
                a.setPassword(rs.getString(4));
                a.setAvatar(rs.getString(5));
                a.setFirstName(rs.getString(6));
                a.setLastName(rs.getString(7));
                a.setEmail(rs.getString(8));
                a.setPhone(rs.getString(9));
                a.setAddress(rs.getString(10));
                a.setTypeAccount(rs.getInt(11));
                a.setIsActive(rs.getBoolean(12));
                a.setRole(role);
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Account getAccount(int accountID) {
        try {
            String sql = "SELECT `account`.`accountID`,\n"
                    + "	`account`.`username`,\n"
                    + "    `account`.`roleID`,\n"
                    + "    `account`.`password`,\n"
                    + "    `account`.`avatar`,\n"
                    + "    `account`.`firstname`,\n"
                    + "    `account`.`lastname`,\n"
                    + "    `account`.`email`,\n"
                    + "    `account`.`phone`,\n"
                    + "    `account`.`address`,\n"
                    + "    `account`.`typeAccount`,\n"
                    + "    `account`.`isActive`,\n"
                    + "     `roles`.`rolename`\n"
                    + "FROM `swp391`.`account` inner join `swp391`.`roles`\n"
                    + "ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "  WHERE accountID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, accountID);
            ResultSet rs = st.executeQuery();
            Account a = new Account();
            if (rs.next()) {
                Role role = new Role(rs.getInt("roleID"), rs.getString("rolename"));
                a.setAccountID(rs.getInt(1));
                a.setUserName(rs.getString(2));
                a.setRoleID(rs.getInt(3));
                a.setPassword(rs.getString(4));
                a.setAvatar(rs.getString(5));
                a.setFirstName(rs.getString(6));
                a.setLastName(rs.getString(7));
                a.setEmail(rs.getString(8));
                a.setPhone(rs.getString(9));
                a.setAddress(rs.getString(10));
                a.setTypeAccount(rs.getInt(11));
                a.setIsActive(rs.getBoolean(12));
                a.setRole(role);
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean registerAccount(String user, String password, String email, String firstName, String lastName) {
        try {
            String sql = "SELECT username\n"
                    + "                          ,roleID\n"
                    + "                          ,password\n"
                    + "                          ,avatar\n"
                    + "                          ,firstname\n"
                    + "                          ,lastname\n"
                    + "                          ,birthday\n"
                    + "                          ,email\n"
                    + "                          ,phone\n"
                    + "                          ,address\n"
                    + "                          ,gender\n"
                    + "                      FROM Account\n"
                    + "                      WHERE username = ? OR email = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            st.setString(2, email);
            ResultSet rs = st.executeQuery();
            if (!rs.next()) {
                String sql1 = "INSERT INTO Account\n"
                        + "                                 (username\n"
                        + "                                 ,password\n"
                        + "                                 ,firstname\n"
                        + "                                 ,lastname\n"
                        + "                                 ,email\n"
                        + "                                 ,`roleID`)\n"
                        + "                           VALUES\n"
                        + "                                 (?, ?, ?, ?, ?, ?);";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setString(1, user);
                if(email.endsWith("@fpt.edu.vn")){
                    st1.setInt(6, 2);
                } else {
                    st1.setInt(6, 1);
                }
                st1.setString(2, password);
                st1.setString(3, firstName);
                st1.setString(4, lastName);
                st1.setString(5, email);
                st1.executeUpdate();
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean registerAccountGoogle(GooglePojo user) {
        try {
            String sql = "SELECT username\n"
                    + "                          ,roleID\n"
                    + "                          ,password\n"
                    + "                          ,avatar\n"
                    + "                          ,firstname\n"
                    + "                          ,lastname\n"
                    + "                          ,email\n"
                    + "                          ,phone\n"
                    + "                          ,address\n"
                    + "                      FROM Account\n"
                    + "                      WHERE email = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getEmail());
            ResultSet rs = st.executeQuery();
            if (!rs.next()) {
                String sql1 = "INSERT INTO `swp391`.`account`\n"
                        + "(`username`,\n"
                        + "`roleID`,\n"
                        + "`password`,\n"
                        + "`avatar`,\n"
                        + "`firstname`,\n"
                        + "`lastname`,\n"
                        + "`email`,\n"
                        + "`typeAccount`)\n"
                        + "VALUES\n"
                        + "(?, ?, ?, ?, ?, ?, ?, ?);";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setString(1, null);
                if(user.getEmail().endsWith("@fpt.edu.vn")){
                    st1.setInt(2, 2);
                } else {
                    st1.setInt(2, 1);
                }
                st1.setString(3, null);
                st1.setString(4, user.getPicture());
                st1.setString(5, user.getGiven_name());
                st1.setString(6, user.getFamily_name());
                st1.setString(7, user.getEmail());
                st1.setInt(8, 1);
                st1.executeUpdate();
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public void editProfile(Account a) {
        try {
            String sql = "UPDATE Account\n"
                    + "                      SET avatar = ?\n"
                    + "                         ,firstname = ?\n"
                    + "                         ,lastname = ?\n"
                    + "                         ,phone = ?\n"
                    + "                         ,address = ?\n"
                    + "                    WHERE username = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getAvatar());
            st.setString(2, a.getFirstName());
            st.setString(3, a.getLastName());
            st.setString(4, a.getPhone());
            st.setString(5, a.getAddress());
            st.setString(6, a.getUserName());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void changePassword(Account a) {
        try {
            String sql = "UPDATE Account\n"
                    + "                       SET password = ?\n"
                    + "                     WHERE username = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getPassword());
            st.setString(2, a.getUserName());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
