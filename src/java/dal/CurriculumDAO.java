package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import module.Curriculum;
import module.Major;
import module.PreRequisite;
import module.Subject;

/**
 *
 * @author inuya
 */
public class CurriculumDAO extends DBContext {

    public ArrayList<Curriculum> getListForCurriculum() {
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
                    + "majors.`isActive`\n"
                    + "FROM swp391.curriculum join swp391.majors on\n"
                    + "curriculum.`majorID` = majors.`majorID`";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9));
                Curriculum curriculum = new Curriculum(rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5), "");
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
                    + "majors.`majorNameVN,`\n"
                    + "majors.`isActive`\n"
                    + "FROM swp391.curriculum join swp391.majors on\n"
                    + "curriculum.`majorID` = majors.`majorID`\n";
            if (code != null && code.length() != 0) {
                sql += "WHERE curriculum.`CurriculumCode` like '%" + code + "%' OR curriculum.`CurriculumNameEN` like '%" + code + "%' OR curriculum.`CurriculumNameVN` like '%" + code + "%' OR majors.`majorNameEN` like '%" + code + "%'";
            }
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9));
                Curriculum curriculum = new Curriculum(rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5), "");
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
                    + "curriculum.`majorID`,\n"
                    + "curriculum.`CurriculumNameEN`,\n"
                    + "curriculum.`CurriculumNameVN`,\n"
                    + "curriculum.`Description`,\n"
                    + "majors.`keyword`,\n"
                    + "majors.`majorNameEN`,\n"
                    + "majors.`majorNameVN`,\n"
                    + "subjects.`SubjectCode`,\n"
                    + "subjects.`subjectName`,\n"
                    + "subjects.`Semester`,\n"
                    + "subjects.`NoCredit`,\n"
                    + "subjects.`isActive`,\n"
                    + "prerequisite.`PreID`,\n"
                    + "prerequisite.`subjectCode`,\n"
                    + "prerequisite.`subjectPre`\n"
                    + "FROM swp391.curriculum join swp391.majors on\n"
                    + "curriculum.`majorID` = majors.`majorID` join swp391.curriculumsubject on\n"
                    + "curriculum.`curriculumCode` = curriculumsubject.`curriculumCode` join swp391.subjects on\n"
                    + "curriculumsubject.`SubjectCode` = subjects.`SubjectCode` join swp391.prerequisite on\n"
                    + "prerequisite.subjectCode = subjects.SubjectCode\n"
                    + "where curriculum.`CurriculumCode` = ?\n"
                    + "order by subjects.Semester asc";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cur);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(14));
                Curriculum curriculum = new Curriculum(rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5), "");
                PreRequisite p = new PreRequisite(rs.getInt(14), rs.getString(15), rs.getString(16));
                Subject subject = new Subject(rs.getInt(12), rs.getInt(11), rs.getString(9), rs.getString(10), p, rs.getBoolean(13));
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
                    + "curriculum.`decisionNo`\n"
                    + "FROM swp391.curriculum join swp391.majors on\n"
                    + "curriculum.`majorID` = majors.`majorID`\n"
                    + "where curriculum.`CurriculumCode` = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cur);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8), rs.getBoolean(9));
                Curriculum curriculum = new Curriculum(rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(9));
                return curriculum;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
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
