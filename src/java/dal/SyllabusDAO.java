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
import module.Question;
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
                    + "    `syllabus`.`SubjectID`,\n"
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
                    + "    `subjects`.`SubjectID`,\n"
                    + "    `subjects`.`SubjectCode`,\n"
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
                    + "ON `syllabus`.`SubjectID` = `subjects`.`SubjectID` LEFT JOIN `swp391`.`decision`\n"
                    + "ON `decision`.`DecisionNo` = `syllabus`.`DecisionNo`";
            if (role == 1) {
                sql += " WHERE `syllabus`.`IsActive` = 1 AND `syllabus`.`IsApproved` = 1";
            }
            sql += " ORDER BY `SyllabusID` DESC";
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
                        + "                            `prerequisite`.`SyllabusID`,\n"
                        + "                            `prerequisite`.`SubjectID`,\n"
                        + "                            `prerequisite`.`subjectPre`,\n"
                        + "                            `subjects`.`SubjectCode`,\n"
                        + "                            `subjects`.`subjectName`,\n"
                        + "                            `subjects`.`Semester`,\n"
                        + "                            `subjects`.`NoCredit`,\n"
                        + "                            `subjects`.`isActive`\n"
                        + "                        FROM `subjects` INNER JOIN `prerequisite`\n"
                        + "                        ON subjects.SubjectID = prerequisite.SubjectID\n"
                        + "                        WHERE `prerequisite`.`SyllabusID` = ?;";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, rs.getInt("SubjectID"));
                ResultSet rs1 = st1.executeQuery();
                ArrayList<PreRequisite> preList = new ArrayList<>();
                while (rs1.next()) {
                    Subject sub = new Subject();
                    sub.setSubjectID(rs.getInt("SubjectID"));
                    sub.setSubjectCode(rs.getString("SubjectCode"));
                    sub.setSubjectName(rs.getString("subjectName"));
                    sub.setSemester(rs.getInt("Semester"));
                    sub.setNoCredit(rs.getInt("NoCredit"));
                    sub.setIsActive(rs.getBoolean("isActive"));
                    PreRequisite pre = new PreRequisite();
                    pre.setPreID(rs1.getInt("PreID"));
                    pre.setSubject(subject);
                    pre.setSubjectPre(rs1.getString("subjectPre"));
                    preList.add(pre);
                }
                subject.setSubjectID(rs.getInt("SubjectID"));
                subject.setSubjectCode(rs.getString("SubjectCode"));
                subject.setPrerequisite(preList);
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
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

    public boolean updateSyllabus(Syllabus s, String[] prerequisite) {
        try {
            String sql = "UPDATE `syllabus`\n"
                    + "SET\n"
                    + "`SubjectID` = ?,\n"
                    + "`SubjectNameEN` = ?,\n"
                    + "`SubjectNameVN` = ?,\n"
                    + "`IsActive` = ?,\n"
                    + "`IsApproved` = ?,\n"
                    + "`NoCredit` = ?,\n"
                    + "`DegreeLevel` = ?,\n"
                    + "`TimeAllocation` = ?,\n"
                    + "`Description` = ?,\n"
                    + "`StudentTasks` = ?,\n"
                    + "`Tools` = ?,\n"
                    + "`ScoringScale` = ?,\n"
                    + "`Note` = ?,\n"
                    + "`MinAvgMarkToPass` = ?,\n"
                    + "`ApprovedDate` = CURDATE()\n"
                    + "WHERE `SyllabusID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, s.getSubject().getSubjectID());
            st.setString(2, s.getSyllabusNameEN());
            st.setString(3, s.getSyllabusNameVN());
            st.setBoolean(4, s.isIsActive());
            st.setBoolean(5, s.isIsApproved());
            st.setInt(6, s.getNoCredit());
            st.setString(7, s.getDegreeLevel());
            st.setString(8, s.getTimeAllocation());
            st.setString(9, s.getDescription());
            st.setString(10, s.getStudentTasks());
            st.setString(11, s.getTools());
            st.setInt(12, s.getScoringScale());
            st.setString(13, s.getNote());
            st.setInt(14, s.getMinAvgMarkToPass());
            st.setInt(15, s.getSyllabusID());
            st.executeUpdate();
            if (prerequisite != null) {
                updatePreRequisite(prerequisite, s.getSyllabusID(), s.getSubject().getSubjectID());
            }
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean createSyllabus(Syllabus s, String[] prerequisite) {
        try {
            String sql = "INSERT INTO `swp391`.`syllabus`\n"
                    + "(`SubjectID`,\n"
                    + "`SubjectNameEN`,\n"
                    + "`SubjectNameVN`,\n"
                    + "`IsActive`,\n"
                    + "`IsApproved`,\n"
                    + "`DecisionNo`,\n"
                    + "`NoCredit`,\n"
                    + "`DegreeLevel`,\n"
                    + "`TimeAllocation`,\n"
                    + "`Description`,\n"
                    + "`StudentTasks`,\n"
                    + "`Tools`,\n"
                    + "`ScoringScale`,\n"
                    + "`Note`,\n"
                    + "`MinAvgMarkToPass`,\n"
                    + "`ApprovedDate`,\n"
                    + "`PreRequisite`)\n"
                    + "VALUES\n"
                    + "(?,?,?,0,0,null,?,?,?,?,?,?,?,?,?,CURDATE(),null);";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, s.getSubject().getSubjectID());
            st.setString(2, s.getSyllabusNameEN());
            st.setString(3, s.getSyllabusNameVN());
            st.setInt(4, s.getNoCredit());
            st.setString(5, s.getDegreeLevel());
            st.setString(6, s.getTimeAllocation());
            st.setString(7, s.getDescription());
            st.setString(8, s.getStudentTasks());
            st.setString(9, s.getTools());
            st.setInt(10, s.getScoringScale());
            st.setString(11, s.getNote());
            st.setInt(12, s.getMinAvgMarkToPass());
            st.executeUpdate();
            if (prerequisite != null) {
                createPreRequisite(prerequisite, s.getSubject().getSubjectID());
            }
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public void createPreRequisite(String[] arrPre, int subId) {
        try {
            String sql = "SELECT SyllabusID\n"
                    + "FROM swp391.syllabus \n"
                    + "ORDER BY SyllabusID DESC\n"
                    + "LIMIT 1;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                for (String pre : arrPre) {
                    String sql1 = "INSERT INTO `prerequisite`\n"
                            + "(`SyllabusID`,\n"
                            + "`SubjectID`,\n"
                            + "`subjectPre`)\n"
                            + "VALUES\n"
                            + "(?, ?, ?);";
                    PreparedStatement st1 = connection.prepareStatement(sql1);
                    st1.setInt(1, rs.getInt(1));
                    st1.setInt(2, subId);
                    st1.setString(3, pre);
                    st1.executeUpdate();
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updatePreRequisite(String[] arrPre, int syId, int subId) {
        try {
            String sql = "DELETE FROM `prerequisite`\n"
                    + "WHERE SyllabusID = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, syId);
            st.executeUpdate();
            for (String pre : arrPre) {
                String sql1 = "INSERT INTO `prerequisite`\n"
                        + "(`SyllabusID`,\n"
                        + "`SubjectID`,\n"
                        + "`subjectPre`)\n"
                        + "VALUES\n"
                        + "(?, ?, ?);";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, syId);
                st1.setInt(2, subId);
                st1.setString(3, pre);
                st1.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void createSubject(Subject s) {
        try {
            String sql = "INSERT INTO `subjects`\n"
                    + "(`SubjectCode`,\n"
                    + "`subjectName`,\n"
                    + "`Semester`,\n"
                    + "`NoCredit`,\n"
                    + "`isActive`)\n"
                    + "VALUES\n"
                    + "(?, ?, ?, ?, 0);";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, s.getSubjectCode());
            st.setString(2, s.getSubjectName());
            st.setInt(3, s.getSemester());
            st.setInt(4, s.getNoCredit());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Subject getSubject(int sid) {
        try {
            String sql = "SELECT `subjects`.`SubjectID`,\n"
                    + "    `subjects`.`SubjectCode`,\n"
                    + "    `subjects`.`subjectName`,\n"
                    + "    `subjects`.`Semester`,\n"
                    + "    `subjects`.`NoCredit`,\n"
                    + "    `subjects`.`isActive`\n"
                    + "FROM `subjects`\n"
                    + "WHERE `subjects`.`SubjectID` = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, sid);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Subject s = new Subject();
                s.setSubjectID(rs.getInt(1));
                s.setSubjectCode(rs.getString(2));
                s.setSubjectName(rs.getString(3));
                s.setSemester(rs.getInt(4));
                s.setNoCredit(rs.getInt(5));
                s.setIsActive(rs.getBoolean(6));
                return s;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Question> getQuestionListBySID(int sid) {
        ArrayList<Question> list = new ArrayList<>();
        try {
            String sql = "SELECT `question`.`QuestionID`,\n"
                    + "    `question`.`SyllabusID`,\n"
                    + "    `question`.`SessionID`,\n"
                    + "    `question`.`QuestionName`,\n"
                    + "    `question`.`Details`\n"
                    + "FROM `question`\n"
                    + "WHERE `question`.`SyllabusID` = ? ORDER BY `QuestionID` DESC;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, sid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Question q = new Question();
                q.setQuestionID(rs.getInt(1));
                q.setSyllabusID(rs.getInt(2));
                q.setSessionID(rs.getInt(3));
                q.setQuestionName(rs.getString(4));
                q.setDetails(rs.getString(5));
                list.add(q);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Question getQuestionByID(int qid) {
        try {
            String sql = "SELECT `question`.`QuestionID`,\n"
                    + "    `question`.`SyllabusID`,\n"
                    + "    `question`.`SessionID`,\n"
                    + "    `question`.`QuestionName`,\n"
                    + "    `question`.`Details`\n"
                    + "FROM `question`\n"
                    + "WHERE `question`.`QuestionID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, qid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Question q = new Question();
                q.setQuestionID(rs.getInt(1));
                q.setSyllabusID(rs.getInt(2));
                q.setSessionID(rs.getInt(3));
                q.setQuestionName(rs.getString(4));
                q.setDetails(rs.getString(5));
                return q;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Question> getQuestionListByKey(String key) {
        ArrayList<Question> list = new ArrayList<>();
        try {
            String sql = "SELECT `question`.`QuestionID`,\n"
                    + "    `question`.`SyllabusID`,\n"
                    + "    `question`.`SessionID`,\n"
                    + "    `question`.`QuestionName`,\n"
                    + "    `question`.`Details`\n"
                    + "FROM `question`\n"
                    + "WHERE `question`.`QuestionName` LIKE ? OR `question`.`Details` LIKE ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "'%" + key + "%'");
            st.setString(2, "'%" + key + "%'");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Question q = new Question();
                q.setQuestionID(rs.getInt(1));
                q.setSyllabusID(rs.getInt(2));
                q.setSessionID(rs.getInt(3));
                q.setQuestionName(rs.getString(4));
                q.setDetails(rs.getString(5));
                list.add(q);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void deleteQuestion(int qid) {
        try {
            String sql = "DELETE FROM `question`\n"
                    + "WHERE QuestionID = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, qid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean updateSubject(Subject s) {
        try {
            String sql = "UPDATE `subjects`\n"
                    + "SET\n"
                    + "`SubjectCode` = ?,\n"
                    + "`subjectName` = ?,\n"
                    + "`Semester` = ?,\n"
                    + "`NoCredit` = ?,\n"
                    + "`isActive` = ?\n"
                    + "WHERE `SubjectID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, s.getSubjectCode());
            st.setString(2, s.getSubjectName());
            st.setInt(3, s.getSemester());
            st.setInt(4, s.getNoCredit());
            st.setBoolean(5, s.isIsActive());
            st.setInt(6, s.getSubjectID());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return true;
    }

    public boolean checkSubjectCode(String subjectCode) {
        try {
            String sql = "SELECT * FROM subjects WHERE subjectCode = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, subjectCode);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean checkSubjectName(String subjectName) {
        try {
            String sql = "SELECT * FROM subjects WHERE subjectName = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, subjectName);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
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
                    + "FROM `swp391`.`subjects` ORDER BY `subjects`.`SubjectID` Desc;";
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
                    + "                    ORDER BY `subjects`.`SubjectID` DESC";
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
                    + "    `syllabus`.`SubjectID`,\n"
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
                    + "    `subjects`.`SubjectID`,\n"
                    + "    `subjects`.`SubjectCode`,\n"
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
                    + "ON `syllabus`.`SubjectID` = `subjects`.`SubjectID` INNER JOIN `prerequisite`\n"
                    + "ON `prerequisite`.`SubjectID` = `subjects`.`SubjectID` LEFT JOIN `swp391`.`decision`\n"
                    + "ON `decision`.`DecisionNo` = `syllabus`.`DecisionNo`"
                    + "WHERE `subjects`.`SubjectCode` = ?";
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
                        + "                            `prerequisite`.`SyllabusID`,\n"
                        + "                            `prerequisite`.`SubjectID`,\n"
                        + "                            `prerequisite`.`subjectPre`,\n"
                        + "                            `subjects`.`SubjectCode`,\n"
                        + "                            `subjects`.`subjectName`,\n"
                        + "                            `subjects`.`Semester`,\n"
                        + "                            `subjects`.`NoCredit`,\n"
                        + "                            `subjects`.`isActive`\n"
                        + "                        FROM `subjects` INNER JOIN `prerequisite`\n"
                        + "                        ON subjects.SubjectID = prerequisite.SubjectID\n"
                        + "                        WHERE `prerequisite`.`SyllabusID` = ?;";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, rs.getInt("SubjectID"));
                ResultSet rs1 = st1.executeQuery();
                ArrayList<PreRequisite> preList = new ArrayList<>();
                while (rs1.next()) {
                    Subject sub = new Subject();
                    sub.setSubjectID(rs.getInt("SubjectID"));
                    sub.setSubjectCode(rs.getString("SubjectCode"));
                    sub.setSubjectName(rs.getString("subjectName"));
                    sub.setSemester(rs.getInt("Semester"));
                    sub.setNoCredit(rs.getInt("NoCredit"));
                    sub.setIsActive(rs.getBoolean("isActive"));
                    PreRequisite pre = new PreRequisite();
                    pre.setPreID(rs1.getInt("PreID"));
                    pre.setSubject(subject);
                    pre.setSubjectPre(rs1.getString("subjectPre"));
                    preList.add(pre);
                }
                subject.setSubjectID(rs.getInt("SubjectID"));
                subject.setSubjectCode(rs.getString("SubjectCode"));
                subject.setPrerequisite(preList);
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
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

    public Syllabus getSyllabusByID(int code) {
        try {
            String sql = "SELECT `syllabus`.`SyllabusID`,\n"
                    + "    `syllabus`.`SubjectID`,\n"
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
                    + "    `subjects`.`SubjectID`,\n"
                    + "    `subjects`.`SubjectCode`,\n"
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
                    + "ON `syllabus`.`SubjectID` = `subjects`.`SubjectID` INNER JOIN `prerequisite`\n"
                    + "ON `prerequisite`.`subjectID` = `subjects`.`subjectID` LEFT JOIN `swp391`.`decision`\n"
                    + "ON `decision`.`DecisionNo` = `syllabus`.`DecisionNo`"
                    + "WHERE `syllabus`.`SyllabusID` = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, code);
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
                        + "                            `prerequisite`.`SyllabusID`,\n"
                        + "                            `prerequisite`.`SubjectID`,\n"
                        + "                            `prerequisite`.`subjectPre`,\n"
                        + "                            `subjects`.`SubjectCode`,\n"
                        + "                            `subjects`.`subjectName`,\n"
                        + "                            `subjects`.`Semester`,\n"
                        + "                            `subjects`.`NoCredit`,\n"
                        + "                            `subjects`.`isActive`\n"
                        + "                        FROM `subjects` INNER JOIN `prerequisite`\n"
                        + "                        ON subjects.SubjectID = prerequisite.SubjectID\n"
                        + "                        WHERE `prerequisite`.`SyllabusID` = ?;";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, rs.getInt("SubjectID"));
                ResultSet rs1 = st1.executeQuery();
                ArrayList<PreRequisite> preList = new ArrayList<>();
                while (rs1.next()) {
                    Subject sub = new Subject();
                    sub.setSubjectID(rs.getInt("SubjectID"));
                    sub.setSubjectCode(rs.getString("SubjectCode"));
                    sub.setSubjectName(rs.getString("subjectName"));
                    sub.setSemester(rs.getInt("Semester"));
                    sub.setNoCredit(rs.getInt("NoCredit"));
                    sub.setIsActive(rs.getBoolean("isActive"));
                    PreRequisite pre = new PreRequisite();
                    pre.setPreID(rs1.getInt("PreID"));
                    pre.setSubject(subject);
                    pre.setSubjectPre(rs1.getString("subjectPre"));
                    preList.add(pre);
                }
                subject.setSubjectID(rs.getInt("SubjectID"));
                subject.setSubjectCode(rs.getString("SubjectCode"));
                subject.setPrerequisite(preList);
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
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

    public static void main(String[] args) {
        SyllabusDAO sdao = new SyllabusDAO();
        ArrayList<Syllabus> list = sdao.getAllSyllabus(0);
        for(Syllabus s : list) {
            System.out.println(s.getSyllabusID());
        }
    }
    
    public ArrayList<Syllabus> getListSyllabusByKey(String key, int role) {
        ArrayList<Syllabus> list = new ArrayList<>();
        try {
            String sql = "SELECT `syllabus`.`SyllabusID`,\n"
                    + "    `syllabus`.`SubjectID`,\n"
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
                    + "    `subjects`.`SubjectID`,\n"
                    + "    `subjects`.`SubjectCode`,\n"
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
                    + "ON `syllabus`.`SubjectID` = `subjects`.`SubjectID` LEFT JOIN `decision`\n"
                    + "ON `decision`.`DecisionNo` = `syllabus`.`DecisionNo`"
                    + "WHERE `subjects`.`SubjectCode` LIKE ? OR `syllabus`.`SubjectNameEN` LIKE ? OR `syllabus`.`SubjectNameVN` LIKE ?";
            if (role == 1) {
                sql += " AND `syllabus`.`IsActive` = 1 AND `syllabus`.`IsApproved` = 1";
            }
            sql += "  ORDER BY `SyllabusID` DESC";
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
                        + "                            `prerequisite`.`SyllabusID`,\n"
                        + "                            `prerequisite`.`SubjectID`,\n"
                        + "                            `prerequisite`.`subjectPre`,\n"
                        + "                            `subjects`.`SubjectCode`,\n"
                        + "                            `subjects`.`subjectName`,\n"
                        + "                            `subjects`.`Semester`,\n"
                        + "                            `subjects`.`NoCredit`,\n"
                        + "                            `subjects`.`isActive`\n"
                        + "                        FROM `subjects` INNER JOIN `prerequisite`\n"
                        + "                        ON subjects.SubjectID = prerequisite.SubjectID\n"
                        + "                        WHERE `prerequisite`.`SyllabusID` = ?;";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, rs.getInt("SubjectID"));
                ResultSet rs1 = st1.executeQuery();
                ArrayList<PreRequisite> preList = new ArrayList<>();
                while (rs1.next()) {
                    Subject sub = new Subject();
                    sub.setSubjectID(rs.getInt("SubjectID"));
                    sub.setSubjectCode(rs.getString("SubjectCode"));
                    sub.setSubjectName(rs.getString("subjectName"));
                    sub.setSemester(rs.getInt("Semester"));
                    sub.setNoCredit(rs.getInt("NoCredit"));
                    sub.setIsActive(rs.getBoolean("isActive"));
                    PreRequisite pre = new PreRequisite();
                    pre.setPreID(rs1.getInt("PreID"));
                    pre.setSubject(subject);
                    pre.setSubjectPre(rs1.getString("subjectPre"));
                    preList.add(pre);
                }
                subject.setSubjectID(rs.getInt("SubjectID"));
                subject.setSubjectCode(rs.getString("SubjectCode"));
                subject.setPrerequisite(preList);
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
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
                    + "    `syllabus`.`SubjectID`,\n"
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
                    + "    `subjects`.`SubjectID`,\n"
                    + "    `subjects`.`SubjectCode`,\n"
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
                    + "ON `syllabus`.`SubjectID` = `subjects`.`SubjectID` LEFT JOIN `swp391`.`decision`\n"
                    + "ON `decision`.`DecisionNo` = `syllabus`.`DecisionNo`";
            if (role == 1) {
                sql += "WHERE `syllabus`.`IsActive` = 1 AND `syllabus`.`IsApproved` = 1";
            }
            sql += "  ORDER BY `SyllabusID` DESC";
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
                        + "                            `prerequisite`.`SyllabusID`,\n"
                        + "                            `prerequisite`.`SubjectID`,\n"
                        + "                            `prerequisite`.`subjectPre`,\n"
                        + "                            `subjects`.`SubjectCode`,\n"
                        + "                            `subjects`.`subjectName`,\n"
                        + "                            `subjects`.`Semester`,\n"
                        + "                            `subjects`.`NoCredit`,\n"
                        + "                            `subjects`.`isActive`\n"
                        + "                        FROM `subjects` INNER JOIN `prerequisite`\n"
                        + "                        ON subjects.SubjectID = prerequisite.SubjectID\n"
                        + "                        WHERE `prerequisite`.`SyllabusID` = ?;";
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, rs.getInt("SubjectID"));
                ResultSet rs1 = st1.executeQuery();
                ArrayList<PreRequisite> preList = new ArrayList<>();
                while (rs1.next()) {
                    Subject sub = new Subject();
                    sub.setSubjectID(rs.getInt("SubjectID"));
                    sub.setSubjectCode(rs.getString("SubjectCode"));
                    sub.setSubjectName(rs.getString("subjectName"));
                    sub.setSemester(rs.getInt("Semester"));
                    sub.setNoCredit(rs.getInt("NoCredit"));
                    sub.setIsActive(rs.getBoolean("isActive"));
                    PreRequisite pre = new PreRequisite();
                    pre.setPreID(rs1.getInt("PreID"));
                    pre.setSubject(subject);
                    pre.setSubjectPre(rs1.getString("subjectPre"));
                    preList.add(pre);
                }
                subject.setSubjectID(rs.getInt("SubjectID"));
                subject.setSubjectCode(rs.getString("SubjectCode"));
                subject.setPrerequisite(preList);
                subject.setNoCredit(rs.getInt("NoCredit"));
                Syllabus syllabus = new Syllabus();
                syllabus.setSyllabusID(rs.getInt("SyllabusID"));
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

    public ArrayList<Syllabus> getListByPage(ArrayList<Syllabus> list,
            int start, int end) {
        ArrayList<Syllabus> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }
}
