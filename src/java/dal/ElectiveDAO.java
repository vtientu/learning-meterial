/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import module.Curriculum;
import module.Elective;
import module.Subject;

/**
 *
 * @author tient
 */
public class ElectiveDAO extends DBContext {

    public ArrayList<Elective> getElectiveList() {
        ArrayList<Elective> list = new ArrayList<>();
        try {
            String sql = "Select elective.ElectiveID,\n"
                    + "elective.ElectiveNameEN,\n"
                    + "elective.ElectiveNameVN,\n"
                    + "elective.isActive,\n"
                    + "elective.note\n"
                    + "from swp391.elective";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Elective elective = new Elective(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5));
                list.add(elective);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Elective> getElective(String curID) {
        ArrayList<Elective> list = new ArrayList<>();
        try {
            String sql = "select elective.ElectiveID,\n"
                    + "elective.ElectiveNameEN,\n"
                    + "elective.ElectiveNameVN,\n"
                    + "elective.isActive,\n"
                    + "elective.note,\n"
                    + "curriculum.CurriculumCode,\n"
                    + "curriculum.CurriculumNameEN,\n"
                    + "curriculum.CurriculumNameVN,\n"
                    + "curriculum.DecisionNo,\n"
                    + "curriculum.Description,\n"
                    + "curriculum.majorID\n"
                    + "from swp391.elective join swp391.curriculumelective on\n"
                    + "elective.ElectiveID = curriculumelective.ElectiveID join\n"
                    + "swp391.curriculum on curriculumelective.CurID = curriculum.CurID\n"
                    + "where curriculum.CurID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, curID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Elective elective = new Elective(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5));
                list.add(elective);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void deleteElective(String id) {
        try {
            String sql = "DELETE FROM `swp391`.`electivesubject`\n"
                    + "WHERE electivesubject.ElectiveID=?;\n";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteElective2(String id) {
        try {
            String sql = "DELETE FROM `swp391`.`curriculumelective`\n"
                    + "WHERE curriculumelective.ElectiveID=?;\n";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteElective3(String id) {
        try {
            String sql = "DELETE FROM `swp391`.`elective`\n"
                    + "WHERE elective.ElectiveID=?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addElective(String nameen, String namevn, String note, int isActive) {
        try {
            String sql = "INSERT INTO `swp391`.`elective`\n"
                    + "(`ElectiveNameVN`,\n"
                    + "`ElectiveNameEN`,\n"
                    + "`note`,\n"
                    + "`isActive`)\n"
                    + "VALUES\n"
                    + "(?,?,?,?);";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, nameen);
            st.setString(2, namevn);
            st.setString(3, note);
            st.setInt(4, isActive); 
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addElective2(int curid) {
        try {
            String sql = "INSERT INTO `swp391`.`curriculumelective`\n"
                    + "(`ElectiveID`,\n"
                    + "`CurID`)\n"
                    + "VALUES\n"
                    + "((select ElectiveID\n"
                    + "from swp391.elective\n"
                    + "order by elective.ElectiveID desc\n"
                    + "Limit 1),\n"
                    + "?);";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, curid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Elective getElectiveById(String id) {
        try {
            String sql = "select elective.`ElectiveID`,\n"
                    + "elective.`ElectiveNameEN`,\n"
                    + "elective.`ElectiveNameVN`,\n"
                    + "elective.`isActive`,\n"
                    + "elective.`note`\n"
                    + "FROM swp391.`elective`\n"
                    + "where elective.`ElectiveID` = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Elective elective = new Elective(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5));
                return elective;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;

    }

    public void EditElective(String nameen, String namevn, String note, String id, int active) {
        try {
            String sql = "UPDATE `swp391`.`elective`\n"
                    + "                   SET\n"
                    + "                   `ElectiveNameEN` = ?,\n"
                    + "                   `ElectiveNameVN` = ?,\n"
                    + "                   `isActive` = ?,\n"
                    + "                   `note` = ?\n"
                    + "                   WHERE `ElectiveID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, nameen);
            st.setString(2, namevn);
            st.setInt(3, active);
            st.setString(4, note);
            st.setString(5, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ArrayList<Subject> getElectiveDetail(String id) {
        ArrayList<Subject> list = new ArrayList<>();
        try {
            String sql = "SELECT subjects.SubjectCode,\n"
                    + "                    subjects.subjectName\n"
                    + "                    FROM swp391.subjects join swp391.electivesubject on\n"
                    + "                    subjects.SubjectID = electivesubject.SubjectID\n"
                    + "                    Where electivesubject.ElectiveID=?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject s = new Subject(0, 0, rs.getString(1), rs.getString(2), null, true);
                list.add(s);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void getInsertCurriculumElective(Curriculum cur) {
        try {
            String sql = "INSERT INTO `swp391`.`curriculumelective`\n"
                    + "(`ElectiveID`,\n"
                    + "`CurID`)\n"
                    + "VALUES\n"
                    + "(?,?);";

            for (Elective e : cur.getElective()) {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, e.getElectiveID());
                st.setInt(2, cur.getCurID());
                st.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println(e + "5");
        }
    }

    public ArrayList<Elective> getCurriculumNeedToChooseInElective(String id) {
        ArrayList<Elective> list = new ArrayList<>();
        try {
            String sql = "SELECT ElectiveID,\n"
                    + "ElectiveNameEN,\n"
                    + "ElectiveNameVN,\n"
                    + "note,\n"
                    + "isActive FROM swp391.elective\n"
                    + "where ElectiveID not in(SELECT elective.ElectiveID FROM swp391.elective join swp391.curriculumelective on\n"
                    + "elective.ElectiveID = curriculumelective.ElectiveID join swp391.curriculum\n"
                    + "on curriculum.CurID = curriculumelective.CurID\n"
                    + "where curriculum.CurID = ?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Elective elective = new Elective(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(5), rs.getString(4));
                list.add(elective);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e + "1122334455");
        }
        return null;
    }
}
