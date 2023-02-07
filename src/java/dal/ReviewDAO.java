/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import module.Feedback;

/**
 *
 * @author tient
 */
public class ReviewDAO extends DBContext {

    public void createFeedbackSyllabus(int aid, int syID, Feedback fb) {
        try {
            String sql = "INSERT INTO `swp391`.`feedback`\n"
                    + "(`accountID`,\n"
                    + "`syllabusID`,\n"
                    + "`displayName`,\n"
                    + "`email`,\n"
                    + "`title`,\n"
                    + "`content`)\n"
                    + "VALUES\n"
                    + "(?, ?, ?, ?, ?, ?);";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, aid);
            st.setInt(2, syID);
            st.setString(3, fb.getDisplayName());
            st.setString(4, fb.getEmail());
            st.setString(5, fb.getTitle());
            st.setString(6, fb.getDescription());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ArrayList<Feedback> getFeedbackBySyID(String syID) {
        ArrayList<Feedback> list = new ArrayList<>();
        try {
            String sql = "SELECT `feedback`.`fbID`,\n"
                    + "    `feedback`.`accountID`,\n"
                    + "    `feedback`.`syllabusID`,\n"
                    + "    `feedback`.`displayName`,\n"
                    + "    `feedback`.`email`,\n"
                    + "    `feedback`.`title`,\n"
                    + "    `feedback`.`content`\n"
                    + "FROM `swp391`.`feedback`\n"
                    + "WHERE `feedback`.syllabusID = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Feedback fb = new Feedback();
                fb.setFbID(rs.getInt("fbID"));
                fb.setAccountID(rs.getInt("accountID"));
                fb.setSyllabusID(rs.getInt("syllabusID"));
                fb.setDisplayName(rs.getString("displayName"));
                fb.setEmail(rs.getString("email"));
                fb.setTitle(rs.getString("title"));
                fb.setDescription(rs.getString("content"));
                list.add(fb);
            }
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

}
