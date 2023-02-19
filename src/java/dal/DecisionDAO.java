/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.mysql.cj.xdevapi.PreparableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import module.Decision;

/**
 *
 * @author tient
 */
public class DecisionDAO extends DBContext {

    public Decision getDecisionByDecisionID(int decisionID) {
        try {
            String sql = "SELECT `decision`.`decisionID`,"
                    + "     `decision`.`DecisionNo`,\n"
                    + "    `decision`.`DecisionName`,\n"
                    + "    `decision`.`ApprovedDate`,\n"
                    + "    `decision`.`Note`,\n"
                    + "    `decision`.`CreateDate`,\n"
                    + "    `decision`.`isActive`,\n"
                    + "    `decision`.`FileName`\n"
                    + "FROM `swp391`.`decision`\n"
                    + "WHERE `decision`.`decisionID` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, decisionID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Decision decision = new Decision();
                decision.setDecisionID(rs.getInt("decisionID"));
                decision.setDecisionNo(rs.getString("DecisionNo"));
                decision.setDecisionName(rs.getString("DecisionName"));
                decision.setApprovedDate(rs.getDate("ApprovedDate"));
                decision.setNote(rs.getString("Note"));
                decision.setCreateDate(rs.getDate("CreateDate"));
                decision.setIsActive(rs.getBoolean("isActive"));
                decision.setFileName(rs.getString("FileName"));
                return decision;
            }
        } catch (SQLException e) {
            System.out.println("decisionDAO -> getDecisionByDecisionID(): " + e);
        }
        return null;
    }
    public List<Decision> getAllDecision() {
        List<Decision> list = new ArrayList<>();
        try {
            String sql = "SELECT `decision`.`decisionID`,"
                    + "     `decision`.`DecisionNo`,\n"
                    + "    `decision`.`DecisionName`,\n"
                    + "    `decision`.`ApprovedDate`,\n"
                    + "    `decision`.`Note`,\n"
                    + "    `decision`.`CreateDate`,\n"
                    + "    `decision`.`isActive`,\n"
                    + "    `decision`.`FileName`\n"
                    + "FROM `swp391`.`decision`;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                Decision decision = new Decision();
                decision.setDecisionID(rs.getInt("decisionID"));
                decision.setDecisionNo(rs.getString("DecisionNo"));
                decision.setDecisionName(rs.getString("DecisionName"));
                decision.setApprovedDate(rs.getDate("ApprovedDate"));
                decision.setNote(rs.getString("Note"));
                decision.setCreateDate(rs.getDate("CreateDate"));
                decision.setIsActive(rs.getBoolean("isActive"));
                decision.setFileName(rs.getString("FileName"));
                list.add(decision);
            }
        } catch (SQLException e) {
            System.out.println("decisionDAO -> getDecisionByDecisionID(): " + e);
        }
        return list;
    }

    public void update(Decision decision) {
        try {
            String sql = "UPDATE `swp391`.`decision`\n"
                    + "SET\n"
                    + "`decisionNo` = ?,\n"
                    + "`DecisionName` = ?,\n"
                    + "`Note` = ?,\n"
                    + "`isActive` = ?,\n"
                    + "`FileName` = ?\n"
                    + "WHERE `DecisionNo` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, decision.getDecisionNo());
            st.setString(2, decision.getDecisionName());
            st.setString(3, decision.getNote());
            st.setBoolean(4, decision.isIsActive());
            st.setString(5, decision.getFileName());
            st.setString(6, decision.getDecisionNo());
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println("decisionDAO -> update(): " + e);
        }
    }

    public void add(Decision decision) {
        try {
            String sql = "INSERT INTO `swp391`.`decision`\n"
                    + "(`DecisionNo`,`DecisionName`,`ApprovedDate`,`Note`,`CreateDate`,`isActive`,`FileName`)\n"
                    + "VALUES (?, ?, ?, ?, ?, ?, ?);";
            
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, decision.getDecisionNo());
            st.setString(2, decision.getDecisionName());
            st.setDate(3, decision.getApprovedDate());
            st.setString(4, decision.getNote());
            st.setDate(5, decision.getCreateDate());
            st.setBoolean(6, decision.isIsActive());
            st.setString(7, decision.getFileName());
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println("decisionDAO -> add(): " + e);
        }
    }

    public int getLastID() {
        try {
            String sql = "SELECT `decision`.`decisionID`"
                    + "FROM `swp391`.`decision`\n"
                    + "ORDER BY `decision`.`decisionID` DESC\n"
                    + "LIMIT 1;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("decisionDAO -> getLastID(): " + e);
        }
        return -1;
    }
}
