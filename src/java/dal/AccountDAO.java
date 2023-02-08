/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import module.Account;
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
                    + "    `account`.`birthday`,\n"
                    + "    `account`.`email`,\n"
                    + "    `account`.`phone`,\n"
                    + "    `account`.`address`,\n"
                    + "    `account`.`gender`,\n"
                    + "    `account`.`typeAccount`,\n"
                    + "     `roles`.`rolename`\n"
                    + "FROM `swp391`.`account` inner join `swp391`.`roles`\n"
                    + "ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "  WHERE username = ? AND password = ?";
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
                a.setBirthday(rs.getDate(8));
                a.setEmail(rs.getString(9));
                a.setPhone(rs.getString(10));
                a.setAddress(rs.getString(11));
                a.setGender(rs.getInt(12));
                a.setTypeAccount(rs.getInt(13));
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
                        + "                                 ,email)\n"
                        + "                           VALUES\n"
                        + "                                 (?, ?, ?, ?, ?);";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setString(1, user);
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

    public void editProfile(Account a) {
        try {
            String sql = "UPDATE Account\n"
                    + "                      SET avatar = ?\n"
                    + "                         ,firstname = ?\n"
                    + "                         ,lastname = ?\n"
                    + "                         ,birthday = ?\n"
                    + "                         ,phone = ?\n"
                    + "                         ,address = ?\n"
                    + "                         ,gender = ?\n"
                    + "                    WHERE username = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getAvatar());
            st.setString(2, a.getFirstName());
            st.setString(3, a.getLastName());
            st.setDate(4, a.getBirthday());
            st.setString(5, a.getPhone());
            st.setString(6, a.getAddress());
            st.setInt(7, a.getGender());
            st.setString(8, a.getUserName());
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
