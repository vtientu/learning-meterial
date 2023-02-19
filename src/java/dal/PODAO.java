/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import module.Decision;
import module.PO;

/**
 *
 * @author phanh
 */
public class PODAO extends DBContext {

    public List<PO> getAllPO() {
        List<PO> list = new ArrayList<>();
        try {
            String sql = "SELECT `po`.`id`,\n"
                    + "    `po`.`POName`,\n"
                    + "    `po`.`PODescription`,\n"
                    + "    `po`.`isActive`\n"
                    + "FROM `swp391`.`po`;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                PO po = new PO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4));
                list.add(po);
            }
        } catch (SQLException e) {
            System.out.println("PODAO -> getAllPO(): " + e);
        }
        return list;
    }

    public PO getPOByID(int id) {
        try {
            String sql = "SELECT `po`.`id`,\n"
                    + "    `po`.`POName`,\n"
                    + "    `po`.`PODescription`,\n"
                    + "    `po`.`isActive`\n"
                    + "FROM `swp391`.`po`\n"
                    + "where `po`.`id` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                PO po = new PO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4));
                return po;
            }
        } catch (SQLException e) {
            System.out.println("PODAO -> getPOByID(): " + e);
        }
        return null;
    }

    public void add(PO po) {
        try {
            String sql = "INSERT INTO `swp391`.`po` (`POName`, `PODescription`, `isActive`)\n"
                    + "VALUES	(?, ?, ?);";

            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, po.getPoName());
            st.setString(2, po.getPoDescription());
            st.setBoolean(3, po.isIsActive());
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println("decisionDAO -> add(): " + e);
        }
    }

    public void update(PO po) {
        try {
            String sql = "UPDATE `swp391`.`po`\n"
                    + "SET\n"
                    + "`POName` = ?,\n"
                    + "`PODescription` = ?,\n"
                    + "`isActive` = ?\n"
                    + "WHERE `id` = ?;";
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, po.getPoName());
            st.setString(2, po.getPoDescription());
            st.setBoolean(3, po.isIsActive());
            st.setInt(4, po.getId());
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println("PODAO -> update(): " + e);
        }
    }

    public int getLastID() {
        try {
            String sql = "SELECT `po`.`id`"
                    + "FROM `swp391`.`po`\n"
                    + "ORDER BY `po`.`id` DESC\n"
                    + "LIMIT 1;";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("PODAO -> getLastID(): " + e);
        }
        return -1;
    }
}
