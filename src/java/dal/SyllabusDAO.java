/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import module.Assessment;
import module.CLO;
import module.Decision;
import module.Material;
import module.PreRequisite;
import module.Subject;
import module.Syllabus;

/**
 *
 * @author tient
 */
public class SyllabusDAO extends DBContext {

    public ArrayList<Syllabus> getAllSyllabus(int role) {
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
                    + "    `syllabus`.`PreRequisite`,\n"
                    + "    `subjects`.`subjectName`,\n"
                    + "    `subjects`.`Semester`,\n"
                    + "    `subjects`.`NoCredit`,\n"
                    + "    `decision`.`DecisionName`,\n"
                    + "    `decision`.`ApprovedDate`,\n"
                    + "    `decision`.`Note`,\n"
                    + "    `decision`.`CreateDate`,\n"
                    + "    `decision`.`isActive`,\n"
                    + "    `decision`.`FileName`\n"
                    + "FROM `syllabus` INNER JOIN `subjects`\n"
                    + "ON `syllabus`.`SubjectCode` = `subjects`.`SubjectCode` INNER JOIN `swp391`.`decision`\n"
                    + "ON `decision`.`DecisionNo` = `syllabus`.`DecisionNo`";
            if (role == 1) {
                sql += "WHERE `syllabus`.`IsActive` = 1 AND `syllabus`.`IsApproved` = 1";
            }
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Decision decision = new Decision();
                decision.setDecisionNo(rs.getString("DecisionNo"));
                decision.setDecisionName(rs.getString("DecisionName"));
                decision.setApprovedDate(rs.getDate("ApprovedDate"));
                decision.setNote(rs.getString("Note"));
                decision.setCreateDate(rs.getDate("CreateDate"));
                decision.setIsActive(rs.getBoolean("isActive"));
                decision.setFileName(rs.getString("FileName"));
                Subject subject = new Subject();
                subject.setSubjectCode(rs.getString(2));
                subject.setSubjectName(rs.getString("subjectName"));
                subject.setSemester(rs.getInt("Semester"));

                String sql1 = "SELECT `prerequisite`.`PreID`,\n"
                        + "    `prerequisite`.`subjectCode`,\n"
                        + "    `prerequisite`.`subjectPre`\n"
                        + "FROM `swp391`.`prerequisite`\n"
                        + "WHERE `prerequisite`.`subjectCode` = ?;";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setString(1, rs.getString("SubjectCode"));
                ResultSet rs1 = st1.executeQuery();
                ArrayList<PreRequisite> preList = new ArrayList<>();
                while (rs1.next()) {
                    PreRequisite pre = new PreRequisite();
                    pre.setPreID(rs1.getInt("PreID"));
                    pre.setSubjectCode(rs1.getString(2));
                    pre.setSubjectPre(rs1.getString("subjectPre"));
                    preList.add(pre);
                }
                subject.setPrerequisite(preList);
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
                syllabus.setSubjectCode(rs.getString("SubjectCode"));
                syllabus.setSyllabusNameEN(rs.getString("SubjectNameEN"));
                syllabus.setSyllabusNameVN(rs.getString("SubjectNameVN"));
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
                syllabus.setPreRequisite(rs.getString("PreRequisite"));
                syllabus.setSubject(subject);
                syllabus.setDecision(decision);
                list.add(syllabus);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void changeStatus(int sid) {
        try {
            String sql = "UPDATE `swp391`.`subjects`\n"
                    + "SET\n"
                    + "`isActive` = NOT `isActive`\n"
                    + "WHERE `SubjectID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, sid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ArrayList<Subject> getListSubject() {
        ArrayList<Subject> list = new ArrayList<>();
        try {
            String sql = "SELECT `subjects`.`SubjectID`,\n"
                    + "    `subjects`.`SubjectCode`,\n"
                    + "    `subjects`.`subjectName`,\n"
                    + "    `subjects`.`Semester`,\n"
                    + "    `subjects`.`NoCredit`,\n"
                    + "    `subjects`.`isActive`\n"
                    + "FROM `swp391`.`subjects` ORDER BY `subjects`.`SubjectID` ASC;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject s = new Subject();
                s.setSubjectID(rs.getInt("SubjectID"));
                s.setSubjectCode(rs.getString("SubjectCode"));
                s.setSubjectName(rs.getString("subjectName"));
                s.setSemester(rs.getInt("Semester"));
                s.setNoCredit(rs.getInt("NoCredit"));
                s.setIsActive(rs.getBoolean("isActive"));
                list.add(s);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<Subject> getListSubjectByKey(String key) {
        ArrayList<Subject> list = new ArrayList<>();
        try {
            String sql = "SELECT `subjects`.`SubjectID`,\n"
                    + "                        `subjects`.`SubjectCode`,\n"
                    + "                        `subjects`.`subjectName`,\n"
                    + "                        `subjects`.`Semester`,\n"
                    + "                        `subjects`.`NoCredit`,\n"
                    + "                        `subjects`.`isActive`\n"
                    + "                    FROM `swp391`.`subjects`\n"
                    + "                    WHERE `subjects`.`SubjectCode` LIKE ?\n"
                    + "                    OR `subjects`.`subjectName` LIKE ?\n"
                    + "                    ORDER BY `subjects`.`SubjectID` ASC";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + key + "%");
            st.setString(2, "%" + key + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject s = new Subject();
                s.setSubjectID(rs.getInt("SubjectID"));
                s.setSubjectCode(rs.getString("SubjectCode"));
                s.setSubjectName(rs.getString("subjectName"));
                s.setSemester(rs.getInt("Semester"));
                s.setNoCredit(rs.getInt("NoCredit"));
                s.setIsActive(rs.getBoolean("isActive"));
                list.add(s);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    
    public ArrayList<Subject> getListByPageSubject(ArrayList<Subject> list,
            int start, int end) {
        ArrayList<Subject> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }
    

    public Syllabus getSyllabus(String code, int role) {
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
                    + "    `syllabus`.`PreRequisite`,\n"
                    + "    `subjects`.`subjectName`,\n"
                    + "    `subjects`.`Semester`,\n"
                    + "    `subjects`.`NoCredit`,\n"
                    + "    `decision`.`DecisionName`,\n"
                    + "    `decision`.`ApprovedDate`,\n"
                    + "    `decision`.`Note`,\n"
                    + "    `decision`.`CreateDate`,\n"
                    + "    `decision`.`isActive`,\n"
                    + "    `decision`.`FileName`\n"
                    + "FROM `syllabus` INNER JOIN `subjects`\n"
                    + "ON `syllabus`.`SubjectCode` = `subjects`.`SubjectCode` INNER JOIN `prerequisite`\n"
                    + "ON `prerequisite`.`subjectCode` = `subjects`.`SubjectCode` INNER JOIN `swp391`.`decision`\n"
                    + "ON `decision`.`DecisionNo` = `syllabus`.`DecisionNo`"
                    + "WHERE `syllabus`.`SubjectCode` = ?";
            if (role == 1) {
                sql += " AND `syllabus`.`IsActive` = 1 AND `syllabus`.`IsApproved` = 1";
            }
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, code);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Decision decision = new Decision();
                decision.setDecisionNo(rs.getString("DecisionNo"));
                decision.setDecisionName(rs.getString("DecisionName"));
                decision.setApprovedDate(rs.getDate("ApprovedDate"));
                decision.setNote(rs.getString("Note"));
                decision.setCreateDate(rs.getDate("CreateDate"));
                decision.setIsActive(rs.getBoolean("isActive"));
                decision.setFileName(rs.getString("FileName"));
                Subject subject = new Subject();
                subject.setSubjectCode(rs.getString(2));
                subject.setSubjectName(rs.getString("subjectName"));
                subject.setSemester(rs.getInt("Semester"));

                String sql1 = "SELECT `prerequisite`.`PreID`,\n"
                        + "    `prerequisite`.`subjectCode`,\n"
                        + "    `prerequisite`.`subjectPre`\n"
                        + "FROM `swp391`.`prerequisite`\n"
                        + "WHERE `prerequisite`.`subjectCode` = ?;";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setString(1, rs.getString("SubjectCode"));
                ResultSet rs1 = st1.executeQuery();
                ArrayList<PreRequisite> preList = new ArrayList<>();
                while (rs1.next()) {
                    PreRequisite pre = new PreRequisite();
                    pre.setPreID(rs1.getInt("PreID"));
                    pre.setSubjectCode(rs1.getString(2));
                    pre.setSubjectPre(rs1.getString("subjectPre"));
                    preList.add(pre);
                }
                subject.setPrerequisite(preList);
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
                syllabus.setSubjectCode(rs.getString("SubjectCode"));
                syllabus.setSyllabusNameEN(rs.getString("SubjectNameEN"));
                syllabus.setSyllabusNameVN(rs.getString("SubjectNameVN"));
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
                syllabus.setPreRequisite(rs.getString("PreRequisite"));
                syllabus.setSubject(subject);
                syllabus.setDecision(decision);
                return syllabus;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Syllabus> getListSyllabusByKey(String key, int role) {
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
                    + "    `syllabus`.`PreRequisite`,\n"
                    + "    `subjects`.`subjectName`,\n"
                    + "    `subjects`.`Semester`,\n"
                    + "    `subjects`.`NoCredit`,\n"
                    + "    `decision`.`DecisionName`,\n"
                    + "    `decision`.`ApprovedDate`,\n"
                    + "    `decision`.`Note`,\n"
                    + "    `decision`.`CreateDate`,\n"
                    + "    `decision`.`isActive`,\n"
                    + "    `decision`.`FileName`\n"
                    + "FROM `syllabus` INNER JOIN `subjects`\n"
                    + "ON `syllabus`.`SubjectCode` = `subjects`.`SubjectCode` INNER JOIN `swp391`.`decision`\n"
                    + "ON `decision`.`DecisionNo` = `syllabus`.`DecisionNo`"
                    + "WHERE `syllabus`.`SubjectCode` LIKE ? OR `syllabus`.`SubjectNameEN` LIKE ? OR `syllabus`.`SubjectNameVN` LIKE ?";
            if (role == 1) {
                sql += " AND `syllabus`.`IsActive` = 1 AND `syllabus`.`IsApproved` = 1";
            }
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + key + "%");
            st.setString(2, "%" + key + "%");
            st.setString(3, "%" + key + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Decision decision = new Decision();
                decision.setDecisionNo(rs.getString("DecisionNo"));
                decision.setDecisionName(rs.getString("DecisionName"));
                decision.setApprovedDate(rs.getDate("ApprovedDate"));
                decision.setNote(rs.getString("Note"));
                decision.setCreateDate(rs.getDate("CreateDate"));
                decision.setIsActive(rs.getBoolean("isActive"));
                decision.setFileName(rs.getString("FileName"));
                Subject subject = new Subject();
                subject.setSubjectCode(rs.getString(2));
                subject.setSubjectName(rs.getString("subjectName"));
                subject.setSemester(rs.getInt("Semester"));

                String sql1 = "SELECT `prerequisite`.`PreID`,\n"
                        + "    `prerequisite`.`subjectCode`,\n"
                        + "    `prerequisite`.`subjectPre`\n"
                        + "FROM `swp391`.`prerequisite`\n"
                        + "WHERE `prerequisite`.`subjectCode` = ?;";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setString(1, rs.getString("SubjectCode"));
                ResultSet rs1 = st1.executeQuery();
                ArrayList<PreRequisite> preList = new ArrayList<>();
                while (rs1.next()) {
                    PreRequisite pre = new PreRequisite();
                    pre.setPreID(rs1.getInt("PreID"));
                    pre.setSubjectCode(rs1.getString(2));
                    pre.setSubjectPre(rs1.getString("subjectPre"));
                    preList.add(pre);
                }
                subject.setPrerequisite(preList);
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
                syllabus.setSubjectCode(rs.getString("SubjectCode"));
                syllabus.setSyllabusNameEN(rs.getString("SubjectNameEN"));
                syllabus.setSyllabusNameVN(rs.getString("SubjectNameVN"));
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
                syllabus.setPreRequisite(rs.getString("PreRequisite"));
                syllabus.setSubject(subject);
                syllabus.setDecision(decision);
                list.add(syllabus);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<Syllabus> getAllSyllabusPreRequisite(int role) {
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
                    + "    `syllabus`.`PreRequisite`,\n"
                    + "    `subjects`.`subjectName`,\n"
                    + "    `subjects`.`Semester`,\n"
                    + "    `subjects`.`NoCredit`,\n"
                    + "    `decision`.`DecisionName`,\n"
                    + "    `decision`.`ApprovedDate`,\n"
                    + "    `decision`.`Note`,\n"
                    + "    `decision`.`CreateDate`,\n"
                    + "    `decision`.`isActive`,\n"
                    + "    `decision`.`FileName`\n"
                    + "FROM `syllabus` INNER JOIN `subjects`\n"
                    + "ON `syllabus`.`SubjectCode` = `subjects`.`SubjectCode` INNER JOIN `swp391`.`decision`\n"
                    + "ON `decision`.`DecisionNo` = `syllabus`.`DecisionNo`";
            if (role == 1) {
                sql += "WHERE `syllabus`.`IsActive` = 1 AND `syllabus`.`IsApproved` = 1";
            }
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Decision decision = new Decision();
                decision.setDecisionNo(rs.getString("DecisionNo"));
                decision.setDecisionName(rs.getString("DecisionName"));
                decision.setApprovedDate(rs.getDate("ApprovedDate"));
                decision.setNote(rs.getString("Note"));
                decision.setCreateDate(rs.getDate("CreateDate"));
                decision.setIsActive(rs.getBoolean("isActive"));
                decision.setFileName(rs.getString("FileName"));
                Subject subject = new Subject();
                subject.setSubjectCode(rs.getString(2));
                subject.setSubjectName(rs.getString("subjectName"));
                subject.setSemester(rs.getInt("Semester"));

                String sql1 = "SELECT `prerequisite`.`PreID`,\n"
                        + "    `prerequisite`.`subjectCode`,\n"
                        + "    `prerequisite`.`subjectPre`\n"
                        + "FROM `swp391`.`prerequisite`\n"
                        + "WHERE `prerequisite`.`subjectPre` = ?;";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setString(1, rs.getString("SubjectCode"));
                ResultSet rs1 = st1.executeQuery();
                ArrayList<PreRequisite> preList = new ArrayList<>();
                while (rs1.next()) {
                    PreRequisite pre = new PreRequisite();
                    pre.setPreID(rs1.getInt("PreID"));
                    pre.setSubjectCode(rs1.getString(2));
                    pre.setSubjectPre(rs1.getString("subjectPre"));
                    preList.add(pre);
                }
                subject.setPrerequisite(preList);
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
                syllabus.setSubjectCode(rs.getString("SubjectCode"));
                syllabus.setSyllabusNameEN(rs.getString("SubjectNameEN"));
                syllabus.setSyllabusNameVN(rs.getString("SubjectNameVN"));
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
                syllabus.setPreRequisite(rs.getString("PreRequisite"));
                syllabus.setSubject(subject);
                syllabus.setDecision(decision);
                list.add(syllabus);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<Material> getListMaterialBySyID(int id) {
        ArrayList<Material> list = new ArrayList<>();
        try {
            String sql = "SELECT `material`.`MaterialID`,\n"
                    + "    `material`.`MaterialDescription`,\n"
                    + "    `material`.`SyllabusID`,\n"
                    + "    `material`.`Author`,\n"
                    + "    `material`.`Publisher`,\n"
                    + "    `material`.`PublishedDate`,\n"
                    + "    `material`.`Edition`,\n"
                    + "    `material`.`ISBN`,\n"
                    + "    `material`.`IsMainMaterial`,\n"
                    + "    `material`.`IsHardCopy`,\n"
                    + "    `material`.`IsOnline`,\n"
                    + "    `material`.`Note`,\n"
                    + "    `material`.`isActive`\n"
                    + "FROM `swp391`.`material`\n"
                    + "WHERE `material`.`SyllabusID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Material m = new Material();
                m.setMaterialID(rs.getInt("MaterialID"));
                m.setMaterialDescription(rs.getString("MaterialDescription"));
                m.setSyllabusID(rs.getInt("SyllabusID"));
                m.setAuthor(rs.getString("Author"));
                m.setPublisher(rs.getString("Publisher"));
                m.setPublishedDate(rs.getString("PublishedDate"));
                m.setEdition(rs.getString("Edition"));
                m.setISBN(rs.getString("ISBN"));
                m.setIsMainMaterial(rs.getBoolean("IsMainMaterial"));
                m.setIsHardCopy(rs.getBoolean("IsHardCopy"));
                m.setIsOnline(rs.getBoolean("IsOnline"));
                m.setNote(rs.getString("Note"));
                m.setIsActive(rs.getBoolean("isActive"));
                list.add(m);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<CLO> getListCLOBySyID(int syID) {
        ArrayList<CLO> list = new ArrayList<>();
        try {
            String sql = "SELECT `clo`.`cloID`,\n"
                    + "    `clo`.`syID`,\n"
                    + "    `clo`.`cloName`,\n"
                    + "    `clo`.`cloDetails`,\n"
                    + "    `clo`.`loDetails`\n"
                    + "FROM `swp391`.`clo`\n"
                    + "WHERE `clo`.`syID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, syID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CLO clo = new CLO();
                clo.setCloID(rs.getInt("cloID"));
                clo.setSyID(rs.getInt("syID"));
                clo.setCloName(rs.getString("cloName"));
                clo.setCloDetails(rs.getString("cloDetails"));
                clo.setLoDetails(rs.getString("loDetails"));
                list.add(clo);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<Assessment> getListAssessmentBySyID(int syID) {
        ArrayList<Assessment> list = new ArrayList<>();
        try {
            String sql = "SELECT `assessment`.`assessmentID`,\n"
                    + "    `assessment`.`SyllabusID`,\n"
                    + "    `assessment`.`category`,\n"
                    + "    `assessment`.`Type`,\n"
                    + "    `assessment`.`Part`,\n"
                    + "    `assessment`.`Weight`,\n"
                    + "    `assessment`.`CompletionCriteria`,\n"
                    + "    `assessment`.`Duration`,\n"
                    + "    `assessment`.`QuestionType`,\n"
                    + "    `assessment`.`NoQuestion`,\n"
                    + "    `assessment`.`KnowledgeandSkill`,\n"
                    + "    `assessment`.`GradingGuide`,\n"
                    + "    `assessment`.`Note`\n"
                    + "FROM `swp391`.`assessment`\n"
                    + "WHERE `assessment`.`SyllabusID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, syID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Assessment ass = new Assessment();
                ass.setAssessmentID(rs.getInt("assessmentID"));
                ass.setSyllabusID(rs.getInt("SyllabusID"));
                ass.setCategory(rs.getString("category"));
                ass.setType(rs.getString("Type"));
                ass.setPart(rs.getInt("Part"));
                ass.setWeight(rs.getString("Weight"));
                ass.setCompletionCriteria(rs.getString("CompletionCriteria"));
                ass.setDuration(rs.getString("Duration"));
                ass.setQuestionType(rs.getString("QuestionType"));
                ass.setNoQuestion(rs.getString("NoQuestion"));
                ass.setKnowledgeandSkill(rs.getString("KnowledgeandSkill"));
                ass.setGradingGuide(rs.getString("GradingGuide"));
                ass.setNote(rs.getString("Note"));
                list.add(ass);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
        SyllabusDAO sd = new SyllabusDAO();
        ArrayList<Syllabus> list = sd.getAllSyllabusPreRequisite(1);
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i).getSubject().getPrerequisite());
        }
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
