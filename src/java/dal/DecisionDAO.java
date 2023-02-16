/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.mysql.cj.xdevapi.PreparableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import module.Decision;

/**
 *
 * @author tient
 */
public class DecisionDAO extends DBContext {

    public Decision getDecisionByNo(String decisionNo) {
        try {
            String sql = "SELECT `decision`.`DecisionNo`,\n"
                    + "    `decision`.`DecisionName`,\n"
                    + "    `decision`.`ApprovedDate`,\n"
                    + "    `decision`.`Note`,\n"
                    + "    `decision`.`CreateDate`,\n"
                    + "    `decision`.`isActive`,\n"
                    + "    `decision`.`FileName`\n"
                    + "FROM `swp391`.`decision`\n"
                    + "WHERE `decision`.`DecisionNo` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, decisionNo);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                Decision decision = new Decision();
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
            System.out.println(e);
        }
        return null;
    }
}
