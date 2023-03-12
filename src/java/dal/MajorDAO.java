/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import module.Major;

/**
 *
 * @author inuya
 */
public class MajorDAO extends DBContext {

    public ArrayList<Major> getMajorlist() {
        ArrayList<Major> list = new ArrayList<>();
        try {
            String sql = "SELECT majorID,\n"
                    + "keyword,\n"
                    + "majorNameEN,\n"
                    + "majorNameVN,\n"
                    + "isActive\n"
                    + "FROM swp391.majors";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Major major = new Major(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getBoolean(5));
                list.add(major);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e+"1234");
        }
        return null;
    }
}
