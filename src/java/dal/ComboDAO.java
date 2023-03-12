/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import module.Combo;
import module.Combo;
import module.Subject;
import module.Subject;

/**
 *
 * @author inuya
 */
public class ComboDAO extends DBContext {

    public ArrayList<Combo> getCombo() {
        ArrayList<Combo> list = new ArrayList<>();
        try {
            String sql = "SELECT combo.ComboID,\n"
                    + "combo.ComboName,\n"
                    + "combo.isActive,\n"
                    + "combo.note\n"
                    + "FROM swp391.combo";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Combo combo = new Combo(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4));
                list.add(combo);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Combo> getComboById(String id) {
        ArrayList<Combo> list = new ArrayList<>();
        try {
            String sql = "SELECT combo.ComboID,\n"
                    + "combo.ComboName,\n"
                    + "combo.isActive,\n"
                    + "combo.note\n"
                    + "FROM swp391.combo join swp391.combocurriculum on\n"
                    + "combo.ComboID = combocurriculum.ComboID join\n"
                    + "swp391.curriculum on curriculum.CurID = combocurriculum.CurID\n"
                    + "where curriculum.CurID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Combo combo = new Combo(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4));
                list.add(combo);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void deleteCombo(String id) {
        try {
            String sql = "DELETE FROM `swp391`.`combocurriculum`\n"
                    + "WHERE ComboID = ?;\n";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteCombo1(String id) {
        try {
            String sql = "DELETE FROM `swp391`.`combo`\n"
                    + "WHERE ComboID = ?;\n";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Combo getcomboById(String id) {
        try {
            String sql = "SELECT combo.ComboID,\n"
                    + "combo.ComboName,\n"
                    + "combo.isActive,\n"
                    + "combo.note\n"
                    + "FROM swp391.combo\n"
                    + "WHERE combo.ComboID = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Combo combo = new Combo(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4));
                return combo;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;

    }

    public void addCombo(String name, int active, String note) {
        try {
            String sql = "INSERT INTO `swp391`.`combo`\n"
                    + "(`ComboName`,\n"
                    + "`isActive`,\n"
                    + "`note`)\n"
                    + "VALUES\n"
                    + "(?,?,?);";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setInt(2, active);
            st.setString(3, note);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void editCombo(String name, int active, String note, String id) {
        try {
            String sql = "UPDATE `swp391`.`combo`\n"
                    + "SET\n"
                    + "`ComboName` = ?,\n"
                    + "`isActive` = ?,\n"
                    + "`note` = ?\n"
                    + "WHERE `ComboID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setInt(2, active);
            st.setString(3, note);
            st.setString(4, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ArrayList<Subject> getComboDetailById(String id) {
        ArrayList<Subject> list = new ArrayList<>();
        try {
            String sql = "select combo.ComboID,\n"
                    + "                    subjects.SubjectCode,\n"
                    + "                    subjects.subjectName,\n"
                    + "                    subjects.Semester\n"
                    + "                    from swp391.combo join swp391.subjects on\n"
                    + "                    combo.ComboID = subjects.ComboID\n"
                    + "                    where combo.comboID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject s = new Subject(0, rs.getInt(4), rs.getString(2), rs.getString(3), null, true);
                list.add(s);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;

    }
}
