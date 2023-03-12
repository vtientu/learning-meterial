/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import module.Material;
import module.Syllabus;

/**
 *
 * @author inuya
 */
public class MaterialDAO extends DBContext {

    public ArrayList<Material> getAll() {
        ArrayList<Material> list = new ArrayList<>();
        try {
            String sql = "SELECT MaterialID,\n"
                    + "MaterialDescription,\n"
                    + "SyllabusID,\n"
                    + "Author,\n"
                    + "Publisher,\n"
                    + "PublishedDate,\n"
                    + "Edition,\n"
                    + "ISBN,\n"
                    + "IsMainMaterial,\n"
                    + "IsHardCopy,\n"
                    + "IsOnline,\n"
                    + "Note,\n"
                    + "isActive\n"
                    + "FROM swp391.material;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Syllabus s = new Syllabus(rs.getInt(3), sql, sql, sql, true, true, sql, 0, sql, sql, sql, sql, sql, 0, sql, 0, null, sql, null, null);
                Material mate = new Material(rs.getInt(1), rs.getString(2),
                        s, rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10),
                        rs.getInt(11), rs.getString(12), rs.getInt(13));
                list.add(mate);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e + "1234");
        }
        return null;
    }

    public Material getMaterial(String id) {
        try {
            String sql = "SELECT MaterialID,\n"
                    + "MaterialDescription,\n"
                    + "SyllabusID,\n"
                    + "Author,\n"
                    + "Publisher,\n"
                    + "PublishedDate,\n"
                    + "Edition,\n"
                    + "ISBN,\n"
                    + "IsMainMaterial,\n"
                    + "IsHardCopy,\n"
                    + "IsOnline,\n"
                    + "Note,\n"
                    + "isActive\n"
                    + "FROM swp391.material\n"
                    + "WHERE MaterialID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Syllabus s = new Syllabus(rs.getInt(3), sql, sql, sql, true, true, sql, 0, sql, sql, sql, sql, sql, 0, sql, 0, null, sql, null, null);
                Material mate = new Material(rs.getInt(1), rs.getString(2),
                        s, rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10),
                        rs.getInt(11), rs.getString(12), rs.getInt(13));
                return mate;
            }
        } catch (SQLException e) {
            System.out.println(e + "1234");
        }
        return null;
    }

    public void getDeleteMaterial(String id) {
        try {
            String sql = "DELETE FROM `swp391`.`material`\n"
                    + "WHERE MaterialID=?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + "1234");
        }
    }

    public void getEditMaterial(String des, String author, String publisher, String date, String edition, String isbn,
            int ismain, int copy, int online, String note, int active, String id) {
        try {
            String sql = "UPDATE `swp391`.`material`\n"
                    + "SET\n"
                    + "`MaterialDescription` = ?,\n"
                    + "`Author` = ?,\n"
                    + "`Publisher` = ?,\n"
                    + "`PublishedDate` = ?,\n"
                    + "`Edition` = ?,\n"
                    + "`ISBN` = ?,\n"
                    + "`IsMainMaterial` = ?,\n"
                    + "`IsHardCopy` = ?,\n"
                    + "`IsOnline` = ?,\n"
                    + "`Note` = ?,\n"
                    + "`isActive` = ?\n"
                    + "WHERE `MaterialID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, des);
            st.setString(2, author);
            st.setString(3, publisher);
            st.setString(4, date);
            st.setString(5, edition);
            st.setString(6, isbn);
            st.setInt(7, ismain);
            st.setInt(8, copy);
            st.setInt(9, online);
            st.setString(10, note);
            st.setInt(11, active);
            st.setString(12, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + "1234");
        }
    }

    public void getInsertMaterial(String des, String author, String publisher, String date, String edition, String isbn,
            int ismain, int copy, int online, String note, int active) {
        try {
            String sql = "INSERT INTO `swp391`.`material`\n"
                    + "(`MaterialDescription`,\n"
                    + "`Author`,\n"
                    + "`Publisher`,\n"
                    + "`PublishedDate`,\n"
                    + "`Edition`,\n"
                    + "`ISBN`,\n"
                    + "`IsMainMaterial`,\n"
                    + "`IsHardCopy`,\n"
                    + "`IsOnline`,\n"
                    + "`Note`,\n"
                    + "`isActive`)\n"
                    + "VALUES\n"
                    + "(?,?,?,?,?,?,?,?,?,?,?);";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, des);
            st.setString(2, author);
            st.setString(3, publisher);
            st.setString(4, date);
            st.setString(5, edition);
            st.setString(6, isbn);
            st.setInt(7, ismain);
            st.setInt(8, copy);
            st.setInt(9, online);
            st.setString(10, note);
            st.setInt(11, active);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + "1234");
        }
    }

    public ArrayList<Material> getSearch(String code) {
        ArrayList<Material> list = new ArrayList<>();
        try {
            String sql = "SELECT MaterialID,\n"
                    + "MaterialDescription,\n"
                    + "SyllabusID,\n"
                    + "Author,\n"
                    + "Publisher,\n"
                    + "PublishedDate,\n"
                    + "Edition,\n"
                    + "ISBN,\n"
                    + "IsMainMaterial,\n"
                    + "IsHardCopy,\n"
                    + "IsOnline,\n"
                    + "Note,\n"
                    + "isActive\n"
                    + "FROM swp391.material\n"
                    + "WHERE MaterialDescription like '%" + code + "%' or Author like '%" + code + "%' or Publisher like '%" + code + "%' or PublishedDate like '%" + code + "%'";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Syllabus s = new Syllabus(rs.getInt(3), sql, sql, sql, true, true, sql, 0, sql, sql, sql, sql, sql, 0, sql, 0, null, sql, null, null);
                Material mate = new Material(rs.getInt(1), rs.getString(2),
                        s, rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10),
                        rs.getInt(11), rs.getString(12), rs.getInt(13));
                list.add(mate);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public ArrayList<Material> getListByPage(ArrayList<Material> list,
            int start, int end) {
        ArrayList<Material> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }
}
