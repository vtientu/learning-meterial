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
import module.Major;

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
                    + "majors.`majorNameVN`\n"
                    + "FROM swp391.curriculum join swp391.majors on\n"
                    + "curriculum.`majorID` = majors.`majorID`;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8));
                Curriculum curriculum = new Curriculum(rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5));
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
                    + "majors.`majorNameVN`\n"
                    + "FROM swp391.curriculum join swp391.majors on\n"
                    + "curriculum.`majorID` = majors.`majorID`\n";
            if (code != null && code.length() != 0) {
                sql += "WHERE curriculum.`CurriculumCode` like '%" + code + "%' OR curriculum.`CurriculumNameEN` like '%" + code + "%' OR curriculum.`CurriculumNameVN` like '%" + code + "%'";
            }
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8));
                Curriculum curriculum = new Curriculum(rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5));
                list.add(curriculum);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
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
                    + "majors.`majorNameVN`\n"
                    + "FROM swp391.curriculum join swp391.majors on\n"
                    + "curriculum.`majorID` = majors.`majorID`\n"
                    + "where curriculum.`CurriculumCode` = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cur);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {                
                Major major = new Major(rs.getInt(2), rs.getString(6), rs.getString(7), rs.getString(8));
                Curriculum curriculum = new Curriculum(rs.getString(1), major, rs.getString(3), rs.getString(4), rs.getString(5));
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
