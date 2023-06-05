/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Material;
import exceptions.MaterialException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author giahu
 */
public class MaterialDao {

    //lấy list material theo syllabusID
    public static List<Material> readMaterialListBySylId(String sylId) throws Exception {
        String query = "select * from Material where syllabusID = ?";
        List<Material> list = new ArrayList<>();
        try {
            Connection con = DBUtils.makeConnection();
            PreparedStatement pre = con.prepareStatement(query);
            pre.setString(1, sylId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Material material = new Material();
                material.setId(rs.getInt("id"));
                material.setName(rs.getString("name"));
                material.setMaterialUri(rs.getString("materialUri"));
                material.setSyllabusID(rs.getInt("syllabusID"));
                list.add(material);
            }
            con.close();
        } catch (Exception e) {
            throw new MaterialException("Something went wrong in get material progress.");
        }
        return list;
    }

    public static void create(int sylID, Material material, Connection con) throws Exception {
        String query = "insert into Material ([name]\n"
                + "      ,[materialUrl]\n"
                + "      ,[syllabusID]) values(?,?,?)";
        PreparedStatement stm = con.prepareStatement(query);
        stm.setString(1, material.getName());
        stm.setString(2, material.getMaterialUri());
        stm.setInt(3, sylID);
        int affectedRows = stm.executeUpdate();
        if (affectedRows == 0) {
            throw new SQLException("Faild to create Material");
        }
    }
}