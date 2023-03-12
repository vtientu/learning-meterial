package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import module.Curriculum;
import module.Decision;
import module.Major;
import module.PreRequisite;
import module.Subject;

/**
 *
 * @author inuya
 */
public class CurriculumDAO_1 extends DBContext {

    public ArrayList<Curriculum> getListForCurriculum() {
        ArrayList<Curriculum> list = new ArrayList<>();
        try {
            String sql = "SELECT curriculum.`CurriculumCode`,\n"
                    + "                    curriculum.`majorID`,\n"
                    + "                    curriculum.`CurriculumNameEN`,\n"
                    + "                    curriculum.`CurriculumNameVN`,\n"
                    + "                    curriculum.`Description`,\n"
                    + "                    majors.`keyword`,\n"
                    + "                    majors.`majorNameEN`,\n"
                    + "                    majors.`majorNameVN`,\n"
                    + "                    majors.`isActive`,\n"
                    + "                    curriculum.`CurID`,\n"
                    + "                    decision.DecisionNo,\n"
                    + "                    curriculum.`isApprove`\n"
                    + "                    FROM swp391.curriculum join swp391.majors on\n"
                    + "                    curriculum.`majorID` = majors.`majorID` join swp391.decision on\n"
                    + "                    curriculum.decisionNo = decision.decisionNo\n"
                    + "                    order by curriculum.CurID asc";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Decision d = new Decision(0, rs.getString(11), sql, null, sql, null, sql, true);
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9));
                Curriculum curriculum = new Curriculum(rs.getInt(10), rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5), d, rs.getInt(12));
                list.add(curriculum);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Curriculum> getListCurriculumByCode(String code) {
        ArrayList<Curriculum> list = new ArrayList<>();
        try {
            String sql = "SELECT curriculum.`CurriculumCode`,\n"
                    + "curriculum.`majorID`,\n"
                    + "curriculum.`CurriculumNameEN`,\n"
                    + "curriculum.`CurriculumNameVN`,\n"
                    + "curriculum.`Description`,\n"
                    + "majors.`keyword`,\n"
                    + "majors.`majorNameEN`,\n"
                    + "majors.`majorNameVN`,\n"
                    + "majors.`isActive`,\n"
                    + "curriculum.`CurID`,\n"
                    + "curriculum.decisionNo,\n"
                    + "curriculum.isApprove\n"
                    + "FROM swp391.curriculum join swp391.majors on\n"
                    + "curriculum.`majorID` = majors.`majorID`\n"
                    + "join swp391.`decision` on\n"
                    + "curriculum.`decisionNo` = decision.`decisionNo`";
            if (code == null) {
                sql += "                   order by curriculum.CurID asc";
            } else if (code != null && code.length() != 0) {
                sql += "WHERE curriculum.`CurriculumCode` like '%" + code + "%' OR curriculum.`CurriculumNameEN` like '%" + code + "%' OR curriculum.`CurriculumNameVN` like '%" + code + "%' OR majors.`majorNameEN` like '%" + code + "%'\n"
                        + "                   order by curriculum.CurID asc";
            }
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Decision decision = new Decision(0, rs.getString(11), code, null, code, null, sql, true);
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9));
                Curriculum curriculum = new Curriculum(rs.getInt(10), rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5), decision, rs.getInt(12));
                list.add(curriculum);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<Subject> getSubject(String cur) {
        ArrayList<Subject> list = new ArrayList<>();
        try {
            String sql = "SELECT curriculum.`CurriculumCode`,\n"
                    + "                   curriculum.`majorID`,\n"
                    + "                   curriculum.`CurriculumNameEN`,\n"
                    + "                   curriculum.`CurriculumNameVN`,\n"
                    + "                   curriculum.`Description`,\n"
                    + "                   majors.`keyword`,\n"
                    + "                   majors.`majorNameEN`,\n"
                    + "                   majors.`majorNameVN`,\n"
                    + "                   subjects.`SubjectCode`,\n"
                    + "                   subjects.`subjectName`,\n"
                    + "                   subjects.`Semester`,\n"
                    + "                   subjects.`NoCredit`,\n"
                    + "                   subjects.`isActive`,\n"
                    + "                   prerequisite.`PreID`,\n"
                    + "                   prerequisite.`SubjectID`,\n"
                    + "                   prerequisite.`subjectPre`,\n"
                    + "                   curriculum.`CurID`,\n"
                    + "                   curriculum.`isApprove`\n"
                    + "                   FROM swp391.curriculum join swp391.majors on\n"
                    + "                   curriculum.`majorID` = majors.`majorID` join swp391.curriculumsubject on\n"
                    + "                   curriculum.`CurID` = curriculumsubject.`CurID` join swp391.subjects on\n"
                    + "                   curriculumsubject.`SubjectID` = subjects.`SubjectID` join swp391.prerequisite on\n"
                    + "                   prerequisite.`SubjectID` = subjects.`SubjectID`\n"
                    + "                   where curriculum.`CurID` = ?\n"
                    + "                   order by subjects.Semester asc";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cur);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(14));
                Curriculum curriculum = new Curriculum(rs.getInt(17), rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5), null, rs.getInt(18));
                PreRequisite p = new PreRequisite(rs.getInt(14), null, rs.getString(16));
                Subject subject = new Subject(rs.getInt(12), rs.getInt(11), rs.getString(9), rs.getString(10), null, rs.getBoolean(13));
                list.add(subject);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e+"1111222233334444");
        }
        return null;
    }

    public ArrayList<Subject> getSubjectById(String cur) {
        ArrayList<Subject> list = new ArrayList<>();
        try {
            String sql = "SELECT curriculum.`CurriculumCode`,\n"
                    + "                   curriculum.`majorID`,\n"
                    + "                   curriculum.`CurriculumNameEN`,\n"
                    + "                   curriculum.`CurriculumNameVN`,\n"
                    + "                   curriculum.`Description`,\n"
                    + "                   majors.`keyword`,\n"
                    + "                   majors.`majorNameEN`,\n"
                    + "                   majors.`majorNameVN`,\n"
                    + "                   subjects.`SubjectCode`,\n"
                    + "                   subjects.`subjectName`,\n"
                    + "                   subjects.`Semester`,\n"
                    + "                   subjects.`NoCredit`,\n"
                    + "                   subjects.`isActive`,\n"
                    + "                   curriculum.`CurID`\n"
                    + "                   FROM swp391.curriculum join swp391.majors on\n"
                    + "                   curriculum.`majorID` = majors.`majorID` join swp391.curriculumsubject on\n"
                    + "                   curriculum.`CurID` = curriculumsubject.`CurID` join swp391.subjects on\n"
                    + "                   curriculumsubject.`SubjectID` = subjects.`SubjectID`\n"
                    + "                   where curriculum.`CurID` = ?\n"
                    + "                   order by subjects.Semester asc";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cur);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject(rs.getInt(12), rs.getInt(11), rs.getString(9), rs.getString(10), null, rs.getBoolean(13));
                list.add(subject);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Curriculum getCurriculum(String cur) {
        try {
            String sql = "SELECT curriculum.`CurriculumCode`,\n"
                    + "curriculum.`majorID`,\n"
                    + "curriculum.`CurriculumNameEN`,\n"
                    + "curriculum.`CurriculumNameVN`,\n"
                    + "curriculum.`Description`,\n"
                    + "majors.`keyword`,\n"
                    + "majors.`majorNameEN`,\n"
                    + "majors.`majorNameVN`,\n"
                    + "majors.`isActive`,\n"
                    + "decision.`DecisionNo`,\n"
                    + "decision.`DecisionName`,\n"
                    + "decision.`ApprovedDate`,\n"
                    + "decision.`Note`,\n"
                    + "decision.`CreateDate`,\n"
                    + "decision.`FileName`,\n"
                    + "decision.`isActive`,\n"
                    + "curriculum.`CurID`,\n"
                    + "curriculum.`isApprove`\n"
                    + "FROM swp391.curriculum join swp391.majors on\n"
                    + "curriculum.`majorID` = majors.`majorID` join\n"
                    + "swp391.decision on curriculum.DecisionNo = decision.DecisionNo\n"
                    + "where curriculum.`CurID` = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cur);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9));
                Decision d = new Decision(0, rs.getString(10), rs.getString(11), rs.getDate(12), rs.getString(13), rs.getDate(14), rs.getString(15), rs.getBoolean(16));
                Curriculum curriculum = new Curriculum(rs.getInt(17), rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5), d, rs.getInt(18));
                return curriculum;
            }
        } catch (SQLException e) {
            System.out.println(e + "12341234121212341234");
        }
        return null;
    }

    public void getEditCurriculum(String id, int major, String decision, String code, String nameen, String namevn, String description, int approve) {
        try {
            String sql = "UPDATE `swp391`.`curriculum`\n"
                    + "                    SET\n"
                    + "                    `CurriculumCode` = ?,\n"
                    + "                    `majorID` = ?,\n"
                    + "                    `CurriculumNameEN` = ?,\n"
                    + "                    `CurriculumNameVN` = ?,\n"
                    + "                    `DecisionNo` = ?,\n"
                    + "                    `Description` = ?,\n"
                    + "                    `isApprove` = ?\n"
                    + "                    WHERE `CurID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, code);
            st.setInt(2, major);
            st.setString(3, nameen);
            st.setString(4, namevn);
            st.setString(5, decision);
            st.setString(6, description);
            st.setInt(7, approve);
            st.setString(8, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void getInsertCurriculumSubject(Curriculum cur) {
        try {
            String sql = "INSERT INTO `swp391`.`curriculumsubject`\n"
                    + "(`CurID`,\n"
                    + "`SubjectID`)\n"
                    + "VALUES\n"
                    + "(?,?)";

            for (Subject s : cur.getSubject()) {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, cur.getCurID());
                st.setInt(2, s.getSubjectID());
                st.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println(e + "5");
        }
    }

    public void curriculumInsert(String code, int major, String en, String vn, String decision, String description) {
        try {
            String sql = "INSERT INTO `swp391`.`curriculum`\n"
                    + "(`CurriculumCode`,\n"
                    + "`majorID`,\n"
                    + "`CurriculumNameEN`,\n"
                    + "`CurriculumNameVN`,\n"
                    + "`DecisionNo`,\n"
                    + "`Description`)\n"
                    + "VALUES\n"
                    + "(?,?,?,?,?,?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, code);
            st.setInt(2, major);
            st.setString(3, en);
            st.setString(4, vn);
            st.setString(5, decision);
            st.setString(6, description);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void getDeleteCurriculum1(String curID) {
        try {
            String sql = "DELETE FROM `swp391`.`curriculumsubject`\n"
                    + "WHERE CurID=?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, curID);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + "12346");
        }
    }

    public void getDeleteCurriculum2(String curID) {
        try {
            String sql = "DELETE FROM `swp391`.`combocurriculum`\n"
                    + "WHERE CurID=?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, curID);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + "12347");
        }
    }

    public void getDeleteCurriculum3(String curID) {
        try {
            String sql = "DELETE FROM `swp391`.`curriculumelective`\n"
                    + "WHERE CurID=?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, curID);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + "12348");
        }
    }

    public void getDeleteCurriculum4(String curID) {
        try {
            String sql = "DELETE FROM `swp391`.`curriculum`\n"
                    + "WHERE CurID=?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, curID);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + "12341234");
        }
    }

    public ArrayList<Curriculum> getListByPage(ArrayList<Curriculum> list,
            int start, int end) {
        ArrayList<Curriculum> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }
}
