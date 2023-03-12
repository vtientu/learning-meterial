/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import module.Elective;
import module.Subject;

/**
 *
 * @author inuya
 */
public class SubjectDAO extends DBContext {

    public ArrayList<Subject> getAll() {
        ArrayList<Subject> list = new ArrayList<>();
        try {
            String sql = "SELECT subjects.SubjectID,\n"
                    + "subjects.SubjectCode,\n"
                    + "subjects.subjectName,\n"
                    + "subjects.NoCredit,\n"
                    + "subjects.Semester,\n"
                    + "subjects.isActive\n"
                    + "FROM swp391.subjects;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject(rs.getInt(1), rs.getInt(4), rs.getInt(5), rs.getString(2), rs.getString(3), null, rs.getBoolean(6), 0, 0);
                list.add(subject);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Subject> getSubjectNeedToChoose(String id) {
        ArrayList<Subject> list = new ArrayList<>();
        try {
            String sql = "select subjects.`SubjectID`,\n"
                    + "subjects.`SubjectCode`,\n"
                    + "subjects.`subjectName`,\n"
                    + "subjects.`Semester`,\n"
                    + "subjects.`NoCredit`,\n"
                    + "subjects.`isActive`\n"
                    + "From subjects\n"
                    + "where SubjectID not in\n"
                    + "(SELECT \n"
                    + "subjects.`SubjectID`\n"
                    + "FROM swp391.curriculum join swp391.majors on\n"
                    + "curriculum.`majorID` = majors.`majorID` join swp391.curriculumsubject on\n"
                    + "curriculum.`CurID` = curriculumsubject.`CurID` join swp391.subjects on\n"
                    + "curriculumsubject.`SubjectID` = subjects.`SubjectID`\n"
                    + "where curriculum.`CurID` = ?\n"
                    + "order by subjects.Semester asc)\n"
                    + "order by Semester asc";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject(rs.getInt(1), rs.getInt(5), rs.getInt(4), rs.getString(2), rs.getString(3), null, rs.getBoolean(6), 0, 0);
                list.add(subject);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e + "11223344");
        }
        return null;
    }

    public ArrayList<Subject> getSubjectNeedToChooseInElective(String id) {
        ArrayList<Subject> list = new ArrayList<>();
        try {
            String sql = "select SubjectID,\n"
                    + "SubjectCode,\n"
                    + "subjectName,\n"
                    + "Semester,\n"
                    + "NoCredit,\n"
                    + "isActive,\n"
                    + "ComboID\n"
                    + "from swp391.subjects\n"
                    + "where subjects.`subjectID` not in (select distinct SubjectID from swp391.electivesubject join swp391.elective\n"
                    + "									on elective.ElectiveID = electivesubject.ElectiveID \n"
                    + "                                    where elective.ElectiveID=?\n"
                    + "                                    order by SubjectID asc)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject(rs.getInt(1), rs.getInt(5), rs.getInt(4), rs.getString(2), rs.getString(3), null, rs.getBoolean(6), 0, 0);
                list.add(subject);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e + "11223344");
        }
        return null;
    }

    public void getInsertCurriculumSubject(Elective s) {
        try {
            String sql = "INSERT INTO `swp391`.`electivesubject`\n"
                    + "(`ElectiveID`,\n"
                    + "`SubjectID`)\n"
                    + "VALUES\n"
                    + "(?,?);";

            for (Subject su : s.getSubject()) {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, s.getElectiveID());
                st.setInt(2, su.getSubjectID());
                st.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println(e + "5");
        }
    }
}
