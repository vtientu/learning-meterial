/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import module.Subject;
import module.Syllabus;

/**
 *
 * @author tient
 */
public class SyllabusDAO extends DBContext {

    public ArrayList<Syllabus> getAllSyllabus() {
        ArrayList<Syllabus> list = new ArrayList<>();
        try {
            String sql = "SELECT `syllabus`.`SyllabusID`,\n"
                    + "    `syllabus`.`SubjectCode`,\n"
                    + "    `syllabus`.`SubjectNameEN`,\n"
                    + "    `syllabus`.`SubjectNameVN`,\n"
                    + "    `syllabus`.`IsActive`,\n"
                    + "    `syllabus`.`IsApproved`,\n"
                    + "    `syllabus`.`DecisionNo`,\n"
                    + "    `syllabus`.`NoCredit`,\n"
                    + "    `syllabus`.`DegreeLevel`,\n"
                    + "    `syllabus`.`TimeAllocation`,\n"
                    + "    `syllabus`.`Description`,\n"
                    + "    `syllabus`.`StudentTasks`,\n"
                    + "    `syllabus`.`Tools`,\n"
                    + "    `syllabus`.`ScoringScale`,\n"
                    + "    `syllabus`.`Note`,\n"
                    + "    `syllabus`.`MinAvgMarkToPass`,\n"
                    + "    `syllabus`.`ApprovedDate`,\n"
                    + "    `subjects`.`subjectName`,\n"
                    + "    `subjects`.`Semester`,\n"
                    + "    `subjects`.`NoCredit`,\n"
                    + "    `subjects`.`PreRequisite`\n"
                    + "FROM `syllabus` INNER JOIN `subjects`\n"
                    + "ON `syllabus`.`SubjectCode` = `subjects`.`SubjectCode`;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setSubjectCode(rs.getString(1));
                subject.setSubjectName(rs.getString("subjectName"));
                subject.setSemester(rs.getInt("Semester"));
                subject.setPreRequisite("PreRequisite");
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
                syllabus.setSubjectCode(rs.getString("SubjectCode"));
                syllabus.setSubjectNameEN(rs.getString("SubjectNameEN"));
                syllabus.setSubjectNameVN(rs.getString("SubjectNameVN"));
                syllabus.setIsActive(rs.getBoolean("IsActive"));
                syllabus.setIsApproved(rs.getBoolean("IsApproved"));
                syllabus.setDecisionNo(rs.getString("DecisionNo"));
                syllabus.setNoCredit(rs.getInt("NoCredit"));
                syllabus.setDegreeLevel(rs.getString("DegreeLevel"));
                syllabus.setTimeAllocation(rs.getString("TimeAllocation"));
                syllabus.setDescription(rs.getString("Description"));
                syllabus.setStudentTasks(rs.getString("StudentTasks"));
                syllabus.setTools(rs.getString("Tools"));
                syllabus.setScoringScale(rs.getInt("ScoringScale"));
                syllabus.setNote(rs.getString("Note"));
                syllabus.setMinAvgMarkToPass(rs.getInt("MinAvgMarkToPass"));
                syllabus.setApprovedDate(rs.getDate("ApprovedDate"));
                syllabus.setSubject(subject);
                list.add(syllabus);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Syllabus getSyllabus(String code) {
        try {
            String sql = "SELECT `syllabus`.`SyllabusID`,\n"
                    + "    `syllabus`.`SubjectCode`,\n"
                    + "    `syllabus`.`SubjectNameEN`,\n"
                    + "    `syllabus`.`SubjectNameVN`,\n"
                    + "    `syllabus`.`IsActive`,\n"
                    + "    `syllabus`.`IsApproved`,\n"
                    + "    `syllabus`.`DecisionNo`,\n"
                    + "    `syllabus`.`NoCredit`,\n"
                    + "    `syllabus`.`DegreeLevel`,\n"
                    + "    `syllabus`.`TimeAllocation`,\n"
                    + "    `syllabus`.`Description`,\n"
                    + "    `syllabus`.`StudentTasks`,\n"
                    + "    `syllabus`.`Tools`,\n"
                    + "    `syllabus`.`ScoringScale`,\n"
                    + "    `syllabus`.`Note`,\n"
                    + "    `syllabus`.`MinAvgMarkToPass`,\n"
                    + "    `syllabus`.`ApprovedDate`,\n"
                    + "    `subjects`.`subjectName`,\n"
                    + "    `subjects`.`Semester`,\n"
                    + "    `subjects`.`NoCredit`,\n"
                    + "    `subjects`.`PreRequisite`\n"
                    + "FROM `syllabus` INNER JOIN `subjects`\n"
                    + "ON `syllabus`.`SubjectCode` = `subjects`.`SubjectCode`"
                    + "WHERE `syllabus`.`SubjectCode` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, code);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setSubjectCode(rs.getString(1));
                subject.setSubjectName(rs.getString("subjectName"));
                subject.setSemester(rs.getInt("Semester"));
                subject.setPreRequisite(rs.getString("PreRequisite"));
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
                syllabus.setSubjectCode(rs.getString("SubjectCode"));
                syllabus.setSubjectNameEN(rs.getString("SubjectNameEN"));
                syllabus.setSubjectNameVN(rs.getString("SubjectNameVN"));
                syllabus.setIsActive(rs.getBoolean("IsActive"));
                syllabus.setIsApproved(rs.getBoolean("IsApproved"));
                syllabus.setDecisionNo(rs.getString("DecisionNo"));
                syllabus.setNoCredit(rs.getInt("NoCredit"));
                syllabus.setDegreeLevel(rs.getString("DegreeLevel"));
                syllabus.setTimeAllocation(rs.getString("TimeAllocation"));
                syllabus.setDescription(rs.getString("Description"));
                syllabus.setStudentTasks(rs.getString("StudentTasks"));
                syllabus.setTools(rs.getString("Tools"));
                syllabus.setScoringScale(rs.getInt("ScoringScale"));
                syllabus.setNote(rs.getString("Note"));
                syllabus.setMinAvgMarkToPass(rs.getInt("MinAvgMarkToPass"));
                syllabus.setApprovedDate(rs.getDate("ApprovedDate"));
                syllabus.setSubject(subject);
                return syllabus;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Syllabus> getListSyllabusByKey(String key) {
        ArrayList<Syllabus> list = new ArrayList<>();
        try {
            String sql = "SELECT `syllabus`.`SyllabusID`,\n"
                    + "    `syllabus`.`SubjectCode`,\n"
                    + "    `syllabus`.`SubjectNameEN`,\n"
                    + "    `syllabus`.`SubjectNameVN`,\n"
                    + "    `syllabus`.`IsActive`,\n"
                    + "    `syllabus`.`IsApproved`,\n"
                    + "    `syllabus`.`DecisionNo`,\n"
                    + "    `syllabus`.`NoCredit`,\n"
                    + "    `syllabus`.`DegreeLevel`,\n"
                    + "    `syllabus`.`TimeAllocation`,\n"
                    + "    `syllabus`.`Description`,\n"
                    + "    `syllabus`.`StudentTasks`,\n"
                    + "    `syllabus`.`Tools`,\n"
                    + "    `syllabus`.`ScoringScale`,\n"
                    + "    `syllabus`.`Note`,\n"
                    + "    `syllabus`.`MinAvgMarkToPass`,\n"
                    + "    `syllabus`.`ApprovedDate`,\n"
                    + "    `subjects`.`subjectName`,\n"
                    + "    `subjects`.`Semester`,\n"
                    + "    `subjects`.`NoCredit`,\n"
                    + "    `subjects`.`PreRequisite`\n"
                    + "FROM `syllabus` INNER JOIN `subjects`\n"
                    + "ON `syllabus`.`SubjectCode` = `subjects`.`SubjectCode`"
                    + "WHERE `syllabus`.`SubjectCode` LIKE ? OR `syllabus`.`SubjectNameEN` LIKE ? OR `syllabus`.`SubjectNameVN` LIKE ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + key + "%");
            st.setString(2, "%" + key + "%");
            st.setString(3, "%" + key + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setSubjectCode(rs.getString(1));
                subject.setSubjectName(rs.getString("subjectName"));
                subject.setSemester(rs.getInt("Semester"));
                subject.setPreRequisite("PreRequisite");
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
                syllabus.setSubjectCode(rs.getString("SubjectCode"));
                syllabus.setSubjectNameEN(rs.getString("SubjectNameEN"));
                syllabus.setSubjectNameVN(rs.getString("SubjectNameVN"));
                syllabus.setIsActive(rs.getBoolean("IsActive"));
                syllabus.setIsApproved(rs.getBoolean("IsApproved"));
                syllabus.setDecisionNo(rs.getString("DecisionNo"));
                syllabus.setNoCredit(rs.getInt("NoCredit"));
                syllabus.setDegreeLevel(rs.getString("DegreeLevel"));
                syllabus.setTimeAllocation(rs.getString("TimeAllocation"));
                syllabus.setDescription(rs.getString("Description"));
                syllabus.setStudentTasks(rs.getString("StudentTasks"));
                syllabus.setTools(rs.getString("Tools"));
                syllabus.setScoringScale(rs.getInt("ScoringScale"));
                syllabus.setNote(rs.getString("Note"));
                syllabus.setMinAvgMarkToPass(rs.getInt("MinAvgMarkToPass"));
                syllabus.setApprovedDate(rs.getDate("ApprovedDate"));
                syllabus.setSubject(subject);
                list.add(syllabus);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<Syllabus> getListByPage(ArrayList<Syllabus> list,
            int start, int end) {
        ArrayList<Syllabus> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }
}