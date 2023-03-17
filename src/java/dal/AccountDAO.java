/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.xml.bind.DatatypeConverter;
import module.Account;
import module.GooglePojo;
import module.Role;

/**
 *
 * @author tient
 */
public class AccountDAO extends DBContext {

    public ArrayList<Account> getAllAccount() {
        ArrayList<Account> list = new ArrayList<>();
        try {
            String sql = "SELECT `account`.`accountID`,\n"
                    + "	`account`.`username`,\n"
                    + "    `account`.`roleID`,\n"
                    + "    `account`.`password`,\n"
                    + "    `account`.`avatar`,\n"
                    + "    `account`.`fullname`,\n"
                    + "    `account`.`email`,\n"
                    + "    `account`.`typeAccount`,\n"
                    + "    `account`.`isActive`,\n"
                    + "     `roles`.`rolename`\n"
                    + "FROM `account` inner join `roles`\n"
                    + "ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "ORDER BY `accountID` ASC";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Role role = new Role(rs.getInt("roleID"), rs.getString("rolename"));
                Account a = new Account();
                a.setAccountID(rs.getInt(1));
                a.setUserName(rs.getString(2));
                a.setRoleID(rs.getInt(3));
                a.setPassword(rs.getString(4));
                a.setAvatar(rs.getString(5));
                a.setFullName(rs.getString(6));
                a.setEmail(rs.getString(7));
                a.setTypeAccount(rs.getInt(8));
                a.setIsActive(rs.getBoolean(9));
                a.setRole(role);
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public String convertPassToMD5(String password) {
        MessageDigest convert = null;

        try {
            convert = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
        }

        convert.update(password.getBytes());
        byte[] passwordByte = convert.digest();
        return DatatypeConverter.printHexBinary(passwordByte);
    }
    
    public String getVerifyCode() {
        String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*_";
        Random random = new Random();
        StringBuilder builder = new StringBuilder();

        for (int i = 0; i < 8; i++) {
            int index = random.nextInt(str.length());
            builder.append(str.charAt(index));
        }

        return builder.toString();

    }

    public ArrayList<Account> getListByPage(ArrayList<Account> list,
            int start, int end) {
        ArrayList<Account> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public void changeStatus(int aid) {
        try {
            String sql = "UPDATE `account`\n"
                    + "SET\n"
                    + "`isActive` = NOT `isActive`\n"
                    + "WHERE `accountID` = ? AND account.roleID != 7;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, aid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ArrayList<Role> getRoleList() {
        ArrayList<Role> list = new ArrayList<>();
        try {
            String sql = "SELECT `roles`.`roleID`,\n"
                    + "    `roles`.`rolename`\n"
                    + "FROM `swp391`.`roles`;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Role r = new Role(rs.getInt(1), rs.getString(2));
                list.add(r);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public void send(String to, String code) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("killermid16@gmail.com", "ckpitlhcqecelhew");
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("killermid16@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));
            message.setSubject("Verification Mail");
            String htmlEmail = "Your new password: " + code;

            MimeBodyPart mimeBodyPart = new MimeBodyPart();
            mimeBodyPart.setContent(htmlEmail, "text/html");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(mimeBodyPart);

            message.setContent(multipart);

            Transport.send(message);

            System.out.println("Đã gửi email");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
    
    public ArrayList<Account> getListAccountByRole(int roleID) {
        ArrayList<Account> list = new ArrayList<>();
        try {
            String sql = "SELECT `account`.`accountID`,\n"
                    + "                    	`account`.`username`,\n"
                    + "                        `account`.`roleID`,\n"
                    + "                        `account`.`password`,\n"
                    + "                        `account`.`avatar`,\n"
                    + "                        `account`.`fullname`,\n"
                    + "                        `account`.`email`,\n"
                    + "                        `account`.`phone`,\n"
                    + "                        `account`.`address`,\n"
                    + "                        `account`.`typeAccount`,\n"
                    + "                        `account`.`isActive`,\n"
                    + "                         `roles`.`rolename`\n"
                    + "                    FROM `account` inner join `roles`\n"
                    + "                    ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "                    WHERE `account`.`roleID` = ?\n"
                    + "                     ORDER BY `accountID` ASC";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, roleID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Role role = new Role(rs.getInt("roleID"), rs.getString("rolename"));
                Account a = new Account();
                a.setAccountID(rs.getInt(1));
                a.setUserName(rs.getString(2));
                a.setRoleID(rs.getInt(3));
                a.setPassword(rs.getString(4));
                a.setAvatar(rs.getString(5));
                a.setFullName(rs.getString(6));
                a.setEmail(rs.getString(7));
                a.setPhone(rs.getString(8));
                a.setAddress(rs.getString(9));
                a.setTypeAccount(rs.getInt(10));
                a.setIsActive(rs.getBoolean(11));
                a.setRole(role);
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println(e + "getListAccountByKey");
        }
        return list;
    }

    public ArrayList<Account> getListAccountByActive(boolean isActive) {
        ArrayList<Account> list = new ArrayList<>();
        try {
            String sql = "SELECT `account`.`accountID`,\n"
                    + "                    	`account`.`username`,\n"
                    + "                        `account`.`roleID`,\n"
                    + "                        `account`.`password`,\n"
                    + "                        `account`.`avatar`,\n"
                    + "                        `account`.`fullname`,\n"
                    + "                        `account`.`email`,\n"
                    + "                        `account`.`phone`,\n"
                    + "                        `account`.`address`,\n"
                    + "                        `account`.`typeAccount`,\n"
                    + "                        `account`.`isActive`,\n"
                    + "                         `roles`.`rolename`\n"
                    + "                    FROM `account` inner join `roles`\n"
                    + "                    ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "                    WHERE `account`.`isActive` = ?\n"
                    + "                     ORDER BY `accountID` ASC";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, isActive);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Role role = new Role(rs.getInt("roleID"), rs.getString("rolename"));
                Account a = new Account();
                a.setAccountID(rs.getInt(1));
                a.setUserName(rs.getString(2));
                a.setRoleID(rs.getInt(3));
                a.setPassword(rs.getString(4));
                a.setAvatar(rs.getString(5));
                a.setFullName(rs.getString(6));
                a.setEmail(rs.getString(7));
                a.setPhone(rs.getString(8));
                a.setAddress(rs.getString(9));
                a.setTypeAccount(rs.getInt(10));
                a.setIsActive(rs.getBoolean(11));
                a.setRole(role);
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println(e + "getListAccountByKey");
        }
        return list;
    }
    
    public ArrayList<Account> getListAccountByKey(String key) {
        ArrayList<Account> list = new ArrayList<>();
        try {
            String sql = "SELECT `account`.`accountID`,\n"
                    + "                    	`account`.`username`,\n"
                    + "                        `account`.`roleID`,\n"
                    + "                        `account`.`password`,\n"
                    + "                        `account`.`avatar`,\n"
                    + "                        `account`.`fullname`,\n"
                    + "                        `account`.`email`,\n"
                    + "                        `account`.`phone`,\n"
                    + "                        `account`.`address`,\n"
                    + "                        `account`.`typeAccount`,\n"
                    + "                        `account`.`isActive`,\n"
                    + "                         `roles`.`rolename`\n"
                    + "                    FROM `account` inner join `roles`\n"
                    + "                    ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "                    WHERE `account`.`username` LIKE ?\n"
                    + "                    OR `account`.`fullname` LIKE ?\n"
                    + "                    OR `account`.`email` LIKE ?\n"
                    + "                    OR `roles`.`rolename` LIKE ?"
                    + "                     ORDER BY `accountID` ASC";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + key + "%");
            st.setString(2, "%" + key + "%");
            st.setString(3, "%" + key + "%");
            st.setString(4, "%" + key + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Role role = new Role(rs.getInt("roleID"), rs.getString("rolename"));
                Account a = new Account();
                a.setAccountID(rs.getInt(1));
                a.setUserName(rs.getString(2));
                a.setRoleID(rs.getInt(3));
                a.setPassword(rs.getString(4));
                a.setAvatar(rs.getString(5));
                a.setFullName(rs.getString(6));
                a.setEmail(rs.getString(7));
                a.setPhone(rs.getString(8));
                a.setAddress(rs.getString(9));
                a.setTypeAccount(rs.getInt(10));
                a.setIsActive(rs.getBoolean(11));
                a.setRole(role);
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println(e + "getListAccountByKey");
        }
        return list;
    }

    public void changeStatus(int aid, boolean status) {
        try {
            String sql = "UPDATE `account`\n"
                    + "SET\n"
                    + "`isActive` = ?\n"
                    + "WHERE `accountID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, status);
            st.setInt(2, aid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Account loginAccount(String user, String password) {
        try {
            String sql = "SELECT `account`.`accountID`,\n"
                    + "	`account`.`username`,\n"
                    + "    `account`.`roleID`,\n"
                    + "    `account`.`password`,\n"
                    + "    `account`.`avatar`,\n"
                    + "    `account`.`fullname`,\n"
                    + "    `account`.`email`,\n"
                    + "    `account`.`phone`,\n"
                    + "    `account`.`address`,\n"
                    + "    `account`.`typeAccount`,\n"
                    + "    `account`.`isActive`,\n"
                    + "     `roles`.`rolename`\n"
                    + "FROM `account` inner join `roles`\n"
                    + "ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "  WHERE username = ? AND password = ? AND typeAccount = -1 AND `account`.`isActive` = 1";
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
                a.setFullName(rs.getString(6));
                a.setEmail(rs.getString(7));
                a.setPhone(rs.getString(8));
                a.setAddress(rs.getString(9));
                a.setTypeAccount(rs.getInt(10));
                a.setIsActive(rs.getBoolean(11));
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
                    + "    `account`.`fullname`,\n"
                    + "    `account`.`email`,\n"
                    + "    `account`.`phone`,\n"
                    + "    `account`.`address`,\n"
                    + "    `account`.`typeAccount`,\n"
                    + "    `account`.`isActive`,\n"
                    + "     `roles`.`rolename`\n"
                    + "FROM `account` inner join `roles`\n"
                    + "ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "  WHERE email = ? AND `account`.`isActive` = 1";
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
                a.setFullName(rs.getString(6));
                a.setEmail(rs.getString(7));
                a.setPhone(rs.getString(8));
                a.setAddress(rs.getString(9));
                a.setTypeAccount(rs.getInt(10));
                a.setIsActive(rs.getBoolean(11));
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
                    + "    `account`.`fullname`,\n"
                    + "    `account`.`email`,\n"
                    + "    `account`.`phone`,\n"
                    + "    `account`.`address`,\n"
                    + "    `account`.`typeAccount`,\n"
                    + "    `account`.`isActive`,\n"
                    + "     `roles`.`rolename`\n"
                    + "FROM `account` inner join `roles`\n"
                    + "ON `account`.`roleID` = `roles`.`roleID`\n"
                    + "  WHERE accountID = ? AND `account`.`isActive` = 1";
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
                a.setFullName(rs.getString(6));
                a.setEmail(rs.getString(7));
                a.setPhone(rs.getString(8));
                a.setAddress(rs.getString(9));
                a.setTypeAccount(rs.getInt(10));
                a.setIsActive(rs.getBoolean(11));
                a.setRole(role);
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean checkUser(String user) {
        try {
            String sql = "SELECT * FROM account WHERE username = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean checkEmail(String email) {
        try {
            String sql = "SELECT * FROM account WHERE email = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public void addUser(Account a) {
        try {
            String sql = "INSERT INTO `account`\n"
                    + "(`username`,\n"
                    + "`roleID`,\n"
                    + "`password`,\n"
                    + "`fullname`,\n"
                    + "`email`,\n"
                    + "`typeAccount`)\n"
                    + "VALUES\n"
                    + "(?, ?, ?, ?, ?, ?);";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getUserName());
            st.setInt(2, a.getRoleID());
            st.setString(3, a.getPassword());
            st.setString(4, a.getFullName());
            st.setString(5, a.getEmail());
            if (a.getEmail().endsWith("@fpt.edu.vn")) {
                st.setInt(6, 2);
            } else {
                st.setInt(6, -1);
            }
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean registerAccount(String user, String password, String email, String fullname) {
        try {
            String sql = "SELECT username\n"
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
                        + "                                 ,fullname\n"
                        + "                                 ,email\n"
                        + "                                 ,`roleID`)\n"
                        + "                           VALUES\n"
                        + "                                 (?, ?, ?, ?, ?);";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setString(1, user);
                if (email.endsWith("@fpt.edu.vn")) {
                    st1.setInt(5, 2);
                } else {
                    st1.setInt(5, 1);
                }
                st1.setString(2, password);
                st1.setString(3, fullname);
                st1.setString(4, email);
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
                    + "                          ,fullname\n"
                    + "                          ,email\n"
                    + "                          ,phone\n"
                    + "                          ,address\n"
                    + "                      FROM Account\n"
                    + "                      WHERE email = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getEmail());
            ResultSet rs = st.executeQuery();
            if (!rs.next()) {
                String sql1 = "INSERT INTO `account`\n"
                        + "(`username`,\n"
                        + "`roleID`,\n"
                        + "`password`,\n"
                        + "`avatar`,\n"
                        + "`fullName`,\n"
                        + "`email`,\n"
                        + "`typeAccount`)\n"
                        + "VALUES\n"
                        + "(?, ?, ?, ?, ?, ?, ?);";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setString(1, null);
                if (user.getEmail().endsWith("@fpt.edu.vn")) {
                    st1.setInt(2, 2);
                } else {
                    st1.setInt(2, 1);
                }
                st1.setString(3, null);
                st1.setString(4, user.getPicture());
                st1.setString(5, user.getFamily_name() + user.getGiven_name());
                st1.setString(6, user.getEmail());
                st1.setInt(7, 1);
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
                    + "                         ,fullname = ?\n"
                    + "                         ,phone = ?\n"
                    + "                         ,address = ?\n"
                    + "                    WHERE username = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getAvatar());
            st.setString(2, a.getFullName());
            st.setString(3, a.getPhone());
            st.setString(4, a.getAddress());
            st.setString(5, a.getUserName());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void changePassword(Account a) {
        try {
            String sql = "UPDATE Account\n"
                    + "                       SET password = ?\n"
                    + "                     WHERE username = ? OR email = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getPassword());
            st.setString(2, a.getUserName());
            st.setString(3, a.getEmail());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void forgetPassword(String email, String password) {
        try {
            String sql = "UPDATE `account`\n"
                    + "SET\n"
                    + "`password` = ?\n"
                    + "WHERE `email` = ?  AND `account`.`isActive` = 1;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, password);
            st.setString(2, email);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean checkEmailForget(String email) {
        try {
            String sql = "SELECT `account`.`accountID`,\n"
                    + "    `account`.`username`,\n"
                    + "    `account`.`roleID`,\n"
                    + "    `account`.`password`,\n"
                    + "    `account`.`avatar`,\n"
                    + "    `account`.`fullname`,\n"
                    + "    `account`.`email`,\n"
                    + "    `account`.`phone`,\n"
                    + "    `account`.`address`,\n"
                    + "    `account`.`typeAccount`,\n"
                    + "    `account`.`isActive`\n"
                    + "FROM `account`\n"
                    + "WHERE `account`.`email` = ?  AND `account`.`isActive` = 1 AND typeAccount = -1;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updateUser(Account a) {
        try {
            String sql = "UPDATE `account`\n"
                    + "SET\n"
                    + "`username` = ?,\n"
                    + "`roleID` = ?,\n"
                    + "`fullname` = ?\n"
                    + "WHERE `accountID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getUserName());
            st.setInt(2, a.getRoleID());
            st.setString(3, a.getFullName());
            st.setInt(4, a.getAccountID());
            st.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
}
